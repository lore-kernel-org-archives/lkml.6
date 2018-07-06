Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D6CC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EAC216F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EAC216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934417AbeGFSXu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:23:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934440AbeGFSXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:23:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFA8C3468C;
        Fri,  6 Jul 2018 18:23:45 +0000 (UTC)
Received: from [10.10.121.173] (ovpn-121-173.rdu2.redhat.com [10.10.121.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C91FF76CE;
        Fri,  6 Jul 2018 18:23:44 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] uio: fix crash after the device is unregistered
To:     xiubli@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
 <1530845836-49101-4-git-send-email-xiubli@redhat.com>
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B3FB3B0.7010105@redhat.com>
Date:   Fri, 6 Jul 2018 13:23:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1530845836-49101-4-git-send-email-xiubli@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 18:23:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 18:23:45 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mchristi@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 09:57 PM, xiubli@redhat.com wrote:
>  static irqreturn_t uio_interrupt(int irq, void *dev_id)
>  {
>  	struct uio_device *idev = (struct uio_device *)dev_id;
> -	irqreturn_t ret = idev->info->handler(irq, idev->info);
> +	irqreturn_t ret;
> +
> +	mutex_lock(&idev->info_lock);
> +	if (!idev->info) {
> +		ret = IRQ_NONE;
> +		goto out;
> +	}
>  
> +	ret = idev->info->handler(irq, idev->info);
>  	if (ret == IRQ_HANDLED)
>  		uio_event_notify(idev->info);
>  
> +out:
> +	mutex_unlock(&idev->info_lock);
>  	return ret;
>  }


Do you need the interrupt related changes in this patch and the first
one? When we do uio_unregister_device -> free_irq does free_irq return
when there are no longer running interrupt handlers that we requested?

If that is not the case then I think we can hit a similar bug. We do:

__uio_register_device -> device_register -> device's refcount goes to
zero so we do -> uio_device_release -> kfree(idev)

and if it is possible the interrupt handler could still run after
free_irq then we would end up doing:

uio_interrupt -> mutex_lock(&idev->info_lock) -> idev access freed memory.

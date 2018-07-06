Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB989C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F731208DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F731208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934617AbeGFS7B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:59:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934201AbeGFS67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:58:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7256C34687;
        Fri,  6 Jul 2018 18:58:59 +0000 (UTC)
Received: from [10.10.121.173] (ovpn-121-173.rdu2.redhat.com [10.10.121.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D286111DCF2;
        Fri,  6 Jul 2018 18:58:58 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] uio: fix crash after the device is unregistered
To:     xiubli@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
 <1530845836-49101-4-git-send-email-xiubli@redhat.com>
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B3FBBF1.9080902@redhat.com>
Date:   Fri, 6 Jul 2018 13:58:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1530845836-49101-4-git-send-email-xiubli@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 18:58:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 06 Jul 2018 18:58:59 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mchristi@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 09:57 PM, xiubli@redhat.com wrote:
>  void uio_event_notify(struct uio_info *info)
>  {
> -	struct uio_device *idev = info->uio_dev;
> +	struct uio_device *idev;
> +
> +	if (!info)
> +		return;
> +
> +	idev = info->uio_dev;
>  

For this one too, I am not sure if it is needed.

uio_interrupt -> uio_event_notify. See other mail.

driver XYZ -> uio_event_notify. I think drivers need to handle this and
set some bits and/or perform some cleanup to make sure they are not
calling uio_event_notify after it has called uio_unregister_device. The
problem with the above test is if they do not they could have called
uio_unregister_device right after the info test so you could still hit
the problem.

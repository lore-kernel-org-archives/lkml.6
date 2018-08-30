Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D727C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40322082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40322082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeH3QBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:01:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbeH3QBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1930E40241CB;
        Thu, 30 Aug 2018 11:59:15 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C521621AA;
        Thu, 30 Aug 2018 11:59:12 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     gregkh@linuxfoundation.org, kys@linuxonhyperv.com
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        kys@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH] vmbus: don't return values for uninitalized channels
References: <20180820211640.5837-1-kys@linuxonhyperv.com>
Date:   Thu, 30 Aug 2018 13:59:11 +0200
In-Reply-To: <20180820211640.5837-1-kys@linuxonhyperv.com>
        (kys@linuxonhyperv.com's message of "Mon, 20 Aug 2018 21:16:40 +0000")
Message-ID: <874lfcgj5c.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 30 Aug 2018 11:59:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 30 Aug 2018 11:59:15 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kys@linuxonhyperv.com writes:

> From: Stephen Hemminger <stephen@networkplumber.org>
>
> For unsupported device types, the vmbus channel ringbuffer is never
> initialized, and therefore reading the sysfs files will return garbage
> or cause a kernel OOPS.
>
> Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
>
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Cc: <stable@vger.kernel.org> # 4.15

As this is also marked for stable, any chance we can get it in 4.19? Or
at least in char-misc-next?

> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e6d8fdac6d8b..4bbc420d1213 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1368,6 +1368,9 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
>  	if (!attribute->show)
>  		return -EIO;
>
> +	if (chan->state != CHANNEL_OPENED_STATE)
> +		return -EINVAL;
> +
>  	return attribute->show(chan, buf);
>  }

Thanks,

-- 
  Vitaly

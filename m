Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF839C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15D920673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15D920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeLAKcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:32:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43956 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAKcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:32:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3516657pfk.10;
        Fri, 30 Nov 2018 15:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JEB/4Zv475uLn9MIf8zqMX+RFM2EbEbSyCy6bqSFF/E=;
        b=R0gFO0mcakSPaSfj8WrbDYSL4UTQ/cBxrXkzsaSsNnMfrV2O9oHk4ReBuujkAuLv5D
         eCR152g/1h1oZKyAoyYGTEKS5hG0dP8yEw64GuHTD6kRE4RUyigHn1sqJF91Djgbf+yJ
         OxxxUt8rmhTSpkl2ggl+9aJGLWEor0ulAsNWtFyckS1Rhahs9Xmx8jYUsxuw79jtr1hG
         c4glhC/xY8bUcUslu2rET1zvDCGfFPD/l2fF4prNTfjobYA7Nlyi4G2W1ZWUBNS0RD+n
         kWT20vp3hguduhs+4CTBJK+4ycpeIk+safIQKBrNfn8gUe9WM6eZRrIBHE9ZZvuev/Bp
         u9Aw==
X-Gm-Message-State: AA+aEWZz7ACJe/6wV2GT/6gat8pbJdAnt1qr6zCPGUFmOx1459MkhTDC
        co/ObYCtuEfKFZHsarmQAhI=
X-Google-Smtp-Source: AFSGD/UVKyUUfttgmpXAmnFhGaCe+wjY9NXrKYmxqpVqFfJARmKX203/1/q7BLeTqTIlJgJO+70F2g==
X-Received: by 2002:a63:680a:: with SMTP id d10mr6429182pgc.396.1543620101133;
        Fri, 30 Nov 2018 15:21:41 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id d202sm9980502pfd.58.2018.11.30.15.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:21:39 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 15:21:37 -0800
Date:   Fri, 30 Nov 2018 15:21:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        dmitry.torokhov@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org
Subject: Re: [driver-core PATCH v7 1/9] driver core: Move
 async_synchronize_full call
Message-ID: <20181130232137.GE28501@garbanzo.do-not-panic.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345153162.18040.15354788106932190561.stgit@ahduyck-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154345153162.18040.15354788106932190561.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 04:32:11PM -0800, Alexander Duyck wrote:
> Move the async_synchronize_full call out of __device_release_driver and
> into driver_detach.
> 
> The idea behind this is that the async_synchronize_full call will only
> guarantee that any existing async operations are flushed. This doesn't do
> anything to guarantee that a hotplug event that may occur while we are
> doing the release of the driver will not be asynchronously scheduled.
> 
> By moving this into the driver_detach path we can avoid potential deadlocks
> as we aren't holding the device lock at this point and we should not have
> the driver we want to flush loaded so the flush will take care of any
> asynchronous events the driver we are detaching might have scheduled.
> 
> Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

> ---
>  drivers/base/dd.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 689ac9dc6d81..88713f182086 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -931,9 +931,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  
>  	drv = dev->driver;
>  	if (drv) {
> -		if (driver_allows_async_probing(drv))
> -			async_synchronize_full();
> -
>  		while (device_links_busy(dev)) {
>  			device_unlock(dev);
>  			if (parent)
> @@ -1039,6 +1036,9 @@ void driver_detach(struct device_driver *drv)
>  	struct device_private *dev_prv;
>  	struct device *dev;
>  
> +	if (driver_allows_async_probing(drv))
> +		async_synchronize_full();
> +
>  	for (;;) {
>  		spin_lock(&drv->p->klist_devices.k_lock);
>  		if (list_empty(&drv->p->klist_devices.k_list)) {
> 

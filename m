Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09283C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB1F2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3FRLOQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB1F2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbeKPIPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:15:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38790 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:15:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so92960plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJC+vMPEutHwTeerYX7incQicYIH59YuhOK3e3DLkWE=;
        b=d3FRLOQicXvdQiKQlMsUYg9MNIgyq2MYVXMD1lgpHOihfnAc9K4XLoJpRFpy6/mmgP
         gqMTe2j3t2W0BbI4IvXMd/9fhNPqDfZlHd6UeP+vDsF071JgevBA8tplkaujWOMU4ufu
         gRur5oh8GSHw92QU2X6R+OKpzfTkYS1q1JLuVZJQiP19zvbg74Cc1yY1FKKh4/r4KmGV
         6jH7wkILDPOLnNCmN/MHI2DnnRtXvWz+yGiZXsi6rTUgRKqhv9nMSCPYTfVd0L+YCAy/
         +hzpgoiFF9ya4533Ugw7xgy0rc1WWOfuXhdX+e4xDCHSgbBXUPcM2zbEM+yNdO4I4i8y
         oqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJC+vMPEutHwTeerYX7incQicYIH59YuhOK3e3DLkWE=;
        b=QBGOk+jfvHD84G2EZvFBHJcD6XJ5xbv+m1znV6gs1MEZfa4QsHLH62YP+M2g9YyaXs
         4sfG88dDT3KpllXsTBDrnPXi29iTMNicHg0uJd3kg1snGxQQvrnWY57gvHfS/4GOYbcU
         xxRX9a9FVzDGBdvEM+6zgkOFTS/o4E37+bYgIcIW7NxytQPMd87l5hKHInbHQTqYuHlM
         KIjY++J0UrYXLiY8IbL+LsHf1zwZZ+TfC2b5W2RXkOiaWbVRU3744h+mhvpd49GN8mlV
         yay/dggI5hpGzFJJrNN182tuy4OYJJ62i+cHg2NOZoBSX3Gd53+3/e1YpwU32g3p+rCS
         Px9A==
X-Gm-Message-State: AGRZ1gLHmROV3bG0bb0v7gd48Y5zDUtPZHKMq/Lp0jej9T6298DEMycm
        UrZzsG9+YPdU2MB2pu1lssJprYnFxuc=
X-Google-Smtp-Source: AJdET5fvBGbr/46gPVnJiYGGK2Nd8iw2AInZAugDBDHghHMvES2dwFgZbhmt1FsozV/z5Vu3PP5Ylg==
X-Received: by 2002:a17:902:b83:: with SMTP id 3-v6mr8327524plr.202.1542319572748;
        Thu, 15 Nov 2018 14:06:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n189-v6sm32332451pfn.163.2018.11.15.14.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:06:11 -0800 (PST)
Date:   Thu, 15 Nov 2018 14:06:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181115220610.GA7735@roeck-us.net>
References: <20181115191126.GA16973@roeck-us.net>
 <e7f72ebb-68e8-29f4-121b-4053ec8b537e@kernel.dk>
 <20181115193854.GA30639@roeck-us.net>
 <6fb23170-5029-f926-c063-77cefea37427@kernel.dk>
 <8bb5c405-55f8-f330-85a5-b22163c83119@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb5c405-55f8-f330-85a5-b22163c83119@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:43:40PM -0700, Jens Axboe wrote:
> On 11/15/18 12:40 PM, Jens Axboe wrote:
> > On 11/15/18 12:38 PM, Guenter Roeck wrote:
> >> On Thu, Nov 15, 2018 at 12:29:04PM -0700, Jens Axboe wrote:
> >>> On 11/15/18 12:11 PM, Guenter Roeck wrote:
> >>>> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
> >>>>>
> >>>>> I think the below patch should fix it.
> >>>>>
> >>>>
> >>>> I spoke too early. sparc64, next-20181115:
> >>>>
> >>>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
> >>>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
> >>>> [   14.263496] ------------[ cut here ]------------
> >>>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
> >>>> [   14.264265] Trying to free already-free IRQ 9
> >>>> [   14.264519] Modules linked in:
> >>>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
> >>>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
> >>>> [   14.265899] Call Trace:
> >>>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
> >>>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
> >>>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
> >>>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
> >>>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
> >>>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
> >>>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
> >>>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
> >>>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
> >>>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
> >>>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
> >>>> [   14.268825]  [0000000000000000]           (null)
> >>>> [   14.269089] irq event stamp: 32796
> >>>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
> >>>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
> >>>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
> >>>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
> >>>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
> >>>>
> >>>> Looks like an error during probe followed by an error cleanup problem.
> >>>
> >>> Did it previous probe fine? Or is the new thing just the fact that
> >>> we spew a warning on trying to free a non-existing vector?
> >>>
> >> This works fine in mainline, if that is your question.
> > 
> > Yeah, as soon as I sent the other email I realized that. Let me send
> > you a quick patch.
> 
> How's this?
> 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ffbab5b01df4..fd73bfd2d1be 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2088,15 +2088,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>  			affd.nr_sets = 1;
>  
>  		/*
> -		 * Need IRQs for read+write queues, and one for the admin queue.
> -		 * If we can't get more than one vector, we have to share the
> -		 * admin queue and IO queue vector. For that case, don't add
> -		 * an extra vector for the admin queue, or we'll continue
> -		 * asking for 2 and get -ENOSPC in return.
> +		 * If we got a failure and we're down to asking for just
> +		 * 1 + 1 queues, just ask for a single vector. We'll share
> +		 * that between the single IO queue and the admin queue.
>  		 */
> -		if (result == -ENOSPC && nr_io_queues == 1)
> -			nr_io_queues = 1;
> -		else
> +		if (!(result < 0 && nr_io_queues == 1))
>  			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
>  

Unfortunately, the code doesn't even get here because the call of
pci_alloc_irq_vectors_affinity in the first iteration fails with
-EINVAL, which results in an immediate return with -EIO.

Guenter

>  		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
> 
> -- 
> Jens Axboe
> 

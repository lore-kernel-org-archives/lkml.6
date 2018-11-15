Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0E52133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cASkiitD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0E52133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbeKPI4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:56:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33938 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:56:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so3842171pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eNulWNwvboDhXhAUHCClieLUbsv1C+7wG8Xx4L64Ijo=;
        b=cASkiitDjoQl8IOKVVccopK6qNzEjWQ49fYrafJydBUtMcOJNdxaIeG/FOpFyIfASA
         TF5cVURVLc18dgE9PTiXcT7rlVXMOqwUvA7lWojRZPvUiWPr6yNXBWmsubw4vzLRQaPV
         eT96VgXIUzM77WLg2LhEb/jsJ6fJTiqw1Tg6e0jY8cuPR3qUo0Q8LwoLC7ZnT7TrLnrC
         Gd2B12/qLJvSTnyqkdbb7nvkila0tNv8Lpe0WB2sn1Iv5erMA2LP7sEGD3N6ooQUbc+p
         18tMNLrZkDNCkk9qHh7XXaZOMjW6coFeI8lwKHNFRWqUDWX/54oGzeaEm6wDkxbj2ngT
         drKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=eNulWNwvboDhXhAUHCClieLUbsv1C+7wG8Xx4L64Ijo=;
        b=svOaBO32HxKs0QQyXRGrm8gzK33ABwuNp4R5qNOpi4gdhQDGbADqaS78hRyeiAvfKw
         upp9DEZhIcQyp38M9xwUE+uE7zKkJ9B9IHKOqRr6+l65nRe98vt1dQRiA38yjLqeNF0C
         ysRNFNnrtj8ka3ecdooK6hxm/jcYybU939fX54ajvmXVBlS2tkzCZGJpXybS3YGgsgaK
         M2kfIsSFudjxZdy+s+7icYMUlEdl5Egl5+CMeF1ZwJgt3qhkp+nB1xD16whd1VWxesnL
         76KWj/IQH9W6V3yl1vOaJJneMd/86A90J3gLfMeQUwtFO188uGr+E70Pu9eFpB+WlM40
         zdww==
X-Gm-Message-State: AGRZ1gKJixvKNpiH2Lwd4r+ZYQ5WszmvRxwDP/Rjd9YTporRLHZQntb7
        HAAYQyfN+a3bNB1prn6d2kQ=
X-Google-Smtp-Source: AJdET5d4Wvo4kfnmIoHv7ZVA/yPvzPewwFbgojbwZSSfuRLbb59R82Fxz+CYnz6H2cUsBZ5M15iPgw==
X-Received: by 2002:a63:2849:: with SMTP id o70mr7424460pgo.155.1542321997345;
        Thu, 15 Nov 2018 14:46:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h128-v6sm32374723pfb.52.2018.11.15.14.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:46:36 -0800 (PST)
Date:   Thu, 15 Nov 2018 14:46:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181115224634.GA13101@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 03:12:48PM -0700, Jens Axboe wrote:
> On 11/15/18 3:06 PM, Guenter Roeck wrote:
> > On Thu, Nov 15, 2018 at 12:43:40PM -0700, Jens Axboe wrote:
> >> On 11/15/18 12:40 PM, Jens Axboe wrote:
> >>> On 11/15/18 12:38 PM, Guenter Roeck wrote:
> >>>> On Thu, Nov 15, 2018 at 12:29:04PM -0700, Jens Axboe wrote:
> >>>>> On 11/15/18 12:11 PM, Guenter Roeck wrote:
> >>>>>> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
> >>>>>>>
> >>>>>>> I think the below patch should fix it.
> >>>>>>>
> >>>>>>
> >>>>>> I spoke too early. sparc64, next-20181115:
> >>>>>>
> >>>>>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
> >>>>>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
> >>>>>> [   14.263496] ------------[ cut here ]------------
> >>>>>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
> >>>>>> [   14.264265] Trying to free already-free IRQ 9
> >>>>>> [   14.264519] Modules linked in:
> >>>>>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
> >>>>>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
> >>>>>> [   14.265899] Call Trace:
> >>>>>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
> >>>>>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
> >>>>>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
> >>>>>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
> >>>>>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
> >>>>>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
> >>>>>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
> >>>>>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
> >>>>>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
> >>>>>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
> >>>>>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
> >>>>>> [   14.268825]  [0000000000000000]           (null)
> >>>>>> [   14.269089] irq event stamp: 32796
> >>>>>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
> >>>>>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
> >>>>>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
> >>>>>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
> >>>>>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
> >>>>>>
> >>>>>> Looks like an error during probe followed by an error cleanup problem.
> >>>>>
> >>>>> Did it previous probe fine? Or is the new thing just the fact that
> >>>>> we spew a warning on trying to free a non-existing vector?
> >>>>>
> >>>> This works fine in mainline, if that is your question.
> >>>
> >>> Yeah, as soon as I sent the other email I realized that. Let me send
> >>> you a quick patch.
> >>
> >> How's this?
> >>
> >>
> >> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> >> index ffbab5b01df4..fd73bfd2d1be 100644
> >> --- a/drivers/nvme/host/pci.c
> >> +++ b/drivers/nvme/host/pci.c
> >> @@ -2088,15 +2088,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
> >>  			affd.nr_sets = 1;
> >>  
> >>  		/*
> >> -		 * Need IRQs for read+write queues, and one for the admin queue.
> >> -		 * If we can't get more than one vector, we have to share the
> >> -		 * admin queue and IO queue vector. For that case, don't add
> >> -		 * an extra vector for the admin queue, or we'll continue
> >> -		 * asking for 2 and get -ENOSPC in return.
> >> +		 * If we got a failure and we're down to asking for just
> >> +		 * 1 + 1 queues, just ask for a single vector. We'll share
> >> +		 * that between the single IO queue and the admin queue.
> >>  		 */
> >> -		if (result == -ENOSPC && nr_io_queues == 1)
> >> -			nr_io_queues = 1;
> >> -		else
> >> +		if (!(result < 0 && nr_io_queues == 1))
> >>  			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
> >>  
> > 
> > Unfortunately, the code doesn't even get here because the call of
> > pci_alloc_irq_vectors_affinity in the first iteration fails with
> > -EINVAL, which results in an immediate return with -EIO.
> 
> Oh yeah... How about this then?
> 
Yes, this one works (at least on sparc64). Do I need to test
on other architectures as well ?

Thanks,
Guenter

> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ffbab5b01df4..4d161daa9c3a 100644
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
>  		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
> @@ -2111,6 +2107,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>  			if (!nr_io_queues)
>  				return result;
>  			continue;
> +		} else if (result == -EINVAL) {

Add an explanation, maybe ?

> +			nr_io_queues = 1;
> +			continue;
>  		} else if (result <= 0)
>  			return -EIO;
>  		break;
> 
> -- 
> Jens Axboe
> 

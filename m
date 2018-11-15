Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4195FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0641C2245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMTfoe3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0641C2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbeKPFqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:46:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41083 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeKPFqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:46:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so10168226pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHeyvUilx3/shJ1XkBvASaZrxvndAilObcircisp5AA=;
        b=MMTfoe3guxU7GArOa9/Ffr03Ywk6lIYtl4D+/dc9tpeM3uq6Tok/S+NwBf6Q8Nk4/y
         rQCrS3qYJaGh2hB3i3MbhU+lrfZdkuq84+hhRAUrJ1O5qexRqR+xjWeYBTitUibMVk9S
         qMhM5DBQ+6sR05oFCgQJYDh1lxBrdo1ouyZjh0OIwM0PZC7z9hgHCoauAJ8Zaaox1xO1
         TnXKdLPaIwEhgbDGOtor0NheYM7MEJ5lAt5LJudVZ9a/EKZRqZ6ozltv4ryQ/vxp1bo8
         BDIVy61e++U8kYFEQ/xohXg6S7BXGcpBUmlXU0ArfQvnP4xsptYHYMNJyZWAQa9F4xld
         XmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHeyvUilx3/shJ1XkBvASaZrxvndAilObcircisp5AA=;
        b=TOJCj4yQZZQorD2iaElQGDSEztYUJmNIRC0a5Gs9CVIH3Aub1ufCJE6KtQjEBTXFEg
         a5N2TffG4H62hBI7K+hWEdnRIPHSelnZXLLcYocLXIDBKwLHI5OEL7jtsp0reCYZwGrB
         CW8GYJqaWJG0PqD8mY3buXW3GMdz6c6lJ/0GQrEfmbIwUK8dXsqr01YsAbAlt7jcWO/s
         atUUGoYdP0t9NcM7w4Y3o0GwRDZVrOYB3nFjGN1/UN7lDBZ37tfxTouYr5xyzCFi5r73
         vmwyR43RKUNpV8YZzO6VzuYeefCjv3kb6Efo7aW7eXG5cvAbF0gAOPplIVf6ZK8xYnkJ
         GA3g==
X-Gm-Message-State: AGRZ1gIUXYKmE+3KGbWY7Vhc17jNWaJgU0n4ujvZvqErPHvgY7hVaQxE
        72YmhQT9HcfJukPX3IRCErQkVxuK8E4=
X-Google-Smtp-Source: AJdET5ch9xwUtAZlU1mgM0InDkPsV84qL9FfrIKg8OZrlEbLuOWChIGdpSgxdW8T/ZZMvYQJv0cwiw==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr7127829pgl.127.1542310619960;
        Thu, 15 Nov 2018 11:36:59 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v2sm13226060pgs.0.2018.11.15.11.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:36:59 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:36:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181115193658.GA7921@roeck-us.net>
References: <20181115191126.GA16973@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115191126.GA16973@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:11:26AM -0800, Guenter Roeck wrote:
> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
> > 
> > I think the below patch should fix it.
> > 
> 
> I spoke too early. sparc64, next-20181115:
> 
> [   14.204370] nvme nvme0: pci function 0000:02:00.0
> [   14.249956] nvme nvme0: Removing after probe failure status: -5
> [   14.263496] ------------[ cut here ]------------
> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
> [   14.264265] Trying to free already-free IRQ 9
> [   14.264519] Modules linked in:
> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
> [   14.265899] Call Trace:
> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
> [   14.268825]  [0000000000000000]           (null)
> [   14.269089] irq event stamp: 32796
> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
> 
> Looks like an error during probe followed by an error cleanup problem.
> 
On sparc64, pci_alloc_irq_vectors_affinity() returns -EINVAL (possibly
because the controller doesn't support MSI).

[   16.554753] nvme nvme0: pci function 0000:02:00.0
[   16.622894] nvme 0000:02:00.0: pre alloc: nr_io_queues: 2 result: 0
[   16.623814] nvme 0000:02:00.0: post alloc: nr_io_queues: 2 result: -22
[   16.625047] nvme nvme0: Removing after probe failure status: -5

... and, as result, allocating a single (legacy) interrupt isn't even tried.

I didn't try to track down the cleanup failure.

Guenter

Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9986C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDB920815
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngGg0dZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDB920815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeKPFUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:20:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43847 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:20:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so9910788plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KBvxmcf0Rlk9ebls9dlzpPkv7ZpQaMBOSobJFOkavx0=;
        b=ngGg0dZaLDlU/sC85tsvLm/MtNXG1c2GET3Dv9oHjqoVyhc90tTq/aFVWK8nf+xY8V
         3II1/FYQ8gYsLt+ZnMjtRcOWYWDaU9XW8HnATwmggvHSurirZ7Bm1ol7D7vkY0WzfMjS
         gC99fiYawICarBL0wuSFEvxRgpSCgmOTp3GLl4axjc4L5YsORiTZwBReWPbBmk4hT6Mk
         MkCpy6WNvkpvgrMF95k53XRgnyTkN/EGzj0Ypjreep9FFBhi3f9WSFjnqN7/fFaGk5VJ
         ZBa42ItYi7xVaELAlmL30jUB4G9IE1zs8TF1IeSaLg8ZPgr1OoE58mMMm7PmUvqyp2wp
         V8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=KBvxmcf0Rlk9ebls9dlzpPkv7ZpQaMBOSobJFOkavx0=;
        b=SDJiHEur5pFbh4Hm/gtw9xeTSyI4zrpnsGhygw0l6aF6IwDPFHwk/jCgvx178+CtdY
         0Gt3ocfC+VSWXMwrz3MrnvNGUYWaT4lTiQLi5X0JGlnqbDEdRmxJpyqDDEAl4p88VB6D
         fXSGGMC+gMCLGGTUozh7Rx4PuBCbxC8UlSgghmihB5s1rpW/CQ0bZ2j5yi7IsAK8gQRs
         Wj34ejyO2o3Saio6tShBbtmKsvDMrPhrVYfEWFHRwg1sFhp5aI21uEEv9Z/hYkNR75To
         MJ/tbqYeFXBKBea+ci2rV8//O3/jKUWfuBV3+ITyXMOmQVeDf2W/VDeCRwxRmp+1SqpP
         Jyaw==
X-Gm-Message-State: AGRZ1gJDY2VWimsaVP53MzGvXZlgKBOohD8+4WJPFDIRgQ3uPcI6mplT
        epkRu4guIPNOz08/ElVR5U5dLCEr8/A=
X-Google-Smtp-Source: AJdET5fPebqqTxxmH8fZQz9+JrBmBW/W2gOLT/eOfpHGSE/mBYO8U88SFrN8FwabBn4skioKN4pOUw==
X-Received: by 2002:a17:902:e01:: with SMTP id 1-v6mr7272243plw.251.1542309088467;
        Thu, 15 Nov 2018 11:11:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f62sm26949701pgc.67.2018.11.15.11.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:11:27 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:11:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181115191126.GA16973@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
> 
> I think the below patch should fix it.
> 

I spoke too early. sparc64, next-20181115:

[   14.204370] nvme nvme0: pci function 0000:02:00.0
[   14.249956] nvme nvme0: Removing after probe failure status: -5
[   14.263496] ------------[ cut here ]------------
[   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
[   14.264265] Trying to free already-free IRQ 9
[   14.264519] Modules linked in:
[   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
[   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
[   14.265899] Call Trace:
[   14.266118]  [000000000046944c] __warn+0xcc/0x100
[   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
[   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
[   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
[   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
[   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
[   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
[   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
[   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
[   14.268321]  [0000000000490624] kthread+0xe4/0x120
[   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
[   14.268825]  [0000000000000000]           (null)
[   14.269089] irq event stamp: 32796
[   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
[   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
[   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
[   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
[   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---

Looks like an error during probe followed by an error cleanup problem.

Guenter

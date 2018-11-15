Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0573C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6745E223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdtXaEPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6745E223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeKPFsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:48:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45756 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:48:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so5352609plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1p/j1E6CzN5LEU4dD1d/TPykOrgm+MAe26B6wVYtsI=;
        b=mdtXaEPfETj9PRObVdXx8z3AJzj8AYdt19yl5AQC+jJQXAINwQk3bytqMc0odmnWAT
         QTm+zFDhTZFXh8hMv6XXctPg1IhG+GnuSLt+7jtyiBvOTtlj4/pijV43xXFgbXJZ6lF+
         wVJ0fT7nbTlhxQ6zOE4sHZgBH+eZ/Yth1K9YfUIeL+p8Jl//V3EkfypAnRjU6iRl3d1k
         q8FGKIYNCs57x20yVDUWnvX+9GaAVtX+1evDewFDAcx/u23y0+D4tQO8mpmGd97fYWeh
         4Gn5WRvPALDwGqPiUORO1DiInbePAS9nJTYTbTOnprJpg/jkYUJbOlMPUTug88YMYi+o
         gAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1p/j1E6CzN5LEU4dD1d/TPykOrgm+MAe26B6wVYtsI=;
        b=KIUF+9bsflTPmeqBT9hVD84JpMX5NLao3lMjm5nj26j0K42mgYwoXMSGZ/ZqVbQvpp
         97r3qmKep1CV9bitUh6+P8sPqaqefslcbM8sl0ETuNZdWxTNneUsMCkomx52JbND54BJ
         u76ZRu3O7SPFvsHptEs5kUjJTsFsW5RgEEYllqnWA0L2MiYglhlTcXXNRcJixKJjmbAh
         ajbiQzLW0ncnd88Nx/iWhOyXb+lwKL2wL00QpkoA7ibBnvxJ5eVrH12UIJ6ItD59zWkW
         2xQrp8UUYVDr5tAMkp0oPGAMZ7xbPUxM7tEOxQ/KafbZ4Mj1RualP3+y2i16P8yZwvBZ
         +TRg==
X-Gm-Message-State: AGRZ1gLPDsJbNmiOSheE9qebndaqUPkEBNBMF8+Scxu6gj/gEdtIbVmz
        DC6260RWLdcym/i//oQ4aQk=
X-Google-Smtp-Source: AJdET5cqgYxbmLlaDOfTjnK06OhbYXzoB6GS+ZUkwBkcCVoK8Qo7+nRBGmQFheVzRlC9CZoKde/EHg==
X-Received: by 2002:a17:902:4303:: with SMTP id i3-v6mr7496709pld.204.1542310735988;
        Thu, 15 Nov 2018 11:38:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i189-v6sm49542017pfc.16.2018.11.15.11.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:38:55 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:38:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181115193854.GA30639@roeck-us.net>
References: <20181115191126.GA16973@roeck-us.net>
 <e7f72ebb-68e8-29f4-121b-4053ec8b537e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f72ebb-68e8-29f4-121b-4053ec8b537e@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:29:04PM -0700, Jens Axboe wrote:
> On 11/15/18 12:11 PM, Guenter Roeck wrote:
> > On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
> >>
> >> I think the below patch should fix it.
> >>
> > 
> > I spoke too early. sparc64, next-20181115:
> > 
> > [   14.204370] nvme nvme0: pci function 0000:02:00.0
> > [   14.249956] nvme nvme0: Removing after probe failure status: -5
> > [   14.263496] ------------[ cut here ]------------
> > [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
> > [   14.264265] Trying to free already-free IRQ 9
> > [   14.264519] Modules linked in:
> > [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
> > [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
> > [   14.265899] Call Trace:
> > [   14.266118]  [000000000046944c] __warn+0xcc/0x100
> > [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
> > [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
> > [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
> > [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
> > [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
> > [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
> > [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
> > [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
> > [   14.268321]  [0000000000490624] kthread+0xe4/0x120
> > [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
> > [   14.268825]  [0000000000000000]           (null)
> > [   14.269089] irq event stamp: 32796
> > [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
> > [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
> > [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
> > [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
> > [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
> > 
> > Looks like an error during probe followed by an error cleanup problem.
> 
> Did it previous probe fine? Or is the new thing just the fact that
> we spew a warning on trying to free a non-existing vector?
> 
This works fine in mainline, if that is your question.

Guenter

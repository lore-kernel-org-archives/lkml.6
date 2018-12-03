Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33499C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E825020850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2D7K3Iw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E825020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeLCOP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:15:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeLCOP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:15:59 -0500
Received: from localhost (unknown [95.98.134.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B4220850;
        Mon,  3 Dec 2018 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543846488;
        bh=F+q8OrDhnmy+fKicqmrOiRGczbcFOMqHm/obRLbjmks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2D7K3Iw6PGOke1c+hBe5PraDdgRx9ekqAj7fYBMX2aIf5w6O0Nz0+VSrGKgqHoXRO
         fk227byB9b4OyB7yKwYq2CDSMDBxgueOsr9HrrtKztuO7lfJZ6fWVQTlyqFEv7DMrF
         imJ9sZjLhCApIy5VnmwhiniFYsg+50enWP3jqv+g=
Date:   Mon, 3 Dec 2018 15:14:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     sashal@kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: v4.14 fix for Hikey 960 unbalanced IRQ enablement
Message-ID: <20181203141442.GA19335@kroah.com>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203133107.4002-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:31:02AM -0200, Rafael David Tinoco wrote:
> Sasha, could you consider including this cherry-picked patchset in v4.14.
> 
> Kernel v4.14 might suffer from the following unbalanced enablement for the board Hikey 960:
> 
> Nov  5 12:02:54 hikey kernel: [   22.148194] Unbalanced enable for IRQ 44
> Nov  5 12:02:54 hikey kernel: [   22.152193] ------------[ cut here ]------------
> Nov  5 12:02:54 hikey kernel: [   22.156872] WARNING: CPU: 2 PID: 509 at /home/inaddy/work/sources/linux/stable/stable-linux-4.14.y/kernel/irq/manage.c:525 __enable_irq+0x78/0x80
> Nov  5 12:02:54 hikey kernel: [   22.249606] CPU: 2 PID: 509 Comm: kworker/2:2 Not tainted 4.14.79 #1
> Nov  5 12:02:54 hikey kernel: [   22.255975] Hardware name: HiKey Development Board (DT)
> Nov  5 12:02:54 hikey kernel: [   22.261248] Workqueue: events_freezable thermal_zone_device_check
> Nov  5 12:02:54 hikey kernel: [   22.267368] task: ffff8000616e0e00 task.stack: ffff00000b5f0000
> Nov  5 12:02:54 hikey kernel: [   22.273312] PC is at __enable_irq+0x78/0x80
> Nov  5 12:02:54 hikey kernel: [   22.277516] LR is at __enable_irq+0x78/0x80
> Nov  5 12:02:54 hikey kernel: [   22.281718] pc : [<ffff00000813e010>] lr : [<ffff00000813e010>] pstate: 000001c5
> Nov  5 12:02:54 hikey kernel: [   22.289129] sp : ffff00000b5f3c80
> Nov  5 12:02:54 hikey kernel: [   22.292457] x29: ffff00000b5f3c80 x28: 0000000000000000 
> Nov  5 12:02:54 hikey kernel: [   22.297804] x27: ffff80005c139e38 x26: ffff000008a71870 
> Nov  5 12:02:54 hikey kernel: [   22.303148] x25: 0000000000000000 x24: 0000000000000002 
> Nov  5 12:02:54 hikey kernel: [   22.308492] x23: ffff00000b5f3d9c x22: ffff80005d565e88 
> Nov  5 12:02:54 hikey kernel: [   22.313836] x21: 000000000000f980 x20: 000000000000002c 
> Nov  5 12:02:54 hikey kernel: [   22.319181] x19: ffff800061726000 x18: 0000000000000010 
> Nov  5 12:02:54 hikey kernel: [   22.324524] x17: 0000000000000000 x16: 0000000000000000 
> Nov  5 12:02:54 hikey kernel: [   22.329868] x15: ffffffffffffffff x14: ffff000009269c08 
> Nov  5 12:02:54 hikey kernel: [   22.335213] x13: ffff00008940678f x12: ffff000009406797 
> Nov  5 12:02:54 hikey kernel: [   22.340558] x11: ffff000009290000 x10: ffff00000b5f3980 
> Nov  5 12:02:54 hikey kernel: [   22.345902] x9 : 00000000ffffffd0 x8 : ffff00000862c298 
> Nov  5 12:02:54 hikey kernel: [   22.351246] x7 : 6c62616e65206465 x6 : 00000000000001b2 
> Nov  5 12:02:54 hikey kernel: [   22.356589] x5 : 0000000000000000 x4 : 0000000000000000 
> Nov  5 12:02:54 hikey kernel: [   22.361931] x3 : 0000000000000000 x2 : ffff800063e824c8 
> Nov  5 12:02:54 hikey kernel: [   22.367275] x1 : 000080005af95000 x0 : 000000000000001c 
> Nov  5 12:02:54 hikey kernel: [   22.372618] Call trace:
> Nov  5 12:02:54 hikey kernel: [   22.375088] Exception stack(0xffff00000b5f3b40 to 0xffff00000b5f3c80)
> Nov  5 12:02:54 hikey kernel: [   22.381560] 3b40: 000000000000001c 000080005af95000 ffff800063e824c8 0000000000000000
> Nov  5 12:02:54 hikey kernel: [   22.389417] 3b60: 0000000000000000 0000000000000000 00000000000001b2 6c62616e65206465
> Nov  5 12:02:54 hikey kernel: [   22.397276] 3b80: ffff00000862c298 00000000ffffffd0 ffff00000b5f3980 ffff000009290000
> Nov  5 12:02:54 hikey kernel: [   22.405136] 3ba0: ffff000009406797 ffff00008940678f ffff000009269c08 ffffffffffffffff
> Nov  5 12:02:54 hikey kernel: [   22.412994] 3bc0: 0000000000000000 0000000000000000 0000000000000010 ffff800061726000
> Nov  5 12:02:54 hikey kernel: [   22.420852] 3be0: 000000000000002c 000000000000f980 ffff80005d565e88 ffff00000b5f3d9c
> Nov  5 12:02:54 hikey kernel: [   22.428710] 3c00: 0000000000000002 0000000000000000 ffff000008a71870 ffff80005c139e38
> Nov  5 12:02:54 hikey kernel: [   22.436569] 3c20: 0000000000000000 ffff00000b5f3c80 ffff00000813e010 ffff00000b5f3c80
> Nov  5 12:02:54 hikey kernel: [   22.444426] 3c40: ffff00000813e010 00000000000001c5 0000000000000000 0000000000000000
> Nov  5 12:02:54 hikey kernel: [   22.452286] 3c60: ffffffffffffffff ffff800061800618 ffff00000b5f3c80 ffff00000813e010
> Nov  5 12:02:54 hikey kernel: [   22.460144] [<ffff00000813e010>] __enable_irq+0x78/0x80
> Nov  5 12:02:54 hikey kernel: [   22.465394] [<ffff00000813e058>] enable_irq+0x40/0x78
> Nov  5 12:02:54 hikey kernel: [   22.470493] [<ffff000000e228a8>] hisi_thermal_get_temp+0x1b0/0x1d8 [hisi_thermal]
> Nov  5 12:02:54 hikey kernel: [   22.478008] [<ffff0000087121a8>] of_thermal_get_temp+0x38/0x50
> Nov  5 12:02:54 hikey kernel: [   22.483869] [<ffff000008711790>] thermal_zone_get_temp+0x58/0x80
> Nov  5 12:02:54 hikey kernel: [   22.489903] [<ffff00000870e7bc>] thermal_zone_device_update.part.4+0x2c/0x1a8
> Nov  5 12:02:54 hikey kernel: [   22.497066] [<ffff00000870e9c8>] thermal_zone_device_check+0x40/0x50
> Nov  5 12:02:54 hikey kernel: [   22.503457] [<ffff0000080f1674>] process_one_work+0x19c/0x3d0
> Nov  5 12:02:54 hikey kernel: [   22.509236] [<ffff0000080f18f4>] worker_thread+0x4c/0x428
> Nov  5 12:02:54 hikey kernel: [   22.514664] [<ffff0000080f84fc>] kthread+0x134/0x138
> Nov  5 12:02:54 hikey kernel: [   22.519659] [<ffff000008085154>] ret_from_fork+0x10/0x1c
> Nov  5 12:02:54 hikey kernel: [   22.524988] ---[ end trace 328d4bb2d9b066a0 ]---
> 
> This issue was solved when "hisi_thermal_alarm_irq" function was removed so only
> "hisi_thermal_alarm_irq_thread" would exist. This has fixed the issue for the
> unbalanced enablement since there is no more:
> 
> 	disable_irq_nosync(irq);
> 	data->irq_enabled = false;
> 
> logic being done in parallel to the threaded handler AND the
> thermal_zone_device_update() call only happens now if the temperature is already
> above the threshold.
> 

So should we revert a patch instead of taking these new ones?  Would
that be easier and is this a "real" issue or just an annoying warning
splat in the kernel log?

thanks,

greg k-h

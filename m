Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EE1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0922087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547812978;
	bh=K3Ld0OfkCukyjdKpPmE6NCAdmDijhMtDnvwbjIp3eDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oYZyTCNsXHJqXvfbKyznNHQBpk3r9KFK0brqTmZ4BJ6bJSRJ2WsHjwjr0d/7PHJLs
	 tmLPx6NwYnW96vDPUeIpa1sOKyZerBkcKdLXgi3JIQJ0gG2NdY9AUchdixq/DaznW4
	 M78ELa8hqO3LoAYtcP6dl02SN79DUzC+aKd8B+nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfARMC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:02:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfARMC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:02:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DB02086D;
        Fri, 18 Jan 2019 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547812975;
        bh=K3Ld0OfkCukyjdKpPmE6NCAdmDijhMtDnvwbjIp3eDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wm2rHe6FIIrzpaiFmyNwbrMvSeYMcxOq8qL0C9K7YvA8zLoVqyQRqH9qWIuKRHcmz
         mZouISAt0KqqpPiCYE5CKdq/wF6uC9gAzJZDK07r9+eKNxcR9qC3Xqzfu21FMSZJSz
         D785X1bImKzwAR3+QVRh0YdNfSgj0ZIYgijLd6EQ=
Date:   Fri, 18 Jan 2019 13:02:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhe.he@windriver.com
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        bigeasy@linutronix.de, Jisheng.Zhang@synaptics.com,
        darwin.dingel@alliedtelesis.co.nz, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Fix serial8250 initialization crash
Message-ID: <20190118120253.GB5532@kroah.com>
References: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:00:19PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> The initialization code of interrupt backoff work might reference NULL
> pointer and cause the following crash, if no port was found.
> 
> [   10.017727] CPU 0 Unable to handle kernel paging request at virtual address 000001b0, epc == 807088e0, ra == 8070863c
> ---- snip ----
> [   11.704470] [<807088e0>] serial8250_register_8250_port+0x318/0x4ac
> [   11.747251] [<80708d74>] serial8250_probe+0x148/0x1c0
> [   11.789301] [<80728450>] platform_drv_probe+0x40/0x94
> [   11.830515] [<807264f8>] really_probe+0xf8/0x318
> [   11.870876] [<80726b7c>] __driver_attach+0x110/0x12c
> [   11.910960] [<80724374>] bus_for_each_dev+0x78/0xcc
> [   11.951134] [<80725958>] bus_add_driver+0x200/0x234
> [   11.989756] [<807273d8>] driver_register+0x84/0x148
> [   12.029832] [<80d72f84>] serial8250_init+0x138/0x198
> [   12.070447] [<80100e6c>] do_one_initcall+0x5c/0x2a0
> [   12.110104] [<80d3a208>] kernel_init_freeable+0x370/0x484
> [   12.150722] [<80a49420>] kernel_init+0x10/0xf8
> [   12.191517] [<8010756c>] ret_from_kernel_thread+0x14/0x1c
> 
> This patch makes sure the initialization code can be reached only if a port
> is found.
> 
> Fixes: commit 6d7f677a2afa ("serial: 8250: Rate limit serial port rx interrupts during input overruns")

No need for the "commit" in this string, this can just be written as:

Fixes: 6d7f677a2afa ("serial: 8250: Rate limit serial port rx interrupts during input overruns")

thanks,

greg k-h

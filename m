Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAF020851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAF020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeKTBVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:21:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729376AbeKTBVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:21:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C4DEACE5;
        Mon, 19 Nov 2018 14:57:18 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to phy_select/restore_page functions
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
        <20181008100728.24959-2-quentin.schulz@bootlin.com>
X-Yow:  Where's th' DAFFY DUCK EXHIBIT??
Date:   Mon, 19 Nov 2018 15:57:17 +0100
In-Reply-To: <20181008100728.24959-2-quentin.schulz@bootlin.com> (Quentin
        Schulz's message of "Mon, 8 Oct 2018 12:07:23 +0200")
Message-ID: <mvm8t1pazea.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 08 2018, Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> The Microsemi PHYs have multiple banks of registers (called pages).
> Registers can only be accessed from one page, if we need a register from
> another page, we need to switch the page and the registers of all other
> pages are not accessible anymore.
>
> Basically, to read register 5 from page 0, 1, 2, etc., you do the same
> phy_read(phydev, 5); but you need to set the desired page beforehand.
>
> In order to guarantee that two concurrent functions do not change the
> page, we need to do some locking per page. This can be achieved with the
> use of phy_select_page and phy_restore_page functions but phy_write/read
> calls in-between those two functions shall be replaced by their
> lock-free alternative __phy_write/read.
>
> Let's migrate this driver to those functions.

This has some serious locking problem.

[<0>] __schedule+0x25e/0x74c
[<0>] schedule+0x1a/0x58
[<0>] schedule_preempt_disabled+0xc/0x14
[<0>] __mutex_lock.isra.0+0x10e/0x22e
[<0>] __mutex_lock_slowpath+0xe/0x16
[<0>] mutex_lock+0x22/0x2a
[<0>] mdiobus_read+0x36/0x60
[<0>] vsc85xx_config_init+0x4c/0x1e2
[<0>] phy_init_hw+0x3c/0x52
[<0>] phy_attach_direct+0xec/0x1dc
[<0>] phy_connect_direct+0x1a/0x56
[<0>] macb_probe+0x800/0xb5e [macb]
[<0>] platform_drv_probe+0x3e/0x7e
[<0>] really_probe+0xba/0x310
[<0>] driver_probe_device+0x54/0xf2
[<0>] __driver_attach+0xde/0x106
[<0>] bus_for_each_dev+0x4a/0x72
[<0>] driver_attach+0x1a/0x22
[<0>] bus_add_driver+0x1ce/0x212
[<0>] driver_register+0x3a/0xd0
[<0>] __platform_driver_register+0x3a/0x42
[<0>] macb_driver_init+0x20/0x28 [macb]
[<0>] do_one_initcall+0x48/0x128
[<0>] do_init_module+0x4a/0x186
[<0>] load_module+0xd6a/0xe6a
[<0>] sys_finit_module+0xc6/0xfc
[<0>] check_syscall_nr+0x22/0x22

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

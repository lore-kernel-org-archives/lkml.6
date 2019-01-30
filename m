Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163A2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E466A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfA3SVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:21:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732918AbfA3SVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:21:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAEA180D;
        Wed, 30 Jan 2019 10:21:41 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312693F557;
        Wed, 30 Jan 2019 10:21:40 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:21:37 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Message-ID: <20190130182137.GN18558@fuggles.cambridge.arm.com>
References: <20190128094301.151252-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128094301.151252-1-drinkcat@chromium.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:43:01PM +0800, Nicolas Boichat wrote:
> L1 tables are allocated with __get_dma_pages, and therefore already
> ignored by kmemleak.
> 
> Without this, the kernel would print this error message on boot,
> when the first L1 table is allocated:
> 
> [    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
> [    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
> [    2.831227] Workqueue: events deferred_probe_work_func
> [    2.836353] Call trace:
> ...
> [    2.852532]  paint_ptr+0xa0/0xa8
> [    2.855750]  kmemleak_ignore+0x38/0x6c
> [    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
> [    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
> [    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
> ...
> 
> Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> I only tested this on top of my other series
> (https://patchwork.kernel.org/patch/10720495/), but I think the same fix
> applies. I'm still a bit confused as to why this only shows up now, as IIUC,
> the kmemleak_ignore call was always wrong with L1 tables.

Yes, I managed to reproduce this on top of -rc4 (see below). I suspect you
/are/ the intersection of people using v7s w/ kmemleak, so this has just
lingered and never been hit until now.

For the patch (assuming this is going via Joerg):

Acked-by: Will Deacon <will.deacon@arm.com>

Will

--->8

[    0.124473] kmemleak: Trying to color unknown object at 0xffff8000042d8000 as Black
[    0.125312] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc4-00012-g40b114779944 #1
[    0.126181] Hardware name: linux,dummy-virt (DT)
[    0.126680] Call trace:
[    0.126950]  dump_backtrace+0x0/0x140
[    0.127346]  show_stack+0x14/0x20
[    0.127706]  dump_stack+0x90/0xb4
[    0.128066]  paint_ptr+0x94/0xa8
[    0.128417]  kmemleak_ignore+0x54/0x60
[    0.128991]  __arm_v7s_alloc_table+0x6c/0x240
[    0.129661]  arm_v7s_alloc_pgtable+0x10c/0x188
[    0.130359]  alloc_io_pgtable_ops+0x44/0xb0
[    0.131006]  arm_v7s_do_selftests+0x84/0x4bc
[    0.131663]  do_one_initcall+0x74/0x178
[    0.132253]  kernel_init_freeable+0x188/0x220
[    0.132923]  kernel_init+0x10/0x100
[    0.133460]  ret_from_fork+0x10/0x18
[    0.142102] arm-v7s io-pgtable: self test ok

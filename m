Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB24C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC1B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfAQS6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:58:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:49334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfAQS6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:58:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 309BBAE77;
        Thu, 17 Jan 2019 18:58:30 +0000 (UTC)
Message-ID: <1547751492.2917.0.camel@suse.de>
Subject: Re: kmemleak scan crash due to invalid PFNs
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>, Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Jan 2019 19:58:12 +0100
In-Reply-To: <51e79597-21ef-3073-9036-cfc33291f395@lca.pw>
References: <51e79597-21ef-3073-9036-cfc33291f395@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 12:36 -0500, Qian Cai wrote:
> On an arm64 ThunderX2 server, the first kmemleak scan would crash
> with
> CONFIG_DEBUG_VM_PGFLAGS=y due to page_to_nid() found a pfn that is
> not directly
> mapped. Hence, the page->flags is not initialized.
> 
> Reverted 9f1eb38e0e113 (mm, kmemleak: little optimization while
> scanning) fixed
> the problem.

Thanks for reporting this.
I will take a look later.
(sorry for tue dupped mail, html sucks)

> 
> [  102.195320] Unable to handle kernel NULL pointer dereference at
> virtual
> address 0000000000000006
> [  102.204113] Mem abort info:
> [  102.206921]   ESR = 0x96000005
> [  102.209997]   Exception class = DABT (current EL), IL = 32 bits
> [  102.215926]   SET = 0, FnV = 0
> [  102.218993]   EA = 0, S1PTW = 0
> [  102.222150] Data abort info:
> [  102.225047]   ISV = 0, ISS = 0x00000005
> [  102.228887]   CM = 0, WnR = 0
> [  102.231866] user pgtable: 64k pages, 48-bit VAs, pgdp =
> (____ptrval____)
> [  102.238572] [0000000000000006] pgd=0000000000000000,
> pud=0000000000000000
> [  102.245448] Internal error: Oops: 96000005 [#1] SMP
> [  102.264062] CPU: 60 PID: 1408 Comm: kmemleak Not tainted 5.0.0-
> rc2+ #8
> [  102.280403] pstate: 60400009 (nZCv daif +PAN -UAO)
> [  102.280409] pc : page_mapping+0x24/0x144
> [  102.280415] lr : __dump_page+0x34/0x3dc
> [  102.292923] sp : ffff00003a5cfd10
> [  102.296229] x29: ffff00003a5cfd10 x28: 000000000000802f
> [  102.301533] x27: 0000000000000000 x26: 0000000000277d00
> [  102.306835] x25: ffff000010791f56 x24: ffff7fe000000000
> [  102.312138] x23: ffff000010772f8b x22: ffff00001125f670
> [  102.317442] x21: ffff000011311000 x20: ffff000010772f8b
> [  102.322747] x19: fffffffffffffffe x18: 0000000000000000
> [  102.328049] x17: 0000000000000000 x16: 0000000000000000
> [  102.333352] x15: 0000000000000000 x14: ffff802698b19600
> [  102.338654] x13: ffff802698b1a200 x12: ffff802698b16f00
> [  102.343956] x11: ffff802698b1a400 x10: 0000000000001400
> [  102.349260] x9 : 0000000000000001 x8 : ffff00001121a000
> [  102.354563] x7 : 0000000000000000 x6 : ffff0000102c53b8
> [  102.359868] x5 : 0000000000000000 x4 : 0000000000000003
> [  102.365173] x3 : 0000000000000100 x2 : 0000000000000000
> [  102.370476] x1 : ffff000010772f8b x0 : ffffffffffffffff
> [  102.375782] Process kmemleak (pid: 1408, stack limit =
> 0x(____ptrval____))
> [  102.382648] Call trace:
> [  102.385091]  page_mapping+0x24/0x144
> [  102.388659]  __dump_page+0x34/0x3dc
> [  102.392140]  dump_page+0x28/0x4c
> [  102.395363]  kmemleak_scan+0x4ac/0x680
> [  102.399106]  kmemleak_scan_thread+0xb4/0xdc
> [  102.403285]  kthread+0x12c/0x13c
> [  102.406509]  ret_from_fork+0x10/0x18
> [  102.410080] Code: d503201f f9400660 36000040 d1000413 (f9400661)
> [  102.416357] ---[ end trace 4d4bd7f573490c8e ]---
> [  102.420966] Kernel panic - not syncing: Fatal exception
> [  102.426293] SMP: stopping secondary CPUs
> [  102.431830] Kernel Offset: disabled
> [  102.435311] CPU features: 0x002,20000c38
> [  102.439223] Memory Limit: none
> [  102.442384] ---[ end Kernel panic - not syncing: Fatal exception
> ]---
-- 
Oscar Salvador
SUSE L3

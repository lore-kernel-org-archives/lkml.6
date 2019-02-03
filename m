Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A4320855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBCJjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:39:43 -0500
Received: from ozlabs.org ([203.11.71.1]:42857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfBCJjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:39:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43sm550vBPz9sMp;
        Sun,  3 Feb 2019 20:39:19 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 10/21] memblock: refactor internal allocation functions
In-Reply-To: <1548057848-15136-11-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com> <1548057848-15136-11-git-send-email-rppt@linux.ibm.com>
Date:   Sun, 03 Feb 2019 20:39:20 +1100
Message-ID: <87ftt5nrcn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@linux.ibm.com> writes:

> Currently, memblock has several internal functions with overlapping
> functionality. They all call memblock_find_in_range_node() to find free
> memory and then reserve the allocated range and mark it with kmemleak.
> However, there is difference in the allocation constraints and in fallback
> strategies.
>
> The allocations returning physical address first attempt to find free
> memory on the specified node within mirrored memory regions, then retry on
> the same node without the requirement for memory mirroring and finally fall
> back to all available memory.
>
> The allocations returning virtual address start with clamping the allowed
> range to memblock.current_limit, attempt to allocate from the specified
> node from regions with mirroring and with user defined minimal address. If
> such allocation fails, next attempt is done with node restriction lifted.
> Next, the allocation is retried with minimal address reset to zero and at
> last without the requirement for mirrored regions.
>
> Let's consolidate various fallbacks handling and make them more consistent
> for physical and virtual variants. Most of the fallback handling is moved
> to memblock_alloc_range_nid() and it now handles node and mirror fallbacks.
>
> The memblock_alloc_internal() uses memblock_alloc_range_nid() to get a
> physical address of the allocated range and converts it to virtual address.
>
> The fallback for allocation below the specified minimal address remains in
> memblock_alloc_internal() because memblock_alloc_range_nid() is used by CMA
> with exact requirement for lower bounds.

This is causing problems on some of my machines.

I see NODE_DATA allocations falling back to node 0 when they shouldn't,
or didn't previously.

eg, before:

57990190: (116011251): numa:   NODE_DATA [mem 0xfffe4980-0xfffebfff]
58152042: (116373087): numa:   NODE_DATA [mem 0x8fff90980-0x8fff97fff]

after:

16356872061562: (6296877055): numa:   NODE_DATA [mem 0xfffe4980-0xfffebfff]
16356872079279: (6296894772): numa:   NODE_DATA [mem 0xfffcd300-0xfffd497f]
16356872096376: (6296911869): numa:     NODE_DATA(1) on node 0


On some of my other systems it does that, and then panics because it
can't allocate anything at all:

[    0.000000] numa:   NODE_DATA [mem 0x7ffcaee80-0x7ffcb3fff]
[    0.000000] numa:   NODE_DATA [mem 0x7ffc99d00-0x7ffc9ee7f]
[    0.000000] numa:     NODE_DATA(1) on node 0
[    0.000000] Kernel panic - not syncing: Cannot allocate 20864 bytes for node 16 data
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4-gccN-next-20190201-gdc4c899 #1
[    0.000000] Call Trace:
[    0.000000] [c0000000011cfca0] [c000000000c11044] dump_stack+0xe8/0x164 (unreliable)
[    0.000000] [c0000000011cfcf0] [c0000000000fdd6c] panic+0x17c/0x3e0
[    0.000000] [c0000000011cfd90] [c000000000f61bc8] initmem_init+0x128/0x260
[    0.000000] [c0000000011cfe60] [c000000000f57940] setup_arch+0x398/0x418
[    0.000000] [c0000000011cfee0] [c000000000f50a94] start_kernel+0xa0/0x684
[    0.000000] [c0000000011cff90] [c00000000000af70] start_here_common+0x1c/0x52c
[    0.000000] Rebooting in 180 seconds..


So there's something going wrong there, I haven't had time to dig into
it though (Sunday night here).

cheers

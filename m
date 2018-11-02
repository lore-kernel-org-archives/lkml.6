Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB423C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A4920831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A4920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeKCCj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:39:59 -0400
Received: from foss.arm.com ([217.140.101.70]:44416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKCCj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:39:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 984A3A78;
        Fri,  2 Nov 2018 10:32:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FACB3F71E;
        Fri,  2 Nov 2018 10:32:01 -0700 (PDT)
Date:   Fri, 2 Nov 2018 17:31:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     will.deacon@arm.com, masami.hiramatsu@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: kprobe: make page to RO mode when allocate it
Message-ID: <20181102173159.GG218059@arrakis.emea.arm.com>
References: <20181030113850.31150-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030113850.31150-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:38:50PM +0100, Anders Roxell wrote:
> Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
> has successfully identified code that leaves a page with W+X
> permissions.
> 
> [    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval____)/0xffff000000d90000
> [    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_page+0x410/0x420
> [    3.246141] Modules linked in:
> [    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-20180928-00001-ge70ae259b853-dirty #62
> [    3.247008] Hardware name: linux,dummy-virt (DT)
> [    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    3.247623] pc : note_page+0x410/0x420
> [    3.247898] lr : note_page+0x410/0x420
> [    3.248071] sp : ffff00000804bcd0
> [    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
> [    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
> [    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
> [    3.249109] x23: 0000000000000004 x22: ffff000000d91000
> [    3.249396] x21: ffff000000d90000 x20: 0000000000000000
> [    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
> [    3.249924] x17: 0000000000000000 x16: 0000000000000000
> [    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
> [    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
> [    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
> [    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
> [    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
> [    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
> [    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
> [    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
> [    3.252664] Call trace:
> [    3.252953]  note_page+0x410/0x420
> [    3.253186]  walk_pgd+0x12c/0x238
> [    3.253417]  ptdump_check_wx+0x68/0xf8
> [    3.253637]  mark_rodata_ro+0x68/0x98
> [    3.253847]  kernel_init+0x38/0x160
> [    3.254103]  ret_from_fork+0x10/0x18
> 
> kprobes allocates a writable executable page with module_alloc() in
> order to store executable code.
> Reworked to that when allocate a page it sets mode RO. Inspired by
> commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()").
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Queued for 4.20 (and removed the signed-off-bys, added acks, removed
unnecessary casts). Thanks.

-- 
Catalin

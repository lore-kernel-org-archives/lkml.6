Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB77AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6760208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6760208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbeGJSin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:38:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51876 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389766AbeGJSin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:38:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57A4C19BF;
        Tue, 10 Jul 2018 10:21:16 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28A6E3F589;
        Tue, 10 Jul 2018 10:21:16 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id EF7271AE53F3; Tue, 10 Jul 2018 18:21:57 +0100 (BST)
Date:   Tue, 10 Jul 2018 18:21:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nikunj Kela <nkela@cisco.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: make flatmem depend on !NUMA
Message-ID: <20180710172157.GB10177@arm.com>
References: <20180710151639.2184213-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710151639.2184213-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 05:16:27PM +0200, Arnd Bergmann wrote:
> Building without NUMA but with FLATMEM results in a link error
> because mem_map[] is not available:
> 
> aarch64-linux-ld -EB -maarch64elfb --no-undefined -X -pie -shared -Bsymbolic --no-apply-dynamic-relocs --build-id -o .tmp_vmlinux1 -T ./arch/arm64/kernel/vmlinux.lds --whole-archive built-in.a --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a --end-group
> init/do_mounts.o: In function `mount_block_root':
> do_mounts.c:(.init.text+0x1e8): undefined reference to `mem_map'
> arch/arm64/kernel/vdso.o: In function `vdso_init':
> vdso.c:(.init.text+0xb4): undefined reference to `mem_map'
> 
> This uses the same trick as the other architectures, making flatmem
> depend on !NUMA to avoid the broken configuration.
> 
> Fixes: e7d4bac428ed ("arm64: add ARM64-specific support for flatmem")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, Arnd. I've picked this one up.

Will

Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7BD20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7BD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbeGIOQb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:16:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:33830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932574AbeGIOQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:16:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFA94ADF3;
        Mon,  9 Jul 2018 14:16:26 +0000 (UTC)
Date:   Mon, 9 Jul 2018 16:16:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180709141621.GD22297@dhcp22.suse.cz>
References: <20180705110716.3919-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705110716.3919-1-alex@ghiti.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC hugetlb guys - http://lkml.kernel.org/r/20180705110716.3919-1-alex@ghiti.fr]

On Thu 05-07-18 11:07:05, Alexandre Ghiti wrote:
> In order to reduce copy/paste of functions across architectures and then
> make riscv hugetlb port (and future ports) simpler and smaller, this
> patchset intends to factorize the numerous hugetlb primitives that are
> defined across all the architectures.
> 
> Except for prepare_hugepage_range, this patchset moves the versions that
> are just pass-through to standard pte primitives into
> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
> 
> s390 architecture has not been tackled in this serie since it does not
> use asm-generic/hugetlb.h at all.
> powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).
> 
> This patchset has been compiled on x86 only. 
> 
> Changelog:
> 
> v4:
>   Fix powerpc build error due to misplacing of #include
>   <asm-generic/hugetlb.h> outside of #ifdef CONFIG_HUGETLB_PAGE, as
>   pointed by Christophe Leroy.
> 
> v1, v2, v3:
>   Same version, just problems with email provider and misuse of
>   --batch-size option of git send-email
> 
> Alexandre Ghiti (11):
>   hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
>   hugetlb: Introduce generic version of hugetlb_free_pgd_range
>   hugetlb: Introduce generic version of set_huge_pte_at
>   hugetlb: Introduce generic version of huge_ptep_get_and_clear
>   hugetlb: Introduce generic version of huge_ptep_clear_flush
>   hugetlb: Introduce generic version of huge_pte_none
>   hugetlb: Introduce generic version of huge_pte_wrprotect
>   hugetlb: Introduce generic version of prepare_hugepage_range
>   hugetlb: Introduce generic version of huge_ptep_set_wrprotect
>   hugetlb: Introduce generic version of huge_ptep_set_access_flags
>   hugetlb: Introduce generic version of huge_ptep_get
> 
>  arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
>  arch/arm/include/asm/hugetlb.h               | 33 +----------
>  arch/arm64/include/asm/hugetlb.h             | 39 +++---------
>  arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
>  arch/mips/include/asm/hugetlb.h              | 40 +++----------
>  arch/parisc/include/asm/hugetlb.h            | 33 +++--------
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
>  arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
>  arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
>  arch/sh/include/asm/hugetlb.h                | 54 ++---------------
>  arch/sparc/include/asm/hugetlb.h             | 40 +++----------
>  arch/x86/include/asm/hugetlb.h               | 72 +----------------------
>  include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
>  15 files changed, 143 insertions(+), 384 deletions(-)
> 
> -- 
> 2.16.2

-- 
Michal Hocko
SUSE Labs

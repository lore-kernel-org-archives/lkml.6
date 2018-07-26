Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C50C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1725A20891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1725A20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeGZG41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:56:27 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50755 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbeGZG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:56:27 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 49C9B40005;
        Thu, 26 Jul 2018 05:41:03 +0000 (UTC)
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
Date:   Thu, 26 Jul 2018 05:41:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87d0vehx16.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is the result of the build for all arches tackled in this series 
rebased on 4.18-rc6:

arm:
         versatile_defconfig: without huge page OK
         keystone_defconfig: with huge page OK
arm64:
         defconfig: with huge page OK
ia64:
         generic_defconfig: with huge page OK
mips:
         Paul Burton tested cavium octeon with huge page OK
parisc:
         generic-64bit_defconfig: with huge page does not link
         generic-64bit_defconfig: without huge page does not link
         BUT not because of this series, any feedback welcome.
powerpc:
         ppc64_defconfig: without huge page OK
         ppc64_defconfig: with huge page OK
sh:
         dreamcast_defconfig: with huge page OK
sparc:
         sparc32_defconfig: without huge page OK
sparc64:
         sparc64_defconfig: with huge page OK
x86:
         with huge page OK

Alex

On 07/23/2018 02:00 PM, Michael Ellerman wrote:
> Alex Ghiti <alex@ghiti.fr> writes:
>
>> Does anyone have any suggestion about those patches ?
> Cross compiling it for some non-x86 arches would be a good start :)
>
> There are cross compilers available here:
>
>    https://mirrors.edge.kernel.org/pub/tools/crosstool/
>
>
> cheers
>
>> On 07/09/2018 02:16 PM, Michal Hocko wrote:
>>> [CC hugetlb guys - http://lkml.kernel.org/r/20180705110716.3919-1-alex@ghiti.fr]
>>>
>>> On Thu 05-07-18 11:07:05, Alexandre Ghiti wrote:
>>>> In order to reduce copy/paste of functions across architectures and then
>>>> make riscv hugetlb port (and future ports) simpler and smaller, this
>>>> patchset intends to factorize the numerous hugetlb primitives that are
>>>> defined across all the architectures.
>>>>
>>>> Except for prepare_hugepage_range, this patchset moves the versions that
>>>> are just pass-through to standard pte primitives into
>>>> asm-generic/hugetlb.h by using the same #ifdef semantic that can be
>>>> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.
>>>>
>>>> s390 architecture has not been tackled in this serie since it does not
>>>> use asm-generic/hugetlb.h at all.
>>>> powerpc could be factorized a bit more (cf huge_ptep_set_wrprotect).
>>>>
>>>> This patchset has been compiled on x86 only.
>>>>
>>>> Changelog:
>>>>
>>>> v4:
>>>>     Fix powerpc build error due to misplacing of #include
>>>>     <asm-generic/hugetlb.h> outside of #ifdef CONFIG_HUGETLB_PAGE, as
>>>>     pointed by Christophe Leroy.
>>>>
>>>> v1, v2, v3:
>>>>     Same version, just problems with email provider and misuse of
>>>>     --batch-size option of git send-email
>>>>
>>>> Alexandre Ghiti (11):
>>>>     hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
>>>>     hugetlb: Introduce generic version of hugetlb_free_pgd_range
>>>>     hugetlb: Introduce generic version of set_huge_pte_at
>>>>     hugetlb: Introduce generic version of huge_ptep_get_and_clear
>>>>     hugetlb: Introduce generic version of huge_ptep_clear_flush
>>>>     hugetlb: Introduce generic version of huge_pte_none
>>>>     hugetlb: Introduce generic version of huge_pte_wrprotect
>>>>     hugetlb: Introduce generic version of prepare_hugepage_range
>>>>     hugetlb: Introduce generic version of huge_ptep_set_wrprotect
>>>>     hugetlb: Introduce generic version of huge_ptep_set_access_flags
>>>>     hugetlb: Introduce generic version of huge_ptep_get
>>>>
>>>>    arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
>>>>    arch/arm/include/asm/hugetlb.h               | 33 +----------
>>>>    arch/arm64/include/asm/hugetlb.h             | 39 +++---------
>>>>    arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
>>>>    arch/mips/include/asm/hugetlb.h              | 40 +++----------
>>>>    arch/parisc/include/asm/hugetlb.h            | 33 +++--------
>>>>    arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +
>>>>    arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
>>>>    arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
>>>>    arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
>>>>    arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
>>>>    arch/sh/include/asm/hugetlb.h                | 54 ++---------------
>>>>    arch/sparc/include/asm/hugetlb.h             | 40 +++----------
>>>>    arch/x86/include/asm/hugetlb.h               | 72 +----------------------
>>>>    include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
>>>>    15 files changed, 143 insertions(+), 384 deletions(-)
>>>>
>>>> -- 
>>>> 2.16.2


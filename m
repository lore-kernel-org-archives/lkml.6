Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A667FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653662173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653662173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbeHCKqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:46:32 -0400
Received: from ozlabs.org ([203.11.71.1]:53181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeHCKqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:46:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hgkK0XF2z9s0R;
        Fri,  3 Aug 2018 18:51:04 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alex Ghiti <alex@ghiti.fr>, linux-mm@kvack.org,
        mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "aneesh.kumar\@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v5 09/11] hugetlb: Introduce generic version of huge_ptep_set_wrprotect
In-Reply-To: <90bf556f-144d-24b8-d2f6-70fee4a30559@ghiti.fr>
References: <20180731060155.16915-1-alex@ghiti.fr> <20180731060155.16915-10-alex@ghiti.fr> <87h8kfhg7o.fsf@concordia.ellerman.id.au> <6acb1389-6998-bafb-cf69-174fd522c04c@ghiti.fr> <90bf556f-144d-24b8-d2f6-70fee4a30559@ghiti.fr>
Date:   Fri, 03 Aug 2018 18:51:03 +1000
Message-ID: <87muu3hlzc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Sorry missed your previous mail.

Alex Ghiti <alex@ghiti.fr> writes:
> Ok, I tried every defconfig available:
>
> - for the nohash/32, I found that I could use mpc885_ads_defconfig and I 
> activated HUGETLBFS.
> I removed the definition of huge_ptep_set_wrprotect from 
> nohash/32/pgtable.h, add an #error in
> include/asm-generic/hugetlb.h right before the generic definition of 
> huge_ptep_set_wrprotect,
> and fell onto it at compile-time:
> => I'm pretty confident then that removing the definition of 
> huge_ptep_set_wrprotect does not
> break anythingin this case.

Thanks, that sounds good.

> - regardind book3s/32, I did not find any defconfig with 
> CONFIG_PPC_BOOK3S_32, CONFIG_PPC32
> allowing to enable huge page support (ie CONFIG_SYS_SUPPORTS_HUGETLBFS)
> => Do you have a defconfig that would allow me to try the same as above ?

I think you're right, it's dead code AFAICS.

We have:

config PPC_BOOK3S_64
        ...
	select SYS_SUPPORTS_HUGETLBFS

config PPC_FSL_BOOK3E
        ...
	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT || PPC64

config PPC_8xx
	...
	select SYS_SUPPORTS_HUGETLBFS


So we can't ever enable HUGETLBFS for Book3S 32.

Presumably the code got copied when we split the headers apart.

So I think you can just ignore that one, and we'll delete it.

cheers

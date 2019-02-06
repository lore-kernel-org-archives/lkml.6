Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE0220844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfBFK6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:58:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfBFK6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:58:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA21E8764F;
        Wed,  6 Feb 2019 10:58:51 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F11DB5D9C9;
        Wed,  6 Feb 2019 10:58:44 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:58:42 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Kr___m______ <rkrcmar@redhat.com>, kvm@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> iif
 KVM is supported
Message-ID: <20190206115842.2cd86269.cohuck@redhat.com>
In-Reply-To: <1549432390-11457-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549432390-11457-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 06 Feb 2019 10:58:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Feb 2019 14:53:10 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> I do not see any consistency about headers_install of <linux/kvm_para.h>
> and <asm/kvm_para.h>.
> 
> According to my analysis of Linux 5.0-rc5, there are 3 groups:
> 
>  [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported
> 
>     alpha, arm, hexagon, mips, powerpc, s390, sparc, x86
> 
>  [2] <asm/kvm_para.h> is exported, but <linux/kvm_para.h> is not
> 
>     arc, arm64, c6x, h8300, ia64, m68k, microblaze, nios2, openrisc
> 
>  [3] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported
> 
>     csky, nds32, riscv
> 
> This does not match to the actual KVM support. At least, [2] is
> half-baked.
> 
> Nor do arch maintainers look like they care about this. For example,
> commit 0add53713b1c ("microblaze: Add missing kvm_para.h to Kbuild")
> exported <asm/kvm_para.h> to user-space in order to fix an in-kernel
> build error.
> 
> We have two ways to make this consistent:
> 
>  [A] export both <linux/kvm_para.h> and <asm/kvm_para.h> for all
>      architectures, irrespective of the KVM support
> 
>  [B] Match the header export of <linux/kvm_para.h> and <asm/kvm_para.h>
>      to the KVM support
> 
> My first attempt was [A] because the code looks better, but Paolo
> showed preference in [B].
> 
>   https://patchwork.kernel.org/patch/10794919/
> 
> So, this commit is the implementation of [B].
> 
> For most architectures, <asm/kvm_para.h> was moved to the kernel-space.
> I changed include/uapi/linux/Kbuild so that it checks generated
> asm/kvm_para.h as well as check-in ones.
> 
> After this commit, there will be two groups:
> 
>  [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported
> 
>     arm arm64 mips powerpc s390 x86
> 
>  [2] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported
> 
>     alpha arc c6x csky h8300 hexagon ia64 m68k microblaze nds32 nios2
>     openrisc parisc riscv sh sparc unicore32 xtensa
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The alternative solution [A] is available at:
> https://patchwork.kernel.org/patch/10794919/
> 
> Comparing the code diff, I personally prefer [A]...

I think both are much better than the status quo. This approach makes
the diff a bit uglier, but the end result looks cleaner to me.

Acked-by: Cornelia Huck <cohuck@redhat.com>

> 
> 
>  arch/alpha/include/asm/Kbuild            | 1 +
>  arch/alpha/include/uapi/asm/kvm_para.h   | 2 --
>  arch/arc/include/asm/Kbuild              | 1 +
>  arch/arc/include/uapi/asm/Kbuild         | 1 -
>  arch/arm/include/uapi/asm/Kbuild         | 1 +
>  arch/arm/include/uapi/asm/kvm_para.h     | 2 --
>  arch/c6x/include/asm/Kbuild              | 1 +
>  arch/c6x/include/uapi/asm/Kbuild         | 1 -
>  arch/h8300/include/asm/Kbuild            | 1 +
>  arch/h8300/include/uapi/asm/Kbuild       | 1 -
>  arch/hexagon/include/asm/Kbuild          | 1 +
>  arch/hexagon/include/uapi/asm/kvm_para.h | 2 --
>  arch/ia64/include/asm/Kbuild             | 1 +
>  arch/ia64/include/uapi/asm/Kbuild        | 1 -
>  arch/m68k/include/asm/Kbuild             | 1 +
>  arch/m68k/include/uapi/asm/Kbuild        | 1 -
>  arch/microblaze/include/asm/Kbuild       | 1 +
>  arch/microblaze/include/uapi/asm/Kbuild  | 1 -
>  arch/mips/include/uapi/asm/Kbuild        | 1 +
>  arch/mips/include/uapi/asm/kvm_para.h    | 5 -----
>  arch/nios2/include/asm/Kbuild            | 1 +
>  arch/nios2/include/uapi/asm/Kbuild       | 1 -
>  arch/openrisc/include/asm/Kbuild         | 1 +
>  arch/openrisc/include/uapi/asm/Kbuild    | 1 -
>  arch/parisc/include/asm/Kbuild           | 1 +
>  arch/parisc/include/uapi/asm/Kbuild      | 1 -
>  arch/s390/include/uapi/asm/Kbuild        | 1 +
>  arch/s390/include/uapi/asm/kvm_para.h    | 8 --------
>  arch/sh/include/asm/Kbuild               | 1 +
>  arch/sh/include/uapi/asm/Kbuild          | 1 -
>  arch/sparc/include/asm/Kbuild            | 1 +
>  arch/sparc/include/uapi/asm/kvm_para.h   | 2 --
>  arch/unicore32/include/asm/Kbuild        | 1 +
>  arch/unicore32/include/uapi/asm/Kbuild   | 1 -
>  arch/xtensa/include/asm/Kbuild           | 1 +
>  arch/xtensa/include/uapi/asm/Kbuild      | 1 -
>  include/uapi/linux/Kbuild                | 2 ++
>  37 files changed, 20 insertions(+), 33 deletions(-)
>  delete mode 100644 arch/alpha/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/arm/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/hexagon/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/mips/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/s390/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/sparc/include/uapi/asm/kvm_para.h

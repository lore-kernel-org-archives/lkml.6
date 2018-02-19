Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeBSL0u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:26:50 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42651 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeBSL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:26:49 -0500
X-Google-Smtp-Source: AH8x227jc2k69l2WAXg9BV0Jq99Kfp5ysqm6eV0pr1ozMmRVKYCCUI/oNFJA2jinHpFqiDT81HIoTA==
From: Jan Glauber <jglauber@cavium.com>
X-Google-Original-From: Jan Glauber <jglauber@caviumnetworks.com>
Date: Mon, 19 Feb 2018 12:26:45 +0100
To: Will Deacon <will.deacon@arm.com>
Cc: John Garry <john.garry@huawei.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
Message-ID: <20180219111747.GA25218@wintermute>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
 <36bd758c-dd49-edef-cc1a-20f5b43f5011@huawei.com>
 <20180219110238.GA30394@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219110238.GA30394@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

I just hit the same issue with 4.16-rc2. The patch makes it compilable
again.

--Jan

On Mon, Feb 19, 2018 at 11:02:39AM +0000, Will Deacon wrote:
> Hi John,
> 
> On Mon, Feb 19, 2018 at 10:19:35AM +0000, John Garry wrote:
> > On 19/02/2018 06:39, Bhupesh Sharma wrote:
> > >Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> > >Silence Sparse warnings), compilation of arm64 architecture is broken
> > >with the following error messages:
> > >
> > >  AR      arch/arm64/kernel/built-in.o
> > >  arch/arm64/kernel/head.S: Assembler messages:
> > >  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >  arch/arm64/kernel/head.S:677: Error: junk at end of line, first
> > >  unrecognized character is `L'
> > >  arch/arm64/kernel/head.S:677: Error: unexpected characters following
> > >  instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
> > >  arch/arm64/kernel/head.S:677: Error: unexpected characters following
> > >  instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
> > >
> > >This patch fixes the same by using the UL() macro correctly for
> > >assigning the MPIDR_HWID_BITMASK macro value.
> > >
> > >Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > >---
> > > arch/arm64/include/asm/cputype.h | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> > >index eda8c5f629fc..350c76a1d15b 100644
> > >--- a/arch/arm64/include/asm/cputype.h
> > >+++ b/arch/arm64/include/asm/cputype.h
> > >@@ -20,7 +20,7 @@
> > >
> > > #define MPIDR_UP_BITMASK	(0x1 << 30)
> > > #define MPIDR_MT_BITMASK	(0x1 << 24)
> > >-#define MPIDR_HWID_BITMASK	0xff00ffffffUL
> > >+#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
> > 
> > Works for me.
> > 
> > FYI, I am using (old) gcc-linaro-4.8-2015.06-x86_64_aarch64.
> 
> Just to confirm: are you saying that this patch fixes the build for you,
> or that mainline builds for you and the patch is not needed?
> 
> Cheers,
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

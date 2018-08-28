Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CD4208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CD4208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeH1LBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:01:21 -0400
Received: from exmail.andestech.com ([59.124.169.137]:29445 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeH1LBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:01:20 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7S781Xu039142;
        Tue, 28 Aug 2018 15:08:02 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 28 Aug 2018
 15:10:31 +0800
Date:   Tue, 28 Aug 2018 15:10:32 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     <linux-riscv@lists.infradead.org>, <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <greentime@andestech.com>
Subject: Re: [PATCH] RISC-V: Mask out the F extension on systems without D
Message-ID: <20180828071032.GA16806@andestech.com>
References: <20180827220352.24301-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180827220352.24301-1-palmer@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7S781Xu039142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Mon, Aug 27, 2018 at 03:03:52PM -0700, Palmer Dabbelt wrote:
> The RISC-V Linux port doesn't support systems that have the F extension
> but don't have the D extension -- we actually don't support systems
> without D either, but Alan's patch set is rectifying that soon.  For now
> I think we can leave this in a semi-broken state and just wait for
> Alan's patch set to get merged for proper non-FPU support -- the patch
> set is starting to look good, so doing something in-between doesn't seem
> like it's worth the work.
> 
> I don't think it's worth fretting about support for systems with F but
> not D for now: our glibc ABIs are IMAC and IMAFDC so they probably won't
> end up being popular.  We can always extend this in the future.
> 
> CC: Alan Kao <alankao@andestech.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 17011a870044..652d102ffa06 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -57,5 +57,12 @@ void riscv_fill_hwcap(void)
>  	for (i = 0; i < strlen(isa); ++i)
>  		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>  
> +	/* We don't support systems with F but without D, so mask those out
> +	 * here. */
> +	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
> +		pr_info("This kernel does not support systems with F but not D");
> +		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
> +	}
> +

The commit message does address the problem and this patch does provide checks
and helpful information to users, but I wonder if we really need this patch, for
two reasons:

* Just as you mentioned, current glibc ABI does not support such a thing as
  IMAFC, so probably no one has had trouble with this.  To be honest, I suppose
  that anybody (RISC-V enthusiasts or vendors) who really need F-only support
  in kernel should get themself involved in the development by sending patches
  to improve.

* There are corner cases to let a F-only machine to pass the check in this
  patch.  For instance, a vendor decides to name her extension ISA as doom,
  and supports single-precision FP only, so her ISA string would be

    IMAFCXdoom.

  The variable elf_hwcap is calculated at the loop in line 57,58, the 'd'
  from Xdoom would bypass the check, while the underlying machine does not
  support double-precision FP.

>  	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
>  }
> -- 
> 2.16.4
>

I don't know if the reasons make sense to you, but anyway that's all I
would like to say about this patch.

Alan

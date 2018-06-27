Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A28226684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A28226684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeF0IvO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:51:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:9536 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933470AbeF0IvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:51:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 01:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="241028109"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO [192.168.4.139]) ([10.255.29.56])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2018 01:51:09 -0700
Subject: Re: [PATCH] x86/entry/64/compat: Fix "x86/entry/64/compat: Preserve
 r8-r11 in int $0x80"
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org
References: <6012b922485401bc42676e804171ded262fc2ef2.1530078306.git.luto@kernel.org>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <3554c7ba-d7d2-4255-cc10-4bfa45b4952d@intel.com>
Date:   Wed, 27 Jun 2018 16:51:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6012b922485401bc42676e804171ded262fc2ef2.1530078306.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/27/2018 1:45 PM, Andy Lutomirski wrote:
> Commit 8bb2610bc496 ("x86/entry/64/compat: Preserve r8-r11 in int
> $0x80") was busted.  My original patch had a minor conflict with
> some of the nospec changes.  git apply is very clever and silently
> accepted the patch by making the same changes to a different
> function in the same file.  There was obviously a huge offset, but
> git apply for some reason doesn't feel any need to say so.
>
> Move the changes to the correct function.  Now the
> test_syscall_vdso_32 selftests passes.
>
> If anyone cares to observe the original problem, try applying the
> patch at
> https://lore.kernel.org/lkml/d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org/raw
> to the kernel at 316d097c4cd4e7f2ef50c40cff2db266593c4ec4.  git am and
> git apply accept the patch without any complaints at all.  patch -p1
> at least prints out a message about the huge offset.
>
> Reported-by: zhijianx.li@intel.com
> Fixes: 8bb2610bc496 ("x86/entry/64/compat: Preserve r8-r11 in int $0x80")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Tested-by: Li Zhijian <zhijianx.li@intel.com>


> ---
>   arch/x86/entry/entry_64_compat.S | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index 9de7f1e1dede..7d0df78db727 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -84,13 +84,13 @@ ENTRY(entry_SYSENTER_compat)
>   	pushq	%rdx			/* pt_regs->dx */
>   	pushq	%rcx			/* pt_regs->cx */
>   	pushq	$-ENOSYS		/* pt_regs->ax */
> -	pushq   %r8			/* pt_regs->r8 */
> +	pushq   $0			/* pt_regs->r8  = 0 */
>   	xorl	%r8d, %r8d		/* nospec   r8 */
> -	pushq   %r9			/* pt_regs->r9 */
> +	pushq   $0			/* pt_regs->r9  = 0 */
>   	xorl	%r9d, %r9d		/* nospec   r9 */
> -	pushq   %r10			/* pt_regs->r10 */
> +	pushq   $0			/* pt_regs->r10 = 0 */
>   	xorl	%r10d, %r10d		/* nospec   r10 */
> -	pushq   %r11			/* pt_regs->r11 */
> +	pushq   $0			/* pt_regs->r11 = 0 */
>   	xorl	%r11d, %r11d		/* nospec   r11 */
>   	pushq   %rbx                    /* pt_regs->rbx */
>   	xorl	%ebx, %ebx		/* nospec   rbx */
> @@ -374,13 +374,13 @@ ENTRY(entry_INT80_compat)
>   	pushq	%rcx			/* pt_regs->cx */
>   	xorl	%ecx, %ecx		/* nospec   cx */
>   	pushq	$-ENOSYS		/* pt_regs->ax */
> -	pushq   $0			/* pt_regs->r8  = 0 */
> +	pushq   %r8			/* pt_regs->r8 */
>   	xorl	%r8d, %r8d		/* nospec   r8 */
> -	pushq   $0			/* pt_regs->r9  = 0 */
> +	pushq   %r9			/* pt_regs->r9 */
>   	xorl	%r9d, %r9d		/* nospec   r9 */
> -	pushq   $0			/* pt_regs->r10 = 0 */
> +	pushq   %r10			/* pt_regs->r10*/
>   	xorl	%r10d, %r10d		/* nospec   r10 */
> -	pushq   $0			/* pt_regs->r11 = 0 */
> +	pushq   %r11			/* pt_regs->r11 */
>   	xorl	%r11d, %r11d		/* nospec   r11 */
>   	pushq   %rbx                    /* pt_regs->rbx */
>   	xorl	%ebx, %ebx		/* nospec   rbx */

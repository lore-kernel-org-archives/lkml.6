Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9DB2FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF7A20864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF7A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbeFOEZq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:25:46 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:52446 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeFOEZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:25:44 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id w5F4OXv6009397; Fri, 15 Jun 2018 13:24:34 +0900
X-Iguazu-Qid: 34tIVOFt9LkeQsXUcy
X-Iguazu-QSIG: v=1; s=0; t=1529036673; q=34tIVOFt9LkeQsXUcy; m=QUIW+ptMhDpD0HvPXyZlspWrT/9BmVucJFbV42nCF/4=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1511) id w5F4OUQX013970;
        Fri, 15 Jun 2018 13:24:30 +0900
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by imx12.toshiba.co.jp  with ESMTP id w5F4OUUc002439;
        Fri, 15 Jun 2018 13:24:30 +0900 (JST)
From:   "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <stable@vger.kernel.org>, "'Andy Lutomirski'" <luto@kernel.org>,
        "'Rik van Riel'" <riel@redhat.com>,
        "'Borislav Petkov'" <bp@alien8.de>,
        "'Brian Gerst'" <brgerst@gmail.com>,
        "'Dave Hansen'" <dave.hansen@linux.intel.com>,
        "'Denys Vlasenko'" <dvlasenk@redhat.com>,
        "'Fenghua Yu'" <fenghua.yu@intel.com>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        "'Josh Poimboeuf'" <jpoimboe@redhat.com>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Oleg Nesterov'" <oleg@redhat.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Quentin Casasnovas'" <quentin.casasnovas@oracle.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>, <pbonzini@redhat.com>,
        "'Ingo Molnar'" <mingo@kernel.org>
References: <20180614132724.483802160@linuxfoundation.org> <20180614132724.905032027@linuxfoundation.org>
In-Reply-To: <20180614132724.905032027@linuxfoundation.org>
Subject: RE: [PATCH 4.4 10/24] x86/fpu: Hard-disable lazy FPU mode
Date:   Fri, 15 Jun 2018 13:24:27 +0900
X-TSB-HOP: ON
Message-ID: <000c01d40460$bfc97710$3f5c6530$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUQj4igkaupq7EehpFPqRFc6I8UgHKB38SpNHsNUA=
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

>  /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -58,7 +58,7 @@ extern u64 fpu__get_supported_xfeatures_
>   */
>  static __always_inline __pure bool use_eager_fpu(void)
>  {
> -	return static_cpu_has_safe(X86_FEATURE_EAGER_FPU);
> +	return true;
>  }

Since this function returns always true then we can remove the code depending on lazy FPU mode.
Actually this has already been done in "x86/fpu: Remove use_eager_fpu()"
Ref: https://patchwork.kernel.org/patch/9365883/

>  static void __init fpu__init_parse_early_param(void)
>  {
> -	if (cmdline_find_option_bool(boot_command_line, "eagerfpu=off")) {
> -		eagerfpu = DISABLE;
> -		fpu__clear_eager_fpu_features();
> -	}

Since this patch removes the kernel boot parameter "eagerfpu", maybe we should remove it from the Documentation.
This has also been done by commit "x86/fpu: Finish excising 'eagerfpu'"
Ref: https://patchwork.kernel.org/patch/9380673/

I will try backporting those patches unless anyone has any objections.

Thanks,
Daniel Sangorrin




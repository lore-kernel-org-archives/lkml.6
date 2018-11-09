Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9C4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C47620818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ADj5ptem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C47620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeKJCbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:31:33 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56114 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeKJCbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:31:33 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B7DB424E0D1A;
        Fri,  9 Nov 2018 08:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541782211; bh=D+fj4bVA05n295NozqYkKR7cMfAh541g8rYlP7avEuA=;
        h=From:To:CC:Subject:Date:References:From;
        b=ADj5ptemN5XIVa4dmwrElFmFoxGDS74gYUsPz+aG2hAczAWi7w4EV589SefRFDWjK
         Av1qPauK0qPAORVKRo6NPUIsaQTWUumLiLYLGRrHqPUgh12osdODbPI/zf2FhmVmKA
         Vmm2KvrqoLl3apuJ0bA3EWPwVimMT21dsKb/fhBpC2WO3cUgqubMfeKWbTvgiSpzhd
         VitW05pxQjJmzTofsvFYXFR9JwIRdh/KXbHuv33hJ7YNflrR/gJ/PlnHLePR6hCeUM
         h2e5P9UW8OHLeP5EvkTuDDHd7HE9F1w9ZR72RgbwXqqzrnE212NQuv86q1dkfvwfy/
         DHBOgLIm2tK/A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id C4A573D47;
        Fri,  9 Nov 2018 08:50:09 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri, 9
 Nov 2018 08:50:09 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
CC:     Elvira Khabirova <lineprinter@altlinux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
Thread-Topic: [PATCH 06/13] arc: define syscall_get_arch()
Thread-Index: AQHUd9qPWfzlAeDkY06iwsmGassPrQ==
Date:   Fri, 9 Nov 2018 16:50:09 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A59239B@us01wembx1.internal.synopsys.com>
References: <20181109031605.GF21511@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 7:16 PM, Dmitry V. Levin wrote:=0A=
> syscall_get_arch() is required to be implemented on all architectures=0A=
> that use tracehook_report_syscall_entry() in order to extend=0A=
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.=0A=
>=0A=
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>=0A=
> ---=0A=
>  arch/arc/include/asm/syscall.h | 6 ++++++=0A=
>  include/uapi/linux/audit.h     | 1 +=0A=
>  2 files changed, 7 insertions(+)=0A=
>=0A=
> diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscal=
l.h=0A=
> index 29de09804306..5662778a7411 100644=0A=
> --- a/arch/arc/include/asm/syscall.h=0A=
> +++ b/arch/arc/include/asm/syscall.h=0A=
> @@ -9,6 +9,7 @@=0A=
>  #ifndef _ASM_ARC_SYSCALL_H=0A=
>  #define _ASM_ARC_SYSCALL_H  1=0A=
>  =0A=
> +#include <uapi/linux/audit.h>=0A=
>  #include <linux/err.h>=0A=
>  #include <linux/sched.h>=0A=
>  #include <asm/unistd.h>=0A=
> @@ -68,4 +69,9 @@ syscall_get_arguments(struct task_struct *task, struct =
pt_regs *regs,=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +static inline int syscall_get_arch(void)=0A=
> +{=0A=
> +	return AUDIT_ARCH_ARC;=0A=
> +}=0A=
> +=0A=
=0A=
Does ptrace (or user of this API) need a unique value per arch. Otherwise i=
nstead=0A=
of adding the boilerplate code to all arches, they could simply define AUDI=
T_ARCH=0A=
and common code could return it. Also the EM_xxx are not there in=0A=
include/uapi/linux/elf.h to begin with since libc elf.h already defines the=
m.=0A=
=0A=
>  #endif=0A=
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h=0A=
> index 818ae690ab79..a7149ceb5b98 100644=0A=
> --- a/include/uapi/linux/audit.h=0A=
> +++ b/include/uapi/linux/audit.h=0A=
> @@ -375,6 +375,7 @@ enum {=0A=
>  =0A=
>  #define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_L=
E)=0A=
>  #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)=
=0A=
> +#define AUDIT_ARCH_ARC		(EM_ARC)=0A=
>  #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)=0A=
>  #define AUDIT_ARCH_ARMEB	(EM_ARM)=0A=
>  #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)=0A=
=0A=
So I don't have the context of this patch (or coverletter) but what exactly=
 are we=0A=
trying to do with this (adding LE to audit)  - what happens when an arch is=
=0A=
capable of either and is say built for BE ?=0A=

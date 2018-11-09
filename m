Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE67C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCF42081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C7pODv2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCF42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeKJJV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:21:58 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:36442 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKJJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:21:58 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F0CD210C1025;
        Fri,  9 Nov 2018 15:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541806748; bh=Ew1Ngv4Ms5KG5ilq6aKZ7ogzGfOSePvWuDpgphPRQTk=;
        h=From:To:CC:Subject:Date:References:From;
        b=C7pODv2EB/bFo0byPs/m1ZwVyqzxtOd3ffrP70Bi1EIpTRWLjAnltuu5Pq/ZuI9XN
         FY9SxHgz7SUsRHPA5UStTzR69YqDImUBw10qxYAQvpZFTW9X/7nWIMm+rIigdFAHkG
         EwnwmB5x6tGx9DydgbZVJ3y716gIdg/P6dQ855rm/roCks3lXje7s63O5Fk+AjiKH5
         P76TKHyvixHqg1DnyoAdAUjjd9UeaOiV+fiCVeU0Dp0KJxMFEqIH8nh9NH9mV+BHAx
         luXEUoLc/httHwgtbGeQSiyK5uPiq3BqUNrsBaNXTVjegMBZ9iCfMpJkBXWVZVi5zc
         x9htPxCwnQziQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id A7B9D5FC6;
        Fri,  9 Nov 2018 15:39:07 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 9 Nov 2018 15:39:07 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
CC:     Elvira Khabirova <lineprinter@altlinux.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13 v2] arc: define syscall_get_arch()
Thread-Topic: [PATCH 06/13 v2] arc: define syscall_get_arch()
Thread-Index: AQHUeISowsnA4GsWFEWQpGdc0LUZ4A==
Date:   Fri, 9 Nov 2018 23:39:07 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A59253C@us01wembx1.internal.synopsys.com>
References: <20181109031605.GF21511@altlinux.org>
 <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
 <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
 <456a69c6e01a6ab5b1af6d459a249388f8b4c1f5.camel@synopsys.com>
 <C6CF3942-3307-431F-B76C-B550BB48F472@amacapital.net>
 <215d66fd9a197b631973c9ff75943b4c1216b899.camel@synopsys.com>
 <CALCETrXCcBBTzcL_yz3agNhby1huZSn2UGtJ9Soo=8n8_rj1Tg@mail.gmail.com>
 <20181109233342.GC2710@altlinux.org>
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

On 11/9/18 3:33 PM, Dmitry V. Levin wrote:=0A=
> syscall_get_arch() is required to be implemented on all architectures=0A=
> that use tracehook_report_syscall_entry() in order to extend=0A=
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.=0A=
>=0A=
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>=0A=
> ---=0A=
> v2: define AUDIT_ARCH_ARCOMPACT, AUDIT_ARCH_ARCOMPACTLE, AUDIT_ARCH_ARCV2=
,=0A=
> and AUDIT_ARCH_ARCV2LE instead of AUDIT_ARCH_ARC, update=0A=
> syscall_get_arch() implementation accordingly.=0A=
>=0A=
>  arch/arc/include/asm/syscall.h | 18 ++++++++++++++++++=0A=
>  include/uapi/linux/audit.h     |  4 ++++=0A=
>  2 files changed, 22 insertions(+)=0A=
>=0A=
> diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscal=
l.h=0A=
> index 29de09804306..a1b698290778 100644=0A=
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
> @@ -68,4 +69,21 @@ syscall_get_arguments(struct task_struct *task, struct=
 pt_regs *regs,=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +static inline int syscall_get_arch(void)=0A=
> +{=0A=
> +#ifdef CONFIG_ISA_ARCOMPACT=0A=
> +# ifdef CONFIG_CPU_BIG_ENDIAN=0A=
> +	return AUDIT_ARCH_ARCOMPACT;=0A=
> +# else=0A=
> +	return AUDIT_ARCH_ARCOMPACTLE;=0A=
> +# endif=0A=
> +#else	/* CONFIG_ISA_ARCV2 */=0A=
> +# ifdef CONFIG_CPU_BIG_ENDIAN=0A=
> +	return AUDIT_ARCH_ARCV2;=0A=
> +# else=0A=
> +	return AUDIT_ARCH_ARCV2LE;=0A=
> +# endif=0A=
> +#endif=0A=
> +}=0A=
=0A=
Bike shedding, but will using IS_ENABLED make the code any better.=0A=
=0A=
=0A=
> +=0A=
>  #endif=0A=
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h=0A=
> index 818ae690ab79..8e70fb70b8f8 100644=0A=
> --- a/include/uapi/linux/audit.h=0A=
> +++ b/include/uapi/linux/audit.h=0A=
> @@ -375,6 +375,10 @@ enum {=0A=
>  =0A=
>  #define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_L=
E)=0A=
>  #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)=
=0A=
> +#define AUDIT_ARCH_ARCOMPACT	(EM_ARCOMPACT)=0A=
> +#define AUDIT_ARCH_ARCOMPACTLE	(EM_ARCOMPACT|__AUDIT_ARCH_LE)=0A=
> +#define AUDIT_ARCH_ARCV2	(EM_ARCV2)=0A=
> +#define AUDIT_ARCH_ARCV2LE	(EM_ARCV2|__AUDIT_ARCH_LE)=0A=
=0A=
More Bike shedding, can we make LE as default and add BE suffixes variants =
please.=0A=

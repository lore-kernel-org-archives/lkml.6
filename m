Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F73C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A452081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ns7BFJfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A452081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeKJE1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:27:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41269 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJE1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:27:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id e22-v6so1307550pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vvHbhpCy678InfazlDZuMjGHDVImcw38UcNI4N/yahg=;
        b=ns7BFJfJ6C5yYBdcEFt2HqmTATpQaFb4HF+xU4aigMrCNBu6jKEgwpxTGWEpLt6MTj
         BRVPg48zrgq3R6EIRH6G5H1zXqAOYSlSMG3byQMQT2P4iyzit0nnINGZsETe9JBM16bE
         cG6+W8IF65f42wSgb6EdLVQQK3bWqNXcfJvHG8LJB5jYHNd9mnCOtQeErdvSZk/+1JeT
         qACQ8A5uTPQ8E021eeRB87TX5pw7V32GOR+p1FUbzLRgJ1KeUcFP3CAud3mVHAjfnxUt
         4NduTzSnPHzV3RvrWYYWHuCaILFrXUD6qx4VwQTp/txY+IYEVHxpy5jF7WYHh8/IP8o3
         L5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vvHbhpCy678InfazlDZuMjGHDVImcw38UcNI4N/yahg=;
        b=GBPhCbp6wzPq95z36LBDzIubnCzVDY4MjWuU8mhH5dVIQwdGx5hhq7MC8mHVd+pMTS
         ZpTNpwNsk2eUT5RC5CoD/PBQdv53DN8mKfwfWTWRl5JuVTrNQl2pwu56mCQx5wBiB3dV
         DX9/FPFImsZdnTrlrS6gGFwueCCa0f2j2GD9eNI3D7De8201469o9xYWB8PNhPFxu4FP
         YBXyRrlSXROjf1RB4v9rRSwu3gpNbYaBMAbkt/rPDiMI8lmp+HtDCBeYEvIUdnUHGgKZ
         VCOLENgrtwZn2ejpsNYyO3fbEb8bOAwFYXpknNLdmZutymIjXpgajSt1cxtXpuXBv5Id
         d97w==
X-Gm-Message-State: AGRZ1gKJvXXyTV+i4Ja5wLBEXeVBIPsQew/009tW2naX1t95jQioTLJ8
        PDYOg16O9SzuP4j+RSt6E9IEIw==
X-Google-Smtp-Source: AJdET5dZM4EnNQT9KOuW+j14O1CdzgWVgASrArpOuEU5BPZ9wC6IZ7FvTdc3P4SFN3j6fK12zB10Ww==
X-Received: by 2002:a63:4141:: with SMTP id o62-v6mr7851005pga.370.1541789155537;
        Fri, 09 Nov 2018 10:45:55 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u76-v6sm9511558pfa.176.2018.11.09.10.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 10:45:54 -0800 (PST)
Date:   Fri, 09 Nov 2018 10:45:54 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 10:45:34 PST (-0800)
Subject:     Re: [PATCH 12/13] riscv: define syscall_get_arch()
In-Reply-To: <20181109031712.GL21511@altlinux.org>
CC:     luto@kernel.org, aou@eecs.berkeley.edu, paul@paul-moore.com,
        eparis@redhat.com, lineprinter@altlinux.org,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     ldv@altlinux.org
Message-ID: <mhng-2fa4cce8-2365-4f36-a07e-5f9ad61cfb88@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018 19:17:13 PST (-0800), ldv@altlinux.org wrote:
> syscall_get_arch() is required to be implemented on all architectures
> that use tracehook_report_syscall_entry() in order to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/riscv/include/asm/syscall.h | 6 ++++++
>  include/uapi/linux/audit.h       | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index 8d25f8904c00..7e1e26ca7317 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -18,6 +18,7 @@
>  #ifndef _ASM_RISCV_SYSCALL_H
>  #define _ASM_RISCV_SYSCALL_H
>
> +#include <uapi/linux/audit.h>
>  #include <linux/sched.h>
>  #include <linux/err.h>
>
> @@ -99,4 +100,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
>  }
>
> +static inline int syscall_get_arch(void)
> +{
> +	return AUDIT_ARCH_RISCV;
> +}
> +
>  #endif	/* _ASM_RISCV_SYSCALL_H */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index c4c8b131af48..ad4105c602a1 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -405,6 +405,7 @@ enum {
>  /* do not define AUDIT_ARCH_PPCLE since it is not supported by audit */
>  #define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_RISCV	(EM_RISCV|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_S390		(EM_S390)
>  #define AUDIT_ARCH_S390X	(EM_S390|__AUDIT_ARCH_64BIT)
>  #define AUDIT_ARCH_SH		(EM_SH)

I think this is incorrect: EM_RISCV has 32-bit and 64-bit variants, and if I 
understand what's going on here this is marking all RISC-V targets as 64-bit.  
Since this is a userspace header, I think the right thing to switch on is 
__riscv_xlen, which will be defined to either 32 or 64 depending on the base 
ISA.

We're also little endian.

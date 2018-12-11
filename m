Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E07BC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CB020880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CB020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLKWkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:40:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKWkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:40:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD6545F;
        Tue, 11 Dec 2018 22:40:51 +0000 (UTC)
Received: from ovpn-120-31.rdu2.redhat.com (ovpn-120-31.rdu2.redhat.com [10.10.120.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0D15600C9;
        Tue, 11 Dec 2018 22:40:33 +0000 (UTC)
Message-ID: <32ecedb571206e462f2bc683219b8b8c349a1702.camel@redhat.com>
Subject: Re: [PATCH v5 04/25] c6x: define syscall_get_arch()
From:   Mark Salter <msalter@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-c6x-dev@linux-c6x.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 17:40:33 -0500
In-Reply-To: <20181210042912.GD6131@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
         <20181210042912.GD6131@altlinux.org>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 11 Dec 2018 22:40:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 07:29 +0300, Dmitry V. Levin wrote:
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
> 
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> 
> Notes:
>     v5: added Cc
> 
>  arch/c6x/include/asm/syscall.h | 7 +++++++
>  include/uapi/linux/audit.h     | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/c6x/include/asm/syscall.h b/arch/c6x/include/asm/syscall.h
> index ae2be315ee9c..39dbd1ef994c 100644
> --- a/arch/c6x/include/asm/syscall.h
> +++ b/arch/c6x/include/asm/syscall.h
> @@ -11,6 +11,7 @@
>  #ifndef __ASM_C6X_SYSCALL_H
>  #define __ASM_C6X_SYSCALL_H
>  
> +#include <uapi/linux/audit.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  
> @@ -120,4 +121,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  	}
>  }
>  
> +static inline int syscall_get_arch(void)
> +{
> +	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
> +		? AUDIT_ARCH_C6XBE : AUDIT_ARCH_C6X;
> +}
> +
>  #endif /* __ASM_C6X_SYSCALLS_H */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index bedf3bf54c3a..72aeea0a740d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -381,6 +381,8 @@ enum {
>  #define AUDIT_ARCH_ARCV2BE	(EM_ARCV2)
>  #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_ARMEB	(EM_ARM)
> +#define AUDIT_ARCH_C6X		(EM_TI_C6000|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_C6XBE	(EM_TI_C6000)
>  #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_FRV		(EM_FRV)
>  #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)

Acked-by: Mark Salter <msalter@redhat.com>



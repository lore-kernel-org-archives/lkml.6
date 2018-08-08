Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D576C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E6421A18
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ibe9tK0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E6421A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHHRc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:32:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35108 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHHRc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:32:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w78F8cLf157018;
        Wed, 8 Aug 2018 15:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yVeXUfGm2Xtt+y+z802k2ADgSim0zIGXuHWPd9jZS4w=;
 b=Ibe9tK0EKxRcJ8QkftwikrId1NnZzF0arKJGayCukmSn9V55LJbKDQXL6QQV6WKSAdmV
 ufyNzkUsX6gm1dwXtPRl+Xf/VbSajOoKBKK1rp3c23sHJbILb/4Nl7iIxlo4PB/GvXXc
 VUyLeBwdchxHgtmlZi6HktfX0/xufu8OtRpBW4D4J0J61ve6EbuGWa5lElmCosphpXXh
 IoTPWrUIUTmf7j/lZ4mqpMSA5tnIDhMOJC4tra/osCeb/T2ccKzGCoQ9oMNeBETLJufY
 zmC3wbMHeohs+ZgFF/sA51nav2CuGA18f+PJb+f+HmcCUx9ylQM+m6H0dlk0AxnRU7q+ VA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kn4spx50h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 15:12:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w78FC5hw006034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 15:12:06 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w78FC3Pg022862;
        Wed, 8 Aug 2018 15:12:03 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 08:12:00 -0700
Subject: Re: [PATCH v2] xen: move pv irq related functions under CONFIG_XEN_PV
 umbrella
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com
References: <20180808061918.5033-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <b7909bb0-ed7c-2640-3f50-136c9e8abf3d@oracle.com>
Date:   Wed, 8 Aug 2018 11:13:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808061918.5033-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 maintainers, this needs you ack too even though it has "xen" tag in
the subject, thanks.


On 08/08/2018 02:19 AM, Juergen Gross wrote:
> All functions in arch/x86/xen/irq.c and arch/x86/xen/xen-asm*.S are
> specific to PV guests. Include them in the kernel with
> CONFIG_XEN_PV only.
>
> Make the PV specific code in arch/x86/entry/entry_*.S dependent on
> CONFIG_XEN_PV instead of CONFIG_XEN.
>
> The HVM specific code should depend on CONFIG_XEN_PVHVM.
>
> While at it reformat the Makefile to make it more readable.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


> ---
>  arch/x86/entry/entry_32.S |  8 +++++---
>  arch/x86/entry/entry_64.S |  8 +++++---
>  arch/x86/xen/Makefile     | 41 +++++++++++++++++++++++++++++++----------
>  include/xen/events.h      |  2 ++
>  4 files changed, 43 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index c371bfee137a..cc4ec4fd58d2 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -369,7 +369,7 @@ GLOBAL(__begin_SYSENTER_singlestep_region)
>   * will ignore all of the single-step traps generated in this range.
>   */
>  
> -#ifdef CONFIG_XEN
> +#ifdef CONFIG_XEN_PV
>  /*
>   * Xen doesn't set %esp to be precisely what the normal SYSENTER
>   * entry point expects, so fix it up before using the normal path.
> @@ -807,7 +807,7 @@ ENTRY(spurious_interrupt_bug)
>  	jmp	common_exception
>  END(spurious_interrupt_bug)
>  
> -#ifdef CONFIG_XEN
> +#ifdef CONFIG_XEN_PV
>  ENTRY(xen_hypervisor_callback)
>  	pushl	$-1				/* orig_ax = -1 => not a system call */
>  	SAVE_ALL
> @@ -888,11 +888,13 @@ ENTRY(xen_failsafe_callback)
>  	_ASM_EXTABLE(3b, 8b)
>  	_ASM_EXTABLE(4b, 9b)
>  ENDPROC(xen_failsafe_callback)
> +#endif /* CONFIG_XEN_PV */
>  
> +#ifdef CONFIG_XEN_PVHVM
>  BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
>  		 xen_evtchn_do_upcall)
> +#endif
>  
> -#endif /* CONFIG_XEN */
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 8ae7ffda8f98..3c2526e24dd8 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1049,7 +1049,7 @@ ENTRY(do_softirq_own_stack)
>  	ret
>  ENDPROC(do_softirq_own_stack)
>  
> -#ifdef CONFIG_XEN
> +#ifdef CONFIG_XEN_PV
>  idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
>  
>  /*
> @@ -1129,11 +1129,13 @@ ENTRY(xen_failsafe_callback)
>  	ENCODE_FRAME_POINTER
>  	jmp	error_exit
>  END(xen_failsafe_callback)
> +#endif /* CONFIG_XEN_PV */
>  
> +#ifdef CONFIG_XEN_PVHVM
>  apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
>  	xen_hvm_callback_vector xen_evtchn_do_upcall
> +#endif
>  
> -#endif /* CONFIG_XEN */
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
> @@ -1150,7 +1152,7 @@ idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
>  idtentry int3			do_int3			has_error_code=0
>  idtentry stack_segment		do_stack_segment	has_error_code=1
>  
> -#ifdef CONFIG_XEN
> +#ifdef CONFIG_XEN_PV
>  idtentry xennmi			do_nmi			has_error_code=0
>  idtentry xendebug		do_debug		has_error_code=0
>  idtentry xenint3		do_int3			has_error_code=0
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index d83cb5478f54..f723b5aa8f74 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -12,25 +12,46 @@ endif
>  # Make sure early boot has no stackprotector
>  nostackp := $(call cc-option, -fno-stack-protector)
>  CFLAGS_enlighten_pv.o		:= $(nostackp)
> -CFLAGS_mmu_pv.o		:= $(nostackp)
> +CFLAGS_mmu_pv.o			:= $(nostackp)
>  
> -obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
> -			time.o xen-asm.o xen-asm_$(BITS).o \
> -			grant-table.o suspend.o platform-pci-unplug.o
> +obj-y				+= enlighten.o
> +obj-y				+= multicalls.o
> +obj-y				+= mmu.o
> +obj-y				+= time.o
> +obj-y				+= grant-table.o
> +obj-y				+= suspend.o
> +obj-y				+= platform-pci-unplug.o
>  
> -obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
> -obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
> -						p2m.o enlighten_pv.o mmu_pv.o
> -obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
> +obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
> +obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
> +obj-$(CONFIG_XEN_PVHVM)		+= suspend_hvm.o
>  
> -obj-$(CONFIG_EVENT_TRACING) += trace.o
> +obj-$(CONFIG_XEN_PV)		+= setup.o
> +obj-$(CONFIG_XEN_PV)		+= apic.o
> +obj-$(CONFIG_XEN_PV)		+= pmu.o
> +obj-$(CONFIG_XEN_PV)		+= suspend_pv.o
> +obj-$(CONFIG_XEN_PV)		+= p2m.o
> +obj-$(CONFIG_XEN_PV)		+= enlighten_pv.o
> +obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
> +obj-$(CONFIG_XEN_PV)		+= irq.o
> +obj-$(CONFIG_XEN_PV)		+= xen-asm.o
> +obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
> +
> +obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
> +obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
> +
> +obj-$(CONFIG_EVENT_TRACING)	+= trace.o
>  
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_XEN_PV_SMP)  	+= smp_pv.o
>  obj-$(CONFIG_XEN_PVHVM_SMP)  	+= smp_hvm.o
> +
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= spinlock.o
> +
>  obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
> +
>  obj-$(CONFIG_XEN_DOM0)		+= vga.o
> +
>  obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
> +
>  obj-$(CONFIG_XEN_EFI)		+= efi.o
> -obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
> diff --git a/include/xen/events.h b/include/xen/events.h
> index c3e6bc643a7b..a48897199975 100644
> --- a/include/xen/events.h
> +++ b/include/xen/events.h
> @@ -89,11 +89,13 @@ unsigned irq_from_evtchn(unsigned int evtchn);
>  int irq_from_virq(unsigned int cpu, unsigned int virq);
>  unsigned int evtchn_from_irq(unsigned irq);
>  
> +#ifdef CONFIG_XEN_PVHVM
>  /* Xen HVM evtchn vector callback */
>  void xen_hvm_callback_vector(void);
>  #ifdef CONFIG_TRACING
>  #define trace_xen_hvm_callback_vector xen_hvm_callback_vector
>  #endif
> +#endif
>  int xen_set_callback_via(uint64_t via);
>  void xen_evtchn_do_upcall(struct pt_regs *regs);
>  void xen_hvm_evtchn_do_upcall(void);


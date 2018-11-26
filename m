Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9155DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528E02086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xgHECmlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528E02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeK0GQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:16:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeK0GQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:16:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4342C20664;
        Mon, 26 Nov 2018 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543260063;
        bh=arTvBTMHo211CEFsQZ3llYCvJQPZMMCwd5uKDaPt9Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xgHECmlc9AR/cgJ/axLTIfy0mednZ0kWh5N45K2uL4JVmRfWtYaMAU2rDo6tfu4E5
         va92Nf0mf5b2GmnH7qQSYsYdmjQ3c6EVsvmF+gWmHSo2UwiG8XRxKzGp8TbZPXIDRo
         MGGhNdJMQuot+OfbrmRGLJLjoBDHUd9exue1KTMg=
Date:   Mon, 26 Nov 2018 20:21:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kys@microsoft.com
Cc:     will.deacon@arm.com, catalin.marinas@armm.com,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Message-ID: <20181126192101.GC32208@kroah.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122031059.16338-3-kys@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:10:58AM +0000, kys@linuxonhyperv.com wrote:
> From: Michael Kelley <mikelley@microsoft.com>
> 
> Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
> are in the architecture independent setup and shutdown paths for
> Hyper-V, and are needed by Linux guests on Hyper-V on ARM64.  The
> x86/x64 implementation is null because VMbus interrupts on x86/x64
> don't use an IRQ.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 4 ++++
>  drivers/hv/hv.c                 | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 0d6271cce198..8d97bd3a13a6 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -109,6 +109,10 @@ void hyperv_vector_handler(struct pt_regs *regs);
>  void hv_setup_vmbus_irq(void (*handler)(void));
>  void hv_remove_vmbus_irq(void);
>  
> +/* On x86/x64, there isn't a real IRQ to be enabled/disable */
> +static inline void hv_enable_vmbus_irq(void) {}
> +static inline void hv_disable_vmbus_irq(void) {}
> +
>  void hv_setup_kexec_handler(void (*handler)(void));
>  void hv_remove_kexec_handler(void);
>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 166c2501de17..d0bb09a4bd73 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -307,6 +307,7 @@ int hv_synic_init(unsigned int cpu)
>  	hv_set_siefp(siefp.as_uint64);
>  
>  	/* Setup the shared SINT. */
> +	hv_enable_vmbus_irq();
>  	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>  
>  	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> @@ -434,6 +435,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  	/* Disable the global synic bit */
>  	sctrl.enable = 0;
>  	hv_set_synic_state(sctrl.as_uint64);
> +	hv_disable_vmbus_irq();
>  
>  	return 0;
>  }
> -- 
> 2.19.1

You created "null" hooks that do nothing, for no one in this patch
series, why?

Add them when they are needed not now.  If I saw this code in the tree,
I would just go delete it as it is because it is not used at all.

thanks,

greg k-h

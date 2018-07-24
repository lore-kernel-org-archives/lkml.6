Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85088C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479BD20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479BD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXQV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:21:57 -0400
Received: from foss.arm.com ([217.140.101.70]:53622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388332AbeGXQV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:21:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4EA15AB;
        Tue, 24 Jul 2018 08:14:59 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD6503F237;
        Tue, 24 Jul 2018 08:14:59 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6B57A1AE3B5E; Tue, 24 Jul 2018 16:14:59 +0100 (BST)
Date:   Tue, 24 Jul 2018 16:14:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alexei Colin <acolin@isi.edu>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alex Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        John Paul Walters <jwalters@isi.edu>
Subject: Re: [PATCH] arm64: enable RapidIO config options in Kconfig
Message-ID: <20180724151458.GE25412@arm.com>
References: <20180724134513.86796-1-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724134513.86796-1-acolin@isi.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:45:14AM -0400, Alexei Colin wrote:
> ARM64 SoCs with a PCI bus present the RapiodIO options; SoCs with
> RapidIO IP blocks but without a PCI bus, need to select HAS_RAPIDIO in
> Kconfig.platforms.
> 
> HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
> other architectures which already define this flag (powerpc).
> 
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
> 
> Tested that kernel builds with RapidIO subsystem and switch drivers and that
> modules insert successfully in a custom Qemu hardware model.
> Maintainers for RapidIO subsystem CCed.
> Similar patch for ARM has been submitted.
> 
>  arch/arm64/Kconfig | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090cf0292..8dceaa5b674c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -293,6 +293,22 @@ config PCI_SYSCALL
>  
>  source "drivers/pci/Kconfig"
>  
> +config HAS_RAPIDIO
> +	bool
> +	default n
> +
> +config RAPIDIO
> +	tristate "RapidIO support"
> +	depends on HAS_RAPIDIO || PCI
> +	help
> +	  This feature enables support for RapidIO high-performance
> +	  packet-switched interconnect.
> +
> +	  If you say Y here, the kernel will include drivers and
> +	  infrastructure code to support RapidIO interconnect devices.

It feels a bit weird to push this help text into the arch Kconfig files,
rather than just have them provide the HAS_RAPIDIO symbol, but if that's
what everybody else is doing then I guess it's fine.

Will

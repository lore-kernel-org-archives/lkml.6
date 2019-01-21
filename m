Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0788C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5D72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DKw4iSCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAUJpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:45:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55132 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfAUJpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:45:32 -0500
Received: from zn.tnic (p200300EC2BC625005DE3D5B66D6AB027.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:2500:5de3:d5b6:6d6a:b027])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE49F1EC01B6;
        Mon, 21 Jan 2019 10:45:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548063931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EUxLhEQmrRhU3Tx/rm3Y1Pz35MW5aKfYD3ET+nNDIJU=;
        b=DKw4iSCuiQVISLYIq4w37noxhzhLCHbttGzzqtbEYPcGOLJSazmsPsjsIdwaNS4ZyHFTto
        sTs/T6PiEr3ronNJrSadwMiFpk99s91/eNVY3pURy1gpZkRaTT/n4ljGpVpjqmCJnNJjt9
        i1WZiS2z5Mv1rYvEuCMerTVeVmtyLjo=
Date:   Mon, 21 Jan 2019 10:45:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190121094524.GD29166@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <20190116110158.GC15409@zn.tnic>
 <20190121093348.GB15754@localhost.localdomain>
 <20190121094214.GC15754@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121094214.GC15754@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 05:42:14PM +0800, Chao Fan wrote:
> Or I clear this function as:
> static acpi_physical_address get_rsdp_addr(void)
> {
>         acpi_physical_address pa;
> 
>         pa = get_acpi_rsdp();
> 
>         if (!pa)
>                 pa = boot_params->acpi_rsdp_addr;
> 
>         if (!pa)
>                 pa = efi_get_rsdp_addr();
> 
>         if (!pa)
>                 pa = bios_get_rsdp_addr();
> 
>         if (pa && !boot_params->acpi_rsdp_addr)
>                 boot_params->acpi_rsdp_addr = pa;

Or simply:

	if (pa)
		boot_params->acpi_rsdp_addr = pa;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

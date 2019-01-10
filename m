Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E3020675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="C/WWNHrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfAJV16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:27:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfAJV15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:27:57 -0500
Received: from zn.tnic (p200300EC2BC5CF00CD9D2FB5DCB47746.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:cd9d:2fb5:dcb4:7746])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E92AC1EC03DB;
        Thu, 10 Jan 2019 22:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547155676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C9vW4VniEW6OOQH5uL5exe+4MdZJW4WyqDaCJ+wMEu0=;
        b=C/WWNHrg2M/cWzh12BZu9vcpWgMr+XFudTuNg5KJh5U19vFR3fPisAkhbc/0Q10+q8978l
        YXIBbbCbdx3UAFbRAKDGvZ7XmtMQpxIcqrPJpLnokSo5AEOVObiI30sYGIR1FBW6Us2rHW
        VRzsrolx9HUILpwA594T4CDXNgcUu2Q=
Date:   Thu, 10 Jan 2019 22:27:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 4/6] x86/boot: Introduce bios_get_rsdp_addr() to
 search RSDP in memory
Message-ID: <20190110212747.GH17621@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-5-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107032243.25324-5-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:22:41AM +0800, Chao Fan wrote:
> Memory information in SRAT table is necessary to fix the conflict
> between KASLR and memory-hotremove. So RSDP and SRAT should be parsed.
> 
> When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
> are different. When booting from BIOS, there is no variable who can
> point to RSDP directly, so scan memory for the RSDP and verify RSDP
> by signature and checksum.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 86 +++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)

...

> +/* Search RSDP address, based on acpi_find_root_pointer(). */
> +static acpi_physical_address bios_get_rsdp_addr(void)
> +{
> +	u8 *table_ptr;
> +	u32 address;
> +	u8 *rsdp;

But those u8's together:

	u8 *table_ptr, *rsdp;
	u32 address;

> +
> +	/* Get the location of the Extended BIOS Data Area (EBDA) */
> +	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
> +	address = *(u16 *)table_ptr;
> +	address <<= 4;
> +	table_ptr = (u8 *)(long)address;
> +
> +	/*
> +	 * Search EBDA paragraphs (EBDA is required to be a minimum of
> +	 * 1K length)
> +	 */
> +	if (address > 0x400) {
> +		rsdp = scan_mem_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
> +		if (rsdp) {
> +			address += (u32)ACPI_PTR_DIFF(rsdp, table_ptr);
> +			return address;
> +		}
> +	}
> +
> +	/* Search upper memory: 16-byte boundaries in E0000h-FFFFFh */
> +	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
> +	rsdp = scan_mem_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
> +

Superfluous newline.

> +	if (rsdp) {
> +		address = (u32)(ACPI_HI_RSDP_WINDOW_BASE +
> +				ACPI_PTR_DIFF(rsdp, table_ptr));
> +		return address;
> +	}
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

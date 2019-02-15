Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E537C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AAC20838
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o9IpEAkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392766AbfBOJ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:28:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35518 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391144AbfBOJ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:28:49 -0500
Received: from zn.tnic (p200300EC2BCDA500C8964896D8752F51.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:a500:c896:4896:d875:2f51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C90191EC0573;
        Fri, 15 Feb 2019 10:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550222927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z4cf+t7qBkOAwU6ZFsbYuEkvR3n1ra72mydVZ9cQaSM=;
        b=o9IpEAkNAO5pw0xY3xe1BTwXWbJltKSQXxPgU13JoGI17beqmPO2pOagiEEdhmlJYmr+wV
        RwBb+Ngc91hT8cePe+tGn/VlPomSk+MFldmvWFoUF9WQyjDTKuxFVNkiVZ08HWt5IFQEqi
        p2qcwmTdSFU44UPC9v3qdSUiFH8oBZU=
Date:   Fri, 15 Feb 2019 10:28:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org
Subject: Re: [PATCH] x86/boot: Move detecting acpi=off in cmdline to
 get_rsdp_addr()
Message-ID: <20190215092841.GA10433@zn.tnic>
References: <20190215091047.23047-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190215091047.23047-1-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 05:10:47PM +0800, Chao Fan wrote:
> If "acpi=off" specified in cmdline, the whole functions of acpi.c
> should not work, there is no need to ealy parse RSDP, so detect
> "acpi=off" in the very first place.
> 
> Also replace magic number with macro.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 0ef4ad55b29b..5510a2105b7b 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -213,8 +213,13 @@ static acpi_physical_address bios_get_rsdp_addr(void)
>  /* Return RSDP address on success, otherwise 0. */
>  acpi_physical_address get_rsdp_addr(void)
>  {
> +	char arg[MAX_ACPI_ARG_LENGTH];
>  	acpi_physical_address pa;
>  
> +	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
> +	    !strncmp(arg, "off", 3))
> +		return 0;

This place looks wrong because we have a get_acpi_rsdp() call before
that which overrides acpi=off practically.

Also, if you move it to get_rsdp_addr(), add a static variable recording
the previous result of the cmdline parsing because I don't want it
parsing cmdline each time it is called.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

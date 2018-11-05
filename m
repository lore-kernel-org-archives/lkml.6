Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E7C46464
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC442084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH4Vf/MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC442084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbeKFGlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:41:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38955 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbeKFGlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:41:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so4791041pgv.6;
        Mon, 05 Nov 2018 13:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8GQfIYxLqXGoh+LrMtJ2OdPSQX6m0kMgXb1fU0CHKaQ=;
        b=pH4Vf/MKd0eKwam9ilmQYJjwgeFgJnzHV0iSijCtSbh1+O5CoNE5Yu4/zlJFQmzxpM
         76FViRRkMiLnluNutl2f6lOzlD87ppSjNxUVU3HBkg2W7oU+UHB8IWyNxv3tKJUptExA
         C2vysWZM8gv+eVHdlmV/xPzbPJC/u/c4C1rIKGHWVYPmWUn4lXMWAThjyAkrCBPDZaB3
         MrTrm7s93XxczGoYmgPOdYYdYBaDkmVpprzFhs/+6sZ5y+lalkm2g3p85TtRbXxN72hb
         Eo4iXc1zx2j42/i74Fj4bqupSK+B6aNpxnqyIqdhykM+Eyz6X/zi84k1fEx9vE4fJH/0
         AoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8GQfIYxLqXGoh+LrMtJ2OdPSQX6m0kMgXb1fU0CHKaQ=;
        b=D3gzevqbEi0zpXCPyAHGqPZiXslNSe8VhFN5dv76jAqsJI6S2U5B79Id/j4RfC2bhD
         yIQ7NOJBFuKiNRqzUF4LB/OQQOjbaAyOKIz+7xUafmSRMYSiV7zEMU/JtJnqq6IeZAoT
         LMUT2NI/lPbviMd9d6mHQGrDV8AmrU7WSQSuYE3rwk+0esxTFCsjHG9AVlaKlW/dgpDw
         IubkdguxyVwXstYVVYrR5xJ4wLeYnYgG5m7eXSpsAYBVYxPdikWi4+QIQ3FpgE02Am44
         lSWp0pBrYxaSrfgT5oXBFfEgckwMO9od083h9Zt7XwAUywH8hTc8MBPEB6JdPlaLTDQP
         UOZQ==
X-Gm-Message-State: AGRZ1gLJ6krZY5UlbnQlCKL0ol6g4x+FJAn9t1fyItk2XYxeR9mo44+W
        gesPEnWcCTdJRt57FntkJIIjDnGr
X-Google-Smtp-Source: AJdET5factQg0t4fWcUpcyYPEIuV3pmmt0Ygfay9135Xb7lz++EwKaOUg4M0LdyBRyWf8TWE5pcrVw==
X-Received: by 2002:a63:81c7:: with SMTP id t190mr19015125pgd.393.1541452777237;
        Mon, 05 Nov 2018 13:19:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23-v6sm12270447pfm.170.2018.11.05.13.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:19:36 -0800 (PST)
Date:   Mon, 5 Nov 2018 13:19:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     wim@linux-watchdog.org, yuenn@google.com, venture@google.com,
        benjaminfair@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: npcm: Modify npcm watchdog kconfig arch
 parameter
Message-ID: <20181105211935.GB15984@roeck-us.net>
References: <20181105161152.205524-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105161152.205524-1-tmaimon77@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 06:11:52PM +0200, Tomer Maimon wrote:
> Modify Nuvoton watchdog Kconfig default supported architecture
> name to ARCH_NPCM7XX because ARCH_NPCM750 architecture name
> is not supported.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 2d64333f4782..746759ec8960 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -538,7 +538,7 @@ config COH901327_WATCHDOG
>  config NPCM7XX_WATCHDOG
>  	bool "Nuvoton NPCM750 watchdog"
>  	depends on ARCH_NPCM || COMPILE_TEST
> -	default y if ARCH_NPCM750
> +	default y if ARCH_NPCM7XX
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here to include Watchdog timer support for the
> -- 
> 2.14.1
> 

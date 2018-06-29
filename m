Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43BFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6814F2806B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EVGecJF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6814F2806B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965443AbeF2Pbr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:31:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37299 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965293AbeF2Pbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:31:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id h20-v6so2462237pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8BiqHkqitE+CRS6ZuM7Z+r8YuT+mTuxruOc9YAk0S0=;
        b=EVGecJF/jI6L/5LDL79PseQG26PAMYFuHxSJupaZ4Vd/ZDy8l7ewEm9060NkVSpKfi
         axbwMtxieLextQjvx0boGFN+PznzMao1sB1CusurX14jnAy8uQq9oUYWIR6gXnyLUuXf
         8TqxrU3wBqgsNoK/DVy2T+J7VOonR1vFNiTh5uilZGP2grDeHif0euYTveEqO5uxtmih
         jWQTfLt/4/X8mJryNM4crJwMucdrak4EFVhuZD7Djq7z+CGftfUjF6lMK5Fl+LzD07ul
         1WRy6m4votzzPgESUSrcJDfskgLnvRjBYLsc6ulAjsd8w6uvr20BJa4zau/W+vhiQjcF
         Lm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8BiqHkqitE+CRS6ZuM7Z+r8YuT+mTuxruOc9YAk0S0=;
        b=J8T4phq0Gon/zcnihwIPuQvHbJO0GVUVxhGgj1ABC30JWqinVlf4cl5fHuuncAcXn4
         uLavaF3tkEs7NXxx2gKyNp2dXXGCvCc+IEJBUolH2dOPBfPxgzyyvd2gBQbKcJx2YBoF
         m1+U+3/d/AfgvB9j5r+0xbZS2+th1460WW31MI+Pi8vrufI1fYTD3PK9F954zndXdqIt
         cBoxJOCDxo6395tbbZ3Zu5Km1vdHkwyWdF29to6VYBe03WqL6goV66XKY7B7hT9ypkbY
         VYSX66VWQ2w42iixYPorMc96JBjO3BsofKdNixysBz9aUdBrdjZ2Phjamx/V/RRTGRqc
         beFw==
X-Gm-Message-State: APt69E3i3ujnWwq5r8CW3hEb8gOB4ApNu/mxvDDOax7QIGROSUSIusRa
        kO+QJShSWx+Lys6FxX/8KJNqJg==
X-Google-Smtp-Source: AAOMgpdQQU4g/4900cX2siq5ykIFNX5Viw2PF+83molZAOWrLjxh0gXEvUlSf3koXHDElJOpkBxLLQ==
X-Received: by 2002:aa7:87d0:: with SMTP id i16-v6mr11115146pfo.82.1530286303209;
        Fri, 29 Jun 2018 08:31:43 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r3-v6sm11843628pgp.83.2018.06.29.08.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 08:31:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fYvN7-00023l-B1; Fri, 29 Jun 2018 09:31:41 -0600
Date:   Fri, 29 Jun 2018 09:31:41 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629153141.GE379@ziepe.ca>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 06:10:02PM +0300, Jarkko Sakkinen wrote:
> Do not allow to compile TPM core as a module. TPM defines a root of
> trust for integrity and keyring subsystems and should be always
> available and not be loaded from the user space. There is no a
> reasonable use case for a loadable module existing.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/Kconfig | 2 +-
>  include/linux/tpm.h      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

This doesn't really make sense..

The kconfig method is that if IMA requires TPM it should declare so
and TPM will become non-modular because IMA is non-modular.

There are lots of legitimate use cases for TPM that don't involve IMA
or keyring.

> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 18c81cbe4704..9728771aecbd 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  
>  menuconfig TCG_TPM
> -	tristate "TPM Hardware Support"
> +	bool "TPM Hardware Support"
>  	depends on HAS_IOMEM
>  	select SECURITYFS
>  	select CRYPTO
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4609b94142d4..cefa61b12891 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -50,8 +50,7 @@ struct tpm_class_ops {
>  	void (*clk_enable)(struct tpm_chip *chip, bool value);
>  };
>  
> -#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> -
> +#if defined(CONFIG_TCG_TPM)

Huh. This new version is certainly right

Jason

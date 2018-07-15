Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4278ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B3B2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5Yvgb7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B3B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeGOXCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:02:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43848 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:02:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so30079328wrv.10;
        Sun, 15 Jul 2018 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZlQXIlqMkSH2VpVVVTef0i0kL3q9Jm1Q0+qUefEZWcs=;
        b=Z5Yvgb7aTJ33eF5O1D+eepb+MCTJk5PciGmEEcAwxCUulBnlzdq2LeW2/A5qmVTeyd
         KsBorP5TGVouzpNhddAYoS/oaBMgpIu1Xbj5bgEtARvfzt7ryR7UiY/g6S4t9DJqAAUI
         XENkgCSDJL9QcNh1NFh+b6xXBpkAGGHrhI/zn5Hp2VhxO79WC/TSycjpWBIDaMZ3lnO6
         1zk9uk9eFp8T+4BCbJ8icD+TyZAkA0zp7kucVIb+94gHKnTgnDwqfNjXidwNupk3ryNg
         8RkKyNosiQvKraXjcSJldI7ksi3W1LYwVSj73TG4ta4vNb6RZlnsvMye3QWcydfQexzZ
         OmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlQXIlqMkSH2VpVVVTef0i0kL3q9Jm1Q0+qUefEZWcs=;
        b=h3smX28hU7gydnsvOtdgGL48aQwpsPfU/Ekv+cV6NJuKvGm+NJ6Y/hPl0lzoowWeoj
         yPb/LnCS1mdWIrDGIGUE0sqzDtpv+GJr5IR/kws6JTuqmeT94gRdARp1cmJ87DZO03Vm
         HYioBiWyZuVBBq6M0lNtpEhwyHMjIM2O7cKi4QCY65bzPaOVjF3ny7wOAFDOV5rtWQfZ
         AX8FvYOG9B74FHl101sJ3B0ki8qgPmp1Ej0uZoLeVGLnO/fcVpY9pmxFt2EdKNO5ZORB
         b8rujCOD8E7H5IdvPWSmJHsTO+DI3ss3qu9n9MaeOy9G/IhHQWx6NfyECZAnN9OZCCGp
         lJQQ==
X-Gm-Message-State: AOUpUlG23s7DoFVR/zN30hqRFv81me950u/ee7hkT+tTFPBUVZe7pCat
        Gm7TUoCs1gvmmmC0/lRdeQE=
X-Google-Smtp-Source: AAOMgpd/yV7ApOZ1/P5K4A0vG+m58+qic4gwNljHSpytVQoLynW4NpwMIqV6N/yY0UaxZRbiEwPV8g==
X-Received: by 2002:adf:c74e:: with SMTP id b14-v6mr9738242wrh.16.1531694291468;
        Sun, 15 Jul 2018 15:38:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s16-v6sm24825330wrq.20.2018.07.15.15.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 15:38:10 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:38:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] efi/x86: Use non-blocking SetVariable() for
 efi_delete_dummy_variable()
Message-ID: <20180715223808.GB16209@gmail.com>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
 <20180711094040.12506-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711094040.12506-3-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> 
> Presently, efi_delete_dummy_variable() uses set_variable() which might
> block and hence kernel prints stack trace with a warning "bad:
> scheduling from the idle thread!". So, make efi_delete_dummy_variable()
> use set_variable_nonblocking(), which, as the name suggests doesn't
> block.
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/platform/efi/quirks.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 36c1f8b9f7e0..6af39dc40325 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -105,12 +105,11 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
>  */
>  void efi_delete_dummy_variable(void)
>  {
> -	efi.set_variable((efi_char16_t *)efi_dummy_name,
> -			 &EFI_DUMMY_GUID,
> -			 EFI_VARIABLE_NON_VOLATILE |
> -			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -			 EFI_VARIABLE_RUNTIME_ACCESS,
> -			 0, NULL);
> +	efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
> +				     &EFI_DUMMY_GUID,
> +				     EFI_VARIABLE_NON_VOLATILE |
> +				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
>  }

Just wondering, what is the full stack trace of the splat? It sounds a bit 
surprising to me that such type of EFI code is used from the idle thread.

Thanks,

	Ingo

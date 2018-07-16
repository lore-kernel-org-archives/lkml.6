Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F976ECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0954A20835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjFg9rsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0954A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeGPB1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:27:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33149 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeGPB1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:27:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so8719288wma.0;
        Sun, 15 Jul 2018 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQ7gL7H+9P+e2qdo50jF/t42P7RQpznHhxWy0+bSxhg=;
        b=hjFg9rsd9gHgHrSLsXvc5CslYCqQMBWogxOCv/dF5UOTlZe56yueXl1OFVNeDvf929
         hfGgkc6FnC6HaZm16rqcYXLienAfRKcaN/eKPVvIQPmsGnCigR7SS5B+N8ah7XgQdXT7
         LI41WSthwt9IhVw12R5/LaX1+LwnsEQGTNPVG17I6UlOoQCeLHDMMhf47ZOcciDq3Qcf
         XnLmiiHhmFIIDbSr+b5EzG0E6RFefkkbik5ZyOuURKCKW7ycIz/CYXnjsVoQKUkaOP8D
         HiXjR3VYI9vdHfS1uOY5C968Qx7AQ0Dj/Iyfgk32w8nQmgI6psG21YydUsVKHZNZmL4o
         x47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQ7gL7H+9P+e2qdo50jF/t42P7RQpznHhxWy0+bSxhg=;
        b=KWvHgEHvhZF3zcxi6I/15+34evPGCKbptMny/ONZxcFUZ2kvdkUzGNuoSk8ulATyiU
         LsSMiZ5DPoKDEh5O0X6I7NgM/bJv+/1UjdgtCivXiyocfre9x9qTwZMUpEiBG2o4S8W7
         yjPjElBA/rqgaO4GDa5h9Paf0sy7MU5+81erv0/hjlyJuuPlLW99h9BIER02qO/izDtT
         fp5GLcucL8qR7tglrdENIWOLNvScJ2Fkax9wf2N15UgznGOya8Dwf5AgRxWneWoAGCot
         AxNbh+BxBD1+p1DnH0I7ZNUhpC8h9u0dIfMuxDXW+mTjpgROTDYTASmssEyxrhk8wyXZ
         fGIA==
X-Gm-Message-State: AOUpUlFnHy7smpARvZ4ntDSVeKAz3FipvpOVt18kOun0FxJL42Zc3ATa
        nxlyznms7ajhE1KZMbP7yjI=
X-Google-Smtp-Source: AAOMgpcV4n0nTOHV7aIunmNdATHhdn6a3xTQrUkdKlEEjQHFp7ZJx6SbI8BPNQdKusA42ba/XqLIHA==
X-Received: by 2002:a1c:2396:: with SMTP id j144-v6mr8396663wmj.26.1531702942246;
        Sun, 15 Jul 2018 18:02:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z9-v6sm56858293wre.49.2018.07.15.18.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 18:02:21 -0700 (PDT)
Date:   Mon, 16 Jul 2018 03:02:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] efi/x86: Use non-blocking SetVariable() for
 efi_delete_dummy_variable()
Message-ID: <20180716010219.GA13742@gmail.com>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
 <20180711094040.12506-3-ard.biesheuvel@linaro.org>
 <20180715223808.GB16209@gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F46A3F83A@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F46A3F83A@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com> wrote:

> > > diff --git a/arch/x86/platform/efi/quirks.c
> > > b/arch/x86/platform/efi/quirks.c index 36c1f8b9f7e0..6af39dc40325
> > > 100644
> > > --- a/arch/x86/platform/efi/quirks.c
> > > +++ b/arch/x86/platform/efi/quirks.c
> > > @@ -105,12 +105,11 @@ early_param("efi_no_storage_paranoia",
> > > setup_storage_paranoia);  */  void efi_delete_dummy_variable(void)  {
> > > -	efi.set_variable((efi_char16_t *)efi_dummy_name,
> > > -			 &EFI_DUMMY_GUID,
> > > -			 EFI_VARIABLE_NON_VOLATILE |
> > > -			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > -			 EFI_VARIABLE_RUNTIME_ACCESS,
> > > -			 0, NULL);
> > > +	efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
> > > +				     &EFI_DUMMY_GUID,
> > > +				     EFI_VARIABLE_NON_VOLATILE |
> > > +				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > > +				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
> > >  }
> > 
> > Just wondering, what is the full stack trace of the splat? It sounds a bit surprising
> > to me that such type of EFI code is used from the idle thread.
> 
> Sorry! for the confusing commit message. Kernel warns about scheduling from idle 
> thread only when "efi_rts_wq" is used to invoke efi_runtime_services(). So, 
> presently, this doesn't happen on mainline kernel. Support for "efi_rts_wq" is 
> added by commit 3eb420e70d87 (efi: Use a work queue to invoke EFI Runtime 
> Services).

Ok, that makes a lot more sense!

Thanks,

	Ingo

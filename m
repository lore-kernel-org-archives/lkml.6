Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C158C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4177120882
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUjKovBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeIKXAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:00:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40229 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeIKXAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:00:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so11676518plp.7;
        Tue, 11 Sep 2018 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oghfOOOU/kdNr7nMxZ7JWt5kjm44iG9IPH0Z3K7lFIw=;
        b=cUjKovBB4+v/QUVSeDjP4X1TX2mAgQByZntBH73YFf3/N2PN3TH0jz38De8IZC8DL4
         GPT5+M4JtsfR5PfPfp9v3wEe9QnE2Ej9+gUi/9MW82nC+66RrXWBaBgM1qO6Ja/2bJEv
         bJdNOmM1bThkLfi3vlZO7wbjaD9qN64TEAnZDI+6PkfPS2MWhMAX/ENXsvnUSRmC96+k
         zThVyfr4bhaSAgrxsH2u8PcXaWw0fVzJ6ncTwOvjHFuV9/Cqwcw/kI5bSaM4EA3wW3UW
         cldRusVHOuTl8Dd3V1P9IH8vUsV2GmOSocd5F3+TWtoazuN0ezAkX2n6knzAor/XEObl
         lgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oghfOOOU/kdNr7nMxZ7JWt5kjm44iG9IPH0Z3K7lFIw=;
        b=CJ8s4rTEVnC3d703FAxVnhjufYFKOFn0XK2CakFNjFa8tV7qs30s7xAoaMOxFWq/Vm
         YdBXE4GX1Mf/tAu1xO+Cmf/HSXM6kU/fw7d4Gi3lrONhxCZ6sWFkiRJXuvRGc5yBTV8c
         HSnLacoUTOZhVIONsjWLzFpP/mUGfgwi8bqHdFu+QjaeFPwg8aI4OSdy6tLWjVRzImMY
         BZ7wKuYkRyeSE/tUx0OMKYVOqCMxinTzsfnL2ClBVWTlDmLbRYzxLAWkrRcjidxb23n8
         UAMHHEc+kF1rLf53Kk2ZSXbwPNEw5l4pORQRGARYbCEgZ/pV0+qQ35Xr29k0k1sOfj5b
         5FDQ==
X-Gm-Message-State: APzg51DNHpJMGlEyWfLvKZ2DOPqR36sPC1b/Df951XHD44Niipsx+jtW
        rGlgwmP6BD/McQKt71zHp5U=
X-Google-Smtp-Source: ANB0VdaOYyBgQOI67kiTRGTEbWtCObkHMLs9Duj4APvXJo2WrI3ABaeqxHNz39b+RZ1NRj3C0ZS9kQ==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr28378324pld.145.1536688782669;
        Tue, 11 Sep 2018 10:59:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u83-v6sm59741685pfj.37.2018.09.11.10.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 10:59:41 -0700 (PDT)
Date:   Tue, 11 Sep 2018 10:59:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: Random crashes with i386 and efi boots
Message-ID: <20180911175940.GB15367@roeck-us.net>
References: <20180910215659.GA17966@roeck-us.net>
 <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net>
 <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net>
 <90A7FF2E-F186-49CF-A028-CDE317BE13E1@amacapital.net>
 <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 07:41:58PM +0200, Joerg Roedel wrote:
> On Tue, Sep 11, 2018 at 09:36:51AM -0700, Andy Lutomirski wrote:
> > >    save_pgd = efi_call_phys_prolog();
> > >    local_irq_save(flags);
> > >    status = efi_call_phys(...);
> > >        local_irq_restore(flags);
> > > 
> > >        efi_call_phys_epilog(save_pgd);
> > > 
> > > So, yes, interrupts are very much enabled.
> > 
> > Does fixing that solve the problem?  It seems more robust.
> 
> The problem is still that in efi_call_phys_prolog() we load the gdt with
> its physical address, and when we reload the %cr3 in _epilog from
> initial_page_table to swapper_pg_dir again the gdt is no longer mapped.
> Blocking interrupts is more robust, but we can't block NMIs that way
> that would also trigger the issue, no?
> 
> So I am in favor of changing the order in efi_call_phys_epilog() too.
> 
Blocking the interrupts across efi_call_phys_prolog() / efi_call_phys() /
efi_call_phys_epilog() does solve the issue, but I am concerned about its
negative effect on 64-bit operation (not sure if blocking interrupts
in the prolog/epilog functions there is ok). Adding another set of
local_irq_save() / local_irq_restore() to efi_call_phys_epilog() seems
wasteful if the problem can be solved by reordering instructions.

So, yes, I also prefer changing the order in efi_call_phys_epilog().
I'll submit a patch along that line.

Thanks,
Guenter

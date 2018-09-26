Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA746C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156820833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RScEgiQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeIZJbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:31:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIZJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:31:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85-v6so9974693pge.6;
        Tue, 25 Sep 2018 20:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tq1v6y8FRSJfgualfH6XlED5+mcTsMTcFSKmNU7q4IA=;
        b=RScEgiQe1uTmNsWXAMUE4WliWW40AaMfw5KA7qLuVcm/sUPI/BuffIm0Z9XwXrnexQ
         FgNdTtKh4uOeRjC+xQUl2o5QI4EtQ8Ey3qdyjzD/WL+aN/c/DdELT8WPweYRx0mlStSJ
         MSVZeJGOE8Rq+/P49tbRmFInHzBC0stLOqlc2qJbQwPooSttoXy1yJopAhbifuOqHyVx
         Gwlu7aDVc7IUvPmGxMCEtdIAtEq5hFEt7RSi8XV+sBMhAysgZQFROmpUYMvnzYzNEaP6
         AIkQZEkHtR8IQZWs5ZAISs3X3VQcb9Uhl9mBynukNvi4Nr1H3eUBG1MiTmECfXCx5FbQ
         NwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=tq1v6y8FRSJfgualfH6XlED5+mcTsMTcFSKmNU7q4IA=;
        b=Hpw9DZrE9AMyfFPH4W82anDaxC7C/UtuHjxbouL5TV2xl46Mk1B3VRyezQpD+v5W8i
         7MSHXMNowg4UYmWBt4alKY18xL8Bnk8KZfTxM6myJWDTCUaQpcq0jNhGo9fNSonNowT/
         ED/KJpRObtMXEAIFQsdIiBfyKnCfbsg8GMSAqpjhZIJJq5qL2qLjh0MUyGtDuVTx2xyv
         t/AzS8Gfa3EczwsXvFo6NqQx0qQC5OmIEhb3Rh5QuYW0ft3TdEGYTV8hF1o/yg+7jUAf
         BgtWDnkNr46OdNktWtsuM15LnWY5+5UByvrtnhzzVpVPTvWf8RGm6u77iUbwcmac/Ier
         O5tA==
X-Gm-Message-State: ABuFfojfEoqrcBOZeUyjLVKtqeXrr5x4ZwIbQd2zUuyUZUMHg+kGQ3T5
        CP0aQvy50OzWShMvdhla5Sw=
X-Google-Smtp-Source: ACcGV63S97NU9zmdsYrFSeAru55zid8dXhiz0ucSbMtXtTWHIZzyPUZr5NIteU5b+GcdeVs8VKEcsw==
X-Received: by 2002:a17:902:aa02:: with SMTP id be2-v6mr3924810plb.294.1537932063628;
        Tue, 25 Sep 2018 20:21:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k26-v6sm5740287pfb.167.2018.09.25.20.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 20:21:02 -0700 (PDT)
Date:   Tue, 25 Sep 2018 20:21:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John David Anglin <dave.anglin@bell.net>
Cc:     jejb@parisc-linux.org, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: Remove PTE load and fault check from L2_ptep
 macro
Message-ID: <20180926032101.GA2458@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 23, 2018 at 10:55:18AM -0400, John David Anglin wrote:
> This change removes the PTE load and present check from the L2_ptep
> macro.  The load and check for kernel pages is now done in the tlb_lock
> macro.  This avoids a double load and check for user pages.  The load
> and check for user pages is now done inside the lock so the fault
> handler can't be called while the entry is being updated.
> 

This patch causes my parisc qemu tests to fail.
Unfortunately I don't have any useful log output; the failure
is silent. Reverting the patch fixes the problem.

Guenter

> Signed-off-by: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  arch/parisc/kernel/entry.S | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index eeee1d2c4b8e..3371472379a6 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S
> @@ -431,8 +431,6 @@
>  	extru		\va,31-PAGE_SHIFT,ASM_BITS_PER_PTE,\index
>  	dep		%r0,31,PAGE_SHIFT,\pmd  /* clear offset */
>  	shladd		\index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
> -	LDREG		%r0(\pmd),\pte
> -	bb,>=,n		\pte,_PAGE_PRESENT_BIT,\fault
>  	.endm
>  
>  	/* Look up PTE in a 3-Level scheme.
> @@ -463,7 +461,7 @@
>  	L2_ptep		\pgd,\pte,\index,\va,\fault
>  	.endm
>  
> -	/* Acquire pa_tlb_lock lock and recheck page is still present. */
> +	/* Acquire pa_tlb_lock lock and check page is present. */
>  	.macro		tlb_lock	spc,ptp,pte,tmp,tmp1,fault
>  #ifdef CONFIG_SMP
>  	cmpib,COND(=),n	0,\spc,2f
> @@ -472,10 +470,12 @@
>  	cmpib,COND(=)	0,\tmp1,1b
>  	nop
>  	LDREG		0(\ptp),\pte
> -	bb,<,n		\pte,_PAGE_PRESENT_BIT,2f
> +	bb,<,n		\pte,_PAGE_PRESENT_BIT,3f
>  	b		\fault
>  	stw		 \spc,0(\tmp)
> -2:
> +2:	LDREG		0(\ptp),\pte
> +	bb,>=,n		\pte,_PAGE_PRESENT_BIT,\fault
> +3:
>  #endif
>  	.endm
>  
> -- 
> 2.7.4

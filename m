Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A3C20645
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKZ/YcLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfBSSpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:45:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44961 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBSSpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:45:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id a3so813871pff.11;
        Tue, 19 Feb 2019 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5GKjlMn6P0nWRNwAxw1lMEPHkPcVeJO1TG4Ph2RZ+Ns=;
        b=vKZ/YcLr2tRYril7jUpMGpnGi2cc7vrI9KcbPMM3Xv2aQ7qCFUl2rE6qq8IGCo1yHw
         RiLB/KCbjbqdOZKeyFxvQNTRAF6VFY+xwc31AcMY6Pn70MrasaE3CfeO+OAJoDZQctSP
         CmV3/DRK8orUVRSectDxSU2gABW5MCZ9D4tbQDT9w1blDgshZEyYlasmRUbia3lNcpEH
         iDzfchaWlpQgf+5AC2uD5xu+16STBYa3t1mF4ANqJ1gXTi7ZS4cA9lcIsvq957zEuH5C
         IFULXK4yFuDpnU2cMKSy4AMsrTbw2gDRw2TBoXnCR0gDnirGAZdV3QT/udD7OA8KwHbv
         T3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GKjlMn6P0nWRNwAxw1lMEPHkPcVeJO1TG4Ph2RZ+Ns=;
        b=VhyIYzSwxErRIkP9JJx7wlT0vlMJOSB6iwmZV168DNuDOuVuaqORwU1A5NALW9PU86
         lWr9Bn3GRzh/jNDdlQL8XIoWDYoPu6bf9fikEKmqz5dKtw1v+/sqldTOCrrFQPrVAk9A
         nSOMGWtzL83divN29jYgnJktmHXY7B0aWw98WlZGyd3wwQzXUOZ04s2pMP4UCj18R4nu
         RytewycdLzJuqzZpKpyAknMm1OUoOUsqW5l4qB9lEab6xpdR66eUfWCm8BkbBh1R3j1p
         HdaOlGe0AKBOM27zbHgKVTcl0aEN7ttjCgsPz9oU+VeryzYHurN7u6c6/X/3k45qiRkL
         KueQ==
X-Gm-Message-State: AHQUAuY8CjQ5leK0ZExYehqKo6nxmC9lzRqqYsuLNkKjdxp9Rei6wPCI
        ZkLISpWmN4vFFTVLO2kPnNE=
X-Google-Smtp-Source: AHgI3IYeJW/vcoA1Myje3zM57F+O3VUpDPcKBovTNrdxGpn9u5L8284qtBl/VQ2shOUjWA0l4xleFQ==
X-Received: by 2002:a63:3fc8:: with SMTP id m191mr29245911pga.240.1550601949042;
        Tue, 19 Feb 2019 10:45:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w10sm18316265pgr.42.2019.02.19.10.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 10:45:47 -0800 (PST)
Date:   Tue, 19 Feb 2019 10:45:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/setup: fix early warning messages
Message-ID: <20190219184546.GA19356@roeck-us.net>
References: <20190218154640.GA27699@roeck-us.net>
 <20190218180146.79930fe6@mschwideX1>
 <20190218182106.61b10ee4@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218182106.61b10ee4@mschwideX1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 06:21:06PM +0100, Martin Schwidefsky wrote:
> On Mon, 18 Feb 2019 18:01:46 +0100
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > On Mon, 18 Feb 2019 07:46:40 -0800
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > > Hi,
> > > 
> > > On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:  
> > > > The setup_lowcore() function creates a new prefix page for the boot CPU.
> > > > The PSW mask for the system_call, external interrupt, i/o interrupt and
> > > > the program check handler have the DAT bit set in this new prefix page.
> > > > 
> > > > At the time setup_lowcore is called the system still runs without virtual
> > > > address translation, the paging_init() function creates the kernel page
> > > > table and loads the CR13 with the kernel ASCE.
> > > > 
> > > > Any code between setup_lowcore() and the end of paging_init() that has
> > > > a BUG or WARN statement will create a program check that can not be
> > > > handled correctly as there is no kernel page table yet.
> > > > 
> > > > To allow early WARN statements initially setup the lowcore with DAT off
> > > > and set the DAT bit only after paging_init() has completed.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>    
> > > 
> > > This patch causes s390 qemu emulations to crash with a kernel stack overflow.
> > > Reverting the patch fixes the problem. Crash log and bisect results below.  
> > 
> > Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
> > with 4K mapping where the prefix page is mapped to absolute zero.
> > 
> > Just using S390_lowcore instead of lowcore_ptr[0] does not work either
> > because low-address protection is already active. I'll think of something.
> > 
> > Thanks for bug report!
>  
> This patch should fix the problem:
> --
> >From d4393e82c3ec9b2fe5dba4b0d1b6eef29f8d15c8 Mon Sep 17 00:00:00 2001
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date: Mon, 18 Feb 2019 18:10:08 +0100
> Subject: [PATCH] s390/setup: fix boot crash for machine without EDAT-1
> 
> The fix to make WARN work in the early boot code created a problem
> on older machines without EDAT-1. The setup_lowcore_dat_on function
> uses the pointer from lowcore_ptr[0] to set the DAT bit in the new
> PSWs. That does not work if the kernel page table is set up with
> 4K pages as the prefix address maps to absolute zero.
> 
> To make this work the PSWs need to be changed with via address 0 in
> form of the S390_lowcore definition.
> 
> Cc: stable@vger.kernel.org
> Fixes: 94f85ed3e2 ("s390/setup: fix early warning messages")
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/s390/kernel/setup.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 65b22ef5141a..12934e8fbb91 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -451,13 +451,12 @@ static void __init setup_lowcore_dat_off(void)
>  
>  static void __init setup_lowcore_dat_on(void)
>  {
> -	struct lowcore *lc;
> -
> -	lc = lowcore_ptr[0];
> -	lc->external_new_psw.mask |= PSW_MASK_DAT;
> -	lc->svc_new_psw.mask |= PSW_MASK_DAT;
> -	lc->program_new_psw.mask |= PSW_MASK_DAT;
> -	lc->io_new_psw.mask |= PSW_MASK_DAT;
> +	__ctl_clear_bit(0, 28);
> +	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
> +	S390_lowcore.svc_new_psw.mask |= PSW_MASK_DAT;
> +	S390_lowcore.program_new_psw.mask |= PSW_MASK_DAT;
> +	S390_lowcore.io_new_psw.mask |= PSW_MASK_DAT;
> +	__ctl_set_bit(0, 28);
>  }
>  
>  static struct resource code_resource = {
> -- 
> 2.16.4
> 
> 
> -- 
> blue skies,
>    Martin.
> 
> "Reality continues to ruin my life." - Calvin.
> 

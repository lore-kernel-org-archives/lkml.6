Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A943C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14C320863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+rwmoHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14C320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeK3SiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:38:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53553 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeK3SiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:38:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so4680363wmi.3;
        Thu, 29 Nov 2018 23:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aonjL0GhWdlbM23aeNz7FxLMWSvwLer/S+02zm4GJeE=;
        b=o+rwmoHrTiiovSff1nsEvnuDMzprOdUTfiO93z4KdWhzuFwumRjjR96nNbkhV0m/G8
         oDQvfA2hzFPT1iwSapiJx++aTSgYYPwUKBKru4xe4f/mwX1UN263SPuaOCc4DKaavUs9
         NcAH6Y8WDjs8oV748dO+TaEGimWeUaRoBLiRvR+hLoWLBzV5RuYdnT4opvyPISJ8OSg8
         wOeE0UZzn1c0FULbvOqbZtR+akLsSKjQCZadL0p3gN/2oyiYbyTyKZSMoaNKpjGlP4Tk
         ktZpx62BKSh1g3vghHj4itmPLKbnwzKr3Rd6a8J48/ArdDid2RLjKEFRIcLtdQLybie+
         fRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aonjL0GhWdlbM23aeNz7FxLMWSvwLer/S+02zm4GJeE=;
        b=nQzwzC2kKq4/vVdcJDLd27QoPZtwUK545mm9snDQqt5jguxrBW2NJ+WepMW2nhfwUQ
         2OL0Lx+jtMWFXQELJ16YyoQySzqTApPDNnLrlfhQO7dKF6piJikRlMIChUu/VzTZiTl5
         QIXJuHqJZw6u3o0cdslX7a7KGYKQ+9Xr6yWbJ8aPLP441Lk+/dW3TJQ8sSMZwCfPrGrE
         wvOYaDOX2IQO0Tn8497ZtzA4vLBd1YMfLqh29hmPUN2AZQEJSge91SM+NzQPWJ7824ux
         2h9MNhnzBFND+lpjuyutAHdYnEZ7ZPTrO9sDTXoDCQ/8NLFQc9GTmRHuC4LNaiqlAtRu
         MABQ==
X-Gm-Message-State: AA+aEWb33z7svem3JCmudLKvj/zlpY+7PaI6cbQcQ10OB9HK/oPkbbDX
        eRTsTDGJ4LhKzOM7p55YYAw=
X-Google-Smtp-Source: AFSGD/WUJT+7YamugMaOabGgLXmWlgwfTp1iWCU9u4JPQU1/cApp1XFTFDK2uk2tUHN4U5LbSFld7A==
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr4374412wmd.111.1543562996211;
        Thu, 29 Nov 2018 23:29:56 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o67sm3603913wmo.18.2018.11.29.23.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 23:29:55 -0800 (PST)
Date:   Fri, 30 Nov 2018 08:29:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH 01/11] x86/efi: Allocate e820 buffer before calling
 efi_exit_boot_service
Message-ID: <20181130072952.GA16084@gmail.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129171230.18699-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> From: Eric Snowberg <eric.snowberg@oracle.com>
> 
> Commit d64934019f6c ("x86/efi: Use efi_exit_boot_services()")
> introduced a regression on systems with large memory maps
> causing them to hang on boot. The first "goto get_map" that was removed
> from exit_boot insured there was enough room for the memory map when
> efi_call_early(exit_boot_services) was called. This happens when
> (nr_desc > ARRAY_SIZE(params->e820_table).
> 
> Chain of events:
>   exit_boot()
>     efi_exit_boot_services()
>       efi_get_memory_map <- at this point the mm can't grow over 8 desc
>       priv_func()
>         exit_boot_func()
>           allocate_e820ext() <- new mm grows over 8 desc from e820 alloc
>       efi_call_early(exit_boot_services) <- mm key doesn't match so retry
>       efi_call_early(get_memory_map) <- not enough room for new mm
>       system hangs
> 
> This patch allocates the e820 buffer before calling efi_exit_boot_services
> and fixes the regression.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/boot/compressed/eboot.c | 65 ++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 24 deletions(-)

Any objections against marking this for -stable and filing it in 
efi/urgent? Boot hangs are show-stopper bugs, so distributions would want 
to backport this fix anyway.

> +	boot_map.map =		&map;
> +	boot_map.map_size =	&map_size;
> +	boot_map.desc_size =	&desc_size;
> +	boot_map.desc_ver =	NULL;
> +	boot_map.key_ptr =	NULL;
> +	boot_map.buff_size =	&buff_size;

I have changed this to the canonical style, which is also used elsewhere 
in the file:

>  	map.buff_size		= &buff_size;
>  	priv.boot_params	= boot_params;
>  	priv.efi		= &boot_params->efi_info;
> -	priv.e820ext		= NULL;
> -	priv.e820ext_size	= 0;

I.e.:

+	boot_map.map		= &map;
+	boot_map.map_size	= &map_size;
+	boot_map.desc_size	= &desc_size;
+	boot_map.desc_ver	= NULL;
+	boot_map.key_ptr	= NULL;
+	boot_map.buff_size	= &buff_size;
+
+	status = efi_get_memory_map(sys_table, &boot_map);

Thanks,

	Ingo

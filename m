Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CBB21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS09PW47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfBKSpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:45:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45488 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfBKSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:45:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id r14so693567pls.12;
        Mon, 11 Feb 2019 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f8WuludV5DY6JBEAA4mWS3Heq1YO9mHamIhfdA1NQEs=;
        b=FS09PW47SWT9WTic+WSr4mCH38g+qNcP9wITmHqh1HKcG+6ItutSVxZ8RMdu72vk9u
         uacrON/m559Ip5F4/g42Q7TtJRX4SUXct6JDayEzbbp9MC05ZnjzwDXO0d6AGhCaPxUp
         Lbp2sJtNUojU89w+NaA/PmtJKM5Benzz8PNTwdQK/yj65Li4BG/GPWHFvXtKTXacrogd
         lGk7EmAQaVOiIHfOSP5SSFJ9e2daLCSxRgjarO/CX35uAs8kC8/IAzkZ7iXafrtdqnhs
         g3T2+zg3Sx/JiCCDEUC9EATv3oa4LFwhcIKi/oHQCFW48J8GUel/2fG2eWr2d3TPLVp8
         R0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f8WuludV5DY6JBEAA4mWS3Heq1YO9mHamIhfdA1NQEs=;
        b=OrCxok5EIx5V/ndD/IFGtaEKSW0ctN3X5baSUEG5pjnhOZSlt/aYqCc3pccXkgXt91
         OiC6Wyntf7Eqp0qParPN+Hl0IZ5EMxLfLlfcdViOaofnAKBPdKsMggnHmCcELStB+UHC
         qBCpSFXuWWF+3phgiywHsyoCsF2siPDZgvjnguCgmKhoCNy1kHxtYpN9vjb6xs5dpjsO
         kDnpFLyUtyM0XcZfO71jiz2+2q1ja0kL9NoNsPlQB+SEu+Cnxklr+SOb4KWFHkgbWPGK
         GYmMV8QDs/LdvggWBYlr5psiJNs/CP+8F7R3TQQ00qpSTL3p/x7SSRlbmYVAb38bdDaD
         gOWQ==
X-Gm-Message-State: AHQUAubDzzLEpbTjwmsEqhUu+PLVX4xAfe3o+6hdx3v14y9TYirkRGn0
        7PKeOI+BokCzR0lLxHxpR+k=
X-Google-Smtp-Source: AHgI3IYkqqWg3qLv11mJkantOVmSlD1yu0ktdetixdx7d8k099+SMnCkUVzvna814b0ufrtSyUZubQ==
X-Received: by 2002:a17:902:7148:: with SMTP id u8mr11197355plm.110.1549910730206;
        Mon, 11 Feb 2019 10:45:30 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e65sm16254804pfc.184.2019.02.11.10.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 10:45:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 10/20] x86: avoid W^X being broken during modules
 loading
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190211182956.GN19618@zn.tnic>
Date:   Mon, 11 Feb 2019 10:45:26 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-11-rick.p.edgecombe@intel.com>
 <20190211182956.GN19618@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 11, 2019, at 10:29 AM, Borislav Petkov <bp@alien8.de> wrote:
> 
>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> index 76d482a2b716..69f3e650ada8 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -667,15 +667,29 @@ void __init alternative_instructions(void)
>>  * handlers seeing an inconsistent instruction while you patch.
>>  */
>> void *__init_or_module text_poke_early(void *addr, const void *opcode,
>> -					      size_t len)
>> +				       size_t len)
>> {
>> 	unsigned long flags;
>> -	local_irq_save(flags);
>> -	memcpy(addr, opcode, len);
>> -	local_irq_restore(flags);
>> -	sync_core();
>> -	/* Could also do a CLFLUSH here to speed up CPU recovery; but
>> -	   that causes hangs on some VIA CPUs. */
>> +
>> +	if (static_cpu_has(X86_FEATURE_NX) &&
> 
> Not a fast path - boot_cpu_has() is fine here.

Are you sure about that? This path is still used when modules are loaded.


Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25EAECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6C2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3cXWBvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeGOXTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:19:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54742 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:19:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so3004231wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjqgaHEQYIiGykRYo46Quysg+OfmUfxDoUFyVLlUcRs=;
        b=u3cXWBvxwibC+XkwOBGQ1K5jDPY0LoglDr+sCPYgauOvEmpU5RQjRsLlW/LSXHObGh
         kYNxtLN6Nf02HiOgxSO/TqVxvmds7UNtgWDxzVVyYHTEml+QU0ccvSNrFi87Ea1ADGAa
         m40cuuHKeeSO2w1wG9Q7ClTrk9Yu701rYA/ct9MgbLib+kr3XjIHtvdIuX0Jv0a30UwH
         OtgwPPRTxoYlid1jAdworBsbVadZDgbx2oWGJ+Dx2lBRomaM05sMwNxXxb8s788SGo+w
         18EaQzJlfkMv15eZ+lsMogPgd5bNUEHc43LQL7MG8Dq5hwHyh6vUIF6FyZ+CNZRaC5bo
         MH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjqgaHEQYIiGykRYo46Quysg+OfmUfxDoUFyVLlUcRs=;
        b=fviWKFnQJhN8IFRkEi4d7MAzdqfyN37giFjgPHN7RCXG/954r/KmzjgVFOoHukvUX8
         0oFpP4mBquVxtsMXdPpzNX3uh/HGTsUW6Z0y9jDKoeCrShyMUWkTgbBV91BLWL6ic8dI
         lsPrhh2+kOirZ6jjl80J45298Kk1lKPIhseIoSgdnbd+I6kxOorgiVMCC6nT+hcelkIx
         l+F5+8ImrEqgtr24vftwljvrJaHKpZExMZJube9RIHoTy2Ot6udIKBQg36a8uV6OBDXD
         JNIoeglfyOw0r2daQ/gkelqla58172Z7khZP2NlqK37MQ7zkkU1vCYd+s7I9dtmLQTLU
         fdAw==
X-Gm-Message-State: AOUpUlEj0a17X36CP8ErMOh+XthfS3tM3albU+yRZiDT5a/PuHPXqw93
        KOYhXXcFwuN22xmcTECFz/g=
X-Google-Smtp-Source: AAOMgpfP+JDs2NtQSnyIh2kV9y/MJWPNiSe5FE7MGkv3JPwgaLHrbPb6kujsm3UZAV48e26mA1HYNw==
X-Received: by 2002:a1c:9809:: with SMTP id a9-v6mr7843750wme.15.1531695275813;
        Sun, 15 Jul 2018 15:54:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l15-v6sm22259956wrt.67.2018.07.15.15.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 15:54:34 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:54:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] x86/ptrace: Add comments to x86_regset about empty slots
Message-ID: <20180715225433.GA30102@gmail.com>
References: <20180713171249.11510-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713171249.11510-1-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> find_regset() goes through regsets sequentially.  Empty slots
> in regset arrays causes mismatch.  Add comments to x86_regset
> enum.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/kernel/ptrace.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index e2ee403865eb..130ca4f27a17 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -42,6 +42,11 @@
>  
>  #include "tls.h"
>  
> +/*
> + * find_regset() goes through regsets sequentially.
> + * Do not create empty slots in x86_64_regsets[] or
> + * x86_32_regsets[] below.
> + */
>  enum x86_regset {
>  	REGSET_GENERAL,
>  	REGSET_FP,

What mismatch exactly? The logic in find_regset() is:

        for (n = 0; n < view->n; ++n) {
                regset = view->regsets + n;
                if (regset->core_note_type == type)
                        return regset;
        }


and an 'empty' slot would have .core_note_type of 0 - which would be easy to skip 
or warn about.

It appears to me user-space ptrace users can control 'type' via PTRACE_GETREGSET, 
so it might make sense to filter out the value of 0 there.

Or something like that. The patch doesn't really explain the problem, and I 
maintain my argument that the current code of relying on no empty slots and not 
having any mechanism other than human review ensuring it is both ugly and fragile.

Thanks,

	Ingo

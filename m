Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C24FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbeLNWcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:32:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40500 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:32:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so3303755pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:32:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SHmlWyuw6BTP9MLJkWfszjNDtzZ6ybq0wCkqDqmybBI=;
        b=JbrbuPZMAqPZO2cjrDPb63TVap/+uyyyxf10eRW836XZD+aDw5Fx4Tlat47+nxmEqI
         k4116JWGsPvK+5zzFWi/ncFxwtQnX85n0/PeLogoJGRjsPKUAH/fDAGyXvwt2rNzQ5UR
         EckaGPytF7tCgi6WBpBjDoCpXbqx2RbveU4hVqGYIhUQCVc3yO5NY9Q1SpAd63UEddpm
         0yenRz3k+zfIqGfXWLjuccdGvEXuYyzVAyK+jzCwvj5Gv7L7/HISOsKShiOGo1yISJqD
         yTKQE1NBggDFwR+hVCAAvABhZBgOAOy+DmRferjLq1Og6zXMlMcfcdC8qnsQUWEL97VF
         Y2Ig==
X-Gm-Message-State: AA+aEWakNLiMZFDmmz3QwMorwxhiZ1Zu8czRdocXjlGTrXRXXyvHtnbv
        mUVHmajoLkGc940kD0XCJXwIfQ==
X-Google-Smtp-Source: AFSGD/UskGub1ayLVu2Wtex0KQlT2Al79Pd1oGLRuqhCDUD8g7Oue5jFunHjeHX1oiZ/BYCTc3pNsw==
X-Received: by 2002:a63:f811:: with SMTP id n17mr4385353pgh.23.1544826728748;
        Fri, 14 Dec 2018 14:32:08 -0800 (PST)
Received: from [10.0.0.54] (c-73-19-79-57.hsd1.wa.comcast.net. [73.19.79.57])
        by smtp.gmail.com with ESMTPSA id x12sm6425217pgr.55.2018.12.14.14.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 14:32:07 -0800 (PST)
Subject: Re: [PATCH] x86: vdso: Pass --eh-frame-hdr to ld
To:     Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com
References: <20181214222757.31280-1-astrachan@google.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <4ab89a22-90af-9e57-a35f-7b478d8c62d5@redhat.com>
Date:   Fri, 14 Dec 2018 14:32:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181214222757.31280-1-astrachan@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 2:27 PM, Alistair Strachan wrote:
> Commit 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
> accidentally broke unwinding from userspace, because ld would strip the
> .eh_frame sections when linking.
> 
> Originally, the compiler would implicitly add --eh-frame-hdr when
> invoking the linker, but when this Makefile was converted from invoking
> ld via the compiler, to invoking it directly (like vmlinux does),
> the flag was missed. (The EH_FRAME section is important for the VDSO
> shared libraries, but not for vmlinux.)
> 
> Fix the problem by explicitly specifying --eh-frame-hdr, which restores
> parity with the old method.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201741
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1659295
> Reported-by: Laura Abbott <labbott@redhat.com>

You should probably use the bugzilla reporters instead
of me given I just did the boring part of sending an e-mail.
Instead you can use:

Tested-by: Laura Abbott <labbott@redhat.com>

> Fixes: 379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")
> Cc: stable@vger.kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: X86 ML <x86@kernel.org>
> Cc: Florian Weimer <fweimer@redhat.com>,
> Cc: Carlos O'Donell <carlos@redhat.com>,
> Cc: "H. J. Lu" <hjl.tools@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: kernel-team@android.com
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> ---
>   arch/x86/entry/vdso/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 141d415a8c80..c3d7ccd25381 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -171,7 +171,8 @@ quiet_cmd_vdso = VDSO    $@
>   		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
>   
>   VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
> -	$(call ld-option, --build-id) -Bsymbolic
> +	$(call ld-option, --build-id) $(call ld-option, --eh-frame-hdr) \
> +	-Bsymbolic
>   GCOV_PROFILE := n
>   
>   #
> 


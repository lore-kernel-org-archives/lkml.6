Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B22C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E04021B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5tw/40m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfBKTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:09:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44615 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbfBKTJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:09:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id y1so5357279pgk.11;
        Mon, 11 Feb 2019 11:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nXXWwRuaJ6+ems3kM7ee19N3t7IhdXW1WW/p2CXVYdI=;
        b=f5tw/40mwGuzkdOcN4HgctENimk7IRkUtncSGUWBNxDfImzcfpFsSc/X2DOrcTTZ3A
         n0LbnvfXS7EVdDtkI/WPQ7IIjassAhqHIEVRy0c3cmH3zmtXgj3WdNJbc8kaTzTRzaqE
         0Rkmf1uLlb/c4Tij/veYAEwld984BfNK6Ze2hcTrtWqKjpHDo16VbqPp6veoBC9kDcet
         R2f4dlLxSLhTx/PL3c/S084cipdpplX0FmsL0nLr3Du3QKb6NA7aVAtMjZ5pyGT2C65J
         CWJvHJsvyIJgLBV62FRx2aregf9ZQXjCbrTIO2Ma29AhKazy6qBW6cDZQhqz/63XTFzV
         DuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nXXWwRuaJ6+ems3kM7ee19N3t7IhdXW1WW/p2CXVYdI=;
        b=j14uYVeT8lS3Z0UbJfNESCTdnE+4lZ08VbMLJwAhzYfDhu6DDDzFlF3Xx14qoPTgHS
         +GXioXzhysQrl1aUSZwPdCfGFJNLNQ0Gq/REppjCRhrGF4Bq3qWTTi8wiy0gmiH7NDLd
         UvqeIhrTydphLrLTySRNKO/pTs3Savv+uc1pS8eCAg2srv/75e4to4PNLnVOtrByiu0q
         AhlOxljcTWBYCQyPePTS6Jl4fRM8iP3yRnvmloUuDSnT+0N+syCGVuLQrCzHYggvKEeK
         awa57uLlN8eMm1lLXNko4824bXrBHG0ZQ93WOM//iNMQG9E5ASjFcRQNdctzexzSsLpt
         ED7g==
X-Gm-Message-State: AHQUAuZQyudcJfU39iXjHlfDeAz8CysohnbD2M1N66uVDpXWjJgNuSET
        gUtmR2NJ7HriRG2/IDLqUhw=
X-Google-Smtp-Source: AHgI3IYG+m4zIDVNNPmj5+E7N+OOV6khCxg17Cv7p6YOyLv1jkwlRprnlmBQzhLqEvhRByWMnrU9nw==
X-Received: by 2002:a63:e051:: with SMTP id n17mr35005871pgj.258.1549912171925;
        Mon, 11 Feb 2019 11:09:31 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a15sm16655637pgd.4.2019.02.11.11.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:09:31 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 10/20] x86: avoid W^X being broken during modules
 loading
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190211190108.GP19618@zn.tnic>
Date:   Mon, 11 Feb 2019 11:09:25 -0800
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <A671F14F-3E03-4A97-9F54-426533077E0C@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-11-rick.p.edgecombe@intel.com>
 <20190211182956.GN19618@zn.tnic>
 <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com>
 <20190211190108.GP19618@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 11, 2019, at 11:01 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Mon, Feb 11, 2019 at 10:45:26AM -0800, Nadav Amit wrote:
>> Are you sure about that? This path is still used when modules are =
loaded.
>=20
> Yes, I'm sure. Loading a module does a gazillion things so saving a
> couple of insns - yes, boot_cpu_has() is usually a RIP-relative MOV =
and a
> TEST - doesn't show even as a blip on any radar.

I fully agree, if that is the standard.

It is just that I find the use of static_cpu_has()/boot_cpu_has() to be =
very
inconsistent. I doubt that show_cpuinfo_misc(), =
copy_fpstate_to_sigframe(),
or i915_memcpy_init_early() that use static_cpu_has() are any hotter =
than
text_poke_early().

Anyhow, I=E2=80=99ll use boot_cpu_has() as you said.=

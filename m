Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453DBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F0120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHdAQc93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfAQW3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:29:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42146 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfAQW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:29:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so5378427plp.9;
        Thu, 17 Jan 2019 14:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8fuEgNkk8T1WJ/UHEMWutP1XUoE1BoPWupQNbWBmkdk=;
        b=JHdAQc93+ID0LwKz7qTSCs/xLJtLJ6/H4Jb1895LciW26CEbMyIEXMoDqApzwUHSG+
         nY7n0XiZvB/uNijfmCxk7WcqkMygdoMZTg2TzzIAM5GmPUaR3UutTUaeX4UCdgjaDVyi
         ugYVoMCcyNLEtDHdKO6HpbovnHuYeGo39FwDfmII3VYAMNo7jNaks8U6gutXTz245Ash
         R7iUKsrrv5RSrW0KlAM5rYDk6TxgAiB5m6V41WkEARlA71sRfVsws1mLt5v0r1cIDORw
         4B23uNB7tVKKUj+hOV/6gc2ncdpjITiQ+enlleUuuVlD9rYemJU2JOYjm1cLALKQYKTs
         LnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8fuEgNkk8T1WJ/UHEMWutP1XUoE1BoPWupQNbWBmkdk=;
        b=i33yYF08ohiiIVz5OONhxtg0CdUxdJsQo1F5+xENUqHIIHX5fuHsG8Bzhp6weReU3z
         202NHsohwq3z+kvyDK1ql4giLlFpoesJBt8ftz56bkmVROGWvOYk2pAfjEWMzTrftnyb
         vezO2tdjosVLyyJpnPHquRW5SwYMkJAeU1N0EuaZJs+Q5f0U3eRonAPI9ADLym1nCGRF
         VGx71vcd5aUZb2AMxBE0v/ge6VA3jOshv+jK4TSym9SS26nHMRAJ05xByz6FbdmD3IMb
         Ntrfm6cO+TSmgtiQxx3TFu+D78KyR3myDT2Kgbg5VQRWThNPYL9pG5WneWoY7wOmOAJj
         Kfcg==
X-Gm-Message-State: AJcUukeK9bokjxKReNjh/KHwqG8y1lubMO8XkCnEOgHGYD8zGJOqLRqv
        Fk006stFU2GSGBcCJexd6Bc=
X-Google-Smtp-Source: ALg8bN4Y+37YAJRaLEFv+LRu5H/rIjwl1kaTrNnvfK/eu2C6XAoCkkj+RSfVNd9hxKUWd+tSix/C2w==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61mr16746843plb.185.1547764179149;
        Thu, 17 Jan 2019 14:29:39 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n21sm4171802pfg.84.2019.01.17.14.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 14:29:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 06/17] x86/alternative: use temporary mm for text poking
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <B8C39C5A-A669-4F80-9BAE-7C11A4379ECF@gmail.com>
Date:   Thu, 17 Jan 2019 14:29:36 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
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
Message-Id: <32219CAE-7D49-4848-9497-A17E0D809B3E@gmail.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-7-rick.p.edgecombe@intel.com>
 <CALCETrUMAsXoZogEJg7ssv0CO56vzBV2C7VotmWcwNM7iH9Wqw@mail.gmail.com>
 <CALCETrXQ6uxzB3JvO14sEyMA21RcWCbwicL4nUdPBG8KAunxwg@mail.gmail.com>
 <B8C39C5A-A669-4F80-9BAE-7C11A4379ECF@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 17, 2019, at 1:43 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>> On Jan 17, 2019, at 12:47 PM, Andy Lutomirski <luto@kernel.org> =
wrote:
>>=20
>> On Thu, Jan 17, 2019 at 12:27 PM Andy Lutomirski <luto@kernel.org> =
wrote:
>>> On Wed, Jan 16, 2019 at 4:33 PM Rick Edgecombe
>>> <rick.p.edgecombe@intel.com> wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>>=20
>>>> text_poke() can potentially compromise the security as it sets =
temporary
>>>> PTEs in the fixmap. These PTEs might be used to rewrite the kernel =
code
>>>> from other cores accidentally or maliciously, if an attacker gains =
the
>>>> ability to write onto kernel memory.
>>>=20
>>> i think this may be sufficient, but barely.
>>>=20
>>>> +       pte_clear(poking_mm, poking_addr, ptep);
>>>> +
>>>> +       /*
>>>> +        * __flush_tlb_one_user() performs a redundant TLB flush =
when PTI is on,
>>>> +        * as it also flushes the corresponding "user" address =
spaces, which
>>>> +        * does not exist.
>>>> +        *
>>>> +        * Poking, however, is already very inefficient since it =
does not try to
>>>> +        * batch updates, so we ignore this problem for the time =
being.
>>>> +        *
>>>> +        * Since the PTEs do not exist in other kernel =
address-spaces, we do
>>>> +        * not use __flush_tlb_one_kernel(), which when PTI is on =
would cause
>>>> +        * more unwarranted TLB flushes.
>>>> +        *
>>>> +        * There is a slight anomaly here: the PTE is a =
supervisor-only and
>>>> +        * (potentially) global and we use __flush_tlb_one_user() =
but this
>>>> +        * should be fine.
>>>> +        */
>>>> +       __flush_tlb_one_user(poking_addr);
>>>> +       if (cross_page_boundary) {
>>>> +               pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep =
+ 1);
>>>> +               __flush_tlb_one_user(poking_addr + PAGE_SIZE);
>>>> +       }
>>>=20
>>> In principle, another CPU could still have the old translation.  =
Your
>>> mutex probably makes this impossible, but it makes me nervous.
>>> Ideally you'd use flush_tlb_mm_range(), but I guess you can't do =
that
>>> with IRQs off.  Hmm.  I think you should add an inc_mm_tlb_gen() =
here.
>>> Arguably, if you did that, you could omit the flushes, but maybe
>>> that's silly.
>>>=20
>>> If we start getting new users of use_temporary_mm(), we should give
>>> some serious thought to the SMP semantics.
>>>=20
>>> Also, you're using PAGE_KERNEL.  Please tell me that the global bit
>>> isn't set in there.
>>=20
>> Much better solution: do unuse_temporary_mm() and *then*
>> flush_tlb_mm_range().  This is entirely non-sketchy and should be =
just
>> about optimal, too.
>=20
> This solution sounds nice and clean. The fact the global-bit was set =
didn=E2=80=99t
> matter before (since __flush_tlb_one_user would get rid of it no =
matter
> what), but would matter now, so I=E2=80=99ll change it too.

Err.. so actually text_poke() might be called with disabled IRQs (by =
kgdb).
flush_tlb_mm_range() should still work fine even with disabled IRQs =
since no
core would use poking_mm at this point. I can add a comment to
flush_tlb_mm_range(), but all in all it is actually not very pretty.


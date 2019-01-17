Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B58C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/at1foR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfAQVn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:43:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44609 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfAQVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:43:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5452316pfh.11;
        Thu, 17 Jan 2019 13:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j/YjH2gW8sjo78VY49dxoRISJ580wMBefMMOJmwxNxI=;
        b=b/at1foR8Zn7AJ/HgdQ8lRzqfG2rx8ui//d+tMeliWzapg622K31UeIUyP1Pq53LNl
         gSr/FdRE/MDGSGnyzGVPDf4nDoekNvE+QSVa/9jL21l8Wcv+iOtFXZ87XFhCeQhU7pfv
         Al9f7VS8NjQIWsGffawWq1EzftOMMegdfiZaK8BA6UO7yUn7gPIdDurJ2IDyUKXTDic4
         CH4KaO0BMomZhzpv2pKS8wt4Os0+zU7i9GFHczoMsYV7A9UF2rSo7YihUuJvA4UM7tEn
         0nYmsCs7PDj/xMvdnzMnVI4pabYqLXVvMxhad9WDJFUGNd92Dhkki3TZ+xawNY6lkC73
         hzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j/YjH2gW8sjo78VY49dxoRISJ580wMBefMMOJmwxNxI=;
        b=IoMU5A/VE5QujtEmCVWE2mVJpDzbXKILofzaNDGq03vUFeX6b6HLJOLCbH63sMwTi5
         7m1nd/KsGsDVTXHNwO2nrtLDvxvwMaQtSfijqBFrbCRoQRgORbt/z3C2+IL0C+TV3B5i
         LlZ4OwboWHY8FsKUuRx5fuP6UvfGLCtRYXCfV1CjxFjxpWaKYX1/vqntVBWwJSt30QHl
         bXzewYEm0WlQlHWCOxlrt66l8TB7rjxubnv24OAWu3m9v4a9AYJ12G/2Yrm3Am0eo04c
         HB7I8rDPGz96ZASJdoCryjGHhXtVzLB0UOfpTdneLNXLxBPAY9kxMRUfjBslK3gdgija
         UQBg==
X-Gm-Message-State: AJcUukcFpGbDv4n95L3tPn6U3m3XIzna88PToKAMBleVKD+wPR1+ZA5G
        g6tHD5d543z48n0tzBF0F9k=
X-Google-Smtp-Source: ALg8bN6HOGsNqvq4jCAfpx6c2TfadH5Og/wDdaHfpQzFTSVApGZshSnGe2dN62tUEyextyulbxth8w==
X-Received: by 2002:a65:4142:: with SMTP id x2mr14564989pgp.356.1547761437190;
        Thu, 17 Jan 2019 13:43:57 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o13sm4133028pfk.57.2019.01.17.13.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 13:43:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 06/17] x86/alternative: use temporary mm for text poking
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrXQ6uxzB3JvO14sEyMA21RcWCbwicL4nUdPBG8KAunxwg@mail.gmail.com>
Date:   Thu, 17 Jan 2019 13:43:54 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
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
Message-Id: <B8C39C5A-A669-4F80-9BAE-7C11A4379ECF@gmail.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-7-rick.p.edgecombe@intel.com>
 <CALCETrUMAsXoZogEJg7ssv0CO56vzBV2C7VotmWcwNM7iH9Wqw@mail.gmail.com>
 <CALCETrXQ6uxzB3JvO14sEyMA21RcWCbwicL4nUdPBG8KAunxwg@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 17, 2019, at 12:47 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Thu, Jan 17, 2019 at 12:27 PM Andy Lutomirski <luto@kernel.org> =
wrote:
>> On Wed, Jan 16, 2019 at 4:33 PM Rick Edgecombe
>> <rick.p.edgecombe@intel.com> wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>>=20
>>> text_poke() can potentially compromise the security as it sets =
temporary
>>> PTEs in the fixmap. These PTEs might be used to rewrite the kernel =
code
>>> from other cores accidentally or maliciously, if an attacker gains =
the
>>> ability to write onto kernel memory.
>>=20
>> i think this may be sufficient, but barely.
>>=20
>>> +       pte_clear(poking_mm, poking_addr, ptep);
>>> +
>>> +       /*
>>> +        * __flush_tlb_one_user() performs a redundant TLB flush =
when PTI is on,
>>> +        * as it also flushes the corresponding "user" address =
spaces, which
>>> +        * does not exist.
>>> +        *
>>> +        * Poking, however, is already very inefficient since it =
does not try to
>>> +        * batch updates, so we ignore this problem for the time =
being.
>>> +        *
>>> +        * Since the PTEs do not exist in other kernel =
address-spaces, we do
>>> +        * not use __flush_tlb_one_kernel(), which when PTI is on =
would cause
>>> +        * more unwarranted TLB flushes.
>>> +        *
>>> +        * There is a slight anomaly here: the PTE is a =
supervisor-only and
>>> +        * (potentially) global and we use __flush_tlb_one_user() =
but this
>>> +        * should be fine.
>>> +        */
>>> +       __flush_tlb_one_user(poking_addr);
>>> +       if (cross_page_boundary) {
>>> +               pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + =
1);
>>> +               __flush_tlb_one_user(poking_addr + PAGE_SIZE);
>>> +       }
>>=20
>> In principle, another CPU could still have the old translation.  Your
>> mutex probably makes this impossible, but it makes me nervous.
>> Ideally you'd use flush_tlb_mm_range(), but I guess you can't do that
>> with IRQs off.  Hmm.  I think you should add an inc_mm_tlb_gen() =
here.
>> Arguably, if you did that, you could omit the flushes, but maybe
>> that's silly.
>>=20
>> If we start getting new users of use_temporary_mm(), we should give
>> some serious thought to the SMP semantics.
>>=20
>> Also, you're using PAGE_KERNEL.  Please tell me that the global bit
>> isn't set in there.
>=20
> Much better solution: do unuse_temporary_mm() and *then*
> flush_tlb_mm_range().  This is entirely non-sketchy and should be just
> about optimal, too.

This solution sounds nice and clean. The fact the global-bit was set =
didn=E2=80=99t
matter before (since __flush_tlb_one_user would get rid of it no matter
what), but would matter now, so I=E2=80=99ll change it too.

Thanks!

Nadav


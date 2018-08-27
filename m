Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DFB208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd+oHePZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DFB208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeH0W6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:58:31 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34073 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeH0W6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:58:31 -0400
Received: by mail-pf1-f182.google.com with SMTP id k19-v6so30616pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lENCYtMSxr4xRHwzZVa5NAUjz8pdiMzVvsTABxxgKDM=;
        b=jd+oHePZbrS6CEWWtibEUDac1tswd2DoK0YcpdwbygRAmMhZdcUSubzbQhFpK8fASC
         u1ijSM4l6CukcGXAe338aWU6XPYJ0xhr61mi+qZG1vNHq/zhS219/f8/jRbY0vjckHl5
         6bLkz/neGROPlf5nSirsr0ay4ukTezoxHlpJFqLt3Hwp0Pt5qtb0l9+0eP7n9ZCIr8M1
         18Yyku509QWgsUpKCLfnWR4U+EdCtNITw+XFyfrwiNw9VIffOn0gZzFGvvWjsvvCNsy9
         t7biXwvDHBkTGs8BEODUSYOcv4W7Bh5jIysGXe7G2MtWm6PIwkrAP7IWKuOnoe32ruZy
         yXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lENCYtMSxr4xRHwzZVa5NAUjz8pdiMzVvsTABxxgKDM=;
        b=AYEh5EmTkTdVASSUJQ2EyKcK6HjwyCdR15lwo4Uenve+mceG++DEG7iLK3OMWdeDty
         7dl84Jyl9rBVbIzYRcnJyQDMDCOudUY3Axvs4O+gA3senvMBg/Oh0Sq/JTLJRJ4VgWCY
         4R5O1p2nRqW/DrmO/Lt73FY2YRWuqSoNjxM6Kv7QxBPKTJwZ+ok/cPq1XPxriAYA7n46
         IO1jDvF6sYUvp455BLWPAarEee+F+Y/1xYQAAKftx6MUcGTkWreG3DphCXhYYRGdgrio
         rVwGN889ahKaHq9CTf3z0dJMAQECjN+dL7+gds8WW71z/qUih1pkUUrcDj95DuESk6cA
         cV8A==
X-Gm-Message-State: APzg51BXOeskPvWb27SM5wqAvH/mDxZQoDvHdJhN1Z5QhN/SSR4LqSSv
        Mdc7Nh9POrkVFGfCXElDouw=
X-Google-Smtp-Source: ANB0VdY1aTJ9/KwMorCuhgoCp4+VPGq31kd3w+0CNO7Neq61805fTpNZAI7B40ubm6O3lmB2cEtSzA==
X-Received: by 2002:a62:234d:: with SMTP id j74-v6mr15394131pfj.106.1535397037818;
        Mon, 27 Aug 2018 12:10:37 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id b64-v6sm30389pfg.66.2018.08.27.12.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:10:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: TLB flushes on fixmap changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrUoNdwDuNSHb3haw9-fYk+sNC_M4r+5EMVVzJ8HWeSsOQ@mail.gmail.com>
Date:   Mon, 27 Aug 2018 12:10:34 -0700
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Transfer-Encoding: quoted-printable
Message-Id: <823D916E-4056-4A36-BDD8-0FB682A8DCAE@gmail.com>
References: <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
 <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
 <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org>
 <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <20180826090958.GT24124@hirez.programming.kicks-ass.net>
 <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
 <4BF82052-4738-441C-8763-26C85003F2C9@gmail.com>
 <20180827170511.6bafa15cbc102ae135366e86@kernel.org>
 <01DA0BDD-7504-4209-8A8F-20B27CF6A1C7@gmail.com>
 <CALCETrWxwpr+Xx0mCK1HUkanmCDOSRbw50VmebgoAgeNaaPAKg@mail.gmail.com>
 <0000D631-FDDF-4273-8F3C-714E6825E59B@gmail.com>
 <CALCETrUoNdwDuNSHb3haw9-fYk+sNC_M4r+5EMVVzJ8HWeSsOQ@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 11:58 AM, Andy Lutomirski <luto@kernel.org> wrote:

> On Mon, Aug 27, 2018 at 11:54 AM, Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>> On Mon, Aug 27, 2018 at 10:34 AM, Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>> What do you all think?
>>=20
>> I agree in general. But I think that current->mm would need to be =
loaded, as
>> otherwise I am afraid it would break switch_mm_irqs_off().
>=20
> What breaks?

Actually nothing. I just saw the IBPB stuff regarding tsk, but it should =
not
matter.


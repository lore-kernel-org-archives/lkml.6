Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD907C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6920F214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY6CiKO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6920F214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLFTji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:39:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:39:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so573989pgp.13;
        Thu, 06 Dec 2018 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RfB4MLR6Gp8n6wmEb7lTS+6uzEaoJXtgNUn8YArnrpQ=;
        b=YY6CiKO8SuHu1R45sdyFHjwpBNb8LC0fLptEoaKUVqreM64tHQMSymxzlZPP5PRMcu
         1LGTD57WmrckGPeqrf5VBB7wLjrHDhqslXG2Jjex0zs9eTPU2p/LtV+cYQddmbsYhBzC
         dEJWsYzTponcFz931t1yJ0eQuinPlOpMyBSSEpEsUHBRfJ6KnWVR3bEJmfBthxuyA4vI
         u/zB8NhK4pFMF/ISG/36qvGMH2Wn2jbDi393jrCYb4bqvSgBGN6BySqCqLUWHWJij0BM
         5mhJC5VvwYUfxymwdVtUirAkuNZccmE5xFzYpSlk7GfjXTApUaG3arhjsJvhRJA3Mi8u
         ar1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RfB4MLR6Gp8n6wmEb7lTS+6uzEaoJXtgNUn8YArnrpQ=;
        b=ik49h/4Z/2YrIU0HcKP52xnqhM0oFJwfbCIZLSnJ4MwIuRQe4GSa58m3sC6CTo91s7
         SRUGBjnya7I+rrOwJ2ogqBqqabCtG2D470Xsvi/wVBFjsr/WC/XNVIEpyxnfu6DxOqra
         mst/ZdYApBMVIewx+sVZPeoJeSSMX20CtoZ4i1N0eIli8mGtWzaavnIM4r1BMvAat2+Y
         BVIfmRFh+Zo0Saa8508t+jP3GhTacHHofUwR1MwRKPCcfEINCa8DX0wTAtP+pVgIrw0v
         tAo42QN8DoB1ZZ0vZCcmqKJdDw9511JMOc/j/PJEmY9U/g/jqmza291ExZ+ShJE3fS2E
         KyBw==
X-Gm-Message-State: AA+aEWbpETjbNk85qSqUcKPlsdzt/KjqW9c4a85HW+rN0M2b/NYr/Yyo
        U1mdYH2cd/LT01Z9lx65RZM=
X-Google-Smtp-Source: AFSGD/Xcv+yCNzyDUwRzgbwJ8RvEr5/23XxCpF2wlyrLdbSky6+7ez0UrXEGLC3pbDyXnvW+7U3ftA==
X-Received: by 2002:a63:344e:: with SMTP id b75mr24186688pga.184.1544125176200;
        Thu, 06 Dec 2018 11:39:36 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id x19sm1650428pfk.14.2018.12.06.11.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:39:35 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrUmxht8dibJPBbPudQnoe6mHsKocEBgkJ7O1eFrVBfekQ@mail.gmail.com>
Date:   Thu, 6 Dec 2018 11:39:32 -0800
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jann Horn <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5664C1D-C3E7-433B-8E5A-7967023E0567@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com>
 <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
 <20181205114148.GA15160@arm.com>
 <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
 <CAKv+Gu_EEjhwbfp1mdB0Pu3ZyAsZgNeaCDArs569hAeWzHMWpw@mail.gmail.com>
 <CALCETrVedB7yacMU=i3JaUZxiwsnM+PnABfG48K9TZK32UWshA@mail.gmail.com>
 <20181206190115.GC10086@cisco>
 <CALCETrUmxht8dibJPBbPudQnoe6mHsKocEBgkJ7O1eFrVBfekQ@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 6, 2018, at 11:19 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Thu, Dec 6, 2018 at 11:01 AM Tycho Andersen <tycho@tycho.ws> wrote:
>> On Thu, Dec 06, 2018 at 10:53:50AM -0800, Andy Lutomirski wrote:
>>>> If we are going to unmap the linear alias, why not do it at =
vmalloc()
>>>> time rather than vfree() time?
>>>=20
>>> That=E2=80=99s not totally nuts. Do we ever have code that expects =
__va() to
>>> work on module data?  Perhaps crypto code trying to encrypt static
>>> data because our APIs don=E2=80=99t understand virtual addresses.  I =
guess if
>>> highmem is ever used for modules, then we should be fine.
>>>=20
>>> RO instead of not present might be safer.  But I do like the idea of
>>> renaming Rick's flag to something like VM_XPFO or VM_NO_DIRECT_MAP =
and
>>> making it do all of this.
>>=20
>> Yeah, doing it for everything automatically seemed like it was/is
>> going to be a lot of work to debug all the corner cases where things
>> expect memory to be mapped but don't explicitly say it. And in
>> particular, the XPFO series only does it for user memory, whereas an
>> additional flag like this would work for extra paranoid allocations
>> of kernel memory too.
>=20
> I just read the code, and I looks like vmalloc() is already using
> highmem (__GFP_HIGH) if available, so, on big x86_32 systems, for
> example, we already don't have modules in the direct map.
>=20
> So I say we go for it.  This should be quite simple to implement --
> the pageattr code already has almost all the needed logic on x86.  The
> only arch support we should need is a pair of functions to remove a
> vmalloc address range from the address map (if it was present in the
> first place) and a function to put it back.  On x86, this should only
> be a few lines of code.
>=20
> What do you all think?  This should solve most of the problems we =
have.
>=20
> If we really wanted to optimize this, we'd make it so that
> module_alloc() allocates memory the normal way, then, later on, we
> call some function that, all at once, removes the memory from the
> direct map and applies the right permissions to the vmalloc alias (or
> just makes the vmalloc alias not-present so we can add permissions
> later without flushing), and flushes the TLB.  And we arrange for
> vunmap to zap the vmalloc range, then put the memory back into the
> direct map, then free the pages back to the page allocator, with the
> flush in the appropriate place.
>=20
> I don't see why the page allocator needs to know about any of this.
> It's already okay with the permissions being changed out from under it
> on x86, and it seems fine.  Rick, do you want to give some variant of
> this a try?

Setting it as read-only may work (and already happens for the read-only
module data). I am not sure about setting it as non-present.

At some point, a discussion about a threat-model, as Rick indicated, =
would
be required. I presume ROP attacks can easily call =
set_all_modules_text_rw()
and override all the protections.


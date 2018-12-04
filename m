Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F923C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4403F2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okHJzn3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4403F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeLDUgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:36:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35878 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeLDUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:36:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so7906530pgm.3;
        Tue, 04 Dec 2018 12:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DrIB/V2f5SlA/8MKxmeUyqbWCQ3Npnh309oIdZQ46mc=;
        b=okHJzn3AsdfRRAx8H8nfGVcfn6tWSeBOGa5N7uv3pADUlTPKpYq77rUnjeafSeqByD
         vrj/31xSLe9oQlKLxSoxz9kdnIRhHaIRqoRFOh8xAN5u2OxEmDhZLq3aGfCbRNG93rE7
         PudYf1XaJY51/eULo/Ke6h3kNmsnCzGg14JukEiZ0vYtjf+imKY6MBzz0+WmN9rykEhS
         0ezQBYFa5mGwbO52nr+ExqNRbjLTdZnEfir+sld6Rd4KPcIuKHWbJhIfVbAmoRZm9GmZ
         Gvgf3poa8FV4DOHoEUJBhZNb5izJthCjKv67z67BBqd3Nlez6w5M1VIFBQc+MU7cikUc
         jblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DrIB/V2f5SlA/8MKxmeUyqbWCQ3Npnh309oIdZQ46mc=;
        b=H425t4v5CZ2oDlTU8b6SjzoXZgxgxwgbIM781sP8rmBT4wypx4/dHRApYDwh9Sfthx
         6qXKjcdzKB2kK4HegJ75gNUI+TgPtLx+cQNSWcjMgpn5TmkcF85wwbVSvAvCVq8jutwf
         qfxGLuHD0XRS7V+8ZQ5ceehuMPvSkCFyopy/578CIFA9kSpuPY6wJRo9IV5P8jUrFw1Z
         ySwpZCtKfolnFgVK/oc+/X2eLdVxAXrTS6kSgi0+6JNLzE/R6f6+WZhL3qXwuYQGoyYf
         HVdQY4ip4IoeKAzhlF9OBsbOefeUcF4Dt7b4Pqws1aVxMqd5RkvuSwSqQjggzZbOsWXC
         NKGw==
X-Gm-Message-State: AA+aEWbFuMYRsAPT0ZN6waO+vYdxlS9lZeT3sW35XFYWm7IS9z71RdH3
        rZhirs3mdqM+gGPXsyQjDlk=
X-Google-Smtp-Source: AFSGD/XpeStNACC+ZvdERn1ObeRbkKfsGpLejM+Tc8ooh8osNb8uj9u8Oql6zmBvMTM1nuXEhF+17g==
X-Received: by 2002:a63:e711:: with SMTP id b17mr17449457pgi.363.1543955808349;
        Tue, 04 Dec 2018 12:36:48 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id i123sm35116036pfg.164.2018.12.04.12.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:36:46 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
Date:   Tue, 4 Dec 2018 12:36:44 -0800
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5ABCA50-12F0-4A19-B499-3927D59BF589@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com>
 <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 4, 2018, at 12:02 PM, Edgecombe, Rick P =
<rick.p.edgecombe@intel.com> wrote:
>=20
> On Tue, 2018-12-04 at 16:03 +0000, Will Deacon wrote:
>> On Mon, Dec 03, 2018 at 05:43:11PM -0800, Nadav Amit wrote:
>>>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe =
<rick.p.edgecombe@intel.com>
>>>> wrote:
>>>>=20
>>>> Since vfree will lazily flush the TLB, but not lazily free the =
underlying
>>>> pages,
>>>> it often leaves stale TLB entries to freed pages that could get =
re-used.
>>>> This is
>>>> undesirable for cases where the memory being freed has special =
permissions
>>>> such
>>>> as executable.
>>>=20
>>> So I am trying to finish my patch-set for preventing transient W+X =
mappings
>>> from taking space, by handling kprobes & ftrace that I missed =
(thanks again
>>> for
>>> pointing it out).
>>>=20
>>> But all of the sudden, I don=E2=80=99t understand why we have the =
problem that this
>>> (your) patch-set deals with at all. We already change the mappings =
to make
>>> the memory writable before freeing the memory, so why can=E2=80=99t =
we make it
>>> non-executable at the same time? Actually, why do we make the module =
memory,
>>> including its data executable before freeing it???
>>=20
>> Yeah, this is really confusing, but I have a suspicion it's a =
combination
>> of the various different configurations and hysterical raisins. We =
can't
>> rely on module_alloc() allocating from the vmalloc area (see nios2) =
nor
>> can we rely on disable_ro_nx() being available at build time.
>>=20
>> If we *could* rely on module allocations always using vmalloc(), then
>> we could pass in Rick's new flag and drop disable_ro_nx() altogether
>> afaict -- who cares about the memory attributes of a mapping that's =
about
>> to disappear anyway?
>>=20
>> Is it just nios2 that does something different?
>>=20
>> Will
>=20
> Yea it is really intertwined. I think for x86, set_memory_nx =
everywhere would
> solve it as well, in fact that was what I first thought the solution =
should be
> until this was suggested. It's interesting that from the other thread =
Masami
> Hiramatsu referenced, set_memory_nx was suggested last year and would =
have
> inadvertently blocked this on x86. But, on the other architectures I =
have since
> learned it is a bit different.
>=20
> It looks like actually most arch's don't re-define set_memory_*, and =
so all of
> the frob_* functions are actually just noops. In which case allocating =
RWX is
> needed to make it work at all, because that is what the allocation is =
going to
> stay at. So in these archs, set_memory_nx won't solve it because it =
will do
> nothing.
>=20
> On x86 I think you cannot get rid of disable_ro_nx fully because there =
is the
> changing of the permissions on the directmap as well. You don't want =
some other
> caller getting a page that was left RO when freed and then trying to =
write to
> it, if I understand this.
>=20
> The other reasoning was that calling set_memory_nx isn't doing what we =
are
> actually trying to do which is prevent the pages from getting released =
too
> early.
>=20
> A more clear solution for all of this might involve refactoring some =
of the
> set_memory_ de-allocation logic out into __weak functions in either =
modules or
> vmalloc. As Jessica points out in the other thread though, modules =
does a lot
> more stuff there than the other module_alloc callers. I think it may =
take some
> thought to centralize AND make it optimal for every =
module_alloc/vmalloc_exec
> user and arch.
>=20
> But for now with the change in vmalloc, we can block the executable =
mapping
> freed page re-use issue in a cross platform way.

Please understand me correctly - I didn=E2=80=99t mean that your patches =
are not
needed.

All I did is asking - how come the PTEs are executable when they are =
cleared
they are executable, when in fact we manipulate them when the module is
removed.

I think I try to deal with a similar problem to the one you encounter -
broken W^X. The only thing that bothered me in regard to your patches =
(and
only after I played with the code) is that there is still a time-window =
in
which W^X is broken due to disable_ro_nx().


Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA66C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF48F2474B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW5dNwl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF48F2474B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbeF0STg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965529AbeF0STf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:19:35 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0386D25A20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530123575;
        bh=pnOehvODlQ3idpKR1Lkn6GzjeTgUnKl3Ug3FAHlJf3I=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sW5dNwl5xquKS640utzph8GAx1gv/UuLv+gZedPC9hFy9KJmArHot7mmISE/aorN0
         spENO0N1Wcp9KugjqbcvaXYblNQKiS8+eeh6r/a08Iy7vdT5fOwAOyn3T4KIrHItxr
         Akys0SsonyDFaaEldRVsi3Rt6XVjD+7LpPQxF+Cg=
Received: by mail-wm0-f48.google.com with SMTP id b188-v6so728779wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:19:34 -0700 (PDT)
X-Gm-Message-State: APt69E3OBJJn3fpcDn6tP1UIF1htHHk0/X1eLyaucLc06ENPif1G1/m+
        wJKUIErJ6/c4RC0OsbFT20bAhQa+rjIQlzJkJN8ECQ==
X-Google-Smtp-Source: AAOMgpd8md20sy6Lj2eJ8/dUtHNqEj7hSIFzbfwE44vJwFezJnpLHGQeiwPyEGuUJ953N2++7bEbpPFf6iBxKLqW8DM=
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr5503301wmc.144.1530123573475;
 Wed, 27 Jun 2018 11:19:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 11:19:12
 -0700 (PDT)
In-Reply-To: <FB113DE3-5841-49B2-A11E-CE785EF0C763@amacapital.net>
References: <20180621211754.12757-1-h.peter.anvin@intel.com>
 <20180621211754.12757-2-h.peter.anvin@intel.com> <CALCETrWerhEUMw+JS4p5MVEopiMnUjbUtX58Ci7UYfYT=Y5Cvw@mail.gmail.com>
 <408ed97a-c64d-c523-c403-4e066d1f34c3@intel.com> <FB113DE3-5841-49B2-A11E-CE785EF0C763@amacapital.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 27 Jun 2018 11:19:12 -0700
X-Gmail-Original-Message-ID: <CALCETrX30hRA_8OJ4uv4GQDf_Tu+DNRhgbo5XF60kTyH9+4G=Q@mail.gmail.com>
Message-ID: <CALCETrX30hRA_8OJ4uv4GQDf_Tu+DNRhgbo5XF60kTyH9+4G=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] x86/ldt: refresh %fs and %gs in refresh_ldt_segments()
To:     "H. Peter Anvin" <h.peter.anvin@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:47 AM, Andy Lutomirski <luto@amacapital.net> wro=
te:
>
>
>
>> On Jun 22, 2018, at 11:29 AM, H. Peter Anvin <h.peter.anvin@intel.com> w=
rote:
>>
>>> On 06/22/18 07:24, Andy Lutomirski wrote:
>>>
>>> That RPL3 part is false.  The following program does:
>>>
>>> #include <stdio.h>
>>>
>>> int main()
>>> {
>>>    unsigned short sel;
>>>    asm volatile ("mov %%ss, %0" : "=3Drm" (sel));
>>>    sel &=3D ~3;
>>>    printf("Will write 0x%hx to GS\n", sel);
>>>    asm volatile ("mov %0, %%gs" :: "rm" (sel & ~3));
>>>    asm volatile ("mov %%gs, %0" : "=3Drm" (sel));
>>>    printf("GS =3D 0x%hx\n", sel);
>>>    return 0;
>>> }
>>>
>>> prints:
>>>
>>> Will write 0x28 to GS
>>> GS =3D 0x28
>>>
>>> The x86 architecture is *insane*.
>>>
>>> Other than that, this patch seems generally sensible.  But my
>>> objection that it's incorrect with FSGSBASE enabled for %fs and %gs
>>> still applies.
>>>
>>
>> Ugh, you're right... I misremembered.  The CPL simply overrides the RPL
>> rather than trapping.
>>
>> We still need to give legacy applications which have zero idea about the
>> separate bases that apply only to 64-bit mode a way to DTRT.  Requiring
>> these old crufty applications to do something new is not an option.
>
>>
>> As ugly as it is, I'm thinking the Right Thing is to simply make it a
>> part of the Linux ABI that if the FS or GS selector registers point into
>> the LDT then we will requalify them; if a 64-bit app does that then they
>> get that behavior.  This isn't something that will happen
>> asynchronously, and if a 64-bit process loads an LDT value into FS or
>> GS, they are considered to have opted in to that behavior.
>
> But the old and crusty apps don=E2=80=99t depend on requalification becau=
se we never used to do it.
>
> I=E2=80=99m not convinced we ever need to refresh the base. In fact, we c=
ould start preserving the base of LDT-referencing FS/GS across context swit=
ches even without FSGSBASE at some minor performance cost, but I don=E2=80=
=99t really see the point. I still think my proposed semantics are easy to =
implement and preserve the ABI even if they have the sad property that the =
FSGSBASE behavior and the non-FSGSBASE behavior end up different.
>

There's another reasonable solution: do exactly what your patch does,
minus the bugs.  We would need to get the RPL !=3D 3 case right (easy)
and the case where there's a non-running thread using the selector in
question.  The latter is probably best handled by adding a flag to
thread_struct that says "fsbase needs reloading from the descriptor
table" and only applies if the selector is in the LDT or TLS area.  Or
we could hijack a high bit in the selector.  Then we'd need to update
everything that uses the fields.

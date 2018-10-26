Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B3ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7467E2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="GUNZ0oRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7467E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJ0GvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:51:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47017 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJ0GvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:51:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so1168151pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a4UC4yKFcXdXacrJcB52mxNOCfLa+dsVv9PFieIFAtI=;
        b=GUNZ0oRuo+hP0p3TJrKS7sW6+O5E3Uh6RpfVHOqs8zAn/u16Z3bnKPdNwbKleoUUWX
         NgcgI8sGW+SvRkCgVJAoJH4aZKxCyi5lMk8YtCngv+pgvVy98ETiU1yLD9UitGdrjbK5
         Pww3ZH6dgMlj1NUiwMF52RcGuSkIqKz0ClN8MVmJWezt1mFrINfVE5QfMOWXjbERUicC
         7HnCIFvyqKb5iD0LhlNqHm6bXxq/gxwc1kmXEj2IdA8Gsb+5EPpIc9W0ycieCz1Ya5QM
         a0NbvUGzR8HBOVmL+xElUXJCu8FrV2uXc08OWiN0wqzmSb7Ciz2tmstboFBOfamllKH/
         K+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a4UC4yKFcXdXacrJcB52mxNOCfLa+dsVv9PFieIFAtI=;
        b=IPZ6jvgMPlIfWe+ukhEbHGpkEMs4qf4rkB34dbxe2ANZYlupAmStoGJ6fZrUridaH1
         wqIpLPal5cUyvQskGHIbw/745kZtghT09NYE5qoBG5Twsd6e40n+qgTewl2qrnBOKIpF
         RzEBVvbAK2a1OtHdz0jaeeCL1Q1QtjUWzt9+zh2Cp/cpDCbYWExdjLj8f8HIsMSPRKyC
         stldIUKsIpK+3nuL/98WxdRaEa4obOhUpQfZaEFmZThNYjkpSiBRRek7XwT6JsBotQUF
         c7h9Nougvb6xAVQfZEbzodcX4sMf3MSj7weHnY4zF+wHOOry7gV0XUG6xmdW93DVgqdT
         alNA==
X-Gm-Message-State: AGRZ1gKXVuRw9EFbMH0nmEIBCEk3Fr2Nu2yfyBNHuL0KT6GzBU1xO4Rh
        Y41IHWePHhAtpre4B1rqbTg2Qw==
X-Google-Smtp-Source: AJdET5dyIH0Xd4GhcMhcu6t3VWZebG0JorOQtL0PhRGSf+Hf7ptZksqgYar73pZWPZWoDgQUSuHKTQ==
X-Received: by 2002:a63:3287:: with SMTP id y129mr5173696pgy.337.1540591940720;
        Fri, 26 Oct 2018 15:12:20 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:2c01:d6c7:c113:66a2? ([2601:646:c200:7429:2c01:d6c7:c113:66a2])
        by smtp.gmail.com with ESMTPSA id t11-v6sm15402577pgn.38.2018.10.26.15.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 15:12:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] x86/pkeys: copy pkey state at fork()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CA+DvKQLpizz2LJppOts1fB6ujQNqj0fii8mo-UfosoYpQWRb5g@mail.gmail.com>
Date:   Fri, 26 Oct 2018 15:12:17 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>, jroedel@suse.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA6429E0-C480-47AA-AAF0-95E615D8265B@amacapital.net>
References: <20181026195146.9C7C1136@viggo.jf.intel.com> <0e5fd8bc-0b18-ea88-ed95-ec81a44d0783@intel.com> <CA+DvKQLpizz2LJppOts1fB6ujQNqj0fii8mo-UfosoYpQWRb5g@mail.gmail.com>
To:     Daniel Micay <danielmicay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 26, 2018, at 2:39 PM, Daniel Micay <danielmicay@gmail.com> wrote:
>=20
> I ended up working around this with a pthread_atfork handler disabling
> my usage of the feature in the child process for the time being. I
> don't have an easy way to detect if the bug is present within a
> library so

Can you not just make sure that the fix is backported to all relevant kernel=
s?

I suppose we could add a new flag for pkey_get() or something.

> I'm going to need a kernel version check with a table of
> kernel releases fixing the problem for each stable branch.

That won=E2=80=99t work right on district kernels. Please don=E2=80=99t go t=
here.

>=20
> It would be helpful if there was a new cpuinfo flag to check if the
> MPK state is preserved on fork in addition to the existing ospke flag.
> The problem will fade away over time but in my experience there are a
> lot of people using distributions with kernels not incorporating all
> of the stable fixes. I expect other people will run into the problem
> once hardware with MPK is more widely available and other people try
> to use it for various things like moving GC or assorted security
> features. Someone will end up running software adopting it on an older
> kernel with the problem.
>=20
> The clobbering issue I found with MAP_FIXED_NOREPLACE isn't quite
> as annoying because it was easy to make a runtime test usable in a library=

> to see if the feature works properly.

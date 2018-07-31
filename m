Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3C5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E401320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="NZr6aQPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E401320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGaRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:19:07 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:34382 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732013AbeGaRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1533051493;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=BogwT2s0os/XINJIfIGe0l1J+D1a1gT94Kvu9lh++B4=;
        b=NZr6aQPG9Oqh/hGxTbdIdeLqbPGDQn2DG2iCXGytmjGXQrGRLlWg/+w9OugVvqLE
        bpT7Az9bvJjFml3WY1GnGPvc8qr1xKhhni3heMzSqQCrGRtRCb6MwhN1UE7wl9YOsn+
        0ruAMwoKVP7LPDdQQRaLP1pQfM/wnpRN+VuP+ZTc=
Date:   Tue, 31 Jul 2018 15:38:13 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        vincenzo.frascino@arm.com, Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
In-Reply-To: <CACT4Y+Y=61VwwETQP3FwAN16ompSNJOCyDCG6Ew1Bm5f_Fe1Lw@mail.gmail.com>
Message-ID: <01000164f0fd5abc-df9ea911-9701-498c-adce-9f833e6df3ed-000000@email.amazonses.com>
References: <cover.1530018818.git.andreyknvl@google.com> <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com> <09cb5553-d84a-0e62-5174-315c14b88833@arm.com> <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
 <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com> <CACT4Y+Y=61VwwETQP3FwAN16ompSNJOCyDCG6Ew1Bm5f_Fe1Lw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.31-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Dmitry Vyukov wrote:

> > Actually you should do this for SLAB_TYPESAFE_BY_RCU slabs. Usually they are with ->ctors but there
> > are few without constructors.
> > We can't reinitialize or even retag them. The latter will definitely cause false-positive use-after-free reports.
>
> Somewhat offtopic, but I can't understand how SLAB_TYPESAFE_BY_RCU
> slabs can be useful without ctors or at least memset(0). Objects in
> such slabs need to be type-stable, but I can't understand how it's
> possible to establish type stability without a ctor... Are these bugs?
> Or I am missing something subtle? What would be a canonical usage of
> SLAB_TYPESAFE_BY_RCU slab without a ctor?

True that sounds fishy. Would someone post a list of SLAB_TYPESAFE_BY_RCU
slabs without ctors?


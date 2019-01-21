Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD2EC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0AC20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="At2DcbcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfAUS2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:28:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44236 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:28:42 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so17076667iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cjZ5Vxrrg39jcD2RwsLl+XciRWqrJDP2EHI7an4ZI08=;
        b=At2DcbcQUOgl+eCZ1BsYQ0X5ljSIRpcifYQx2jRYqh4h6fCsnn8QY/fx8b/1ywjX0e
         L/jZ5QjtAN2NH5b1Rbt4kLrHvDVUCwowX8AyO2AYDEqX250Me9p9QWcKxz9ZUZEhoNZi
         R5QGfUGEuASEP+OLz5DAjDgzIVeKhxsxviZcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cjZ5Vxrrg39jcD2RwsLl+XciRWqrJDP2EHI7an4ZI08=;
        b=qE3Hre2v11FWzgnlrgRJLumlTyuh3cVpdeIN+0gkP+s13Iag6RqJxVo0Il3MP8pqOq
         leVWuTNG24EHX0BWIbANyunMD4ozfbUuBOl3hVvRXpQvg5B0mAKJ3bps7+nVm0Tt51nx
         g6VWOBoerQLZQvwKQfqqq7OvDR7c7q4QOXvr8G/wOtz5Kt4UoetmZ37AC0GmFZJu3XhG
         5a3eB/e5uAq+jJAMZwrU7B4VPEGAJ9dLkK7n6C+FLlGpGGZK6r3KRsEmWLEhv3HkIMSP
         SFUwnoku/CobNhCTZhIdnsjA0Mt40RU+mOWa80wv8mzVIxl68gc/7iWbIXlKJYLUSjaL
         mm0Q==
X-Gm-Message-State: AJcUukeAt71l73fZltXCIT04H2m5s2XYfoOiYCfVzM0rM8l5AnTicdU8
        pTe7htLvrKU8kTxnHy7nD+vPi3NB5pbVgGd5F/QvDQ==
X-Google-Smtp-Source: ALg8bN7L/mGV1rcOL5b/ftEwv+cqJaT9ZIqxkpGx05uQu8yKMYQswwAgRvB/FZ1DUJZwoNeBmdrbxfsoZz69nvGBmr4=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr18094736iop.60.1548095321815;
 Mon, 21 Jan 2019 10:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net> <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net> <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
In-Reply-To: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 19:28:30 +0100
Message-ID: <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        David Zhou <David1.Zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 19:24, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-21 7:20 p.m., Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 19:04, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:
> >>
> >> On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
> >>> On Mon, 21 Jan 2019 at 18:55, Michel D=C3=A4nzer <michel@daenzer.net>=
 wrote:
> >>>>
> >>>> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
> >>>>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org>=
 wrote:
> >>>>>
> >>>>>> Until that happens we should just change the driver ifdefs to defa=
ult
> >>>>>> the hacks to off and only enable them on setups where we 100%
> >>>>>> positively know that they actually work.  And document that fact
> >>>>>> in big fat comments.
> >>>>>
> >>>>> Well, as I mentioned in my commit log as well, if we default to off
> >>>>> unless CONFIG_X86, we may break working setups on MIPS and Power wh=
ere
> >>>>> the device is in fact non-cache coherent, and relies on this
> >>>>> 'optimization' to get things working.
> >>>>
> >>>> FWIW, the amdgpu driver doesn't rely on non-snooped transfers for
> >>>> correct basic operation (the scenario Christian brought up is a very
> >>>> specialized use-case), so that shouldn't be an issue.
> >>>>
> >>>
> >>> The point is that this is only true for x86.
> >>>
> >>> On other architectures, the use of non-cached mappings on the CPU sid=
e
> >>> means that you /do/ rely on non-snooped transfers, since if those
> >>> transfers turn out not to snoop inadvertently, the accesses are
> >>> incoherent with the CPU's view of memory.
> >>
> >> The driver generally only uses non-cached mappings if
> >> drm_arch/device_can_wc_memory returns true.
> >>
> >
> > Indeed. And so we should take care to only return 'true' from that
> > function if it is guaranteed that non-cached CPU mappings are coherent
> > with the mappings used by the GPU, either because that is always the
> > case (like on x86), or because we know that the platform in question
> > implements NoSnoop correctly throughout the interconnect.
> >
> > What seems to be complicating matters is that in some cases, the
> > device is non-cache coherent to begin with, so regardless of whether
> > the NoSnoop attribute is used or not, those accesses will not snoop in
> > the caches and be coherent with the non-cached mappings used by the
> > CPU. So if we restrict this optimization [on non-X86] to platforms
> > that are known to implement NoSnoop correctly, we may break platforms
> > that are implicitly NoSnoop all the time.
>
> Since the driver generally doesn't rely on non-snooped accesses for
> correctness, that couldn't "break" anything that hasn't always been broke=
n.
>

Again, that is only true on x86.

On other architectures, DMA writes from the device may allocate in the
caches, and be invisible to the CPU when it uses non-cached mappings.

Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A164C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51C72152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="erzCEuAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51C72152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeHTJjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:39:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33298 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeHTJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:39:31 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so23962920oip.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7jf+0bCo2RUt9ol4S1b7IVaFt/uy69mfCor2sPKaIXM=;
        b=erzCEuAxbOUb3xd3BsI+ZfE8uIm8R0T+7ipblTKodYJfZQo/JfZE2fvMkX2L59N8a0
         YYWpkaxi+Cnyv2EAhF7iuuNtDF3STwXATNR0O/R/oreWC4O7SyNh1t5bWdE5Gm4VD3VU
         09IWwourlTGnJFe/3FwX+LZScbyh/+4X/WO+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7jf+0bCo2RUt9ol4S1b7IVaFt/uy69mfCor2sPKaIXM=;
        b=dkZyiveoDfKM3LNNbILsRFTDBymJEgCc+L6nXGGKYNnFZUAG5sapBFyei/74CWOZ+r
         i9ceYngDabhKwfPNLKPz0B9AywrmCAn/ss6ANb51URTud2O98+P9bgjNn3yC3zKG8x4b
         uibXGvlCiDXkmxgkHV3bwmJAQPabMpGwmLsmTkCvW0qXOtGJsH9ICPifLULmhfdDlaU6
         +Xs8iQ8GXZ8jCCwUsReOAypiE0EZw0F2cuVsHcPxnYMRMDv4yXtIdU/E7JR7JWrNoVf4
         w0L7rxT1sBWxbkGRhyry7G/FECLC9FI91jtIWvQgayLjUNIdm8tEbcqgdPe3rT6r3bwe
         iHUw==
X-Gm-Message-State: AOUpUlGnbyR5F+M/Y6DImJUIT7UGbY959o1/IjnF9iNXMBMNkNOL+yIT
        RqoY1jqzWiOE6g5E//bScED4D2Xw1fGTyLnEsOaMww==
X-Google-Smtp-Source: AA+uWPx2d05/2a9Di4OFhpOSko9WesKp1ZCOcEbpZI7lpm03VV3/mG511eSjrIHUCIQ47pld/Y4YD8u1JxpB1GVyfvA=
X-Received: by 2002:aca:d4d7:: with SMTP id l206-v6mr11917533oig.52.1534746310530;
 Sun, 19 Aug 2018 23:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:6a83:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 23:25:09
 -0700 (PDT)
In-Reply-To: <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-2-benh@kernel.crashing.org> <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
 <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
 <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com> <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
From:   Hari Vyas <hari.vyas@broadcom.com>
Date:   Mon, 20 Aug 2018 11:55:09 +0530
Message-ID: <CAM5rFu_dsfAiQtVnM58631tFUxYyzXrA5tgz8_v0=or3Lv8YbA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race condition"
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 7:40 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2018-08-18 at 21:24 -0500, Bjorn Helgaas wrote:
>> On Sat, Aug 18, 2018 at 01:24:51PM +1000, Benjamin Herrenschmidt wrote:
>> > On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
>> > > On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
>> > > > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
>> > >
>> > > Just to be clear, if I understand correctly, this is a pure revert of
>> > > 44bda4b7d26e and as such it reintroduces the problem solved by that
>> > > commit.
>> > >
>> > > If your solution turns out to be better, that's great, but it would be
>> > > nice to avoid the bisection hole of reintroducing the problem, then
>> > > fixing it again later.
>> >
>> > There is no way to do that other than merging the revert and the fix
>> > into one. That said, the race is sufficiently hard to hit that I
>> > wouldn't worry too much about it.
>>
>> OK, then at least mention that in the changelog.
>
> Sure will do. This is just RFC at this stage :-)
>
> As for the race with enable, what's your take on my approach ? The
> basic premise is that we need some kind of mutex to make the updates to
> enable_cnt and the actual config space changes atomic. While at it we
> can fold pci_set_master vs. is_busmaster as well as those are racy too.
>
> I chose to create a new mutex which we should be able to address other
> similar races if we find them. The other solutions that I dismissed
> were:
>
>  - Using the device_lock. A explained previously, this is tricky, I
> prefer not using this for anything other than locking against
> concurrent add/remove. The main issue is that drivers will be sometimes
> called in context where that's already held, so we can't take it inside
> pci_enable_device() and I'd rather not add new constraints such as
> "pci_enable_device() must be only called from probe() unless you also
> take the device lock". It would be tricky to audit everybody...
>
>  - Using a global mutex. We could move the bridge lock from AER to core
> code for example, and use that. But it doesn't buy us much, and
> slightly redecuces parallelism. It also makes it a little bit more
> messy to walk up the bridge chain, we'd have to do a
> pci_enable_device_unlocked or something, messy.
>
> So are you ok with the approach ? Do you prefer one of the above
> regardless ? Something else ?
>
> Cheers,
> Ben.
>
>
Some concern was raised about race situation so just to be more clear
about race condition.
Situation is described in Bug 200283 - PCI: Data corruption happening
due to a race condition.
Issue was discovered by our broadcom QA team.
Initially commit was to use one separate lock only for avoiding race
condition but after review, approach was slightly changed to move
is_added  to pci_dev private flags as it was completely
internal/private variable of pci core driver.
Powerpc legacy arch code was using is_added flag directly which looks
bit strange so  ../../ type of inclusion of pci.h was required. I know
it looks ugly but it is being used in some legacy code still.
Anyway, as stated earlier too, problem should be just solved in better way.

Regards,
hari

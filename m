Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9423CC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0309420833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODpDdDFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0309420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeIIUqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:46:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32833 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeIIUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:46:02 -0400
Received: by mail-io1-f66.google.com with SMTP id r196-v6so5082329iod.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fZKF5r8urd2yVRiHJG51pNBja/4zKr/DhfLHNDlE0Us=;
        b=ODpDdDFmvRYLDnnkS0F8MmTQ+Riq/h24Fhky2ybrKZfVFZNsV6vdLQ1B3VsRGk9c9N
         N1eR7jO2JEw0+ahKMmh4PW6/YEqLlk75vlCP1Cy1uh+Q5V8xdtkRol3z7hedybsmDSUD
         CHW3C5SK7A2Q4h1I6Zcp1XrY7j7i6n/j046S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fZKF5r8urd2yVRiHJG51pNBja/4zKr/DhfLHNDlE0Us=;
        b=XWBRS7pmCpcJwVXP8zfFNNmtpybMaTsv7QjCyCr3E+yW7i3DKqxFKIjXHXfolm3O6A
         LvFGYRxgBvJtY/G4QIj7fcILcqZ4MYO+hSWNwVcYmu4leCmqRC/g6EUJ91tkTInUmkE/
         kmgYbDendjxcClJvEI7DmtmHVlBh4YviLVgRRpAZVCGHK/x3S4dBbcdl6wk0PfCORPxP
         fJBE0Rj+rlFMICpns1M/Ahjmbu/4Ac9P4DTn3QFTNcDXt4ZMGMkWB9zbaCmlVAxS0MII
         vG9H8IGeWhIN0aWbaMfG2Md4Ws1CbRUCL6FI5tFnef4gnBMoiywZ/qdO+cBZFKkOUnJc
         xK7Q==
X-Gm-Message-State: APzg51AoJwBVQLpDaS8pbIshxCJwIP9eKUQC2dNRJziVc8GLQsMz0XMy
        zt1w5zNhn2ctw5nikJfkl8spboaGvWDbDn8btkWfOw==
X-Google-Smtp-Source: ANB0VdZyN97goDDaJS7PZB60rpV7melQW1+ASjDA929brsNBLbGsbHWT0hajClOQmib8sd2Waq5xR0AlDvXIRO3W9OU=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr14360138ioa.60.1536508556327;
 Sun, 09 Sep 2018 08:55:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 08:55:55 -0700 (PDT)
In-Reply-To: <20180909110732.GA63296@iMac.local>
References: <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com> <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
 <1f8095f1-1f0c-0791-31c4-c7b986c4ce1f@broadcom.com> <CACxGe6tbuDzEaBqOD7Z3nWMW0Nkcf22MFbD3BL+KBqnKEo2tQw@mail.gmail.com>
 <dc26dc1b-c022-341b-18ba-c009275e5ee9@broadcom.com> <20180909110732.GA63296@iMac.local>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 9 Sep 2018 17:55:55 +0200
Message-ID: <CAKv+Gu_y9fzRR8DLS2gVmcW8U4jZAnxgQUjxrOO=QS=0NPq5Zw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 September 2018 at 13:07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Sep 05, 2018 at 11:04:36AM -0700, Scott Branden wrote:
>> On 18-09-05 11:00 AM, Grant Likely wrote:
>> > On Wed, Sep 5, 2018 at 6:27 PM Scott Branden <scott.branden@broadcom.com> wrote:
>> > > On 18-09-05 02:40 AM, Ard Biesheuvel wrote:
>> > > > On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
>> > > > > Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
>> > > > > the efistub use CONFIG_OF to determine whether it supports dtb= or not?
>> > > > >
>> > > > > That way ACPI-only distros disable devicetree support entirely.
>> > > > >
>> > > > Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
>> > > OF shouldn't be automatically selected in the arm64/Kconfig.  It should
>> > > have a config parmaeter like other archs as mips and arm.  I can
>> > > submit a patch so it functions the same way as other archs so it
>> > > is not always selected.  It will be good to add a USE_OF config
>> > > options like the other archs (or simply remove the select from the
>> > > Kconfig and choose OF directly in the defconfig. This will have
>> > > the added benefit of doing away with OF support when its not
>> > > needed on an ARM64 platform.  ACPI is already not automatically
>> > > selected for all ARM64 platforms, nor should devicetree.
>> > We don't do that on Arm because a devicetree is always required at
>> > boot time. Even on ACPI systems a tiny DTB is used containing just a
>> > /chosen node for passing the kernel command line and the initrd
>> > location.
>>
>> Seems bizarre DTB is not needed for x86 to boot from UEFI with ACPI
>> support?  I'll look into it further at some point in order to remove such
>> anomaly.  There should be no need for such devicetree reliance.
>
> I'd say don't waste time on this, the patch would not get merged ;). As
> Grant said, we use a tiny dtb to pass the command line, initrd to the
> kernel. You'd have to invent an alternative (setup_header, ATAGs) and I
> really don't see the point of increased complexity just because of some
> philosophical arguments against OF.
>

Not just that: we also need of_match_table support for ACPI's PRP0001
device (which is a horrible hack in itself, but currently supported in
Linux/arm64 *and* Linux/x86 nonetheless)

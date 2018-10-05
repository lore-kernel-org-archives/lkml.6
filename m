Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A9F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iYl9ls4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A9F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJEXfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:35:02 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44221 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEXfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:35:02 -0400
Received: by mail-yb1-f193.google.com with SMTP id x5-v6so5655742ybl.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4vcOWcGFWjgwlB0xk/o4LvAQ9uGCBIWBW8bUlhArKxU=;
        b=iYl9ls4DIMiAVy/svw/tu2nJffUBabsYRHkJjIKrCmMrnkikCXUQ6h7qei1J04PiMm
         OIDae3hqgGHc824Fhj41m83Qg58istTGaywFs254LeSNbMmatmF4uYFTzCXBGgQuaPem
         jh4hDDV64YjLpVcPdy+/j8DAzS5xJmlJ1Rj9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4vcOWcGFWjgwlB0xk/o4LvAQ9uGCBIWBW8bUlhArKxU=;
        b=gYToK/HmUeVI+zHlJ5MpkqBw7Wjah4xBxAK8NaBed8THj7idhViFi8YNKz9BQiSF08
         KKY1UhfNvbTjhbvrKIcN9V7PojiGTM3DZKGAcD+r3Ru7PNPJzZ3yw+Vw3Z8rOLH0N5PZ
         v0Jt0x3Y37Jt5ac3ivivFRMGM4RnnzbEhDi4Kzi0m/w6glLogoOIL9YxpvsmoZn/NGt+
         F2VNIZmeTPJckHJN9Bwi3C8pkjEAUibJbghhG1ZesNVsxIT+guIBj5wetIh+4hRArSLF
         6GOYcB+jZdDqDnM9/Azoiije+pILAyTbYPQ0iGehJw5O4NldRanPBORBNmZu73IUNtrH
         Iccg==
X-Gm-Message-State: ABuFfoguSuhGQq1js9hLbH+Xg7pBJQv9ELZkC/zcffVcIyliixbCCbAK
        /2LAdvvumGLhGFhJraxLSbpsi8tpnLo=
X-Google-Smtp-Source: ACcGV614IodYu16A13RUhku7QOoYQZFw7EbhHJsgAnb4gwhxewzyYi7vD2zZKZNNscX9IaS1X5NuCA==
X-Received: by 2002:a25:a4a6:: with SMTP id g35-v6mr6824777ybi.56.1538757332914;
        Fri, 05 Oct 2018 09:35:32 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id u22-v6sm8855244ywu.49.2018.10.05.09.35.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:35:30 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id y14-v6so5480657ywa.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 09:35:29 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr6744281ywg.353.1538757329237;
 Fri, 05 Oct 2018 09:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 09:35:27 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810051449110.2590@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <alpine.LRH.2.21.1810050338470.14095@namei.org> <CAGXu5j+3HqqBa_ogQqGJYubeZr9uCrbKzEoKO3Or=71e4c_=Gw@mail.gmail.com>
 <alpine.LRH.2.21.1810051449110.2590@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 5 Oct 2018 09:35:27 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKrOWnrmEfpzH3ay2uQBsP1nmpgceWLsGRsEzZ0n4dLvw@mail.gmail.com>
Message-ID: <CAGXu5jKrOWnrmEfpzH3ay2uQBsP1nmpgceWLsGRsEzZ0n4dLvw@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:58 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 4 Oct 2018, Kees Cook wrote:
>
>> On Thu, Oct 4, 2018 at 10:49 AM, James Morris <jmorris@namei.org> wrote:
>> > On Wed, 3 Oct 2018, Kees Cook wrote:
>> >> Then someone boots the system with:
>> >>
>> >> selinux=1 security=selinux
>> >>
>> >> In what order does selinux get initialized relative to yama?
>> >> (apparmor, flagged as a "legacy major", would have been disabled by
>> >> the "security=" not matching it.)
>> >
>> > It doesn't, it needs to be specified in one place.
>> >
>> > Distros will need to update boot parameter handling for this kernel
>> > onwards.  Otherwise, we will need to carry this confusing mess forward
>> > forever.
>>
>> Are you saying that you want to overrule Paul and Stephen about
>> keeping "selinux=1 secuiryt=selinux" working?
>
> Not overrule, but convince.
>
> At least, deprecate selinux=1 and security=X, but not extend it any
> further.

Okay, this is the expectation from me as well. I think my series makes
it work as-is with the new stuff just fine.

>> > In my most recent suggestion, there is no '!' disablement, just
>> > enablement.  If an LSM is not listed in CONFIG_LSM="", it's not enabled.
>>
>> And a user would need to specify ALL lsms on the "lsm=" line?
>>
>
> Yes, the ones they want enabled.
>
>> What do you think of my latest proposal? It could happily work all
>> three ways: old boot params and security= work ("selinux=1
>> security=selinux" keeps working), individual LSM enable/disable works
>> ("lsm=+loadpin"), and full LSM ordering works
>> ("lsm=each,lsm,in,order,here"):
>>
>> https://lore.kernel.org/lkml/CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com/
>>
>
> I think having something like +yama will still lead to confusion.
> Explicitly stating each enabled LSM in order is totally unambiguous.
>
> If people are moving away from the distro defaults, and there is no
> high-level interface to manage this, it seems to me there's a deeper
> issue with the distro.

Okay. I will adjust the series and send a v5.

-Kees

-- 
Kees Cook
Pixel Security

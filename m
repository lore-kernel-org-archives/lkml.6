Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D02C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5A621473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nwzhh2Yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5A621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJDBKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:10:18 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40174 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDBKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:10:18 -0400
Received: by mail-yb1-f195.google.com with SMTP id w7-v6so2783220ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uZQOA0DuRSvaNKbfmyV5gC0MDYC2apwZOxhNpWzX+8A=;
        b=nwzhh2Yor1IalU+mxBYgqdzrAgrLteqh1e9tMXXGytcLhEeSxnrw+4/1VZm3GFBHWE
         NsgvLIG8ZY22exf4k5UahRIc1RoV6KgA4A9GPFAqEFm3EBy/mjLwltlC+/HLEnDPDg/c
         EP5IDRaZ2CYr0emGOSnPmzszzpVpTTzHaR3HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uZQOA0DuRSvaNKbfmyV5gC0MDYC2apwZOxhNpWzX+8A=;
        b=EbEXfPa/oPvciAHa1YLDRmGjSCBdasBRST0dK6lBi39k+oMA2UiuHRioUZOvApb7+U
         HlrkPFSniSmyTxSp29V1Yj0gF9AbxxnT0DUHS4nx8cWI5whf1urKK2t62vUgSoq8VqLx
         XihzxDjQu8SuDeFrOlSbXze52l1LR6Ok+Xa6s1FgMeJq8LIu5ESfrXwetgE6QL/CcyPe
         vwpGVQ7+XsdRaoUK9fKqO4LL2p0kOdbs+/oMSs+5Np84ccU+/sFSJk0We5+rCZ8bLPcm
         3Ri2U/XfwTVwX7OIofmo0cSF2Dy4yScMMTdw1zMScc7F85feV7jMVHu0CzXvV6OebFl7
         2ICQ==
X-Gm-Message-State: ABuFfojIbzHYsKS7Ghg7Ljf5TIhCWRgR6Vb7k79HOSo8s1RuvSdlqwXR
        3E8mT33uNcKFiEVxNeGoMXxK0j/Yd/w=
X-Google-Smtp-Source: ACcGV61z3e1p4jXyBvXwC154oTp6ye9mOj0WbxWaaHkd67KNekwOXtdvPwyUgDnAOeNjA5ye7JcCjw==
X-Received: by 2002:a5b:c4b:: with SMTP id d11-v6mr1710541ybr.381.1538590847408;
        Wed, 03 Oct 2018 11:20:47 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id x64-v6sm1618090ywx.103.2018.10.03.11.20.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:20:46 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id a197-v6so2681033ywh.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:20:45 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr1714563ywd.288.1538590845603;
 Wed, 03 Oct 2018 11:20:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 11:20:44 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810040416500.13517@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 3 Oct 2018 11:20:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
Message-ID: <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
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

On Wed, Oct 3, 2018 at 11:17 AM, James Morris <jmorris@namei.org> wrote:
> On Tue, 2 Oct 2018, John Johansen wrote:
>> To me a list like
>>   lsm.enable=X,Y,Z
>
> What about even simpler:
>
> lsm=selinux,!apparmor,yama

We're going to have lsm.order=, so I'd like to keep it with a dot
separator (this makes it more like module parameters, too). You want
to mix enable/disable in the same string? That implies you'd want
implicit enabling (i.e. it complements the builtin enabling), which is
opposite from what John wanted.

-Kees

-- 
Kees Cook
Pixel Security

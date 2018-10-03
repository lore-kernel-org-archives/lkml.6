Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20AAC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B957E21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XPda/oH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B957E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJDDAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:00:51 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40803 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJDDAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:00:51 -0400
Received: by mail-yw1-f67.google.com with SMTP id l79-v6so2829860ywc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ltOwQ63QbGaIFq6R/SviRcoBgF6s6Isx0gKdU2+eh4=;
        b=XPda/oH/q9itpDkmQRKeH9ujvUdiUnzH6UMG3fUN1ETKnM2I5z5t2kM6l4KmpYER+g
         KpYQxsFTsVEdMQLDSVbBHLTY2cY5felkFLqd+8ZHGAfWyS/MU2mJgi1/Q/I88AtSLEmj
         uZlwpyrbwRnSCwR9ft+EWCry46D1M2+Z14BUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ltOwQ63QbGaIFq6R/SviRcoBgF6s6Isx0gKdU2+eh4=;
        b=GuRkcBRXoCz00tIgKvJqMbb1qfPrmrZbDcCgUsbgd5+t1rjBIAFJTUW37FaDj5XiKq
         kumPBOjIcRh+pzboH7JQ2aqBMwa12Cr44LNatxAquTd16vIFi4rRrrdTXbq6L1m9PGW9
         e17aZdaoRKfw/Yr+8RmreyrBPTznSKJ/DLZVUlLEBhBf3laxg7kshNVo0VH5IXG0W/0O
         qf8shZ/7+dpGafSBaBQUBno+TDiroCBt8AoLZpEJ/X3Ku/p7yMuxyee20vaebcIrJmlK
         0NCPbxY0rH6axBg28HTiAY8Vo05Yt2kaxTA4xnfoN6yvAnyRHDYC0Tx4yaoQYgi632Zg
         2sDw==
X-Gm-Message-State: ABuFfohcw3I8MXcf5VJMRYbdwaIMYW1KUvdQRiqcKrOnfUIgtYOW4qh7
        Vg+j/c31lf/YKaqXvCSUv/X5PSK2Juk=
X-Google-Smtp-Source: ACcGV62NHCgvIXD0Y4bva3y/smU99h19G/T4MOQfZ2+Zyb63WubfmxedUd1pGeDrb2KRWn32irlamg==
X-Received: by 2002:a81:6d85:: with SMTP id i127-v6mr1846543ywc.322.1538597457664;
        Wed, 03 Oct 2018 13:10:57 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id r5-v6sm2225422ywr.80.2018.10.03.13.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 13:10:54 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id c4-v6so2940068ybl.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 13:10:53 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr1888958ybk.209.1538597452740;
 Wed, 03 Oct 2018 13:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 13:10:51 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810040427550.13517@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com> <alpine.LRH.2.21.1810040427550.13517@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 3 Oct 2018 13:10:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
Message-ID: <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
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

On Wed, Oct 3, 2018 at 11:28 AM, James Morris <jmorris@namei.org> wrote:
> On Wed, 3 Oct 2018, Kees Cook wrote:
>
>> On Wed, Oct 3, 2018 at 11:17 AM, James Morris <jmorris@namei.org> wrote:
>> > On Tue, 2 Oct 2018, John Johansen wrote:
>> >> To me a list like
>> >>   lsm.enable=X,Y,Z
>> >
>> > What about even simpler:
>> >
>> > lsm=selinux,!apparmor,yama
>>
>> We're going to have lsm.order=, so I'd like to keep it with a dot
>> separator (this makes it more like module parameters, too). You want
>> to mix enable/disable in the same string? That implies you'd want
>> implicit enabling (i.e. it complements the builtin enabling), which is
>> opposite from what John wanted.
>>
>
> Why can't this be the order as well?

That was covered extensively in the earlier threads. It boils down to
making sure we do not create a pattern of leaving LSMs disabled by
default when they are added to the kernel. The v1 series used
security= like this:

+       security=       [SECURITY] An ordered comma-separated list of
+                       security modules to attempt to enable at boot. If
+                       this boot parameter is not specified, only the
+                       security modules asking for initialization will be
+                       enabled (see CONFIG_DEFAULT_SECURITY). Duplicate
+                       or invalid security modules will be ignored. The
+                       capability module is always loaded first, without
+                       regard to this parameter.

This meant booting "security=apparmor" would disable all the other
LSMs, which wasn't friendly at all. So "security=" was left alone (to
leave it to only select the "major" LSM: all major LSMs not matching
"security=" would be disabled). So I proposed "lsm.order=" to specify
the order things were going to be initialized in, but to avoid kernels
booting with newly added LSMs forced-off due to not being listed in
"lsm.order=", it had to have implicit fall-back for unlisted LSMs.
(i.e. anything missing from lsm.order would then follow their order in
CONFIG_LSM_ORDER, and anything missing there would fall back to
link-time ordering.) However, then the objection was raised that this
didn't provide a way to explicitly disable an LSM. So I proposed
lsm.enable/disable, and John argued for CONFIG_LSM_ENABLE over
CONFIG_LSM_DISABLE.

-Kees

-- 
Kees Cook
Pixel Security

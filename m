Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45667C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1F920666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iND8GjVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1F920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJCGk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:40:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34198 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeJCGk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:40:29 -0400
Received: by mail-yb1-f194.google.com with SMTP id 184-v6so1621991ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=myLBZqcYlMnhLpy5A45FsjW/5Vk4tQR3DKJeP2Ytazg=;
        b=iND8GjVxJSaRwJPJub3okGE9GMOlOJDHIE5jQlBxb9z0/mqLvFOfwzKAdx3kkSKjWm
         +W9s6PBHi8PFuFYi46vWKwR9DGxNk0owYGEaB/Wu/zk+CBIHh/LjHuuQlfrqyw/y2QIT
         4firk4oYw5/9V3RhMJvssisn6RHoHC5eJq0Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=myLBZqcYlMnhLpy5A45FsjW/5Vk4tQR3DKJeP2Ytazg=;
        b=LjeqzD1ipMeDpLQiICbJpZ5TnuXn8YHtNLy9LkhnF04kKdaWZNME+Qh4ElRiULYPYd
         x0LJQEfULtVZlgnV83P9VAE+TFMffiy/vd1jZAfgagx3IsgKaeSTTT1/J4oAdlfIhHni
         A+EBV4Td1g/B2nEm+SWmD2GCexDAzxfL91pIfrbv5xDeMT05HOmtqMb3zB60n//GLgLu
         u+2DDmkzouutad8ooaK0YjPnRWfeqzA/l1cUKgjKFKRjDWfEKPr3Fl2gk+vTETck2C+p
         ycOsgdgTQNT8tySvlKLqWDf05wxU9Q6GWgvAa73wNMYHNPLW/AGJUV/jpZY3h6hedlA4
         l52g==
X-Gm-Message-State: ABuFfoiFAK7wp8Xz+0NYNFsZspuwvujgnH3RQrfxukrtgRotK3zj7Uvi
        9NFo4z85SlfshDA1b0A8K0S3xD99wYw=
X-Google-Smtp-Source: ACcGV630LNrsVFAKjcMnTp1EvdXOL1GI39BAybvLKJQyJkKS9rI39MFSPa3zLmbBtbCvZjLICf98vg==
X-Received: by 2002:a25:c905:: with SMTP id z5-v6mr9908569ybf.265.1538524475628;
        Tue, 02 Oct 2018 16:54:35 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id w207-v6sm3296274yww.95.2018.10.02.16.54.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:54:34 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id m129-v6so1566729ywc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:54:33 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr1813541yws.168.1538524473138;
 Tue, 02 Oct 2018 16:54:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 16:54:32 -0700 (PDT)
In-Reply-To: <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 16:54:32 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
Message-ID: <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
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

On Tue, Oct 2, 2018 at 4:46 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/02/2018 04:06 PM, Kees Cook wrote:
>> I think the current proposal (in the other thread) is likely the
>> sanest approach:
>>
>> - Drop CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
>> - Drop CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE
>> - All enabled LSMs are listed at build-time in CONFIG_LSM_ENABLE
>
> Hrrmmm isn't this a Kconfig selectable list, with each built-in LSM
> available to be enabled by default at boot.

That's not how I have it currently. It's a comma-separated a string,
including the reserved name "all". The default would just be
"CONFIG_LSM_ENABLE=all". Casey and I wanted this to have a way to
capture new LSMs by default at build-time.

>> - Boot time enabling for selinux= and apparmor= remain
>> - lsm.enable= is explicit: overrides above and omissions are disabled
> wfm

Okay, this is closer to v3 than v4. Paul or Stephen, how do you feel
about losing the SELinux bootparam CONFIG? (i.e. CONFIG_LSM_ENABLE
would be replacing its functionality.)

-Kees

-- 
Kees Cook
Pixel Security

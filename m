Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07947C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C178E2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4CQvmW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C178E2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeJCG66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:58:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33409 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeJCG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:58:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id m127-v6so1586464ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X5BnuAGhgfj4DUNsWuwoN0sZkV1YAJwtcmx3txcghz0=;
        b=D4CQvmW2TA1WvT7TeKvuETP4MpHuHFm4D7Fj859S51UPV57DvMYXoVD+/kPXRx9ZTS
         Wk++7esffUgh551V568wm99Of6FhfuGptyi6suZbHU2VacHbQfrPw/9lZOwIQo8uRqvX
         Nl7r5ZNpcOGQHiX0hN55oKhsDd4e0hLtJLIAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X5BnuAGhgfj4DUNsWuwoN0sZkV1YAJwtcmx3txcghz0=;
        b=QvsUL8kVvI/2REa4sCPHkWyG95PePIR+R5XwJxXTlXqE77rqvECo+nFdyHcqqRmDHw
         Jp7glHsxSQX4TA4fffW1KIIhqGa0gmB/HwbBTOwWJq7/6Fp1gcox9XLliIwtxSKW2ksl
         sRzIMhwTU2/6aYEdezSuUZbbqvehYeJtORGBeu0Dyv2Ep4GxFEIf/nKB2z2NI1PKp1R7
         ivavR6AGiYoFsYS4iLuodQKElMqXpt3B2yUrmUwZxd6BbhEoVg9hC941s73czIkQ9cBF
         BDaJ2arFuVTZpgr4jmSD6QETFQxphQ0HrygdgG3wX2t7gU/FBQzJ74asLLLs2Ew6qcNW
         hl6w==
X-Gm-Message-State: ABuFfogzhj5UYp8+Vm3/hJhm+Buvwf21Rx6jSX8cNBJRhLS6uKIBLNEl
        lsG8hnP4i18x6wHeMj46QQaAcEsvClE=
X-Google-Smtp-Source: ACcGV61wN8Uej/mabcjEqWmzzsHX9SfC8luAEWGznn+WZYs0gxKOv1FsM0mkIVr/PTnN/dVggaE7ng==
X-Received: by 2002:a81:1b58:: with SMTP id b85-v6mr9728803ywb.63.1538525581226;
        Tue, 02 Oct 2018 17:13:01 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id f194-v6sm9361459ywb.53.2018.10.02.17.12.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id m127-v6so1586398ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr10168177ywd.124.1538525579097;
 Tue, 02 Oct 2018 17:12:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 17:12:58 -0700 (PDT)
In-Reply-To: <3b539d37-136f-b868-3155-f2982eb63890@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <3b539d37-136f-b868-3155-f2982eb63890@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 17:12:58 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ-2V5ch-Qer_O0mg1J5-9SUmyJXsGYicZEMyg5KkqHaw@mail.gmail.com>
Message-ID: <CAGXu5jJ-2V5ch-Qer_O0mg1J5-9SUmyJXsGYicZEMyg5KkqHaw@mail.gmail.com>
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

On Tue, Oct 2, 2018 at 5:05 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/02/2018 04:54 PM, Kees Cook wrote:
>> That's not how I have it currently. It's a comma-separated a string,
>> including the reserved name "all". The default would just be
>> "CONFIG_LSM_ENABLE=all". Casey and I wanted this to have a way to
>> capture new LSMs by default at build-time.
>>
>
> I understand where you are coming from, but speaking with my distro
> hat on, that is not going to work. As a distro Ubuntu very much wants
> to be able to offer all the LSMs built in to the kernel so the user
> can select them. But very much wants to be able to specify a default
> supported subset that is enabled at boot.
>
> I expect RH and Suse will feel similarily. Speaking for Ubuntu if this
> isn't available as part of lsm stacking it will get distro patched in.

Right. Ubuntu would do something like:

CONFIG_LSM_ENABLE=yama,apparmor,integrity

And that's why I wanted non-explicit lsm.enable, so that an end user
could just do:

lsm.enable=loadpin

to add loadpin.

Perhaps we could have both? "lsm.enable=+loadpin" (add loadpin to
build default list) vs "lsm.enable=loadpin" (override build default
list with ONLY loadpin).

-Kees

-- 
Kees Cook
Pixel Security

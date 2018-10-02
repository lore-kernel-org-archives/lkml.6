Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1311C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748A720684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuvQvUvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748A720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJCDO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:14:57 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45156 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeJCDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:14:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id v198-v6so1333005ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xkubUhT1JOPull8ZaAjzdOGaMvUij5ox3WB5+0xqLEA=;
        b=DuvQvUvI5S8aEP6og3V8j46ebUtz0fJWKZDL7BT4TNmgm/AVHlr5FVYb2qB5miIdvE
         /bAJYook+SkPE22nykwlxmiMkU2AVvSvZpbXI0Ut/4OVFPptQEic4cgUEaH5r4YrpYUn
         uwKUii56yLjPjMGIXPlQ1+n2Hy62JPF6l5D8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xkubUhT1JOPull8ZaAjzdOGaMvUij5ox3WB5+0xqLEA=;
        b=l95S/mEOMxm0nt2auro1fJNPoAcOqb4BEct0yiEXBJRqe+Gtws+eLTIfLnLFRK3oDf
         hMnjLk+XSBE3fpUw3P/mhwn6bXoz6z7zQfx4VmcgUvsc1ZOZDIjHvmoEiwv3NtMD+SBb
         42h9rBvPC2Uis/GteigmZeq3xDNq+5mvbk+zXluSNKOtuk/8qEK1JipBdlDrhBIjKxnB
         u3Vs0hmFcbbVxyQWFnAOrDzGFsWFPZvevRw5hKDfU0AbwihSKV/CHv2m2AGzY91xulWu
         jIPjNwNHMbv2hkHyIcvqB1CkInaMT6NOch7/XDlTE3WnWj9kbgB2wW8iySLz2bVrk1P9
         LdnQ==
X-Gm-Message-State: ABuFfohqx/CpzOuTZ2c9BdrT0+bhrdK7Qr/Qd5p+O5fiyzfLnXmeUm9A
        qRVx75Ie+mr/yk2C7P4cVQDl7IvHwfg=
X-Google-Smtp-Source: ACcGV63aKf07a3P8gEHrEQnJhVvhyw3Oq/KIa0Xpcs6jlb9QOzu0KVNFpYQ9Lv1cwCVRcUqgmVEj2Q==
X-Received: by 2002:a81:b2c9:: with SMTP id q192-v6mr9465398ywh.223.1538512186357;
        Tue, 02 Oct 2018 13:29:46 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id q1-v6sm2200292ywa.92.2018.10.02.13.29.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 13:29:44 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id e201-v6so1351596ywa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 13:29:44 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr2117852ywd.288.1538512183688;
 Tue, 02 Oct 2018 13:29:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 13:29:42 -0700 (PDT)
In-Reply-To: <125243f2-8532-c0c0-0b0e-d28b3ecb910e@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <125243f2-8532-c0c0-0b0e-d28b3ecb910e@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 13:29:42 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLcK6k+Ox5Q1ZN_4wF9WeR6KchX9LJzbSbfdrcDpZftLg@mail.gmail.com>
Message-ID: <CAGXu5jLcK6k+Ox5Q1ZN_4wF9WeR6KchX9LJzbSbfdrcDpZftLg@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     John Johansen <john.johansen@canonical.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
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

On Tue, Oct 2, 2018 at 12:47 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 10/02/2018 12:17 PM, Kees Cook wrote:
>> I could define CONFIG_LSM_ENABLE as being "additive" to
>> SECURITY_APPARMOR_BOOTPARAM_VALUE and
>> SECURITY_SELINUX_BOOTPARAM_VALUE?
>
> Oh sure lets deal with my complaint about too many ways to configure
> this beast by adding yet another config option :P

This is what v3 already does: SEC...BOOTPARAM_VALUE trumps ...LSM_ENABLE.

> seriously though, please no. That just adds another layer of confusion
> even if it is only being foisted on the distro/builder

You've already sent a patch removing
SECURITY_APPARMOR_BOOTPARAM_VALUE. If SELinux is fine to do that too,
then I think we'll be sorted out. I'll just need to make "lsm.enable="
be an explicit list. (Do you have a problem with "lsm.disable=..." ?)

-Kees

-- 
Kees Cook
Pixel Security

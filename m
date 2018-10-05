Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58774C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D8320854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GbYgaM6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D8320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeJEHBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:01:12 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38700 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeJEHBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:01:12 -0400
Received: by mail-yb1-f196.google.com with SMTP id e190-v6so4717622ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YiS6kj9F/mIyeBOtensRm7BthCtrk4+9vKJ/9TOUD60=;
        b=GbYgaM6tlQBZk15VYd/sqf+K2Qj/m520UDDBw1ouQtrHOvIXvKKAZAqtK6gGMKRyjy
         8ACXz5k6EtIgHbz8htcPdTl5zC03k4zH+fkxIITYLkEIxJHRSVHoKKaEr1QiNpXU3fLQ
         NVAgoTILmiueYDi7gnJwmTENx/oErMyyo12AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YiS6kj9F/mIyeBOtensRm7BthCtrk4+9vKJ/9TOUD60=;
        b=tyjRZqinf+v77fblwtVFsuZlZ9nijbUrHPA2Ki22KbzEPzcl3QskWABxGRXhxiq2zP
         BqlN7ZN7d64AUtjI8AD4sr9N5rfb9XZi4pTboMxkt0Z96Ty5Vcg1EeI3+5sCvS67SB0o
         SQK2WcoyJEhYokbgskTuJmpLJlwQiW+NcXxmmLjG95kbissj4yQtB4KHL0/Esyndw31A
         SE7BOFvOI3EC++lSvaePYAaRotvYKS4/kdHQZjbq7xqtiYlH3G7x6UmrAC6fjV614VEu
         XqrZx0h9EIV3ZBkQJhgBAk5HG5L2Q7F6lKMmkvaGv/MDDtRsj7nmXKTvlWFuAW6GcRIV
         UZjw==
X-Gm-Message-State: ABuFfoijtitCbMWxL/HWTjVkYtAnMBKkjl6RHpUw2fHDZ18iq3oBxpcJ
        cj1TlcicMFQjSL97PQZ+NSrHh6vPimc=
X-Google-Smtp-Source: ACcGV61I2G7UbX0ZGaAoaeJC2S3SS5bzjg0kM6FhVmMXxb2hdoUEFCpRMOnRW0iRoIg5YSfPLo9/1g==
X-Received: by 2002:a25:d305:: with SMTP id e5-v6mr5224663ybf.514.1538697914049;
        Thu, 04 Oct 2018 17:05:14 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id h10-v6sm2280736ywa.35.2018.10.04.17.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 17:05:12 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id y14-v6so4553793ywa.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 17:05:11 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr4982145ywg.353.1538697911394;
 Thu, 04 Oct 2018 17:05:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 17:05:09 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810050338470.14095@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <alpine.LRH.2.21.1810050338470.14095@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 4 Oct 2018 17:05:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+3HqqBa_ogQqGJYubeZr9uCrbKzEoKO3Or=71e4c_=Gw@mail.gmail.com>
Message-ID: <CAGXu5j+3HqqBa_ogQqGJYubeZr9uCrbKzEoKO3Or=71e4c_=Gw@mail.gmail.com>
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

On Thu, Oct 4, 2018 at 10:49 AM, James Morris <jmorris@namei.org> wrote:
> On Wed, 3 Oct 2018, Kees Cook wrote:
>> Then someone boots the system with:
>>
>> selinux=1 security=selinux
>>
>> In what order does selinux get initialized relative to yama?
>> (apparmor, flagged as a "legacy major", would have been disabled by
>> the "security=" not matching it.)
>
> It doesn't, it needs to be specified in one place.
>
> Distros will need to update boot parameter handling for this kernel
> onwards.  Otherwise, we will need to carry this confusing mess forward
> forever.

Are you saying that you want to overrule Paul and Stephen about
keeping "selinux=1 secuiryt=selinux" working?

>> CONFIG_LSM="yama,apparmor,!selinux"
>>
>> to mean "put selinux here in the order, but don't enable it". Then the
>> problem becomes what happens to an LSM that has been built in but not
>> listed in CONFIG_LSM?
>
> In my most recent suggestion, there is no '!' disablement, just
> enablement.  If an LSM is not listed in CONFIG_LSM="", it's not enabled.

And a user would need to specify ALL lsms on the "lsm=" line?

What do you think of my latest proposal? It could happily work all
three ways: old boot params and security= work ("selinux=1
security=selinux" keeps working), individual LSM enable/disable works
("lsm=+loadpin"), and full LSM ordering works
("lsm=each,lsm,in,order,here"):

https://lore.kernel.org/lkml/CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com/

-Kees

-- 
Kees Cook
Pixel Security

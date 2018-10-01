Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19350C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C834C2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DL62DlLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C834C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJBEgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:36:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41589 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:36:41 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so6176956ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qEzzBMCxb12vY/FYUOpb/kfbgPGZDUraFm4sj/mqu0U=;
        b=DL62DlLdJoL5VRrkxAthiGviLnWqwFc2ajZmhsS/NFYfSO2p493+64GvzGdH6przN0
         Nh3+vd3a61tlfRYRwbUamxXzFR3XdtWpT7N7WR+wHCigGrh7KSxC3LWdGNBkGJb5/pzF
         p7Lc2X4KfEfBu2uaXhFx2+bwui7VK0URrTXGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qEzzBMCxb12vY/FYUOpb/kfbgPGZDUraFm4sj/mqu0U=;
        b=hIRYHt1QqhhaTYHTi5M1oejVqBY1W0gSHKRsOLBRXgjGwD/z62bslJ0hELBqJ+FS5l
         5Wt134r3X6rh6RfGK96purTWhDk4T2Me96zZhnClNklWVIimYsBWBTi2REzT05Z6L5o9
         cjmtRh9/fx4CxPUttyb0HiyPrDZxWWh69qy+nNkbN0wJr+/KbeL4rHYEwusmU/nSis39
         NHKmhSTQMwNx/7WvvYqMmkuR/jy6o73rUzF17dXFwzMSnLiz0SHtiRFoduaimR0jb0DQ
         FNEm+wxugv8TNnFddqqn8PWdSoTginvaH4HqAolcalA6qR4KfD/sczinq5C+D6VBoUmD
         YwlA==
X-Gm-Message-State: ABuFfojyikkLLkvvG+2ecKVhzzvf+I7hXBdD0lcI9iPL/xLskkIHX2CD
        taJrxuw8lnGaVy8fbUWMg3jOkuT4Fck=
X-Google-Smtp-Source: ACcGV60HDU/VMsZ+oXG1E6JEI/Z6Mw0Fc4NiUcm4SzkgHg2hZuQRFyjWMx16bU5rJmjArV4NNTz3Yg==
X-Received: by 2002:a81:c405:: with SMTP id j5-v6mr6935331ywi.475.1538431006311;
        Mon, 01 Oct 2018 14:56:46 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id b71-v6sm20910535ywa.48.2018.10.01.14.56.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:56:44 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id j75-v6so1248785ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:56:44 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr7188157ywi.288.1538431004028;
 Mon, 01 Oct 2018 14:56:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 14:56:43 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810020747380.20364@namei.org>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-15-keescook@chromium.org>
 <alpine.LRH.2.21.1810020747380.20364@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 14:56:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJKvb=3vu3_b-NNdr_=KwvgO9qa96Qo5qzSZuiy2=+Oig@mail.gmail.com>
Message-ID: <CAGXu5jJKvb=3vu3_b-NNdr_=KwvgO9qa96Qo5qzSZuiy2=+Oig@mail.gmail.com>
Subject: Re: [PATCH security-next v3 14/29] LSM: Plumb visibility into
 optional "enabled" state
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 2:47 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 24 Sep 2018, Kees Cook wrote:
>
>> In preparation for lifting the "is this LSM enabled?" logic out of the
>> individual LSMs, pass in any special enabled state tracking (as needed
>> for SELinux, AppArmor, and LoadPin). This should be an "int" to include
>> handling any future cases where "enabled" is exposed via sysctl which
>> has no "bool" type.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/linux/lsm_hooks.h | 1 +
>>  security/apparmor/lsm.c   | 5 +++--
>>  security/selinux/hooks.c  | 1 +
>>  3 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 5056f7374b3d..2a41e8e6f6e5 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>>  struct lsm_info {
>>       const char *name;       /* Populated automatically. */
>>       unsigned long flags;    /* Optional: flags describing LSM */
>> +     int *enabled;           /* Optional: NULL means enabled. */
>
> This seems potentially confusing.
>
> Perhaps initialize 'enabled' to a default int pointer, like:
>
>         static int lsm_default_enabled = 1;
>
> Then,
>
>         DEFINE_LSM(foobar)
>         flags = LSM_FLAG_LEGACY_MAJOR,
>         .enabled = &lsm_default_enabled,
>         .init = foobar_init,
>         END_LSM;

The reason I didn't do this is because there are only two LSMs that
expose this "enabled" variable, so I didn't like making the other LSMs
have to declare this. Internally, though, this is exactly what the
infrastructure does: if it finds a NULL, it aims it at
&lsm_default_enabled (in a later patch).

However, it seems more discussion is needed on the "enable" bit of
this, so I'll reply to John in a moment...

-Kees

-- 
Kees Cook
Pixel Security

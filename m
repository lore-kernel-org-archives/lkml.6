Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2812CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4D320883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQyfy/sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4D320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeIQVwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:52:17 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:43042 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbeIQVwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:52:16 -0400
Received: by mail-yb1-f175.google.com with SMTP id k5-v6so7976826ybo.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X1Qhbf3ixWDfceIRFDwkJWVGU22q1ZyaZYOCXPlkx50=;
        b=jQyfy/shm9rDsvgph9ixJMOPwpcyrrMudvP5f2FuKSUqZQeYR3E8jtU8+t8kYBOPOT
         7MfyvkAD9D3BTtifC02vEAzH+4Blikx1kF/XXyocozIDXxIej9vmSRtyuxudm+t18dh2
         7oxPCxgtKMNG0F0p5ELIB7fVGaSwcM372WmMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X1Qhbf3ixWDfceIRFDwkJWVGU22q1ZyaZYOCXPlkx50=;
        b=rJxvZa95sqdB92DolmRbhJ6pTJjaOoNMD5jUvQvhrxWBFKjy1gExxymoahlQOLAJhV
         zm4XgISdhIi6+DBRoPDuJSYDwYzuP81IAW5bdGI50QQpl3x3SMyANnKDLpXC0Qanyndh
         zv1wkN5B3k68mKAfnI7v1PVlt8N14KuHMxTiscXK2yGiek/aHY5eRDlQ+c3gdSzzw4yB
         bD82MF2drHq9rEADLKdgAw1wyhlpDO5nQEnSrmHkgAEF80cobpcl74BOuo/Y7+AjCcFj
         ruOgKmKUS1sTpLAj9fNwgvhxMy4nQo89pppYFIOqA0dANbUksF0d/bvZZKPYrGYRgFMv
         cwYA==
X-Gm-Message-State: APzg51ArbFf5dLq80aSu++LYlwlWY0Lc96H1wm7ZpmQeEGNBfnCEndQ1
        rL4ip/ZT9K9lis4P5LFGPwEaX8t/1Qg=
X-Google-Smtp-Source: ANB0VdY+ibMd5gH17gL6rbFhh2cEA5X3d5NpaWqsrXiw3RhReYaXM4lwjhUkjW5tizyTdDUwt9O7wA==
X-Received: by 2002:a25:210:: with SMTP id 16-v6mr11093884ybc.380.1537201451162;
        Mon, 17 Sep 2018 09:24:11 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id p62-v6sm8535283ywh.73.2018.09.17.09.24.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 09:24:09 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id z143-v6so5675915ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:24:09 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr10346107ywg.353.1537201449087;
 Mon, 17 Sep 2018 09:24:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 09:24:07
 -0700 (PDT)
In-Reply-To: <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com> <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 09:24:07 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
Message-ID: <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 8:06 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> The trailing comma thing gets us some compatibility, but we still have
>> to decide which things should be exclusive-via-"security=" since with
>> blob-sharing it already becomes possible to do selinux + tomoyo.
>>
>> The -$lsm style may make it hard to sensibly order any unspecified
>> LSMs. I guess it could just fall back to "follow builtin ordering of
>> unspecified LSMs" (unless someone had, maybe, "-all").
>
> That's why I'm not especially happy with either one.
>
>> so, if builtin ordering after blob-sharing is
>> capability,integrity,yama,loadpin,{selinux,apparmor,smack},tomoyo
>>
>> security=apparmor  is  capability,apparmor,integrity,yama,loadpin,tomoyo
>
> I would expect capability,integrity,yama,loadpin,apparmor to reflect
> today's behavior.

If that's desired then we have to declare tomoyo as "exclusive" even
though it doesn't use blobs. But then what happens in the extreme
stacking case? Do we add "lsm.extreme=1" to change how security= is
parsed?

>> security=yama,smack,-all  is  capability,yama,smack
>
> Yes
>
>> security=loadpin,selinux,yama,-integrity  is
>> capability,loadpin,selinux,yama,tomoyo
>
> I think that the negation should only apply to
> integrity, yama and loadpin. All blob-using modules
> must be explicitly stated if you want to use them.

What about tomoyo, though? It's presently considered a major LSM (i.e.
security=tomoyo disables the other majors), but it doesn't use blobs.

>> Whatever we design, it needs to handle both the blob-sharing
>> near-future, and have an eye towards "extreme stacking" in the
>> some-day future. In both cases, the idea of a "major" LSM starts to
>> get very very hazy.
>
> Long term the only distinction is "minor" and blob using. So long as
> there's a way to enforce incompatibility (i.e. not Smack and SELinux)
> in the sorter term we can adopt that mindset already.

Given that tomoyo doesn't share blobs and integrity doesn't register
hooks, how would they be considered in that world? Or rather, what
distinguishes a "minor" LSM? It seems there are three cases: uses
blobs with sharing, uses blobs without sharing, uses no blobs. What
happens if an LSM grows a feature that needs blob sharing? If "uses no
blobs" should be considered "shares blobs", then there is no
distinction between "minor" and "blob sharing".

>> As for how we classify things, based on hooks...
>>
>> now:
>>     always: capability
>>     major: selinux,apparmor,smack,tomoyo
>>     minor: yama,loadpin
>>     init-only: integrity
>>
>> blob-sharing:
>>     always: capability
>>     exclusive: selinux,apparmor,smack
>>     sharing: tomoyo,integrity,yama,loadpin
>>
>> extreme:
>>     always: capability
>>     sharing: selinux,apparmor,smack,tomoyo,integrity,yama,loadpin
>>
>> The most special are capability (unconditional, run first) and
>> integrity (init-only, no security_add_hooks() call).
>>
>> Can we classify things as MAC and non-MAC for "major" vs "minor"? SARA
>> and Landlock aren't MAC (and neither is integrity), or should we do
>> the "-$lsm" thing instead?
>
> I don't like using MAC because the use of the module isn't the issue,
> it's the interfaces used. As ugly as it is, I like the -$lsm better.

Agreed on MAC. And yes, I think -$lsm is best here. Should we overload
"security=" or add "lsm.stacking="?

-Kees

-- 
Kees Cook
Pixel Security

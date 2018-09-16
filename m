Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A4CECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DDA2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENvpZ6ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DDA2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeIQEZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 00:25:14 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42539 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeIQEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 00:25:13 -0400
Received: by mail-yb1-f196.google.com with SMTP id j8-v6so6999276ybg.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aS0O6rTyLNJVS6Fpc6tBclz1LGf7y4px7eKsRWEUvts=;
        b=ENvpZ6kuYbMorISfPLGjbGVxgnBx85J5t9u9UfptazBcjb2XA8tWl2c6SUewwtEhLe
         nrGdcgCJUdAtzwcryzvQYi9f0c9eSVz4X6A9T0vnkLu+VaCEje2ghhAw3rcosISe3h9r
         HJ6GmAuoCSKmO7nYAPYMO7zATQ3oR4Ib7xYhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aS0O6rTyLNJVS6Fpc6tBclz1LGf7y4px7eKsRWEUvts=;
        b=VFnS05y7hAw+Pk8rgvjFguSsCwNQBMl+xbIqFp41DXeGjcZGLwETckjPOAOuhP7sJd
         0lAAWH0uY5X34R7QketTwBm3QCYXsExxcdF5SM1rcfEh9+uKroqCUzEZpCd7JxlnzADX
         6H6/0/N4xgFl8Jlpad6yhNIpahnjg3/xswmAZXOpHMvmQS0nZTlxf1fo1br/ADRn01xn
         qi8pa9gIluSk1Jp42nM7mHqk4vknKb8FKvPvFun6P2JLGgbw1AsrqGBN0Fh/dcWtkT/h
         Lmjz0xXNrGonKjfCQwVuDxShvOpIPxv89VdI9J394dQfWAl6ZI3Ar3TMhUa3p5Po5RQ2
         x08w==
X-Gm-Message-State: APzg51CPmRNsN+nco4mzUuMNdeJuTxkyCIBeH9iRXu3KNuJ6QR51MNij
        VS7/UW/nCf9mRlUXr9WFX5u6BLl5txo=
X-Google-Smtp-Source: ANB0VdZ9Xcik9OSdzRMqvVUSMisGPPJjc3LruGv7W0GSsfqrgm2TXomIytXTVUUMXSdiSYIXqVv4zA==
X-Received: by 2002:a5b:c44:: with SMTP id d4-v6mr9573394ybr.381.1537138839664;
        Sun, 16 Sep 2018 16:00:39 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id p190-v6sm5506272ywg.95.2018.09.16.16.00.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:00:38 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id y134-v6so4756846ywg.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:00:38 -0700 (PDT)
X-Received: by 2002:a81:4e01:: with SMTP id c1-v6mr9451125ywb.237.1537138837666;
 Sun, 16 Sep 2018 16:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sun, 16 Sep 2018 16:00:36
 -0700 (PDT)
In-Reply-To: <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 16 Sep 2018 16:00:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
Message-ID: <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
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

On Sun, Sep 16, 2018 at 11:49 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 9/15/2018 5:30 PM, Kees Cook wrote:
>> To prepare for having a third type of LSM ("shared blob"), this implements
>> dynamic handling of LSM ordering. The visible change here is that the
>> "security=" boot commandline is now a comma-separated ordered list of
>> all LSMs, not just the single "exclusive" LSM. This means that the
>> "minor" LSMs can now be disabled at boot time by omitting them from the
>> commandline. Additionally LSM ordering becomes entirely mutable for LSMs
>> with LSM_ORDER_MUTABLE ("capability" is not mutable and is always enabled
>> first).
>
> Today if I have Yama enabled and use security=apparmor I get a
> module list of capability,yama,apparmor. With this change I would
> get a different result, capability,apparmor. I am personally OK with
> this, but I think others may see it as a violation of compatibility.

Correct. That is the problem I had asked about earlier: it means
people with existing security= for specifying the active major LSM
will _disable_ all the minor LSMs after this change. It makes me
uncomfortable.

> One solution is to leave security= as is, not affecting "minor"
> modules and only allowing specification of one major module, and adding

I would much prefer this, yes.

A question remains: how do we map the existing "security=" selection
of a "major" LSM against what will be next "exclusive" plus tomoyo,
and in the extreme case, nothing?

Perhaps as part of deprecating "security=", we could just declare that
it is selecting between SELinux, AppArmor, Smack, and Tomoyo only?

> another boot option security.stack= that overrides a security= option
> and that takes the list as you've implemented here.

or "lsm.stack=" that overrides "security=" entirely?

> An icky alternative would be to say that any security= specification
> with no commas in it retains the old behavior. So
>         security=apparmor
>         security=apparmor,
> would get you
>         capability,yama,apparmor
>         capability,apparmor
> respectively.
>
> Another option would be to require negation on the minor modules,
> such as
>         security=apparmor,-loadpin
>
> I can't honestly say which I like least or best.

The trailing comma thing gets us some compatibility, but we still have
to decide which things should be exclusive-via-"security=" since with
blob-sharing it already becomes possible to do selinux + tomoyo.

The -$lsm style may make it hard to sensibly order any unspecified
LSMs. I guess it could just fall back to "follow builtin ordering of
unspecified LSMs" (unless someone had, maybe, "-all").

so, if builtin ordering after blob-sharing is
capability,integrity,yama,loadpin,{selinux,apparmor,smack},tomoyo

security=apparmor  is  capability,apparmor,integrity,yama,loadpin,tomoyo

security=yama,smack,-all  is  capability,yama,smack

security=loadpin,selinux,yama,-integrity  is
capability,loadpin,selinux,yama,tomoyo


Whatever we design, it needs to handle both the blob-sharing
near-future, and have an eye towards "extreme stacking" in the
some-day future. In both cases, the idea of a "major" LSM starts to
get very very hazy.

As for how we classify things, based on hooks...

now:
    always: capability
    major: selinux,apparmor,smack,tomoyo
    minor: yama,loadpin
    init-only: integrity

blob-sharing:
    always: capability
    exclusive: selinux,apparmor,smack
    sharing: tomoyo,integrity,yama,loadpin

extreme:
    always: capability
    sharing: selinux,apparmor,smack,tomoyo,integrity,yama,loadpin

The most special are capability (unconditional, run first) and
integrity (init-only, no security_add_hooks() call).

Can we classify things as MAC and non-MAC for "major" vs "minor"? SARA
and Landlock aren't MAC (and neither is integrity), or should we do
the "-$lsm" thing instead?

-Kees

-- 
Kees Cook
Pixel Security

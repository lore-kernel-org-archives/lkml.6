Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA211C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ED120835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZlAWMLy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ED120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJLGiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:38:52 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44654 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeJLGiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:38:52 -0400
Received: by mail-yb1-f195.google.com with SMTP id x5-v6so4266615ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E9Z8YXmyEHkjN2JSkxIYnrk1oOeD6hL6rpGkgyv6Ooo=;
        b=ZlAWMLy7xB9VGuFtLXV9bY21AJDQg6yop286S/xbIdJNCEc3h3BKb1qIkTXGibDO1O
         J3F+/m0Ia1keM4s5AiwIXKF9h5oP7fbZ39giOxryZzEtv2aibOGzP4/rAgvAhGJ+Y4o2
         aNLpJoLo/GfWqFYNhCXz+OV8d0g/b66W6UaJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E9Z8YXmyEHkjN2JSkxIYnrk1oOeD6hL6rpGkgyv6Ooo=;
        b=mjK5a8LyWpZOxOkvT8MCyiB12NqgBEULF22VD5jsgXtH4NlUVYD0b/iDeII5S1GK1O
         UR33Z7TsyOgMizDnM5wLEjjkrXMWbOJGTKtnX5+6f+BnT881wM+Y44PYICs76V9cBQV4
         /tHkbtN0753K/DhcY/lx4XYYfkACg1OwuhKl3MD2HPup5SHk/Jc2Y1WUyTQmx0JhsL+X
         ++7wSBIWm5dLP5qMAx8HcXUBlQ8Fmcvk9Xf5ZGvmBXlnIrADvJsG6W555m9OdYmwgZ6g
         vZ1E9RRg42aqy6By/L1Dmb+ro+Y5+aHgLZTkSnmXpRX5KGY50Tv3tqbvstMxhh7D5z6z
         BTBg==
X-Gm-Message-State: ABuFfojJbQxcnNk11JHpRt3k/JW0buQM8U5o87Q3jd9AlUQBVVZPGyvw
        7JUXa7iuqGAs6QrqsV5Y27w7m1XARno=
X-Google-Smtp-Source: ACcGV61ZFRBVgCvAJlPPYneNgddXQdnuX9iyAGD7RI4u8MSIhA1HTwnyeV6YrMX6/s7K5zsSNx6kOg==
X-Received: by 2002:a25:b3c9:: with SMTP id x9-v6mr1999863ybf.508.1539299362297;
        Thu, 11 Oct 2018 16:09:22 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id m82-v6sm5618784ywc.67.2018.10.11.16.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 16:09:20 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id w80-v6so4269303ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:09:20 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr2077559yba.410.1539299360001;
 Thu, 11 Oct 2018 16:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 16:09:18
 -0700 (PDT)
In-Reply-To: <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
References: <20181011001846.30964-1-keescook@chromium.org> <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 16:09:18 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
Message-ID: <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 3:58 PM, Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
> On Thursday, October 11, 2018 7:57 PM, Kees Cook <keescook@chromium.org> wrote:
>>     To switch to SELinux at boot time with
>>     "CONFIG_LSM=yama,loadpin,integrity,apparmor", the old way continues to
>>     work:
>>
>>     selinux=1 security=selinux
>>
>>     This will work still, since it will enable selinux (selinux=1) and
>>     disable all other major LSMs (security=selinux).
>>
>>     The new way to enable selinux would be using
>>     "lsm=yama,loadpin,integrity,selinux".
>>
>
> It seems to me that legacy way is more user friendly than the new one.
> AppArmor and SElinux are households names but the rest may be enigmatic
> for most users and the need for explicit passing them all may be
> troublesome. Especially when the new ones like sara,landlock or cows :)
> will be incoming. Moreover to knew what you have to pass there, you need
> to look at CONFIG_LSM in kernel config (which will vary across distros
> and also mean copy-paste from the web source may won't work as expected)
> which again most users don't do.
>
> I think there is risk that users will end up with "lsm=selinux" without
> realizing that they may disable something along the way.
>
> I would prefer for "lsm=" to work as override to "CONFIG_LSM=" with
> below assumptions:
>
> I. lsm="$lsm" will append "$lsm" at the end of string. Before extreme
> stacking it will also remove the other major (explicit) lsm from it.
>
> II. lsm="!$lsm" will remove "$lsm" from the string.
>
> III. If "$lsm" already exist in the string, it's moved at the end of it
> (this will cover ordering).

We've had things sort of like this proposed, but if you can convince
James and others, I'm all for it. I think the standing objection from
James and John about this is that the results of booting with
"lsm=something" ends up depending on CONFIG_LSM= for that distro. So
you end up with different behaviors instead of a consistent behavior
across all distros.

Now, in the future blob and extreme stacking world, having the
explicit lsm= list shouldn't be too bad since LSMs will effectively
ALL be initialized -- but they'll be inactive since they have no
policy loaded.

But I still agree with you: I'd like a friendlier way to
disable/enable specific LSMs, but an explicit lsm= seems to be the
only way.

> It's possible that something lime this was discussed already
> but without full examples it was hard to me for tracking things.

It's been a painful thread. ;)

-Kees

-- 
Kees Cook
Pixel Security

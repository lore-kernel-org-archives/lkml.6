Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5877C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D20920839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AuiWKcdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D20920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeINFDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:03:30 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38446 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINFDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:03:30 -0400
Received: by mail-yb1-f194.google.com with SMTP id e18-v6so4057547ybq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TcQIKPwMFVaN0GBK/xzZ3MhnEvz867kC3tFnl8rrao0=;
        b=AuiWKcdnegYGgE6bQdvx02KimSMAwE3HFkUpEHwvwDwr5xlusgCnuZBcmbk8ecv8Qf
         7hV+DqruG/q2WqNvegOG183NfAHAnOlBbiXjbia3AcrHXpgpLjQPbMCBjiIg5aoA+BVv
         QTirJYNNqlRyJ75eId7woI9wjNLyLu4/Qm2qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TcQIKPwMFVaN0GBK/xzZ3MhnEvz867kC3tFnl8rrao0=;
        b=dM+V/tgvu0xVOI0L+ARYKSV3XdZZe2JJ8b5hCcuszdMbwqn8mWWbweUzqbvXblgBZU
         ODkQ752UcVszD+PB4IZ7waeoF2QLxBrQXEjglwPPr03K+8iiM7fbVrjoW4ch4BB+i6Ut
         OtrsztYWZ/tNSwAA0+eQRCgk+YbATN5BJ7CEJp77K2+Ny1SJ6g3268fOc0agISMyG0fv
         mDexWEtP3mxqRAtse11upJl9unA6vZ8sVvlZT0mspJ2MIi8Bi+71Vu5R4HsJNWM6lVXr
         dvfMma71dnd4y3VT+N8yQwucjZhn+K2jvxjAikvIbDtuzywsKWV4eSP/LmlpVBTeF7sl
         TIMw==
X-Gm-Message-State: APzg51BB7jstqKfbA0yec7VtHjPpznaFeCPvBoQKNTGFy3NSols1DjfV
        /bxoUqwKFD7k1hUhmCLOCd/6IjZ5sV0=
X-Google-Smtp-Source: ANB0VdbkUHqxgXIlmGf8gRF3dGkGXzC9bDBRXeH/23qiDxxqlgQDzkajilbGnUjd0bdgzmb+Z72qXA==
X-Received: by 2002:a5b:950:: with SMTP id x16-v6mr4737545ybq.67.1536882706097;
        Thu, 13 Sep 2018 16:51:46 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id x184-v6sm4840707ywx.75.2018.09.13.16.51.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 16:51:44 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g79-v6so1426151ybf.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 16:51:44 -0700 (PDT)
X-Received: by 2002:a25:23c3:: with SMTP id j186-v6mr4529970ybj.137.1536882704367;
 Thu, 13 Sep 2018 16:51:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 16:51:43
 -0700 (PDT)
In-Reply-To: <0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com> <0eb75e66-ed50-4013-6440-38bc2f814c6f@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 16:51:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
Message-ID: <CAGXu5jKZ7rquTux5fS+5tQ==0w_9rDTRaJWS_mS7C+Fy2dXRRQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     John Johansen <john.johansen@canonical.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:32 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/13/2018 04:06 PM, Kees Cook wrote:
>> - what order should any stacking happen? Makefile? security=?
>>
> Preferably not. For the single LSM we have the ability to choose the default LSM, ideally we let the distro decide in the Kconfig and the user with security=...

I can't find a non-crazy way to do this in Kconfig. Right now, if I
threw out all the _DEFAULT stuff, I could do:

config SECURITY_SELINUX_ENABLED
        bool "SELinux LSM enabled at boot time"
        depends on SECURITY_SELINUX
        depends on !SECURITY_APPARMOR_ENABLED && !SECURITY_SMACK_ENABLED
        default SECURITY_SELINUX

config SECURITY_SMACK_ENABLED
        bool "SMACK LSM enabled at boot time"
        depends on SECURITY_SMACK
        depends on !SECURITY_APPARMOR_ENABLED && !SECURITY_SELINUX_ENABLED
        default SECURITY_SMACK

config SECURITY_APPARMOR_ENABLED
        bool "AppArmor LSM enabled at boot time"
        depends on SECURITY_APPARMOR
        depends on !SECURITY_SMACK_ENABLED && !SECURITY_SELINUX_ENABLED
        default SECURITY_APPARMOR

config SECURITY_TOMOYO_ENABLED
        bool "TOMOYO LSM enabled at boot time"
        depends on SECURITY_TOMOYO
        default y if !SECURITY_SELINUX_ENABLED &&
!SECURITY_SMACK_ENABLED && !SECURITY_APPARMOR_ENABLED

config DEFAULT_SECURITY
        string
        default "selinux" if SECURITY_SELINUX_ENABLED
        default "smack" if SECURITY_SMACK_ENABLED
        default "apparmor" if SECURITY_APPARMOR_ENABLED
        default "tomoyo" if SECURITY_TOMOYO_ENABLED

(As before CONFIG_DEFAULT_SECURITY basically means the effective
"security=" contents. Reminder than Kconfig default are "first match",
so tomoyo would only happen if all others are not enabled by default.)

But this doesn't provide a way for Kconfig to declare the ordering of
TOMOYO followed by SELinux. If we just declare ordering is a function
of the Makefile, then the above would work as expected. The
"conflicting major LSM" could be specified on "security=" and stacked
could be enabled with $lsm.enable=1 (or disabled).

So, before we can really make a decision, I think we have to decide:
should ordering be arbitrary for even this level of stacking?

-Kees

-- 
Kees Cook
Pixel Security

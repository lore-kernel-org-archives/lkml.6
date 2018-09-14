Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8722EECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316CD2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hur8Fj33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316CD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIOBVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:21:12 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38584 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeIOBVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:21:12 -0400
Received: by mail-yw1-f65.google.com with SMTP id n21-v6so3130703ywh.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zBskjrVMgqPEtHZdixoZMRt82wo8eCH0rW4627hLC/s=;
        b=hur8Fj33JRnrmzK4sOB4meOd3I6kV8UW4eKYVEWQuKg/rP1HEs95a9ofholYTwLZDW
         S3zZIXLe4HqQG5uPLfHeo6t6TZ7lqlJ9XrncVkPoVaUvVR0AzGc9MKpsrQTySMyDT6q5
         YKyPIrVWPShCZrcByC35jfIpAujXq9CQ256pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zBskjrVMgqPEtHZdixoZMRt82wo8eCH0rW4627hLC/s=;
        b=To4448KTENb2lKo5Z9+n8S/jgksusFjXe2t2ZfGvXznksm9eWA4s0cZPzFIV9v47m4
         VV6orctuqh8uo6oJ1qYi01SYBg24kplXZqhio2KR8lvDa9FL11bOitx2xRUdTL1MKzGe
         KTt4UAkZocVVK+m85Vtd4Qyks+hG8n+udzUSdtVwaXCHa0tjtlbUseUzAjHhtzk8Gpdc
         UgOvIPPftBIz+b8T6Vb+aQHzNPvdy0/UbNg62RnmiRBPfWM0qLM1FIFgYM/62QFKaKeH
         336mMclHU1H5XsPfY6v5PnBxFuVytietoOqZ6OAF0MmxmFAm9xoxF2KcfiCCHGhO5k1m
         ih1g==
X-Gm-Message-State: APzg51CSjElZWFnICOluKRmrzKji+HpMH8FXJ/dWoMM3t64VD/UuIMOI
        XMhAko3S3sAHjw/APKDqxlep3rLpPFU=
X-Google-Smtp-Source: ANB0VdaCLYoTg44Tk8IdBQmUjgA3aS20bEOTHDu+lacJVhpUy+kNH9tXEdgClocQUu2DApoR+ugqHw==
X-Received: by 2002:a81:7484:: with SMTP id p126-v6mr6186703ywc.287.1536955511389;
        Fri, 14 Sep 2018 13:05:11 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id w207-v6sm10598398yww.17.2018.09.14.13.05.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 13:05:09 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id y20-v6so5286370ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 13:05:08 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr6285244ybh.209.1536955508417;
 Fri, 14 Sep 2018 13:05:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 13:05:07
 -0700 (PDT)
In-Reply-To: <2bc5e4f5-8429-6843-f255-8fab6dacf39b@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com> <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
 <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com> <CAGXu5jJ5__jdBM5X0vVyEU1TKnN4dpkXbj=10iak9RvD1DZk9g@mail.gmail.com>
 <2bc5e4f5-8429-6843-f255-8fab6dacf39b@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 14 Sep 2018 13:05:07 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL2LjPhLsx2bQJQdj4GraTDakYTqb3fqUbWGrOfUsW8=w@mail.gmail.com>
Message-ID: <CAGXu5jL2LjPhLsx2bQJQdj4GraTDakYTqb3fqUbWGrOfUsW8=w@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
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

On Fri, Sep 14, 2018 at 8:57 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/13/2018 5:19 PM, Kees Cook wrote:
>> We already have the minor LSMs that cannot change order.
>
> Are you saying that we don't have a mechanism to change
> the order, or that they wouldn't work right in a different
> order? Well, there's the capability module that has to be
> first.

I just meant their order is explicit in security.c.

>> They aren't
>> part of security= parsing either.
>
> True, but there's no reason now that we couldn't change that.
> Except for capability. Hmm.

Right, we have at least one that MUST be first (and must not be disabled).

>> Should "blob-sharing" LSMs be like major LSMs or minor LSMs?
>
> I like the idea of changing the minor modules to do the full
> registration process. That would make them all the same.
> Except for capability. In any case, the "blob-sharing" LSMs
> need to do the full registration process to account for their
> blobs sizes, and that brings the "major" behavior along with it.

I agree. I'm working on some clean-ups that I'll send out soon, though
I'm worried about some of the various boot-time options...

>> If someone is booting with "security=selinux,tomoyo" and then SARA
>> lands upstream, does that person have to explicitly add "sara" to
>> their boot args, since they're doing a non-default list of LSMs?
>
> Yes. security= is explicit.
>
>> (I actually prefer the answer being "yes" here, FWIW, I just want to
>> nail down the expectations.)
>
> For now let's leave the minor (capability, yama, loadpin) as they are,
> and require all new modules of any flavor to use full registration.

I would even be fine to convert yama and loadpin.

> We could consider something like
>
> security=$lsm           # Stack with $lsm at priority 2 - Existing behavior
> $lsm.stacked=N          # Add $lsm to the stack at priority N. Delete if N == 0
>
> It's OK to specify "selinux.stacked=2" and "sara.stacked=2". Which gets
> called first is left up to the system to decide. Whatever the behavior is
> gets documented. Capability will always be first and have priority 1.
> It's OK to specify "smack.stacked=1".

I'm less excited about this kind of stacking priority, but, whatever
the case, I think my cleanups may help with whatever we decide.

> The default stack is determined by CONFIG_SECURITY_$lsm_STACKED at
> build time. CONFIG_SECURITY_$lsm_STACKED changes from a boolean to
> an integer value to establish the default hook order.
>
> /sys/kernel/security/lsm reports the modules in hook call order.

Didn't I send a patch to new-line terminate this list? I always get
annoyed when I "cat" it. ;)

> /sys/kernel/security/lsm-stack reports the list with the hook call priority
>
>         capability:1,yama:1,selinux:1,sara:5,landlack:17
>
> If stacking is not configured $lsm.stacked=0 is treated as security=none.
> For other values of N $lsm.stacked=N is treated as security=$lsm.

I feel like "order" is bad enough. Can we avoid adding "priority"?

-Kees

-- 
Kees Cook
Pixel Security

Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C0CC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE07220881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gst+g95s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE07220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeINDDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:03:22 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46516 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeINDDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:03:22 -0400
Received: by mail-yb1-f194.google.com with SMTP id y20-v6so3922232ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vcYGkvhLJaDy0HR8Vri0K78eWfACUqgqrMj8r432pa0=;
        b=Gst+g95s0g5VTODe2asIe2jbgtwAwUk6gggYBK+DUYqjnod4oxLoRh/bBPx+rs4DI3
         KcYhsDbMS672h1zaGenR0bjGQvEA+U0sTpoGpqa9XRfNLJisDIqFUyTDusRIdnY5dcI3
         G0qHG8aSv3eoAPKWKG9uM/iwOhFJbbbpPQhfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vcYGkvhLJaDy0HR8Vri0K78eWfACUqgqrMj8r432pa0=;
        b=p9tFS8CMwzqEXy/U8v8+ix4Ki9quqjZ7jLim9sC3zg5nFPfyLLleEFYHvBjp6Wrr8m
         xzY1wKKivKbO1qTEDL1W+0IBH0sp19wLP8aX7SXvkv5ZQ5dh8IoV7/nwOR32rnuklxGz
         cifvz9PK4pGgkoZ4nK6qhTN32FybmiXAMJzHn2KDV6/bdTz//hMoa9KfrHzhg2m9H47O
         octP9SYNup5iwoTTdyWH4KYuCwX6UgHNKMu7mZlwsc+skCbu4r178h2dqnKMkGTxXBCt
         OnVGkK4k82t23prafFpm9G943scsGiT2q0o5negtHjWxMMfDbTAYwK+Jyhf5SJleYEZO
         e1AA==
X-Gm-Message-State: APzg51CASCn/8IO0f8CXmZg5i0FAK6Bo77OTy+9BlmOodzGMUaYiwMIU
        KTRk6l9GQUF3xb5l66kBYxCn0JfupjM=
X-Google-Smtp-Source: ANB0VdZRA1jRzJ1SHxgHrcbGjvxGqJzMKWnNjdOYzNd8uE6syqCdv/eEAqSW8Lj1wiWuKFA9vWPf5g==
X-Received: by 2002:a25:b904:: with SMTP id x4-v6mr4395473ybj.56.1536875520095;
        Thu, 13 Sep 2018 14:52:00 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id s63-v6sm2568095ywd.63.2018.09.13.14.51.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:51:59 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id t10-v6so3966643ybb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:51:58 -0700 (PDT)
X-Received: by 2002:a25:f606:: with SMTP id t6-v6mr4554188ybd.141.1536875518364;
 Thu, 13 Sep 2018 14:51:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 14:51:57
 -0700 (PDT)
In-Reply-To: <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com> <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com> <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 14:51:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
Message-ID: <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
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

On Thu, Sep 13, 2018 at 2:38 PM, Paul Moore <paul@paul-moore.com> wrote:
> The infrastructure bits aren't really my concern; in fact I *like*
> that the infrastructure is always exercised, it makes
> testing/debugging easier.  I also like the ability to limit the
> user/admin to one LSM at boot time to make support easier; my goal is
> to allow a distro to build support for multiple LSMs without also
> requiring that distro to support *stacked* LSMs

I see your point, but as soon as SARA and Landlock appear, they'll have:

    depends on SECURITY_STACKING

and then all distros will enable it and there will be no sensible
runtime way to manage it. If, instead, we make it entirely runtime
now, then a CONFIG can control the default state and we can provide
guidance to how SARA and Landlock should expose their "enable"ness.

At the very least, to avoid stacking now (i.e. TOMOYO being enabled
with another major LSM), we just do nothing. The existing code already
makes the existing major LSMs exclusive. Adding a stackable LSM would
need to just have its own "enable" flag (i.e. ignore
security_module_enable()), and then either check a runtime "is
stacking allowed?" flag or have new "depends on SECURITY_STACKING". (I
think the CONFIG will force distros into enabling it without any
runtime opt-out.)

> (see my earlier
> comments about the difficulty in determining the source of a failed
> operation).

Agreed. I would hope that audit could help for that case. *stare at blue sky*

-Kees

-- 
Kees Cook
Pixel Security

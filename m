Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AAC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AB7204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/gBwgSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AB7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeIMFaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:30:39 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43381 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeIMFaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:30:39 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so469332ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8ktaeWIjqwPSIh1NZQKxymzGW3ecIFfPfa3leYrdQZU=;
        b=E/gBwgSeA13jY1rfKYppcwV0bzp2pyeyCFmHieVvmuE7dCVTAH9tVdgtCDKdJ32+NF
         tf8gy7rOvtgXidqVhqb3urdtc168SkjPUTZULTwfYW+O/35aXBdkUbUxN/djOhAP722p
         ToRRYYCuZAik2lCQful2ORaXqcSFu29I6ONZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ktaeWIjqwPSIh1NZQKxymzGW3ecIFfPfa3leYrdQZU=;
        b=pGWIJkzDxtUcYASdsBykAHzOeyl1E4VnRYAZ6Grz+ZepJvC6sE0tti0PBIeJAXAAPf
         nsAX42zBjd7HgZ5E/TTnEbhEh7Y6AtJYkNueV70TZVAHrc40MM5KiXeL4TopbDMaAbjx
         bLfRTguwTnppNkRfjr0mMikFk296dlec988+T6looPUBdes94vNUSSpwwHPFBiSYWkeu
         bdWEdOaS97fZkvfwuWdH1dVy1gsKJ17UvFWFq/TP/bzY1Xzc9k+Kx1h6dBNidcydpudJ
         2FmGFBqogwqpnFzSMkJ1yrFinI7VEkHB8KI8Fd+Qbobk9scaAyz3bHl4dwQT1v+0I9Zi
         OVMw==
X-Gm-Message-State: APzg51B0G4mbmWDnP0eBIwficFSCwxPV06gDbw7109jCEGKv/e/DirLO
        wVf2kup4au9mVQWW6ymmNVBE2AL4gAU=
X-Google-Smtp-Source: ANB0Vda+SD9FjHYomIIRbtsVkjFf7roPbKZAhe3o2OIkMAhRXv0VQTQTibXt/aE/1Z5AyaFZLZWLBA==
X-Received: by 2002:a81:7d46:: with SMTP id y67-v6mr2315731ywc.457.1536798221823;
        Wed, 12 Sep 2018 17:23:41 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id k184-v6sm817375ywc.62.2018.09.12.17.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 17:23:40 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id l189-v6so469312ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:23:40 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr2232916ywg.47.1536798220268;
 Wed, 12 Sep 2018 17:23:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 17:23:39
 -0700 (PDT)
In-Reply-To: <1aa12afc-2e1e-2e89-d422-a471990e0367@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com> <1aa12afc-2e1e-2e89-d422-a471990e0367@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 17:23:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLvyCXgtE6-S05kEQqBnZwftRanRTVYJOnBRPJJnOK4Vw@mail.gmail.com>
Message-ID: <CAGXu5jLvyCXgtE6-S05kEQqBnZwftRanRTVYJOnBRPJJnOK4Vw@mail.gmail.com>
Subject: Re: [PATCH 07/10] SELinux: Abstract use of inode security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the inode->i_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Happily mechanical! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

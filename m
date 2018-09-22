Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B499C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A3721569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4nJxnw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A3721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeIVIiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:38:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46851 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeIVIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:38:55 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so5958367ywc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/DwY8Hsv8xYW8i78a17yt3JxgNy6juVebR3psO5Eyf0=;
        b=f4nJxnw+jm8/ogq+3HX8GEA5MGsvf0zr/845tgO7+V4Yu9H6WS94TNOgTL1GS1qO3P
         i61TbX0qUNWyCKg73A+ViFvt7vBKp+Sx3BxenuR4dGZ5TLFmhzPF2ZVikY8qYnPhGywz
         45TLh2sNGV9X0k/+lvz2Bcmhr9tmnTWgBSMRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/DwY8Hsv8xYW8i78a17yt3JxgNy6juVebR3psO5Eyf0=;
        b=W2IlGtcmx0qAYaCcEM9SGHBEXP0/S3EdfeYMs7C4ANTVKwBvWq0ODUqSYDczm8xSSH
         9tidqiyc3+8qgvoH+2oJE/hCdfwY4TnoROPhVXt4fKvhyOaUpVJeoVhSexhXssfbEpD5
         mPsZO5UjIeSkL5jj94fUFpSLz/30H2e2wwhQ1X/ZC8CuUaNWYFNMdPYx6I3lnov5ULZi
         HItFT013Js9HvxN0QeTqraC/ufIf4Od6TMc2PqLWahe0pEybFf1exAtZM6SKVxeVU0Ac
         0wxhB3WrJ6ZbHzz6sQYhMNMsWO8HvcjP84C6hkktwYQkH0XpfxsVvPunFw30+RnlFwkc
         Gwag==
X-Gm-Message-State: APzg51DlDexRTqnQqbxIqMagcYIrzR0eqUxDRyF228Q3AOYFcE9x0bPI
        ObAEQjN4QENaVbBbd9PCI6eca2AQYGs=
X-Google-Smtp-Source: ANB0VdatXdWSJNNgduKK9tmWeHXSZlGbJiimjXG1FHJZ1w9zQRI45LXCmnBVF0xL4PNZ3xAZ3YiGyA==
X-Received: by 2002:a81:7d46:: with SMTP id y67-v6mr199334ywc.457.1537584426098;
        Fri, 21 Sep 2018 19:47:06 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id k184-v6sm5119891ywc.62.2018.09.21.19.47.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:47:04 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id e190-v6so6255698ybb.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:47:04 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr202782ybd.403.1537584423705;
 Fri, 21 Sep 2018 19:47:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:47:03
 -0700 (PDT)
In-Reply-To: <8ea966f7-924e-b805-56e8-9ad74e7f9d86@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <8ea966f7-924e-b805-56e8-9ad74e7f9d86@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:47:03 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKRmACSA0kdG1v==zaaNxh=K9ePi4TVFfD3Zq-vOChVfg@mail.gmail.com>
Message-ID: <CAGXu5jKRmACSA0kdG1v==zaaNxh=K9ePi4TVFfD3Zq-vOChVfg@mail.gmail.com>
Subject: Re: [PATCH v4 07/19] TOMOYO: Abstract use of cred security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide helper functions that provide the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

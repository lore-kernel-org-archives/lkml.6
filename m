Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6050BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209CE20834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oNri3LK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209CE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeLEAb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:31:29 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44389 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLEAb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:31:28 -0500
Received: by mail-yb1-f193.google.com with SMTP id j145so2769729ybg.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HI/NZ9Pl5qptqj62pAcHKWa5WGEOJQMbSZKqqsDETqg=;
        b=oNri3LK4r0hcjcqotwrisMzz2j0myVO82+wol3vLJA/0+JWznFP4USftJ1BnOBM7U4
         k4p9ifiBRgrusIoF3dsoJUWxDn/Z/wCKnYrdHNz1eeK0c2pc7hNan1R5DmhcnO78isuM
         sYxC06KfXJQ9ctqZWUQggofzDYqNjKAM740co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HI/NZ9Pl5qptqj62pAcHKWa5WGEOJQMbSZKqqsDETqg=;
        b=MkWNa9qSyBD4wRkDdiivSeYYrfVsn4TAuOZ2ZA4O6LCY7OU4qpSuDYzr3Ovxr9/GNu
         EruOootR+78STIZ4ACVs1kqQB6gN+PSWdKC+jDAgn1+7ahp29ZDBg4i2zLt8ZnHhxtUA
         1kn+bM+MALyOaDX5fKnjJG/tgR253BAIUOsdkOMZMT9XS11wB6Xj9I3LeCSij9hhfozw
         pYLfkGLyFM+Qc0xbSvT9+BWqjOPvm/4o5xOTD7HmS8ASmIQLPC7Z2QjLQvVaaN6+NSAR
         SSSKGR38b/9RGY23GITntHjhJ7dYMEwC2S5y9/IXS6GuRAapSvj7ASwvKtAeSVzbPhxy
         iKvA==
X-Gm-Message-State: AA+aEWbBD1cBNb9aG2Y5J3GEaV0oapJ6fZEbzB8r7chpPik/7FTMwwvK
        cQmq7vHoWHkCoYcLTia1hwsO6BmEnyk=
X-Google-Smtp-Source: AFSGD/XOcnjtPs+VJn+KNPtNeOzu1KosWOqrji3dQ9yVuEHFO/PvnhOmtP2HiAv76SCUs4Ghzky4KQ==
X-Received: by 2002:a25:c781:: with SMTP id w123-v6mr20792946ybe.135.1543969887126;
        Tue, 04 Dec 2018 16:31:27 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id u4sm9323295ywu.92.2018.12.04.16.31.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 16:31:26 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id w203so3844556ybg.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:31:25 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr20736357ybi.171.1543969885074;
 Tue, 04 Dec 2018 16:31:25 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 4 Dec 2018 16:31:13 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
Message-ID: <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> v5: Include Kees Cook's rework of the lsm command
>     line interface. Stacking is not conditional.

Can you resend this series with corrected "From:" lines in the body, etc?

Beyond that, I obviously like it. James, what's needed for this to move forward?

-- 
Kees Cook

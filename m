Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F16CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69E721569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hq4jTAqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69E721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeIVIpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:45:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39664 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeIVIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:45:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id g3-v6so1346464ywb.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RoRONKQMjtDxQiQHwsgl0ViOw4PwAn/e0EP/Ksl/R08=;
        b=Hq4jTAquuv5osMvtG3RmGxhFk2LFMuH+dj3wCJ83NxZH3g97MbcjBfoylvySfBa/mz
         e/yhH4pp8biGshjZ7uzr4deQaKL8o6kHl/y67txD51VUqx1aZjJQ+EfKcc4Pi6WPbIef
         RUccvcSZaG+RbHkIw7OfHYIab+sb/lmvjQMp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RoRONKQMjtDxQiQHwsgl0ViOw4PwAn/e0EP/Ksl/R08=;
        b=Eqi2LgOu3f+jEHTdXvaQBDLUrMtLbQrH4nEs40Kij3WWYMIAR6ZaubaeGfAisIZWPT
         DNmXlzXjWW5nisMbNn8YqQAI2D1nHdtW8CiahwjGWvdRX35jPGQwvZODQDca8M8+4E7K
         wd/n+NYFVchAN3GQMukKUL6qoBmBbLeX/6HQQLYTOqHPPU+XdNPt6aN1tXCk7A5dazUg
         XepVACqCsurl5Ph0x+CrywFlH9VObx7yY8KeCJbdMrtRwT9f+HlHSJVlwbbzoATHtTTv
         Z6t0a0Hsb3bMh1W3/kXGXECOr4eZY/b21c39FV2Ri2uteQ8xKcbE+pmZOfpO0wU75LL9
         /ZDQ==
X-Gm-Message-State: APzg51CFIdpWyAXAYC6y9LsvEemeQ8CyYYnZ3cCGZ+/5xZSfoL+Ebc0R
        58+JoYQAR3aCxkfCComSHuhhESpNmMQ=
X-Google-Smtp-Source: ANB0VdbMYIq0mTXPaZ/U2VJGmLPg9w69AKjUiZZHRMMtpREg6/KUo8b+9tT6Q50VJSVBnbpIDD9j1Q==
X-Received: by 2002:a81:b102:: with SMTP id p2-v6mr46574ywh.20.1537584807143;
        Fri, 21 Sep 2018 19:53:27 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id u124-v6sm10206070ywd.37.2018.09.21.19.53.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:53:25 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id j131-v6so5961559ywc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:53:25 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr193715ywg.353.1537584805076;
 Fri, 21 Sep 2018 19:53:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:53:24
 -0700 (PDT)
In-Reply-To: <1ca14e0b-6a95-4efe-7a23-e82d7562df26@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <1ca14e0b-6a95-4efe-7a23-e82d7562df26@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:53:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK-9O=ttcaLF6QNenhLXS9FeXPDardSKAu2-4fwaNJDGw@mail.gmail.com>
Message-ID: <CAGXu5jK-9O=ttcaLF6QNenhLXS9FeXPDardSKAu2-4fwaNJDGw@mail.gmail.com>
Subject: Re: [PATCH v4 11/19] LSM: Infrastructure management of the file security
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

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the file->f_security blob out of the
> individual security modules and into the infrastructure.
> The modules no longer allocate or free the data, instead
> they tell the infrastructure how much space they require.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

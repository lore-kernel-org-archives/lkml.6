Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954FBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F37214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AF/qJh14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F37214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJQKNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:13:01 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38730 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJQKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:13:01 -0400
Received: by mail-yb1-f196.google.com with SMTP id e190-v6so9736015ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 19:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fmS4tWhzloUUJqiAdoh6mxdsNrq3Rd/E5QAg9bsl7MY=;
        b=AF/qJh146laykI9gT6QmcZWIHVJxCD2AZAkPEtWCVqQq5RSZ70L2xSkX7iaPiYjujZ
         G2SS+CyVnnROkoz6ywljm0XS7V3tdffI16BPqi7Scy4zzRHQQ3B8HLO+hX/JIlte2ee+
         mI9U4HLV1cYuProy3SDHrZC6W08VtGVRX6mpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fmS4tWhzloUUJqiAdoh6mxdsNrq3Rd/E5QAg9bsl7MY=;
        b=uXvdbUgKvfta8xCfLevji3ibuI5V4wLvJbb6gRZu9g2DtmrCngqLufmH42bxTHI7QA
         SSWohJK7oZZulx0e3sO+bsgwmZ9ozjmqWlfLJF9/TVBDPg3LVkGYPZi23L0PN2H6/ShJ
         GThGlRqrvULqlSFJfcmvq3VVlwplqQ4PmYhloAhffnrUR6+ys06aH/ryGH2aPNa8bgKL
         TWelj/EaR7ZGdTRSnKkyeTOkUZyCLmN9o4Te60A/ChMEfp5cxSVkaqArb1I1dVnw6+KY
         evKIm/vB/b1Be69TVlO3KKFyKKBzWtHokzYBkzQQQaobY6j2l1V5Ae0s/hCcv6QCab0A
         HkaQ==
X-Gm-Message-State: ABuFfoinOAacjfIt9J8x1I0XSPsi1iS28RE6VWfxH+EOfD24HrWF6dBx
        kJ3cjmxr7Psd2+YBVh+0+AZK2exOUlk=
X-Google-Smtp-Source: ACcGV62i7U/Sq6eQcV24ZMuKEe3+gDXFuqNv71DuMjPHbmqn+2EDjNslFuH9yDtn9g0A7SubeSQLIg==
X-Received: by 2002:a25:4982:: with SMTP id w124-v6mr12662842yba.85.1539742778334;
        Tue, 16 Oct 2018 19:19:38 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id q2-v6sm3840666ywg.87.2018.10.16.19.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 19:19:37 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id e190-v6so9735987ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 19:19:36 -0700 (PDT)
X-Received: by 2002:a25:bcc6:: with SMTP id l6-v6mr2427739ybm.171.1539742776434;
 Tue, 16 Oct 2018 19:19:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 19:19:35
 -0700 (PDT)
In-Reply-To: <CAHrFyr6AeZzfGkQneiyoLz6YZ-vnyyQWTtc0HK-tqVJkoXt=4w@mail.gmail.com>
References: <20181016223322.16844-1-christian@brauner.io> <20181016223322.16844-2-christian@brauner.io>
 <877eihjw0n.fsf@xmission.com> <CAHrFyr6AeZzfGkQneiyoLz6YZ-vnyyQWTtc0HK-tqVJkoXt=4w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Oct 2018 19:19:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJTaOyzPUYMCi9_vbxCUhLz09C-LEQL9dmM+pt_xfxcQw@mail.gmail.com>
Message-ID: <CAGXu5jJTaOyzPUYMCi9_vbxCUhLz09C-LEQL9dmM+pt_xfxcQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sysctl: handle overflow in proc_get_long
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:24 PM, Christian Brauner <christian@brauner.io> wrote:
> Right, but if you write a value that exceeds the buffer of 22 chars that is used
> to parse you already get EINVAL back on current kernels.
> So it didn't feel like returning EOVERFLOW or ERANGE might make sense.
> I saw a change in 4.10 or 4.11 as well that used EINVAL on UINT_MAX overflow
> or something. EINVAL might be enough information for userspace here ?/.

I'd agree: I think there is more precedent for EINVAL.

-Kees

-- 
Kees Cook
Pixel Security

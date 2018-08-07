Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B1FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924F52154F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gi6Rx280"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924F52154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389824AbeHGUO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:14:27 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46893 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389208AbeHGUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:14:26 -0400
Received: by mail-yb0-f196.google.com with SMTP id x14-v6so1158534ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=BwKG5mbwwr039cmdVxanDGkpPlPiDfBOcP9uNxW2iMI=;
        b=Gi6Rx280ctsVdue8qQfhRw2Zv9kZY2Mc40YoDW/FDBcGu/ghRa1xMPyv8OVCk4pxbr
         VihqDUBk7USA2gp99mw1xEsbH+iHq89f7ao+Qlq5Wp7X3goDLEIM+yMEK9dFvEc46cPH
         QzfEbe1VoaTEk3L4UGiR/lfWBYR0yX++at+JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=BwKG5mbwwr039cmdVxanDGkpPlPiDfBOcP9uNxW2iMI=;
        b=A0IKohnnwq8+HbjpRavLcGYTYA+mNM+tUWP9LiuKR4p/8ynbSx0jObknxX/P6eV2tS
         7nMXfrc8+wMNo6O882Lq9urrsgZSPJQlQ9UB2tHBrWXJVfH6HspiwfwRTg9YJ5O8hHKh
         aW1qVT0VgT3sws0xQEvPw0pv9sVXEbqTkzBQ8vWCFtkZ4RD2Yp5A/JPgvt7D88vmqkef
         nnamESB5t6VLtMSWt4nbxM5waucJCFCOT7bOT793hTtPcwcjCfsWzqGoIuDYGgvAoP7j
         FAUGIkRZeuRP6LM+I8t0lxvD/YsqR0fg2x3+Yh6TMUofsZoEeU4RfAUJ8gGOyobIlHSm
         BIAQ==
X-Gm-Message-State: AOUpUlHXQb1//6fWvHn8fGO6iJV3Cz6UsYJMNzFHI7ojD7zx7ZuoJTHp
        aEoDkf4COH6ilqFcdQ5kkcho20Xhqto=
X-Google-Smtp-Source: AAOMgpfMJcAJHCD5tq0T8ItjS6f8ypZzhf9a7gt7hkYPY/8sbO6K0GWxjQvxEVthWVwT08SGFGD3fw==
X-Received: by 2002:a25:3287:: with SMTP id y129-v6mr9940279yby.473.1533664736918;
        Tue, 07 Aug 2018 10:58:56 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id u67-v6sm750952ywa.56.2018.08.07.10.58.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:58:55 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id j68-v6so5263736ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:58:55 -0700 (PDT)
X-Received: by 2002:a81:b248:: with SMTP id q69-v6mr10501859ywh.38.1533664734930;
 Tue, 07 Aug 2018 10:58:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 10:58:53 -0700 (PDT)
In-Reply-To: <CAD=FV=XBCeKUrfMCppfhetWNWLJWzsbiBkQnTugoXDff-0SD5w@mail.gmail.com>
References: <20180706233142.166296-1-dianders@chromium.org>
 <20180720141059.GA3064@rob-hp-laptop> <CAD=FV=WzjZBYV+yjekC-GGgjyWNbdGX=ZwesQMQhiYHZLyzhzA@mail.gmail.com>
 <CAL_JsqKZUB3P_Z_pRG-Udx0wgWtSjzgF=Rc3t8Xf2n2uZkV3Qw@mail.gmail.com> <CAD=FV=XBCeKUrfMCppfhetWNWLJWzsbiBkQnTugoXDff-0SD5w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 7 Aug 2018 10:58:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKxxTBitJdm-rY+9JH1pd+kHZT2OdVTvc5sQMbjaRFHew@mail.gmail.com>
Message-ID: <CAGXu5jKxxTBitJdm-rY+9JH1pd+kHZT2OdVTvc5sQMbjaRFHew@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qmp: Fix dts bindings to reflect reality
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:54 AM, Doug Anderson <dianders@chromium.org> wrote:
> [...]

Apologies for this noise. I have nothing to add to this specific
conversation. :)

Doug and I (via our @chromium.org accounts) have had DKIM issues. This
is a test to see if it really has been solved. (The "sender" field was
being included in DKIM signatures, which appear to be removed now...
but this is a "full" test through LKML where the problem was seen.)

-Kees

-- 
Kees Cook
Pixel Security

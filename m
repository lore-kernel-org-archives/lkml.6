Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09987C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F5121722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LLmC+rWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F5121722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeH0Bkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:40:41 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41436 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeH0Bkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:40:41 -0400
Received: by mail-yb0-f196.google.com with SMTP id z3-v6so5365535ybm.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aFAGpveJSCZ8Z5J8xfX0Jkvh4HQchaGUGLQgiO+eQRk=;
        b=LLmC+rWpZyS8225oS8E309vDYWx+9HauJ9fAvpbIuLu6yMjsgTwqgLp0Lvb8ZUonSH
         9nguc3726J56XFbPAustGkQPV0Pxzp7ZtcsXyi1lP04SH7pDR0eajzQYq73RxQy9Onww
         nj/hjyghncQLovWeBWBoHvQhDIYsAmtBYFKN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aFAGpveJSCZ8Z5J8xfX0Jkvh4HQchaGUGLQgiO+eQRk=;
        b=j84/EfUiRwg25wuWinfRIFTHh/Toj+Na42l0cT7ykNFe0BfBt1RElUROR0Ey9opmxs
         lEW0hOdtOUQ7eUm33ZDocaSzqomiAgEMYo7u0C9W/6TPGzmvLi2n/l9j4zhJzAHjDcSv
         Lb0dnuqzHionoiZquXNyMDjpm9uVwdvSF7u90hJvcl/+cvezC0BvF9fU4P8ZwR0F3brl
         h1C6kB4iLcQJUnFL95m1sQ+jWZ3Mhti5yRlGOnmYv8i6ZSvf4JAx2sNRWoyvlxCpnm4D
         4WxX2p32a4KoIqzF6QIB9jAxIaGm/tA9fkeWd2unosB4jLkauEGMNRQo3Rq3FXo+txQ/
         F+xw==
X-Gm-Message-State: APzg51ARvkn/TtzVxEKbJZDoHNqnICePETa884BEYSRWyMIAsLKSakzX
        hFND+lgoZ6GYW5WjxF9EmRsfS0PK74U=
X-Google-Smtp-Source: ANB0VdZafTakSoUnSog/Dpm0TuzmvkW82DBNKzvD0zOlnh7p9RQXBAUBO6WGH+3IjBMrSm8pkdwJKw==
X-Received: by 2002:a25:b445:: with SMTP id c5-v6mr5812284ybg.263.1535320610684;
        Sun, 26 Aug 2018 14:56:50 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id b6-v6sm5646110ywb.78.2018.08.26.14.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:56:49 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id n207-v6so4915310ywn.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:56:48 -0700 (PDT)
X-Received: by 2002:a0d:db10:: with SMTP id d16-v6mr5884208ywe.124.1535320608141;
 Sun, 26 Aug 2018 14:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 14:56:47
 -0700 (PDT)
In-Reply-To: <5c88b08d-b9ca-f3df-ae78-cf685ee6723a@mojatatu.com>
References: <20180826055801.GA42063@beast> <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com> <5c88b08d-b9ca-f3df-ae78-cf685ee6723a@mojatatu.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 26 Aug 2018 14:56:47 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJZ-BfJPA+m1BOuVVQxPb8SXpSRo+F2cVTF62C9JTyRXQ@mail.gmail.com>
Message-ID: <CAGXu5jJZ-BfJPA+m1BOuVVQxPb8SXpSRo+F2cVTF62C9JTyRXQ@mail.gmail.com>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 10:30 AM, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> We should add an nla_policy later.

What's the right way to do that for cases like this?

-Kees

-- 
Kees Cook
Pixel Security

Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289FC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723BE2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EgoSvKE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723BE2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeKCDcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:32:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36280 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeKCDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:32:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id s15-v6so2571753lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ptdvsysNS0SNDP4JI4yo45VkzEm/wZNSyXqbB/UYCs=;
        b=EgoSvKE9Bjw0+LEOTaMaK5+KBTD6xFTpRBBm1qTxg24IYVWOdH2+zqpi6ohLGnP6zo
         PeM13hs3Fl0lWLfq/hLIBpAjHJD204HEq/orJwI9wZT+iJQRM2jbYR9bDYhv/Jqc/ei3
         R+9WcBYDq3t1tD0PEBCe9Xwv9w8fWV9mGERQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ptdvsysNS0SNDP4JI4yo45VkzEm/wZNSyXqbB/UYCs=;
        b=AmNw2UfufZ5tk7dd8lXvkQsuBn749ChKeeKjy5raZuPxwZABTBEnWCQsV0u7GngMA1
         Ir0MD+E3DGR1hwiYmJi8kEwhRu2vMS9C5hyNIhPgL8yHF1SsZqJ/iW71mVedCyqCWpJw
         CCMQj2yyb3Escpy3SwcKjc0dQVwntYoOI/ge+saLzN5PuzntCl54SL0WWYMof3dATdcx
         hs587mp7s1D980h6enxA3EnFSp4V9KwY1Gr/djadLPTf6Rs5DPiUNGcxi4f4CpW0nK5h
         gqCz9s/x5mJiy/MLMBQyK180pbkLTj74hKMwvg3pWsca0tGbwZxZbFwelmcGmUm7DT6j
         9IlQ==
X-Gm-Message-State: AGRZ1gJwG5tuUETW4A8sI+9EOK1w13bGHyzxJgM7yGsEwEICmuzUk1X9
        laPn2TttdNqQ1g/ekchLMwgCGspWDL+WHQ==
X-Google-Smtp-Source: AJdET5doqGet+AWTJNVOSUNK20495M1SnCXxWK24c4aOl9SX4EpSQc39CoArJZ3rs6GAwZnc5uhykw==
X-Received: by 2002:a2e:730a:: with SMTP id o10-v6mr7111283ljc.67.1541183039767;
        Fri, 02 Nov 2018 11:23:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id o88sm2632509lfk.38.2018.11.02.11.23.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:23:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id q186-v6so2560321ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:23:58 -0700 (PDT)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr5694282ljj.120.1541183038074;
 Fri, 02 Nov 2018 11:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181102132359.11720-1-thierry.reding@gmail.com>
In-Reply-To: <20181102132359.11720-1-thierry.reding@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 11:23:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQTHF6PxgUsBKrQ2mY_cO7YzzXG0PcV=AosParKYeHhQ@mail.gmail.com>
Message-ID: <CAHk-=whQTHF6PxgUsBKrQ2mY_cO7YzzXG0PcV=AosParKYeHhQ@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Changes for v4.20-rc1
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:24 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> This series contains a number of improvements to existing drivers, such
> as LPSS. Some drivers, such as renesas-tpu and rcar get support for more
> SoC generations. To round things off this fixes an issue with the sysfs
> interface.

Pulled,

                     Linus

Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45AEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706BB217A6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z1o2qJvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706BB217A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeHIAZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:25:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36283 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:25:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id v197-v6so2766402ywg.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9ghDYz7hN0gMlDHVCs6oCGc8cZsLkZ80P5mwohmpjyY=;
        b=Z1o2qJvCqyZSBfP6Z2QduxXPXkFYefGdgErvQjJKjNlXpIHxgUzXtsme4QKFBsPS0I
         Zb9Knid0uT6iGlHMloytKXHB1Bn7MD0T91tz8sy8pIp+eP9dvrRsFqDNqQKpERFaT8WK
         NFQ6LY2TIq7/ASBDkogjn/3CGF8WbpvCjPV2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9ghDYz7hN0gMlDHVCs6oCGc8cZsLkZ80P5mwohmpjyY=;
        b=o/3A9i3Jfd5+k3uEOIk/qfAOVDgqUJnr3DD8K0m0VhJ3jfXvuG/lNqqQ8loSg2qZzr
         aJl9s7j3qUkTR07KoQnrhiHz5ExHKjOoa40P2OQCdcSDNDtke2kcibV0xpgMOFzBvVav
         zSRSjDI0T5TcQlI8gE6P5l5KroP/FLBHJwIfClvnAz2kfUSFOolO02bSOi1deMP0RolY
         WbFQHVPLPfHvYcTgrKOU5MU9F73ZbMS2/rVzh45xKrv2tuK4vktAJmXVcrWsAWOrVbdS
         LCapmTBcy2Z37k/09EAnJdS4UKc8CsJeS/7lHS2n266P0w6FDxjBxzern5gqFJotSKCP
         nBaQ==
X-Gm-Message-State: AOUpUlGewcK9ifbmXYfHlh+ojS1KcegdUiId+o5eK8IlKRa2Y9ft6ptr
        OXjO2kUqdUeqsq76nAQ78plTF3B3RP4=
X-Google-Smtp-Source: AA+uWPwOpEyKETcCorPCLOI+33Na726MGgRvXF/ZdzBmn7CS2ZMx1qHDyX+nbemcIMPXpbzhBX0ibg==
X-Received: by 2002:a25:744f:: with SMTP id p76-v6mr2484497ybc.23.1533765831798;
        Wed, 08 Aug 2018 15:03:51 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id x19-v6sm2198968ywg.72.2018.08.08.15.03.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 15:03:50 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id s68-v6so2768424ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:03:50 -0700 (PDT)
X-Received: by 2002:a0d:fa42:: with SMTP id k63-v6mr2532664ywf.53.1533765829685;
 Wed, 08 Aug 2018 15:03:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 15:03:49 -0700 (PDT)
In-Reply-To: <20180808115932.12944-1-yuehaibing@huawei.com>
References: <20180808115932.12944-1-yuehaibing@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 8 Aug 2018 15:03:49 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+QEM-_dbj6+urqH2s+GUoaBSA4bPvRS+qOETw63dUxAA@mail.gmail.com>
Message-ID: <CAGXu5j+QEM-_dbj6+urqH2s+GUoaBSA4bPvRS+qOETw63dUxAA@mail.gmail.com>
Subject: Re: [PATCH net-next] decnet: fix using plain integer as NULL warning
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-decnet-user@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 4:59 AM, YueHaibing <yuehaibing@huawei.com> wrote:
> Fixes the following sparse warning:
> net/decnet/dn_route.c:407:30: warning: Using plain integer as NULL pointer
> net/decnet/dn_route.c:1923:22: warning: Using plain integer as NULL pointer
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

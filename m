Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBAB21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWYboavZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392023AbeLUVp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:45:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40613 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbeLUVpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:45:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so3048887pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :in-reply-to:user-agent:references:message-id:date;
        bh=TykQrWcxURowkDO/EedupXH0E00UsWc5rFelsJXoyYQ=;
        b=VWYboavZlMgn0OU8EwbXYXYZ2y6QzniUOoj6RI5FmTdIE5rcL9dY9Ui0h6MuxKAiZo
         QcejrqoyljlOXxXfde9cq+BJFMKAW+qzG5fRrcx4zaH90LfW3fyLTc5x7gTcuxgPSHWA
         HGNjxr2aN9EK6UfXjRk6FXQbGIq/nD3zgpb/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:from:in-reply-to:user-agent:references:message-id:date;
        bh=TykQrWcxURowkDO/EedupXH0E00UsWc5rFelsJXoyYQ=;
        b=aSJ4cDjOjpHj6aUmUKb1lnZ405ZS5HAsP5lS3wHdJRSUPimeuN5DE9PnMuON+c1sAM
         7YFRdLp/+kOXqJZIltbdZ5pb/GmWp2S02yiuWhwhQDupR9WQpvuptmA8CJL8YcI+xvPU
         SUSiunwhsALARC5i49y/B/dqWywYs+GxGiNtDLBzuDUypxXO0n97VPLqlAJCVeBXkG48
         Rhg9llV1MHSd1JTTphvVx3erDtdYe5R8IGYeZEcOQb/Rk8rsbKDa5lxlm0iZ2Cl6gf/e
         182Ghfqr5VSSSs5mLcTKopH+NtZYnWFv0/9lBCEWQUboUV5PPnyaFzYsskCROPLMqiWm
         t7EQ==
X-Gm-Message-State: AJcUukc7O6UyWB56UkL4iTpupBgMNIOhNN9uVvDFn+b7rSPSZwkoPCmk
        sk//HvULBDRckt2P3tPzCgCObg==
X-Google-Smtp-Source: ALg8bN5P4n4+DfMMJNHAoNZMOqXem7jv5yIqCRyMh32MVzkRfC5cRqaJdLZ1tpLrh+zWsVpPuq78NA==
X-Received: by 2002:a63:c24c:: with SMTP id l12mr4042158pgg.146.1545428754940;
        Fri, 21 Dec 2018 13:45:54 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 24sm56309511pfl.32.2018.12.21.13.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 13:45:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
User-Agent: alot/0.8
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
Message-ID: <154542875327.13075.3548703610883534822@swboyd.mtv.corp.google.com>
Date:   Fri, 21 Dec 2018 13:45:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-21 10:06:48)
> Add support to read the voltage look up table and populate OPP for all
> corresponding CPUS.

Yes, but why? Please specify the motivations in the commit text.


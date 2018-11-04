Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FAC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991C320847
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kbBynkf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991C320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbeKDLss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:48:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36002 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKDLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:48:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so2650584pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 19:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=6LaDnGSNEY1qoSKX2ys0gI3sF99pPilm1/Iuf3i8Ooo=;
        b=kbBynkf8EaBX6m9jorwJTPehkTEKx/eOLQrMXykVRZpYe4fw0yEzaX2hl7p2Gzxl26
         qe2qp3FK44xK6+t6+Rkh808RuJD6BP2SPw4tvJRy/4J7Ft7GdY2rt31dk6XFvwt/tAux
         oqS60vQ1Dl8WA7Newh749eXU/tq8iHKXUeWZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=6LaDnGSNEY1qoSKX2ys0gI3sF99pPilm1/Iuf3i8Ooo=;
        b=pKLlkjxzlsUYZUYjrSjUCZzNW5jxkf1+gfAsxzhPkSBs/2JXi3jGHHvTPkqkNBInN8
         3xLkcsccP294APBql5hYYLkc2br1fLl2vyPuZNai5tk4TBRK7iW3AL9b+06Q+N0CZy2y
         g1BLk/2hkCMDXMZB4eVyIaIrot1WE3MImtNRqFxFtQ9Vtrz6Xe8kKEzk3TN1ui+u4jP8
         A3mnUIOe8oWkotM3mSDjq90/Hs4uN2JGTVoabNEJs/RyZMSI1vCePkjleC+D56x8AH9a
         nq4YwQ36ZyqPVWRYSDdRItRzF/7DXQ5uE94cgqBijdBcPipxdGIWeWNHbi/F6y79Kyjd
         m9dA==
X-Gm-Message-State: AGRZ1gLhfUaBnD7YwpmoXnHXLwmlkNDt5qgl3bYEzjLIbpjvwX0r1xqY
        N2Y692dgbaQnNbeLQXl5MjJrEA==
X-Google-Smtp-Source: AJdET5cC2oUnRVDS4vkKXnt8Vsibnge6T51XxiO5hqmgB8FykMOCXrPpuDJJSulxYmB8zhL2vheqUA==
X-Received: by 2002:a62:d206:: with SMTP id c6-v6mr17039937pfg.143.1541298936064;
        Sat, 03 Nov 2018 19:35:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 124-v6sm51840191pfb.132.2018.11.03.19.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 19:35:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alok Chauhan <alokc@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
 <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
Message-ID: <154129893446.88331.9615390972721567018@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] spi: spi-geni-qcom: fix nitpicks
Date:   Sat, 03 Nov 2018 19:35:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alok Chauhan (2018-10-25 09:40:28)
> fixed the nitpicks.

Agree with Doug, this commit text needs work.

> =

> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---

Code is fine though.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


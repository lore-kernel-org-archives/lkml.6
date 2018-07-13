Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F28B208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRELO0R0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F28B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeGMHzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:55:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40891 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeGMHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:55:22 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so10278776ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrRAIQK4i/qTmkbZHAjg7sQQJefDHClH68u6C/ceUf4=;
        b=dRELO0R0T8ZxSzvXvlIFgGACYJ89k+aHcBCZGyyy5FR2DPxTS9FpkFtDwt3xMFNF17
         5sukbhzKZBH5o2Mxsw8kdDKxZCcl7390UvR23oe+ztCd6ABX5i01cWfsOuzBZEu3KIOl
         ATvrr1cfQJeCfUZ//Bt9H6VyOu1gBrGdQocR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrRAIQK4i/qTmkbZHAjg7sQQJefDHClH68u6C/ceUf4=;
        b=Y22lzqgbDtcihJvierUBS2xT/ob8iSZUCfuCc6FF/R39wsWq8dRvdRMR1/MV1vvKFE
         6lro3Ru3xl0z9iBB+sXpVdVZ+iuY6Ik8l7IGsSgYrHby0JeIk9UsGHYaGjZL5gCI/Jgp
         KMW+D585UZxqQmXBWboVVv0fIcqzR0hfweiPughLwU1lcmjVJ0uARl8xrCAS1cRH6Vj0
         FqPEp2Sa1+Qg/iUb42zcgrFToCzI7BD8GTP/U9RSQ9GB+pXQUIEDz4Esw4wd+V9lATJJ
         0YxMtxwLjpPX8aaNx2GF6xmbFfkEfxxGXTxG16uEMKziSZa3NuuAiXjAclA8t+GRj2yP
         WCEQ==
X-Gm-Message-State: AOUpUlEzwQ6gpfFns4oGxk7jcx0Ar2BR5dPnXqF0NzJqdJXf3VMMPdeK
        RfMNZaRM4qe/oWL1IBZizlc/6GiGRQ+2UyFu+U5dSQ==
X-Google-Smtp-Source: AAOMgpdS+/DpYE3Ik7WAcmVQ0csO1GSViCefq+cmQnUXiD+mgLjQge9MAzwf/vpoAXIBUwz8QYKEn2ELo5zrsBawCts=
X-Received: by 2002:a02:597:: with SMTP id 23-v6mr4359565jal.112.1531467717386;
 Fri, 13 Jul 2018 00:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180711130126.4090-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180711130126.4090-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:41:45 +0200
Message-ID: <CACRpkdbZZ4g4H0RNfo7PvDdnva4S+BHeZhc3Kip_X0KGOftg2A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: fix gpio4 twi function
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 3:01 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> the TWI function on GPIO4 is actually a multiplexed SCL, not an original
> TWI SDA or SCL. Fix it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied.

Yours,
Linus Walleij

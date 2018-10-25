Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7371AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C5E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z3JMMVHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C5E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJZElQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:41:16 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42467 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJZElP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:41:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id e126so6352833vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNyyp3bamUd5gte7Te0YIke570eTHJpI/AoBI0lenuA=;
        b=Z3JMMVHjZWxXhwYG9Wv9dBsvPYkI/KR4vZJfbfRiJqIT5d/uPb7OLqx1srqtYgINQC
         D2nsffzrzWachndMNB0+W0lzQu/ZSqvjKXnkVrPgELC/K2xVeYLWrEjGHkg+AsvgsU4V
         jehRVz2xNMbObgLfEIr63oAi0orIoROYZqbNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNyyp3bamUd5gte7Te0YIke570eTHJpI/AoBI0lenuA=;
        b=j9vgFl3qFxrmae7JTi0oxtPhUL3ybZlu/8ex4/7aHvBk6RMVSHxW3bacoMyR42HipQ
         ocUuJ+vHHDq4rLX2MBXKnHp8/JvBsRX+YRVM942/gq75NjCla1x9XrkEwyRYM+BStZ9O
         xMuMeQeUS1v3xAHuQO5iUAsTwms/SDU1heV1aF5nkA+cCKySYmg1Tt6jT88mgETJEord
         ceE9HOl59ci3WwA4Xx8+yO2hpAixtNAhX61A6CkDS9EMooADr8+6+yG0Thx+/TzTZxll
         +PgMDNmKGIEOdO/Ifbenx1db//mGre2aXwaJEfN1lPC7DLQ+M77LeKMAzJysSlao2Orj
         KkDg==
X-Gm-Message-State: AGRZ1gJyc8/eHPQNOszZ+JP/20zQSBtOiBG2aX40YE9w94Jp6vo278Ws
        J+P2NCHC2TBkVGWYcbT/5420uECOr18=
X-Google-Smtp-Source: AJdET5fJnYvUYM4MJ+ASgZjUEPZwRD0RAMu8WAMXYD2wo/JpyCVfKNxMcfvha+imAzvnBblG7i8qYQ==
X-Received: by 2002:a67:7988:: with SMTP id u130mr311368vsc.119.1540498025416;
        Thu, 25 Oct 2018 13:07:05 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a92sm1675825uaa.15.2018.10.25.13.07.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:07:04 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 22so1693031vkz.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:07:04 -0700 (PDT)
X-Received: by 2002:a1f:9352:: with SMTP id v79mr307310vkd.73.1540498023534;
 Thu, 25 Oct 2018 13:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org> <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Oct 2018 13:06:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUB6jxQE61eXdFQBcc45uLz5Lc9PO2K4pmOY=6PjNDnQ@mail.gmail.com>
Message-ID: <CAD=FV=VUB6jxQE61eXdFQBcc45uLz5Lc9PO2K4pmOY=6PjNDnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Simplify probe function
To:     alokc@codeaurora.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 25, 2018 at 9:40 AM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Re-arrange existing APIs in probe function to
> avoid using goto and remove redundant variables.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 49 ++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)

I agree that this is what Stephen was looking for in his review
feedback.  I personally thought it was fine the way it was but I have
no objections to this.  Thanks for following up.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

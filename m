Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3297C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E7A20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hziAOlbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E7A20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeIZD7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:59:34 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33068 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbeIZD7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:59:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id i4-v6so10120265uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXbbsKWJNukhIyFIqI162BBksTwHx2nKFkZpsLzTOY8=;
        b=hziAOlbbWj13cfe4ebZRt2Jmz5MMdG5+RZRVrePbZqosVQEe/c/+vShLtOhuDDQyqZ
         8gdXG2NABkJrfQCkMDveWigdFsN3/CF2uaZ+TBPzT17YlaAoTXK31XarFnMbIbpZYeRf
         UmHe+vljtvJZ0DHuknrG4KQedRvTLy5s7cB5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXbbsKWJNukhIyFIqI162BBksTwHx2nKFkZpsLzTOY8=;
        b=Q7wRjAb0i3u4ZfGmVNkib4uzHZZFz7N8bF6J29qBN1PeQPuW+nozJY9RUnmHXGaYL/
         FeFzh+MB9SjYb8Pv3cPo/KyyRtAh9JV3aat2XwGD1HDgiQRAz0YfZcz/XM2a02eK1+aE
         ffncm+9gaf+6Rg0BXaJgSS+vF5L+JwyCIVf4tWKhFDM3yL7JoVqDoYFHdNcs7yR2p+Bh
         R9kX4gWMn8DJHGMSsMmo/wf0PxR/7NWzSr//h4xz/qZlFCNyTGJIODBe7f9wdETbg5T3
         lvu+H9auDFLA6HIyHGW2W0LOkpBMQ9br5qJ6REv76kv2XrjwChYKOxdJzMUYFwjAF8o7
         9rZw==
X-Gm-Message-State: ABuFfoithB+zd8e4BvDOjl1+0qiM1s7F13U0lPqYL93LUYey0wJCCh2Z
        7pNzoxrmKuwBD6yF93mqd6fQfwtcaCw=
X-Google-Smtp-Source: ACcGV62CXlqvNGG+8LMeTNFW59hl+aJBl6MR/xK1CdtERmOpgPqOwFodO94K6eZ1cbdIy+OYd64flQ==
X-Received: by 2002:ab0:51e5:: with SMTP id h34-v6mr1009919uaa.97.1537912197802;
        Tue, 25 Sep 2018 14:49:57 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id n81-v6sm550300vsi.19.2018.09.25.14.49.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:49:56 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id s10-v6so2710671vkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:49:56 -0700 (PDT)
X-Received: by 2002:a1f:9b52:: with SMTP id d79-v6mr890052vke.79.1537912196438;
 Tue, 25 Sep 2018 14:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180924235235.182649-1-swboyd@chromium.org> <20180924235235.182649-3-swboyd@chromium.org>
In-Reply-To: <20180924235235.182649-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Sep 2018 14:49:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWCrY3Kxa1qXXvYd4FM_8cAtWnKMm4mYU8zxEfQmHmVw@mail.gmail.com>
Message-ID: <CAD=FV=WWCrY3Kxa1qXXvYd4FM_8cAtWnKMm4mYU8zxEfQmHmVw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] i2c: i2c-qcom-geni: Simplify irq handler
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 24, 2018 at 4:52 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to use goto here, we can just collapse the if statement
> and goto chain into multiple branches and then combine some duplicate
> completion calls into one big if statement. Let's do it to clean up code
> some more.
>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 70 +++++++++++++-----------------
>  1 file changed, 29 insertions(+), 41 deletions(-)

It doesn't gleam as powerfully the cleanups in patch 2/3 but this does
have a few nice readability improvements.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

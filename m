Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D9ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306C21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FGYfmzvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F306C21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbeIUEDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:03:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:03:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so4994542pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=xun1qhtcz3roZQ5ZYvX/52eo5NgWPzZ45l7HSlcN5aU=;
        b=FGYfmzvFy9DgkCWfRyKRrD6HQl2IvJ3Qa2tvE2OcldLACoyyu1GnNlicrUhSL0zYDf
         /gt9w//ZGwizr+ySZu/+96C9zCHUmfj8TZNcXOuBY6cGxFH+oItruelXKbCYBqJ3GSNm
         ENzFP6aaoXfcFsda/ZkoM070eyvLyn0iN2b6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=xun1qhtcz3roZQ5ZYvX/52eo5NgWPzZ45l7HSlcN5aU=;
        b=Dguz5P/pwpx+Ad5uWdr4kJ5u1wm43d9IKpsmvh2+9H59d4+MB7vg6fl43hecIVCUIz
         WLJZ/7yriVvbMr/1BbqX8ufwjkXpZI71p26TNKBOcD6scamFTpclon9lFyLidIDgJ/fi
         /0AbNqB/+X5FBvgjiXLQDSWvIqhxIg8n6fHlFDEdbqamKkUx4WdcwqCqD6pXGe8js7dL
         gX0gwvCMBx+Z5SSPJFtOoX6wKiZKWoHQQ+cV1s51k63pu4+EgUPfsJvEKozgWwZEDD4J
         NocBXpX9u9wVDpo36A8p5HP9QKme6AeK5MqhPPE9B7kalHbX0qZedr2UULSNCLkJwpuY
         QRvQ==
X-Gm-Message-State: APzg51D5beDTr+M39RWNhw5/5glRKlMaUGTE5wP0hkfKDgaxsWuPY4ub
        hdzpbpXyeRFoiC6YfR4ntsV3iV7lBzQ=
X-Google-Smtp-Source: ANB0VdbV2j8hofSRq9FP6qLdKAhDCINx0khgbh5O3FGwUzFnUnT7pED/tOqNFF1AGPv/LUI4/HD3MA==
X-Received: by 2002:a63:c046:: with SMTP id z6-v6mr38775962pgi.114.1537481890799;
        Thu, 20 Sep 2018 15:18:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id j187-v6sm3949294pfg.108.2018.09.20.15.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 15:18:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=U=r0nkT+JO2j4WUHF03ZiJcmaVrzL6dsauDHV=a2m3tQ@mail.gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
References: <20180920180323.217377-1-swboyd@chromium.org>
 <20180920180323.217377-3-swboyd@chromium.org>
 <CAD=FV=U=r0nkT+JO2j4WUHF03ZiJcmaVrzL6dsauDHV=a2m3tQ@mail.gmail.com>
Message-ID: <153748188889.119890.3818754688788845202@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] i2c: i2c-qcom-geni: Simplify tx/rx functions
Date:   Thu, 20 Sep 2018 15:18:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-09-20 13:22:37)
> Hi,
> On Thu, Sep 20, 2018 at 11:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > We never really look at the 'ret' local variable in these functions, so
> > let's remove it to make way for shorter and simpler code. Furthermore,
> > we can shorten some lines by adding two local variables for the SE and
> > the message length so that everything fits in 80 columns. And kernel
> > style is to leave the return statement by itself, detached from the rest
> > of the function.
> >
> > Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> > Cc: Sagar Dharia <sdharia@codeaurora.org>
> > Cc: Girish Mahadevan <girishm@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/i2c/busses/i2c-qcom-geni.c | 54 ++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 29 deletions(-)
> =

> I didn't hate the old code, but you're right that this looks a little bet=
ter.
> =

> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> =

> NOTE: now that you're cleaning it up, I'd personally go even further
> and totally get rid of the "mode" local variable.  Basically, just:
> =

> dma_buf =3D i2c_get_dma_safe_msg_buf(msg, 32);
> if (dma_buf)
>   geni_se_select_mode(se, GENI_SE_DMA);
> else
>   geni_se_select_mode(se, GENI_SE_FIFO);

Sure that's fine. I'll resend this one patch with that squashed in.


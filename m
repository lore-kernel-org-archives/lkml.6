Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3740420877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NS8BDwoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3740420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbeIUCIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:08:05 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36090 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbeIUCIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:08:04 -0400
Received: by mail-vs1-f65.google.com with SMTP id z19-v6so3614238vso.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0UHkrMeqzjGAB7Qhv9NjOQHsZUZ6DsGCn2pk/SeNP4=;
        b=NS8BDwoCYEzhIo+uBJXh9pFMzPwBhK+lyn3Iu1SjJAiUjh/CjhLejmCtPjyJJGm72p
         jgLwb8nesVl8cobGALXIyc9VjuKeFx3Gdzx4++mNOfZH+VXCEyhm5dgV2H0Pk8sedS+W
         XiVBc7IfomU4yJbnpUkuj+2tKOnV88SPN7ILE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0UHkrMeqzjGAB7Qhv9NjOQHsZUZ6DsGCn2pk/SeNP4=;
        b=QLxbLTFv76nGaVXfHXv+VrYYNtPdnbIliqxQqDE8qoUjmckRGY5tfZgpj/VRXdYJGu
         Y71CuGubrWaznJsXJTvCKWuYzFWFz33fEXcJZi1tmHBHGYHRPhfIX14BLcoRkWFCQNna
         Bt4PLLcd1TC1TZJGVav+XmrAdZQ0MYPlefe23gSQpjMlEoROsGChwRK+4HEOqXqq+eRH
         Ayqeqex1XgSlLu5oLFBZfV1CruQNvRF8Uc+zFC8X5TUvhNlpK/Xbd+EmswiRnOWDD7Ai
         DK3gDnQy/bbojbdeJ29jhNBQLbiQP1MzobElK7IumeeQ+fs3xntpGTHMP8XIID5hbkG2
         qEuA==
X-Gm-Message-State: APzg51DfehvomLMQpznf50yekeg3X4ZiJGlwm62UbLNDbP8y8SmuOL6y
        Rqwvxio3vl8AXFVBBaPvcluqU35U5jI=
X-Google-Smtp-Source: ANB0VdbyIMOHt6z4NC2u1sZCLlk4yLdjzds+W+QvODQJ35Y91UVGs7rsEfpTW26yoAxH19plBtV4EA==
X-Received: by 2002:a67:4690:: with SMTP id a16-v6mr12743322vsg.35.1537474970821;
        Thu, 20 Sep 2018 13:22:50 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a20-v6sm2219470vsi.3.2018.09.20.13.22.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:22:50 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id w7-v6so5049784uan.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:49 -0700 (PDT)
X-Received: by 2002:a9f:35ec:: with SMTP id u41-v6mr13697372uad.86.1537474969478;
 Thu, 20 Sep 2018 13:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180920180323.217377-1-swboyd@chromium.org> <20180920180323.217377-3-swboyd@chromium.org>
In-Reply-To: <20180920180323.217377-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Sep 2018 13:22:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=r0nkT+JO2j4WUHF03ZiJcmaVrzL6dsauDHV=a2m3tQ@mail.gmail.com>
Message-ID: <CAD=FV=U=r0nkT+JO2j4WUHF03ZiJcmaVrzL6dsauDHV=a2m3tQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: i2c-qcom-geni: Simplify tx/rx functions
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
On Thu, Sep 20, 2018 at 11:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We never really look at the 'ret' local variable in these functions, so
> let's remove it to make way for shorter and simpler code. Furthermore,
> we can shorten some lines by adding two local variables for the SE and
> the message length so that everything fits in 80 columns. And kernel
> style is to leave the return statement by itself, detached from the rest
> of the function.
>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 54 ++++++++++++++----------------
>  1 file changed, 25 insertions(+), 29 deletions(-)

I didn't hate the old code, but you're right that this looks a little better.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: now that you're cleaning it up, I'd personally go even further
and totally get rid of the "mode" local variable.  Basically, just:

dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
if (dma_buf)
  geni_se_select_mode(se, GENI_SE_DMA);
else
  geni_se_select_mode(se, GENI_SE_FIFO);

...elsewhere just continue to use "dma_buf" being NULL to mean FIFO if
you have to fall back to the FIFO case you set dma_buf to NULL after
calling i2c_put_dma_safe_msg_buf() to indicate to later code that
you're in FIFO mode.

I prototyped this up and the net-net is one fewer line of code and
also the nice consistency that you never hold dma_buf in a pointer
after you've freed it.

-Doug

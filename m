Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5264BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F138321797
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ot0zMOmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F138321797
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeHHUfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:35:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34441 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeHHUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:35:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so2471819ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MT79x9l+qk8s431aWejidU7i9OwBmIlJ9nJycvj5p5M=;
        b=Ot0zMOmfjtiR4cLiATeHQ6aLLrb6jf8vAbmKXqSVFlgYdbyhHZVOMWOQJoGaNy3CWL
         KK56LnCNOI25tb8DsSRHXTbA4oTvnyd/j0zMWRM1xqIqg+os3pxEkO6RUxx7PQWt9BHg
         /07Gu8+2D/9I4vIMhSy6QsjnZ1fkT0fCir7as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MT79x9l+qk8s431aWejidU7i9OwBmIlJ9nJycvj5p5M=;
        b=Z9t9oNIcoxLOD23vG2WCMDDX/+lCc4yyqTBSC7kP56r2TIFQdBCH5V14cdhN3nXPkh
         BYdf8/mHQ9Q8feJhG/ww2YEvrJH+0dtxIuDD3Kw5FKWKApADLJp26Wg1Jsfo1SSCBhvh
         2qzjVk0tKNWwDOJCLhJwumfWUmKTed8dhCjz6ZL3DEmeTA5KU51rEkjjeautbDI+2bPA
         +3sLpVzuJnEUJxzJIVV4eCuO5qwkSyytDwDFpxEPAS0e9pmnh/Bf3WfGIK/Q57b8GGRp
         w9w6ORXrOLq6gxiRWCWjgeodkRv5sqZMGbvh2mFyVkcD/8Ah9SjLX7wFDqecTeMWAe0y
         NN6g==
X-Gm-Message-State: AOUpUlFZS/OPXMcXwg/9XdZuh10X8JGvylivPzYRtVuyCfF4TDHDORd+
        ocEkhrq+VceIjy/Ow9ZHv2vJNEApbTQ=
X-Google-Smtp-Source: AA+uWPyr+rSNu4Omvkbxw+GFgdNB6ZcOTVsfWhUC9DbvfMkQXpnxPXdxY/Z9MNYitSIshfx9YIQsUA==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr2712146ljf.102.1533752097355;
        Wed, 08 Aug 2018 11:14:57 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f28-v6sm787776lje.61.2018.08.08.11.14.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:14:55 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id l16-v6so2223525lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 11:14:55 -0700 (PDT)
X-Received: by 2002:a19:290c:: with SMTP id p12-v6mr2547332lfp.124.1533752095311;
 Wed, 08 Aug 2018 11:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
 <1532971432-16784-2-git-send-email-kramasub@codeaurora.org> <20180731192004.acg5jnbj5wg55mpl@ninjato>
In-Reply-To: <20180731192004.acg5jnbj5wg55mpl@ninjato>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 8 Aug 2018 11:14:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft46X7Pwufd0w2KCGmzviC1Gn2JLxUWTmSaYeLkYRi3ULw@mail.gmail.com>
Message-ID: <CAE=gft46X7Pwufd0w2KCGmzviC1Gn2JLxUWTmSaYeLkYRi3ULw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] i2c: i2c-qcom-geni: Add bus driver for the
 Qualcomm GENI I2C controller
To:     wsa@the-dreams.de
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        acourbot@chromium.org, swboyd@chromium.org,
        Doug Anderson <dianders@chromium.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:20 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Jul 30, 2018 at 11:23:51AM -0600, Karthikeyan Ramasubramanian wrote:
> > This bus driver supports the GENI based i2c hardware controller in the
> > Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> > module supporting a wide range of serial interfaces including I2C. The
> > driver supports FIFO mode and DMA mode of transfer and switches modes
> > dynamically depending on the size of the transfer.
> >
> > Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> > Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> > Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Tested-by: Stephen Boyd <swboyd@chromium.org>
>
> Applied to for-next, thanks!
>
> As discussed, I squashed the MAINTAINER addition and the RPM fix by Evan
> into this commit. Please check later that I resolved the conflict
> correctly (once I pushed out).

The squashing in of my patch looks good!

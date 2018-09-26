Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA47C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A537020685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgcniTQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A537020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeIZNmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:42:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50188 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeIZNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:42:04 -0400
Received: by mail-it1-f196.google.com with SMTP id j81-v6so1681609ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXeBHRcSNresoy543JnyQTVC14q9FdIl+nms9b/1YxU=;
        b=ZgcniTQMSGvE6LBULEpVhHK7Cb9J+xLv1X0dAPHZWdUcd1kmz2iMYqXIVcnSljJWPh
         PepQuEI3LzOXGpUZN2BoBU7OYmjtbZah9/CmHeN5ERPfPohzA6PWS/h497zTPdDwmxOm
         EZ6XLjMSCYLOSWYNp8rbd1gP1rbHCBkz8FbKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXeBHRcSNresoy543JnyQTVC14q9FdIl+nms9b/1YxU=;
        b=V53hSRCcbvG5PPk2Mk9BirVyRYeMCadLl8iZ0RcLzwCdbAtVvtA+o+RaSgzaeUSZyN
         uWbIMarXILAnR9bVLva5pueZHqb7T1dmRYHHjUCFAM7L2tjGNpZG9NLzs5kYehL+XXV4
         fURFJaCa4Z17pEAiIoC2IE4bjSzjwqC9/FoFQLmCLTMezgja9d8koDsQsKKivh7dl6bu
         0gz9izwm+ycUAf48LD8KWT/7lUok4ny+ihR25If1/TwwBF4rXy3sR1ISbZA4Rv9fLeMO
         UJIRuQSn0PjjtV2wRF0IOcuejwfVaBxr7/qrHBrHV7tOA2TIQEhJ1JWpElfmy634QFU3
         ahWQ==
X-Gm-Message-State: ABuFfoi8TIP9cfp4cgH0UUl1+fwCba034bj4PLgG7gKLADKCxBr/F5M8
        OZBKiRI+mBmNWZ9yd4kO/6MgG7jiyWJvI9+IuMz1hw==
X-Google-Smtp-Source: ACcGV60fyDld2yg9xI42WE3PZNnfOB6VwHeL89cFzUGN1875DbOkIf3pRz//CDzlg9R1Ap/l76SIKdEsAtJO6AuwvFY=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr4459965jab.87.1537947031161;
 Wed, 26 Sep 2018 00:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180924221748.21584-1-bjorn.andersson@linaro.org> <20180924221748.21584-2-bjorn.andersson@linaro.org>
In-Reply-To: <20180924221748.21584-2-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:30:19 +0200
Message-ID: <CACRpkdazp0TNkaHufedgH5vBVjgy4DeA_Jw7XJj2b3cTJZJ8cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pinctrl: qcom: Introduce readl/writel accessors
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> In preparation for the support for dispersed tiles move all readl and
> writel calls to helper functions. This will allow us to isolate the
> added complexity of another indirection.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Rebased onto "devel"

Patch applied.

Yours,
Linus Walleij

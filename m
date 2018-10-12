Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAEBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F682086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDQji4bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F682086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeJLPsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:48:31 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55358 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbeJLPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:48:31 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so17516875itd.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMmrgELM0EOpqrClWyzxVHq2KGRABZMtIJ/PbthJ3EI=;
        b=fDQji4bJC8QwX901rQB2rWOnUGa6ML9lUxs125ufs0BE8syg+PzF4KlifzuCG1T93W
         SfHd2Xs/bi8GRYU/u53RYUx+dJgsNLmy7ntaoRBnu+6UmGRg35DSzrFF2/5uewRZbSfb
         KvNv7TXzX5xvqFoQgpCKXfbZglb8ifsqSSkMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMmrgELM0EOpqrClWyzxVHq2KGRABZMtIJ/PbthJ3EI=;
        b=MW3JNnfMa2Hhqn5PXpp9ohxPUo7KNw20UEjkIDvTC+EzA7xPwOg8+VcIgA+gAw30xl
         KD3jiJs01+vo0rYehR4tWEdlXVuRIrBmg5x4qb9X1k+eWgIgv21wKJh62461FQ4dhzTW
         Nl+Ipgz96iRCC1+S4XCsdaRQegj5xrykZ8dLmvIC+t6/5UCSQVtqb2nwX0Mx9Ppsrnez
         D85UpizfX3hvRqZ3UND5ZmhV7HuQ1waAYEYm1JCQFKOVJP8c+4dd9ZWiiuE+LuTnvo8a
         dObWSmM/CTGVaPnM/VAtngGGoF5lA1mJW/Y9OsAU2CFHO40EwB8rx5t3VTX1LF4Dg0SF
         3Lcg==
X-Gm-Message-State: ABuFfojg33dNED6CsgwVWJKhqRAvfIcJcSuYLK7HC6s6PorHx+pBqM9d
        WHLgZs5vAelUcbdNYB1z3YFLNXyWJI00d87DbXxRCw==
X-Google-Smtp-Source: ACcGV61xlGfI8Kf0PfwC4wOttGVk8l7aX6I610kuZA2QOmcTCj6rQwJhjoMyajDrbs5SbZuLKFhhmSk9pBvdQP+KO48=
X-Received: by 2002:a24:e0c8:: with SMTP id c191-v6mr3114723ith.156.1539332233838;
 Fri, 12 Oct 2018 01:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181012061136.11421-1-ricardo.ribalda@gmail.com>
In-Reply-To: <20181012061136.11421-1-ricardo.ribalda@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Oct 2018 10:17:01 +0200
Message-ID: <CACRpkdbnNh6bzD_zp+Dc078c5Bi6JMTZRu9k5BZDYApS6kn54g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Initialize gdev field before is used
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Vignesh R <vigneshr@ti.com>, jhugo@codeaurora.org,
        timur@kernel.org, Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 8:11 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> gpio_hog depends on gdev field being initialized. This patch fixes an
> OOPs during initialization of TI's AM335x-ICEv2.
>
> Fixes: 3edfb7bd76bd1cba ("gpiolib: Show correct direction from the beginning")
> Tested-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Patch applied. Thanks to both of you for sorting this out!

Yours,
Linus Walleij

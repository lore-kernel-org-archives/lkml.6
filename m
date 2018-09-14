Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D454ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6D920853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Swui+hZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6D920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeINOLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:11:32 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51156 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeINOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:11:32 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so1620809ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvgQUnJj70BPqpljkzkXFgnEwBeqV+W9s/ldtoAjVbI=;
        b=Swui+hZS7cOzfOHlEWwPBCIGbddGA1BtWSBNRXsDifeqPS65ReX8s23WTHTmZ2/+f2
         ei/PrRePaVKFzyC71gvtJBfT9NJb/4NMrZCiZaSiE9tT44zqj48uMUOq34sr74mPWRqa
         1davvK7kgtySF91EfevMLh2GS6uT8DoclP3NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvgQUnJj70BPqpljkzkXFgnEwBeqV+W9s/ldtoAjVbI=;
        b=h4jb8Xdg6wXwEOQnNAUc1Gv1xgLQt9tbKP0uLRp6PtaHtq3Hf19R8/OsRkx9ppAeYi
         uM1RD7mxCFClFFj7ZAjUIYxB1dvEpFlQpiaIEEh6+tOeFknU1x8jLxYhzzwDT89e87Cv
         N4ubh/kDslBRrJioLy84Y7zFHmPUxaulklWCRKrsWMCeE0zdnjRHG1eGae5KrdcxNPgf
         Empb6zrNEWywDQfTge2Y7n0mjHQr6xr6BF8ggXiVkeeNSepYOgLOLrIZCRArSFXSHjN2
         e549W6X2t1HF8lWUQlm3qZflaBp7ImFTtTsgwq/Zua13WVxl7u3hqxhs7yXpwNjRwqny
         LKrw==
X-Gm-Message-State: APzg51DGU4/Q+REpyq7jpL7ZFlV/3f+mvGm5LwpylRL6PwWWBc9AXEki
        fSQcaORFxw5+gcfKR0X4ZMaj/c1e12wmUNaLNv017g==
X-Google-Smtp-Source: ANB0Vda8n338l/jVZ+Uil1xrl463TdituOIX+FYvFnHYpLSlHIoEHM19tqq8nDg9zEhaoUqafpeuF7uW4Tk9+3NVT3A=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr1505304itd.130.1536915481001;
 Fri, 14 Sep 2018 01:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180913163541.7364-1-jim@jtan.com> <CAPybu_1WO8jcJbKJfiyCcfTahtxqSvdvyhyYaZsog05ab+OXWw@mail.gmail.com>
In-Reply-To: <CAPybu_1WO8jcJbKJfiyCcfTahtxqSvdvyhyYaZsog05ab+OXWw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Sep 2018 10:57:48 +0200
Message-ID: <CACRpkdYnOr25e93hMN_hPFK1vO=qCsfc0jZz91qPx8xH2Ca+cw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix freeing of descriptors on error
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     jim@jtan.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 9:56 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> Hi Jim
>
> I have sent an identical patch 3 hours before you [1] ;)
> Seems that we are working on the same stuff.

Haha w00t but I'm grateful that you fine people are taking the
chardev ABI for a ride!

I recorded Jim's contribution as Reported-by on your patch.

Yours,
Linus Walleij

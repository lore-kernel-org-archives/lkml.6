Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0EAFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896CF20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFmLgdhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896CF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeINOJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:09:43 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40379 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeINOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:09:43 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so1592411ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRAsTkxmhRzoYhpfLe7xkP8JVKRy7+i8KLCig5Sggsw=;
        b=QFmLgdhZpzKxiI3xlP2GEnpCU87xvrTGUdDRDC8fWJjmkxovJkGdTaTrcxb7yBHrnd
         AyJtk1dkJYe/DQkIY1KiWjXvI20f+sWC5sXds2KlOGPnGPOFrQIRSd3thE3Wba7O9wf3
         q7CTkmwl8eA5VWV6QRAYdfXeP/aDwVmfIGtJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRAsTkxmhRzoYhpfLe7xkP8JVKRy7+i8KLCig5Sggsw=;
        b=OSnkhyrhIeojwl6TSMFWFkCDIF4jKpfOVv7YnX6g0NRhKE8f1BShmigeTkPFFYFzQZ
         iN8rJmwMnY61MWPOYk2cS9jEKYQ5jz1KdiGCEARTY1Vmx+COAaT9p8Ke/08VwqXd6T3n
         kUjTRjxjccWzJrsDEPvh3b6Tg2xpylsYv4uS5pw9yx3w94I4GMM/9p3/S3SQB48C1G5n
         jJG0FdOiUuAPNLpOiJdeufEwDteWS28kC+mIsaSj32EFw5qEQ/XmBFGS+9KhZZxERU3P
         WIxIWlSLGtuFHxXjFzIQzjoNdECIegDzDrkvTlfrOhbRK+L3hTtG8BBXw63noVn4qVO1
         lQ+A==
X-Gm-Message-State: APzg51BTLhzg2qViHYmHs4A4cxiyxhOwisAhZ3gkTJx0WYgbbngRsW4G
        zrY+9GWMNQRoXKnxwXwRuXZVbL8tAT5Ymdh1V9ReEGZa
X-Google-Smtp-Source: ANB0VdZ4qeAFpUHLTod8UDKe61L9CzitawjNMmRZMgIqe3/AfbI8NqVLZgxNbTHA3DgesoBb3dmfGaeH0RCd3Oo0KdA=
X-Received: by 2002:a24:7044:: with SMTP id f65-v6mr504404itc.62.1536915372011;
 Fri, 14 Sep 2018 01:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180913133704.15739-1-ricardo.ribalda@gmail.com>
In-Reply-To: <20180913133704.15739-1-ricardo.ribalda@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Sep 2018 10:56:00 +0200
Message-ID: <CACRpkdYgC7Z79c3swKE=ZwEUfVTC+oijKOqo5HwVdXLOsTT8Mg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Free the last requested descriptor
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:37 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> The current code only frees N-1 gpios if an error occurs during
> gpiod_set_transitory, gpiod_direction_output or gpiod_direction_input.
> Leading to gpios that cannot be used by userspace nor other drivers.
>
> Cc: Timur Tabi <timur@codeaurora.org>
> Cc: stable@vger.kernel.org
> Fixes: ab3dbcf78f60f46d ("gpioib: do not free unrequested descriptors)
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Patch applied for fixes with Jan's Reported-by tag.

Yours,
Linus Walleij

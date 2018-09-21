Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF32DECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8899121565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgXTE8Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8899121565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390507AbeIUWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:01:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41625 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390111AbeIUWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:01:26 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so12788096iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OT32QokYZZ/rx4athmT8N45z8YhkrhdsSabdQ6jchvo=;
        b=dgXTE8YjKbjUKqFr4hlYlIN6OlGficMCKzFsmEEoW++L5wX0xUoOgG2EfWxeEPVUYf
         VsQVxNcw8eoVjZlnNlfxb0qSTxQ/zMiOS5l5C51kWHfAGdRZVxRVWM2bv8I6FRdMiV+T
         C4Ogkzt9kNS1vaVJflQFszAPuJk9dNrAijQH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OT32QokYZZ/rx4athmT8N45z8YhkrhdsSabdQ6jchvo=;
        b=FyZPTIcoKK8skU13R0xXy0eUorO5u+ygGmq2mhA5kXk429k+lQXZRanZTRS0xQY2O+
         CBl5OAImhX8BA0TaidUUE6vdGbXT8GhjWUJXehSDTHKa7aHEp6XJJPmX1YtmLtDR5CTp
         swF1HpSNvXBriWrmDc33sxJWiDnLuRy0Mw+gjtgSM+8pyQ2mweBdquZ24bPJf8vAUqYZ
         JwD7e5cGLw8uKydbPEjdGbUymQxz8h6DiDRUgpKqDwfZlNdOoI4LWTq11PuMZGILdwar
         z/zqG2JOZnYEMMrrmf+vld+oR5syNo7RBX0P+r7PfrvykSKfrEAszHw5EAcEQXxHFsjt
         +o1g==
X-Gm-Message-State: APzg51AQgIEt43ygwlXb9ghtde8eHssDF5/RJrhVTVr8/LiVTK5opXEM
        HacCtA6wCp+C9yBS5gv1ndJ30q3VK8M8lAjc+AAvyazL
X-Google-Smtp-Source: ANB0VdaQ3ERPqYUGeMCT1NSR8hcCbba9yuSd8cgbR9Gsr+8pNrfyQ0hZdcxBjayMKdgsxiic9QEtgJgD+2PY0aZGp3I=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr24970828ioa.277.1537546311538;
 Fri, 21 Sep 2018 09:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
In-Reply-To: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 09:11:38 -0700
Message-ID: <CACRpkdavhUsJkd262rgjk=2RdHVrdmAi+8JHGBMHEDv_w=gnVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] pinctrl: mediatek: fix static checker warning caused
 by EINT_NA
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:07 PM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> EINT_NA is an u16 number, so it should be U16_MAX instead of -1
> to fix up drivers/pinctrl/mediatek/pinctrl-paris.c:732 mtk_gpio_to_irq()
> warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> Also happens in
> drivers/pinctrl/mediatek/pinctrl-paris.c:749 mtk_gpio_set_config()
> warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> drivers/pinctrl/mediatek/pinctrl-moore.c:479 mtk_gpio_to_irq()
> warn: impossible condition (desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> drivers/pinctrl/mediatek/pinctrl-moore.c:496 mtk_gpio_set_config()
> warn: impossible condition '(desc->eint.eint_n == -1) => (0-u16max == (-1))
>
> Fixes: 6561859b067f ("pinctrl: mediatek: add eint support to MT8183 pinctrl driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij

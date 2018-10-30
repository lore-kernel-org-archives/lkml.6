Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2288C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689282081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJ4j8XZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689282081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeJ3WIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:08:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35279 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeJ3WIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:08:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so7090271ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vl0HyFr3dq0xQVM/zfnWXgc5CNEk/3xLwfWTWcjCfpM=;
        b=JJ4j8XZ2tdFyYpuFoIPjw2YmQf3nqmlqW9urp+DQfv/5eCCBK6dUsqtQbchxLci7X0
         5aTuNZrzobGaq3AOhO66ayQjKOYu3Yvf9tqcntOvxZou2VQsvYpQu6oTywlg4LfqRrj4
         w/RqC2wFqCdGOfXRP6yvbSaaYc/d5ZNQp6eWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vl0HyFr3dq0xQVM/zfnWXgc5CNEk/3xLwfWTWcjCfpM=;
        b=j75ywN3m/01DTqy563uKuvwAVZuPkneOuNRF7ZsAsCd9Xv5IUGoludcRho1qE3xQdz
         savDYvyn34rV2iCcv9akMn5Va5XSq3VX7LOC4PPO5mv848ABPhZb6bBRv/qtCP9c6sPe
         JchVtCbrYf+p42G9Kf+B45Brfj6lMijZDNGWglcdqrOI/mVNAaj7PR6TgknLkp71SLXD
         TgYmIglWEYFEvZI6mChImSFnJjUV5fj7r8CTm70IEmFvcDlhK0v6jNC+LGdi5wdNAxbZ
         IAaWof528gjLoVFGrJosvceyibyuKCThHXAs9pFWpgAXBOniVMNvuO02CMkMJ8wXoJaX
         pFWQ==
X-Gm-Message-State: AGRZ1gLfSvWOKhxh38RsgTVgOunqRAKNb7DUZNt/AA8Dv5Lh8YfS96Rt
        GWSwAkjzu7v343jU5AefYsq5YY0O7A6tAZRQG/fTAw==
X-Google-Smtp-Source: AJdET5fhXz9EL2zqpiN3RJTuN2TmQMylKbSbJX6DNd5sHBiD6cuZ2VDrALTuBCBL1XGlm6KVn5cG1YWUSGqR+3nVkvc=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr5304951ljj.9.1540905326421;
 Tue, 30 Oct 2018 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com> <20181021200002.1472-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200002.1472-4-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:15:14 +0100
Message-ID: <CACRpkdb0fkqK5fVKhN4+QDbO=6ex4V0kwXgERVCua7NSOjfWqw@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: gpio-mxc: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied for v4.21.

Yours,
Linus Walleij

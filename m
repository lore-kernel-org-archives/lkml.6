Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E461DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86E8206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iz1LApfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbfAKMQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:16:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43557 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfAKMQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:16:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so12728426lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJvZ9aA7kxJjZFLo1RF/B2VvSXiNkbAu9KeR5An6hXg=;
        b=iz1LApfXrv4XxZ+SXzgkPFB8g6QClp7K7ozwAW1s1F4nkJlMRyfchOPQGBuOL2aW8F
         3u/CLsz+DQlU0nmKCm5ZH2t10gvdNFtDox+2pry5MYpPdp3zmf1/ZDQrPp4mKUWngaKv
         +Z9q8oRXBz0f7TAM9IKypRJFffAh62uExhjVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJvZ9aA7kxJjZFLo1RF/B2VvSXiNkbAu9KeR5An6hXg=;
        b=QG8xpMfyVrHaPqgodydMLP78O4AUnbs/GudljL6do0am9WLLmuw5SC8dlEEg3u3lUx
         uzM2xzBbMbzDzeb4hRkAbRV/XhbsiJGGX7b+smdbv4zod3Xu2DPsWlFzhGUWWCxQwYop
         /hHJuGEsLPns3PB18aOS2C+A9I2RQGgQqkdFNptntBg7uz/G/fOgF1oYzo9nL85tO7Ap
         LNG3bn/oB3+gokNcyXAktkNypvgaKK+o3lwX66dl0iBYwxaUajfp9IBcIYQNLf9JrHtB
         b4Xp177QiaLiwN6mJCuXpdR/dRNHokKmZTMBYl0DrY+KQoY7mCdRqYjVellVOLvf4dZX
         dsuA==
X-Gm-Message-State: AJcUukdbPG6IB1N0xiF2+VHWqoST6kbGxp3kyU+RSUA47z0rjgRjMWjp
        H/DEyKuNbJjjXxqjoESLTUoYlTmketkQBmO9gtFrWA==
X-Google-Smtp-Source: ALg8bN41O3reEE+JTtBEo9wmOu52QK/F0wo/fZAIr5YSpubH6XUtUqJfyDFNoBgO3RbPfsOkv98W822XrAfXo/jTjCQ=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr8436654ljg.23.1547208966250;
 Fri, 11 Jan 2019 04:16:06 -0800 (PST)
MIME-Version: 1.0
References: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 13:15:54 +0100
Message-ID: <CACRpkdaF+PFv-oUkLiWT7M2hYESsAYxaPN5OM2=XraeAx9zP4Q@mail.gmail.com>
Subject: Re: [PATCH v5] pinctrl: mediatek: add EINT support to virtual GPIOs
To:     chuanjia.liu@mediatek.com
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        youlin.pei@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        hailong.fan@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 4:38 AM <chuanjia.liu@mediatek.com> wrote:

> From: "chuanjia.liu" <Chuanjia.Liu@mediatek.com>
>
> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't need SMT.
> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: chuanjia.liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v5: This patch is the same as v4,re-upload due to
>       mail permissions issues

Patch applied with Sean's ACK.

Yours,
Linus Walleij

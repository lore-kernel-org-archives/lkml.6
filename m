Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986AAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238527EF2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/k4YUW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5238527EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbeF2McI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:32:08 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35172 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeF2McG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:32:06 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so8295721iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gitJUPBMpjX9IO3H5ctZ7Zgia/d5i4dnaFDBXBkGLVw=;
        b=T/k4YUW0GUMHUDowVye4y0SPWCxN7QKjkRVZRqOrWhoJocF878pHAcq4YqLljZUz4M
         x5qTS9xPvyTYgXGkMEZmsDVoPcvzmld/O42XE16I0wJ/sINv33JnsMYj1ayoU9bjtJm5
         0vWikuE2bbTJ1/Rky06/8F65obdAftcDG0C5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gitJUPBMpjX9IO3H5ctZ7Zgia/d5i4dnaFDBXBkGLVw=;
        b=h7XWVDuy4ERLwO0xr9kif/VjUbePdjq6rOdt79ownoyyfQqBwUkytEo1r8uNmGgh46
         c0ZTrRuKXDolFKE0l8Eg11rIKQ7oxI2jlUWCFEAD1TnVAyXIRN4+Fc8SQbkhfzznqWbC
         Ab9vlrP3p7iHjdQxV6kiRicAbibnyGSz4h/GhiFNW5Y78ZjBam/PxEMkfGd5pPEAHKbe
         wPsUZp9LYuWEWRGoK0z9kdcM29mV/lY+tq6TQXnKvJiuDds9ccrpmhmh1PSNCyWnIZ45
         QCeOekoYueoFnBfsXJlDRKatfbqn+qZaV+GlyxJh0Vi7Fxh4Tdx4bFAfn5TVv/Yvz6Lr
         RkTg==
X-Gm-Message-State: APt69E0BC5Y2THJCatZhaBkyUgKxNqLPYsYXZpAcaj5FAH1bSOMSzPLP
        K/ukbms5Fg9RCK7/fScoUF0lD1sV35BPHWGBMKDSIZBv
X-Google-Smtp-Source: AAOMgpdqfbrw0tywnxQNmNcoU1YJFmKmM+Zug3Hl994DCvd8Bd+LCTtvHY9m9e5a8hU7WMGRkHD0fAi5/MtyF/jBk6A=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr11863570ioh.175.1530275525873;
 Fri, 29 Jun 2018 05:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org> <20180623045954.6729-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20180623045954.6729-4-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 14:31:54 +0200
Message-ID: <CACRpkdZcUJBsb-P5eT3PcYe1ukYCU8OC95pBbR58wYXutdT1JQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pinctrl: actions: Add interrupt support for OWL
 S900 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 7:00 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add interrupt support for Actions Semi OWL S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied with Andy's review tag.

I really like the looks of this!

If you have ideas on how we can move more of the multiple
IRQ parent per-bank IRQ into the core and make it easier to
use, feel free to contribute ideas and code :)

Yours,
Linus Walle=C3=ADj

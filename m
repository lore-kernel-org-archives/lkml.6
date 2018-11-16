Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606DCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5862086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcFC4Kse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5862086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeKQI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:29:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36843 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeKQI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:29:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id h192so17568807lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDGTliiTeNUWqk9ilnkUQ34m5eKTjEV95kgvWFV8vu0=;
        b=EcFC4KseWIsIXJdtUmyBS8OOU5m5xKz9I3ggARhba1SYZPV2W1keo9XjiuF8/Fvg62
         TvtmIJses2PwdNeiHeY09x6MG04rK92kKUsZ+yAey6i7FRsusj9SxvPXM8q5L6N/JM/T
         uXuxHBr9o7cZrmupv4mtXvsDwW54QXl432UwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDGTliiTeNUWqk9ilnkUQ34m5eKTjEV95kgvWFV8vu0=;
        b=UC7VRJSGPqWDQ8XF2OcTz4Jib+8WJY/ZI4NPpnBr7lTfAgh1PS8OiLsUEiKXzWcdyh
         ocTFWeH6PPTnplH5+r8qgmlzGPTISCZcVNB6N0MiR5+lle7vpYAGb6TENtoC7Gm6ZEJY
         PHC/DgwYd1Dm5N4jAEped5CdndRdlIOdKQrXV3D+YLCNXDg6mj2CpOToy74Ce6XmG2uI
         E1SpsAGYWjIyNsu920iHu0vIWb/lfIWvPc2XgHXhDw824SV483ka3L8zKHBloCNyHvaM
         4spL6Baof6v5rMAG+Rb8y2LvkU+iI+mdRrvREkP9SIw3vLJzgvR6naRt7dGM4c6/X/DE
         9KBQ==
X-Gm-Message-State: AGRZ1gLtDZrSFS7qrJHI/h5COZoanUFZMHrQ8W8R5f/LCZQKNHzZUYMA
        L4Xvl6F3MNnyKBbrIuU9BQDFdOFhO52CtDpPCe3tcw==
X-Google-Smtp-Source: AJdET5drXYLLa6ImoMIrC1TJiHq8m1olmETscOLDqhfsm7QNh4xQOcCyJxCWs1NhtXdfygN77CumtQYQljtj2EqA+M4=
X-Received: by 2002:a19:f813:: with SMTP id a19mr6236987lff.67.1542406501297;
 Fri, 16 Nov 2018 14:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20181111013411.14153-1-masneyb@onstation.org>
In-Reply-To: <20181111013411.14153-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 23:14:49 +0100
Message-ID: <CACRpkdbdEkegcMMmwAQdAc=_n7vcu5M1KGx9KfgvFKbk4ZQ12Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: ssbi-gpio: fix gpio-hog related boot issues
To:     masneyb@onstation.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 2:34 AM Brian Masney <masneyb@onstation.org> wrote:

> When attempting to setup up a gpio hog, device probing will repeatedly
> fail with -EPROBE_DEFERED errors. It is caused by a circular dependency
> between the gpio and pinctrl frameworks. If the gpio-ranges property is
> present in device tree, then the gpio framework will handle the gpio pin
> registration and eliminate the circular dependency.
>
> See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
> gpio-hog related boot issues") for a detailed commit message that
> explains the issue in much more detail. The code comment in this commit
> came from Christian's commit.
>
> I did not test this change against any hardware supported by this
> particular driver, however I was able to validate this same fix works
> for pinctrl-spmi-gpio.c using a LG Nexus 5 (hammerhead) phone.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Patch applied.

Yours,
Linus Walleij

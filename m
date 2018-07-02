Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB73C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F8A25DAD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UENwhbm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F8A25DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeGBNWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:22:39 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42808 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbeGBNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:22:33 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so14704700ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6fMWvsnXXnXAMJ7Hyv0NhEp6yduIrATneyKZbgYKyg=;
        b=UENwhbm03efUV+NzQCWiYB5qqVafL5BVe7HkyBMZM140Jji3lyYvP0QzsAZhuw5Zcv
         KjCB29s19I63GceHGHdq8Ktws/GVjDftplMdAeLx9FLMKMXSUID6dj82Zuauy1eswTXn
         6ZFmFQ4Va7n5AqFIdRysaU0o6jNRMeXnhSZfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6fMWvsnXXnXAMJ7Hyv0NhEp6yduIrATneyKZbgYKyg=;
        b=tCDfEJTHwem7j9ls+o7M1W5ss6iZT6XYN0wuyyZkFyOOetyETfzcZKq5huU9Sq6Vr0
         /QniyvPQWMiVAW/eZhJWxG07rOR6rf1CyKuHJxwWWLvnetp3+46M+jXa5u0AoYQcD6AZ
         LgxASi11wKa/4cQfRiHWVqvwdHAycyo7B/6/ZUkA78dBhPQFmSGUFPKldF+0688nD30a
         /edHyzXJoMdMNn8Jdcx/hz7cKkjpHw505Zh0ZctMz8T1HTvN7KxUv+3SkA7zv2fRnZ9+
         KcSV7CGKHg0q5Wt4iMjAW0UptEjuguWydS6UKNkj4BX9xD3efoao7drbKe0QarfRDL82
         ppIw==
X-Gm-Message-State: APt69E3JiET9JJoA4zyholdURLlSfbPZaGzSLS1/WdnVv9/dQc7y5UTK
        Hf/uV3+A4sWTaOJR4LSopXef+U3K3AzFua/XmhBOow==
X-Google-Smtp-Source: AAOMgpd3dafKhYw1BgxzLW1OgUkTNNCMdfsoM3S1Y1IsBmdICrOvWexaTR049MVn0BA+PIwB5GCcH+dTXz3cWLHwkw8=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr20421461ioz.304.1530537752700;
 Mon, 02 Jul 2018 06:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <1530215860-25549-1-git-send-email-dev@kresin.me>
In-Reply-To: <1530215860-25549-1-git-send-email-dev@kresin.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 15:22:20 +0200
Message-ID: <CACRpkdbhjPpFN_k36xDYgNKVrEg8ze8R0iHhXTPPuy5u7yWGsA@mail.gmail.com>
Subject: Re: [PATCH] gpio: stp-xway: Implement get callback
To:     dev@kresin.me
Cc:     John Crispin <john@phrozen.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:02 PM Mathias Kresin <dev@kresin.me> wrote:

> Add an implementation to get the current GPIO state.
>
> The callback is used by the leds-gpio driver for example, in case the
> current LED/GPIO state should be kept during driver load.
>
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Patch applied.

Yours,
Linus Walleij

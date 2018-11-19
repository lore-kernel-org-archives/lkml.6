Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADA9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0362120671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOpizwTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0362120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeKSXmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:42:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42135 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeKSXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:42:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so17682974lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdDqoATsmwvm79Su28v38E++562W7E6nDnouYUV38fA=;
        b=BOpizwTNNrplv617ZtZtPoIaFrUnwN9ZqJ25HZ9gPR2I2lP3s8unzZF8qGrd4rvKVx
         efLhRMpvIdiQUWZnia6APoAOMcbweUbIOw3B5okQ1jTwQTdWqqhS+KqQiBNZ7fhNX8ky
         xfZb4ClBLd8Y/ignTyLkzmK2bujX/40zLUeHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdDqoATsmwvm79Su28v38E++562W7E6nDnouYUV38fA=;
        b=QeuNu4mn7LeczoEi69Q0WrYmciZIWuKdhZrbSW08/R/0si2uKxHSOOAJxgSr0yMo8B
         labMWWARGmdoKCGlV4H94whxJYshV7JPgdqZalcfDKd9xDFU9z67TJZYRNUldMMWWUhV
         Kd4NREMYtP7GUxC8/Q2jAV/fnq9v241NUIBH7kfa9V7SDJ1Zi52s8e3r/kKE4tKsaFW8
         iqMct7IGdbVBqne7X9O9/MCUWV2DmrrRJwI7bYxlb+kObjSQaENCC5qxkHnmCnD5u99X
         4RXaABrJ1sGcdptdPwA5jv00TuHPI5de5vp1SgHZIfEAFUpanZOmr0zlw+nvel3+uYUo
         3anA==
X-Gm-Message-State: AGRZ1gKzxEyfuxTRw6Jp2BXjNzWCBW8taKe8PqgZXvxZXXr4W1lz/WbV
        Jb2TeJLDPwnI27ywczpB7g6w89wLOCHkVq5nG8OW6A==
X-Google-Smtp-Source: AJdET5fQkbUTqltjhivltJS0Byq/z1+XEBvP/JlbMJdSnCAdOxzWTt5LJRUcBYXjdFYHxVOKeKkbG0bREhZITdNkAMU=
X-Received: by 2002:a19:2752:: with SMTP id n79mr11626632lfn.11.1542633511052;
 Mon, 19 Nov 2018 05:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20181113105536.6459-1-jbrunet@baylibre.com>
In-Reply-To: <20181113105536.6459-1-jbrunet@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 14:18:19 +0100
Message-ID: <CACRpkdZ=pqxvmQdXhyGTMM9x4-rocwWkwdJv=yduO5WDwQ8z6g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: fix pull enable register calculation
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:55 AM Jerome Brunet <jbrunet@baylibre.com> wrote:

> We just changed the code so we apply bias disable on the correct
> register but forgot to align the register calculation. The result
> is that we apply the change on the correct register, but possibly
> at the incorrect offset/bit
>
> This went undetected because offsets tends to be the same between
> REG_PULL and REG_PULLEN for a given pin the EE controller. This
> is not true for the AO controller.
>
> Fixes: e39f9dd8206a ("pinctrl: meson: fix pinconf bias disable")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied for fixes.

Yours,
Linus Walleij

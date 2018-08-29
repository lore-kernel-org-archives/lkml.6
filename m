Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C77DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6C20867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPoLaN1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF6C20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeH2QBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:01:18 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38860 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH2QBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:01:18 -0400
Received: by mail-io0-f194.google.com with SMTP id y3-v6so4254691ioc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvWT9F3i/88z544uu3HaErLdy4sBRRKi67ZiOKyK7/A=;
        b=PPoLaN1rdadkumr9ztKhg+95n1neGOl71FZk+usUiM3rwIMtv56dk3/dSKMIQoYKnf
         nCCz6WU44C1zwRdIijgGXj26uQt4H+yWJlo5swvmoVZm5wkOTkr5Pbd0Tvc8fsCNnqH3
         Ynu1NHLSWnCQmdHoNQjE3DtLUlAvhD6+xxJN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvWT9F3i/88z544uu3HaErLdy4sBRRKi67ZiOKyK7/A=;
        b=ULne6EI+JPI5ObE1N2pAmDQZ/MFXoQPy8l67/pLj4OaPeUCGdIqjrbmk8dd4MZh0xg
         gLy9DkDBnfXm4EUUSXWci1aDHzSxCiawOga+GY3nNy3vr9T/asGrGNy0wKBf1mZOyNpl
         Bh4WqwWDECpDCEHKdGqo7Xzlcti1q1sp4jT/ecNW6cB1eL9l6xmLZBJq2gKhtH3ZQbeO
         gXW9WTCLgAm5UmZkTC8AsDI7rs/lBrh1fLHmCu2e3++UUBuGKMn1sPH3GBwG1FkvuuvE
         sWsa+QSWq18ibSOLphPVvXa7wfc4E7/eJeS5cjfCktL71TdyXoEIXGhpPZPxzRAoLGPj
         TjnQ==
X-Gm-Message-State: APzg51DADOi4Hvyc53o0aDpcwfPcFLeEw8Gzf7ZAVmJ1kCMVnPuNzHNN
        tVa3uqDxX/nKqRj3IitKrCTh6F7vNAj9xzqmHYf7Aw==
X-Google-Smtp-Source: ANB0VdbUm1pij3nf8JI0JgTdICksBbZxFBG1uX7OK9YtAR5MYdwf8LdIdM4sms2lonG5KmZ5IftTfuY+Qs/c3JvT7sg=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr4776994iof.304.1535544282816;
 Wed, 29 Aug 2018 05:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <1535488826-30200-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1535488826-30200-1-git-send-email-khoroshilov@ispras.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 14:04:30 +0200
Message-ID: <CACRpkdZuA0S7CmHu07mHz545QfDsvN62VeoPcmEwpYGuCWu1WQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Fix error handling in dwapb_gpio_probe()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Hoan Tran <hotran@apm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:43 PM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:

> If dwapb_gpio_add_port() fails in dwapb_gpio_probe(),
> gpio->clk is left undisabled.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Patch applied for fixes.

Yours,
Linus Walleij

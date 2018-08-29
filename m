Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8060EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E26920661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVhF9Y+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E26920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeH2PwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:52:10 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33850 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2PwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:52:10 -0400
Received: by mail-io0-f193.google.com with SMTP id c22-v6so4252285iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Fj7qDzw2FocCAucnXgaEt9Zx5MiavjZzfdXfU6lsbw=;
        b=OVhF9Y+UHCr2bJ8yoGMUCivAav0wkYVbhj9+A89pJ9owWnjqNUpjT5OQFm3Q1OPAD9
         g/61607EUbUj+DVis73ZDtveKYU9/rKPjYj2AYeAKVlGYv+iIGjw2MtaAinW3MTJb07Y
         BiB9P0xFpBZRBE2nzT8Cs58sgAx8FpW+zfybY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Fj7qDzw2FocCAucnXgaEt9Zx5MiavjZzfdXfU6lsbw=;
        b=X1Ht8JEVZrfmTeW2HtPiWZKlQKJvZ865A03KLidOuzhb0e+CabALDYEawHXXzol7gK
         cPQ4Ii6UCanxWpnfAquvBlLRadsdrBPaNHNCx5rNm1EHnK5RmDIeDS9LwjQ5eBrNgjHM
         elbROWh9QyQezEV3DS1eSzMsD0VqjWyuQSObwfoJYDcqaRNJDKxcFEEIvjAG1XD5RAG1
         ++gJoE10ndsWovQlbEH44c92TQF7ZHFetSSKhbjczEmifW9Jp6A/37BXTK/SVlCL16DA
         AZIO7HJW7DiDOjg1YqD63Xk80Bggy0ehhR9rRTFQisQoYFeviIHt6kcQUfeUWi0Gbitb
         gSwg==
X-Gm-Message-State: APzg51A7MaKMWEmetv+IwVLPGKNFaJsIhPMcWgOMVw95x7QEehP4hpiH
        r6MTeRlCxoJ0xNsYqCKjYci+msUxXu40sbJlxJuFZQ==
X-Google-Smtp-Source: ANB0VdYtJmz6uh3Db3Qp5TaIkj0K3taJm983HX5XzOSczcjQkCPck4/6jPtBxMpLOd3m+4qbFTkSXxaGlFrHXB3R+tE=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr4757433iog.175.1535543737044;
 Wed, 29 Aug 2018 04:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180822165754.213402-1-djkurtz@chromium.org>
In-Reply-To: <20180822165754.213402-1-djkurtz@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 13:55:24 +0200
Message-ID: <CACRpkdb7OEC8ZFNOU915aD2e=PzOk1DasmaAq-oHCeSYVrnuTQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl/amd: use byte access to clear irq/wake status bits
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Daniel Drake <drake@endlessm.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 6:57 PM Daniel Kurtz <djkurtz@chromium.org> wrote:

> Commit 6afb10267c1692 ("pinctrl/amd: fix masking of GPIO interrupts")
> changed to the clearing of interrupt status bits to a RMW in a critical
> section.  This works, but is a bit overkill.
>
> The relevant interrupt/wake status bits are in the Most Significant Byte
> of a 32-bit word.  These two are the only write-able bits in this byte.
>
> Therefore, it should be safe to just write these bits back as a byte
> access without any additional locking.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

The build robot is complaining about the syntax.
Is this fixable? Maybe you already sent a new patch... I will
see when I reach the top of my inbox.

Yours,
Linus Walleij

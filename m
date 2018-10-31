Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1530BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBAD20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEYlPypU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBAD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJaR5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:57:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38345 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJaR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:57:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id q186-v6so725549ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHQUwjQkZEpbRaLsSl9f7wZMyI2mQDNUNH8zy898Cjk=;
        b=VEYlPypUGIRs4iDO0eDXHoata8Ds3E0PlXZOmhwOJBQ0LNfuU3rPrtQzIe2vcyvuSD
         FSEzuEq4xqxFUNSeAxJWO5wXvKXRhn+dObXQCjXXowYbarI88FhMSl13hnoSe7oUT4Hy
         Ho8n1kepX5S9576KoZZIE8gbExnNDEBq2mjNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHQUwjQkZEpbRaLsSl9f7wZMyI2mQDNUNH8zy898Cjk=;
        b=AzY4O0tED04wxwh/zIIorsGz9y7mmITPF5g505sBn7kYAEmoIG9yTD9iswXlY9TQDE
         lHqdanT1tEbcQ3i1IfFxYzZp6MY4lFk+S7i07WnpUSBSwbycQqUxdbXMKvhh2L/TF73P
         SQH5qTVXG2n8AlCtr0Wk3QXJrcH0h2YG3ZAIGXhYX0kUqI/i4ShZWPsZWxwhRP7GxxpT
         CyWz/c90uxe3ksPaHiSAYTGUEpRfT1BnvR4Vk6qv/jdCCCvbehDakAXufORMH7ZK3+gP
         tY4mHFj+hiqrFRrP8JwG1r2LfS32s9HT1QnCZ3d4cu4zG9Yc6R7iOob45e7KgHoe53/E
         7zpw==
X-Gm-Message-State: AGRZ1gJlJLYI3vcvCWZK4jN7lzIc3CnZfA5ooVxvd5sh7ojur2VG5Weo
        gJUnWL06cr9suZpZH96UDQ/TNdkRWP+MENUrZdhe+6PnRn4=
X-Google-Smtp-Source: AJdET5cNt86R5kLrtR7m6ERpzExbRpNoUHkBcr1zyuxOFlJF5UnXi5E5eoTJ2ibNatQ/Y1Rdb2E97Mhp4SPwYXlIRMQ=
X-Received: by 2002:a2e:1510:: with SMTP id s16-v6mr1404318ljd.4.1540976437461;
 Wed, 31 Oct 2018 02:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1540209293.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1540209293.git.vilhelm.gray@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 10:00:26 +0100
Message-ID: <CACRpkdYcOVmJjdoVRpoMObxxmLa0-o4Kf9eQiL9zKZsEKb4YoQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Mask read inputs for get_multiple callbacks
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 2:08 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The implementation for several drivers' get_multiple callbacks return
> additional input states that were not requested by the mask passed in.
> Although the current caller in the kernel does not care, it would be
> prudent to ensure the behavior of the get_multiple implementations is to
> return exactly the requested input states and not more. This patchset
> ensures such behavior by applying a final mask on the read inputs before
> setting the bits array.
>
> William Breathitt Gray (6):
>   gpio: 104-dio-48e: Mask read inputs for get_multiple
>   gpio: 104-idi-48e: Mask the read inputs for get_multiple
>   gpio: gpio-mm: Mask read inputs for get_multiple
>   gpio: ws16c48: Mask read inputs for get_multiple
>   gpio: pci-idio-16: Mask read inputs for get_multiple
>   gpio: pcie-idio-24: Mask read inputs for get_multiple

All patches applied for v4.21.

Yours,
Linus Walleij

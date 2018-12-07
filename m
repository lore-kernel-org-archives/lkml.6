Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A50AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E2E208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkqX12io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E2E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeLGKPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:15:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44503 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeLGKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:15:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so3036852lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peLIgHYKKTA7dIqpQ26Gw2DjM++Zd4zFlvCxar8cRYc=;
        b=EkqX12iov10HSOjhssc4KP6Ie9AeHwoR2YdqyLIkAKNsn+VKvC4bybPzHaOvguFsRa
         +Vz2xAnAQpubZGil2I9XqwIy31SaVhvEBcUre6kB+BYMc9y8f+E0k3v/4CBn/EvdCzmh
         90BsjRB/qtqzxZZ1cQjE8okW5ie82f91FkqwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peLIgHYKKTA7dIqpQ26Gw2DjM++Zd4zFlvCxar8cRYc=;
        b=Wl69Xd/75gGCyeiEoAwpsXPq9wcLwzKW2iRDzcAMCjIbipmtSNQCvxXZBzEbpyAzVk
         AM3CEB4NUy+WfEUHrLyLf18ltwQlpRJXigEIgo0ywQdMUv0P6F1vFhYZBCpkBALHHFwv
         PSGgjI22+d2F0YxT1GPWslpwCkOX54qoQ7P6ga/DOlqFCL1KUHutOVZ77Omqe5Zl6vZZ
         JU6l0ejZTtYOnGcGCQ+qjToWRQ4x8RxsnKcmpuewvMLuibpBS27EzKnk629JrhxtVhoq
         TRGGaOFbycEcXmFB4AO2W90BFRAEAfXTwqNnzmgzzyfBr9zyhMqgN3HpqjklE+3O8wWF
         itPA==
X-Gm-Message-State: AA+aEWZoaGTJr3VfkTFlCSGo8osVuHn3p2ZkbsvfGf2ob4Hho/Zy6Bag
        Wfq/kQQ0I+bOtDTQoHLOm7qkRzj0wLRwyLzglO7uLw==
X-Google-Smtp-Source: AFSGD/WheBNyGjmroCARhdQ7mJaYuaJOU+buIUj0eizCTWr+nNfasEraccTyxHKER+HgZgSLfdb98uN+pmoYNOrw/8g=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr968851ljj.9.1544177699253;
 Fri, 07 Dec 2018 02:14:59 -0800 (PST)
MIME-Version: 1.0
References: <1543665438-26756-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543665438-26756-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 11:14:47 +0100
Message-ID: <CACRpkdYp8mT2cXVP6hKmopMmHrzugVjTS_0=-qLo8F7y7Um_ng@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: pl061: handle failed allocations
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 1:03 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> devm_kzalloc(), devm_kstrdup() and devm_kasprintf() all can
> fail internal allocation and return NULL. Using any of the assigned
> objects without checking is not safe. As this is early in the boot
> phase and these allocations really should not fail, any failure here
> is probably an indication of a more serious issue so it makes little
> sense to try and rollback the previous allocated resources or try to
> continue;  but rather the probe function is simply exited with -ENOMEM.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")

Looks good to me so patch applied to my Integrator tree
for fixes.

Yours,
Liinus Walleij

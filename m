Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C2C208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5WuUOt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C2C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeLEVcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:32:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38196 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLEVcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:32:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so15869863lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLGOhqMGRGCWc/JDJ01mEG+LxCdHe4SROFCfZtS3Q0E=;
        b=e5WuUOt3QyUAL7hubAQfQPdKSp+zDMuEGqthSLQfDogZiBoj2TiDurNN66+Yk6lZLA
         x119K1auOeydjKVinjVHh0bQAyioGjuxCKtxapwgXzjjXJ7WsWdktzeN9+j6qNlzEJ3o
         3hs5r8922BHop7ofKtfFukef2m3VqwoeOFCHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLGOhqMGRGCWc/JDJ01mEG+LxCdHe4SROFCfZtS3Q0E=;
        b=AMhIsRsAXVQKg2h5mQNtjtc1y9E3UFWeIYRCveD0GhXzsDiLvu2H1ga3JC9HyEOIXB
         F5tNb6NWQykK4pxmMuvkddVTtrpJ+hWFsqwiHGBkj5tePEf5B6BzWso0YkJcDbbIiYQA
         qmYw5/bfI7EdGrLPL5PHEvPYho5ejK0C+Rfx6DByaVnYmkYeVOPuZXW+0XLwrryoB1Js
         nUHsgs2/ZSlS6k/u6YXB7emFo7C+P+AFI04rwqvXCNN5PtOuqn0L8h/5ObONR6qOQc16
         pGiPQ4aBXoqyWfVTwprcN4+bHLuHS3/7qi33Sk9ZDN9EgePfIcRWQNaz576/y7FCCxsx
         JXDw==
X-Gm-Message-State: AA+aEWbU5sIF98sSPIAbu8K816YxCEdXtmqC6A2NPF763ODB+nqxHHkT
        mFHhcDFgPD+1CAE/PyhgfG1o2bo7NHXzb2JxVwWokg==
X-Google-Smtp-Source: AFSGD/WqzBRRt068RVHHdG/tQI9HUPFJr72FYTmMvo0aLpcMLOHCWykZd16oCoQKGQ3qZ0TR/ZiYf2p1BJ13rJ39Vec=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr16084716lfa.32.1544045526945;
 Wed, 05 Dec 2018 13:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20181129170312.23625-1-thierry.reding@gmail.com> <20181129170312.23625-3-thierry.reding@gmail.com>
In-Reply-To: <20181129170312.23625-3-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 22:31:55 +0100
Message-ID: <CACRpkdbRswRmMWFGuB6pMWeUVdB6=rxqC-o4ytv1VhK-2yjWDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] genirq: Export irq_chip_set_wake_parent()
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 6:03 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Interrupt controllers in a hierarchy want to use this function to
> propogate ->irq_set_wake() operations to their parent domains.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Tglx/Marc: is this change OK? (ACK?)

Yours,
Linus Walleij

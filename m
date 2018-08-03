Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD45C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F0A21777
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORxNka3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F0A21777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeHCTQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:16:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38913 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeHCTQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:16:08 -0400
Received: by mail-io0-f195.google.com with SMTP id o22-v6so5593762ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Br4uW5Mao84Evly/kpK73fkEMe7+xTtOWTzc1bakSbs=;
        b=ORxNka3n32jepSckn0ZeMFUSZUjarKB+1QvSnBHHjSV6Jaizbcj8vTT/pvPyjj4cYg
         Suv5+qAq0kCFsFNk4WJEHXHH0WLEZ+w9oFT26bdFrrE3YXNOij4jOV3GGofLaSU2etuz
         7XmTJMQDVjrnfekgcgSNZoR06GF6vOa9irSNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Br4uW5Mao84Evly/kpK73fkEMe7+xTtOWTzc1bakSbs=;
        b=RpCeM8RSX1cISgAm3LsvkXqTk12Uz0eLgBpa/7NNLE74L5gi5rL4NJzdWUD4GWU/i7
         Bz6hfpnTlvvLb8vAx1y3RMhA6zMEmt3gNKsrhZUIKwJh6aYLUytlCezowFkmoGZU2mna
         4Czu2NePydL+c9FghC70yT8uQPXIvrL9GCivO6Leq4sW36Gw9JA6QTYKpIXwEGGZYl0j
         N8odPUaD5HZwuEOrncDf+RLIFgF+QzxV+qsynUaO6qwuOmfyotSYwF3qhmJf0WRS6JnS
         SPHPXBd+e78sJYvH08t7F/udBitSiTcrxKmcRriLi+OQ1n8BYio5L59t53rHBt2Xq1fG
         T7Gg==
X-Gm-Message-State: AOUpUlGdnP2ho/LdwO5yY4qu+pruULb106/Wf1JYkFP/muW1sLqfp3dX
        jCMg/TCFXz09xJQAAZoXVCvUT5goqF1iLR5eQ0I/ePPT
X-Google-Smtp-Source: AA+uWPx1O7oxLoHTJYNPcD8T0vebV/2fCKjnEu5ZvjCHdWPB1FJoTpeOVdYRxx3N+c/hgwx8C1x9ncoQ8A6es/VSuqw=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr6721575iof.304.1533316735196;
 Fri, 03 Aug 2018 10:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180802111144.12512-1-digetx@gmail.com>
In-Reply-To: <20180802111144.12512-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 19:18:43 +0200
Message-ID: <CACRpkdas4qF51eesZ-M2+7wzp1t81qYSZSyxsmm-zAuvcaE2Pg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to
 arch_init level
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 1:12 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> There is a bug in regards to deferred probing within the drivers core
> that causes GPIO-driver to suspend after its users. The bug appears if
> GPIO-driver probe is getting deferred, which happens after introducing
> dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
> property in device-tree. The bug in the drivers core is old (more than 4
> years now) and is well known, unfortunately there is no easy fix for it.
> The good news is that we can workaround the deferred probe issue by
> changing GPIO / PINCTRL drivers registration order and hence by moving
> PINCTRL driver registration to the arch_init level and GPIO to the
> subsys_init.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Patch applied with Stefan's ACK.

Yours,
Linus Walleij

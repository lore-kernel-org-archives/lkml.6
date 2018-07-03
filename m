Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B716C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43B323F66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LekbfsI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43B323F66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeGCHCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:02:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34312 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeGCHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:02:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so748538wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FTr/mx+ESvJK4iazcGo2YZMqwOCdpMPVpIzlOjpbRvU=;
        b=LekbfsI85qQ6CafxgzuKKiqfTX30oId/r9Ao3fbTElhSKoGHnSg5Zz1a2neP/1GY+g
         4jU9m5ggEzXyytRy9QFqjvCZzbCjqP1uKglS+xlciCNWV/wiCb9Dsiq7Ge5EWt444+Rc
         xDgsSrHQMyp/goCYjTJOqvO0zcWtPaIJz8kC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FTr/mx+ESvJK4iazcGo2YZMqwOCdpMPVpIzlOjpbRvU=;
        b=Hf+2iximajG1v6dYunQtGjDvA93gSkfAdCZlJS5FR7BANyVFqZ2oW4HDEbRnBCKY9e
         392zluiSUtMp7KMMvQoIWy9CGpheG0i4lRU6UuTRJ0SbN7DHVGCGLBnIdgXLvQIYMvWX
         Q2ZMizWd+eHRgbXBWKaz0BjZ9XyUv5qhDVcF8pRkDhJ8z176Zg6Qvatg8CYxBP/fIKql
         QsaxoBiym1zSlMd+WxZ62bceVOcGx5IXzxaKr3X9tOesFi36V7zDofZDvoPSTRqiIAk+
         KHBXELdR5bOe+MhwkAg1k2xoRiI6W7yl4CW8l/RrA+kvVcwL30j610XNGyDNYessayTZ
         M/2w==
X-Gm-Message-State: APt69E1Ea916g9ki8YD+1baUWtwG7ENuAuXOmN4irmVL6cJapzLRr0U8
        aT0mww8PXyIrWDWNiNaFeR+hDA==
X-Google-Smtp-Source: AAOMgpexlk6R0IWVd4OgPL0sUHJxz58cJP3yl+hbOS4NWPuUUVN5w+gmeq6D7yf/P0/IeWAL91At7A==
X-Received: by 2002:adf:a401:: with SMTP id d1-v6mr3289778wra.121.1530601322531;
        Tue, 03 Jul 2018 00:02:02 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id 143-v6sm974969wml.37.2018.07.03.00.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:02:01 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:02:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 0/4] mfd/regulator/clk/input: bd71837: ROHM BD71837
 PMIC driver
Message-ID: <20180703070200.GC20176@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180621103400.GB6076@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180621103400.GB6076@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Matti Vaittinen wrote:

> On Tue, Jun 19, 2018 at 01:55:31PM +0300, Matti Vaittinen wrote:
> > Patch series adding support for ROHM BD71837 PMIC.
> > 
> What is the preferred way when I send updated patches:
> 
> 1. always resend _all_ unapplied patches even if there is no changes to
>    some of them. (patch-vN mail thread contains _all_ unapplied patches)
> 2. only resend changed patches (patch-vN mail thread contains only
>    patches that were changed from patch-vN-1)
> 
> I have currently used approach 1 - so that no patches would be
> accidentally forgotten - but downside is that people need to check if
> they have already reviewed some of the patches. I'd rather not caused
> any extra work. What is the most convenient way for you guys?

Option 1 is preferred.

Just ensure you apply any tags you have collected so reviewers can see
which patches are pending a review.  It's also a good idea to keep a
succinct change log between the "--" marker and the diff stat where
you can state "v4: No change" or the like.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB63C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D4C20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkQA3jUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D4C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeLNM0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:26:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41386 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730665AbeLNM0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:26:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so5245136wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uYDmuUCRNFfuHQ8OAF81ypD3ZblmLZsnLEku4glONRQ=;
        b=UkQA3jUKcfneEMRfR2lFynUyiIcZw4ZuJwlO8RFvMp/v4h/2rrsPb48kT5Tfi9Sn9h
         44Li6qGlSYrJE9PSnO10QEQ4mgZJZteMnKCE14nokxtcKp5INwVtNJq9Jh2KV6soO9Sz
         RDyYeqOdaePw8TN19ik44VmMOEdHiQfrvl4lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uYDmuUCRNFfuHQ8OAF81ypD3ZblmLZsnLEku4glONRQ=;
        b=Byn2SLgGelXgFcypvMRaut9VRxT5DobFioW9xPMGzte/zEvjxQdqk93ypTgb5Uymsk
         LmBpgoY1uXlRGZFvgQEjYwUF2ywSfHepb9qoZa2VAh+P3paltqUyCyz1GIBtmkpXr6SR
         NurxdQDrVwsHNh1svDyu2vc9cUsVpN1UnFxkjmShl9/h/ax4JYnwBfr4Pe1RBFBCzX3U
         fQGgZWmnAjQ6DOW+NNOYFwVp377le/HjYCHWm6NXh92CCn2AU1JblnSjXEAX7gz/QP5Z
         zDGkPdhQbA8W1rMiRQdH0Qk7dgOUvM9z3QPC6LQS3jbQDJzHUGzoRHzSscVlZyDK+soc
         W85Q==
X-Gm-Message-State: AA+aEWbsElg/5A58SVX3hV3935koQ5A0yubeJQMapJ5I/CHTEV85mm07
        hhbz6l11zBi3zV4fQuK1sRB7PA==
X-Google-Smtp-Source: AFSGD/VUs1nLKy/FFlrIogRpNrUQdEvqLAojNtxljhbYEwkBkU1DUXZgblVFuZPLrHlmHrhwhAheLA==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr2469654wrc.62.1544790381075;
        Fri, 14 Dec 2018 04:26:21 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id k19sm6178167wre.5.2018.12.14.04.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:26:20 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:26:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     "J, KEERTHY" <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Message-ID: <20181214122619.GW4497@dell>
References: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181214122559.GV4497@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214122559.GV4497@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Lee Jones wrote:

> On Thu, 06 Dec 2018, Christian Hohnstaedt wrote:
> 
> > Free allocated IRQ if reading the device ID fails.
> 
> The patch is fine.  However, in future please submit patches using the
> format set (by precedent) by the subsystem.  I will fix the subject
> for you this time.
> 
> To check the format, you can do:
> 
>   `git log --oneline -- <subsystem>`

Patch applied, by the way.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

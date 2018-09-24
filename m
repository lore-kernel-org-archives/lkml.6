Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F6EC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B2120883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaZt58zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B2120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIYF7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:59:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44907 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeIYF7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:59:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so2071925pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+aWUmSJ5yMJ+w9P7Y//bz8CUVmmZRWaY/PsDPQct91s=;
        b=aaZt58zQWsvca9z3qMyrIKxytxrfLhGTgpWgn1aKndV0w+P3fKfM54P97Bqnq0WGMR
         0dkwwbTLjwAjJAeI93FlzMYuUdoUahVXjUELDqD/qiGy1R4nVjX68sFGANUbOX0xEzkC
         xzL66DFlvlKv3MU8GLpk5Ncmqet6S6THWnsRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+aWUmSJ5yMJ+w9P7Y//bz8CUVmmZRWaY/PsDPQct91s=;
        b=MvzHowAjqOi/tyopdOBiEFplyZKc85Ctg0dtnpTQ4kja7/qIpj05J2QwJkB294rrB/
         bywcsmbUT0yOFKdpzN+ZbNEJlsPUQHQC1yrzcGkhHseIf9Q+2be3WHchMZ51EMu2sBB7
         dQDwi+iz883zbqVKUnJKaA/ST7DYbdB3MY5uFF8VMICSW6sMlSaWpB6NpqEo3ENi0z5x
         KlnbD8+qFMHPXj67v8lL1tzjzKsAvP8ge+c7cdiMyhN18JN90epdHZDgIVT6L3upLnht
         doEJ4eBSw+LLQVIWHu5rSCMqib3IairbV8Gk0aqw9j0F5QqTAB0LLYPTgwNhkJXA3qvs
         2izQ==
X-Gm-Message-State: ABuFfohLQiF6eVf5FRDb/Z6PKsyOovx9yYrmwcMsAxtaqyW/0oJSsmPo
        QBA9xH+7v0KkSENAujSxLCu0Dw==
X-Google-Smtp-Source: ACcGV61tDbeFQreSvsoigDxbZJJw342/Qf40myD4bMAkdyKWjj5judhQPQvrYIqn0HUCFK0JCvtLCQ==
X-Received: by 2002:a63:7107:: with SMTP id m7-v6mr841925pgc.73.1537833295756;
        Mon, 24 Sep 2018 16:54:55 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k3-v6sm846159pfk.60.2018.09.24.16.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 16:54:54 -0700 (PDT)
Date:   Mon, 24 Sep 2018 16:54:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180924235452.GI2523@minitux>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Sep 19:47 PDT 2018, Baolin Wang wrote:
[..]
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
[..]
> +What:		/sys/class/leds/<led>/hw_pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a hardware pattern for the LED, for LED hardware that
> +		supports autonomously controlling brightness over time, according
> +		to some preprogrammed hardware patterns.
> +
> +		Since different LED hardware can have different semantics of
> +		hardware patterns, each driver is expected to provide its own
> +		description for the hardware patterns in their ABI documentation
> +		file.
> +
> +What:		/sys/class/leds/<led>/repeat
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a pattern repeat number. -1 means repeat indefinitely,
> +		other negative numbers and number 0 are invalid.
> +
> +		This file will always return the originally written repeat
> +		number.

This captures the infinite case much better, thanks!

Given that 0 is described as invalid, does this imply that setting a new
pattern the repeat will be disabled? And hence if my hardware supports
only infinite or no-repeat setting a new pattern is the way to disable
further repeats (rather than just setting repeat = 0)?


Regardless, I believe the semantics of these two files will work fine
for my Qualcomm LPG driver.

Regards,
Bjorn

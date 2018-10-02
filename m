Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B1820684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsUwF9xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B1820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJBP3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:29:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34306 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeJBP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:29:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so1020203ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=klW9Tz2535F/OE7Wyq8OS7WuBlhAjWlTAD2jp6YiDv8=;
        b=FsUwF9xllvfNVmS7jKMMo9EFOaTw9+pwPTQQlKz/KUWC3XVNUW/bhzRp7xjgh7zLD+
         BUfLyIUIyL9TYLywszVrgtKl5AX0TFiQjnCXYX5g3I7iwLONpw8iKU6DCW5sny61S6Dv
         RkWhDy3nUwVy0BehnmxC2S+Yd86YewK7MC6rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=klW9Tz2535F/OE7Wyq8OS7WuBlhAjWlTAD2jp6YiDv8=;
        b=LJpZutPkY8JO0HqbYKIcDXE8Ruu4AMrJ+q0qKI8461VbS7oknDOnIxg6bp/g1hJxhj
         tcU9Ol3XBWhIyNAKU7+4poygM2uBnwjioHXNQDrRiOmJhX52urkEsfmcwwdl9y4tyYaA
         exLR9JKjfEwl2dLrO1G/fgCxdUmEzOzcEXcb+gBFq8rl8AJlJDA3f8WMoVtBahd6IrOk
         MlqFjCYUhJ3OMIcdcU7y+38hpR7JBX9LH8b08X217RgIb47pWQ52+Dcje1mcmNhxMWKP
         HlVed4+8lrvNmPgwDvYGfSn0m+UjjO/ejbB2B+bwryW1kxghROZ/IL+C8BfLmTvoJ3S2
         p9JA==
X-Gm-Message-State: ABuFfojUQnSEa/iCRaJA0tr04Bmj4nrURwx3mBD/NK2xMLAkXHcyNwFd
        dv+pp0vy3M3OAZrN9uYEsmdwEQ==
X-Google-Smtp-Source: ACcGV62edFwmUKQcqDMVOVSijNvIATT4jKxTCsIr1TbQSqTChzAwVEPOHVasJ9olooF3n8W+YBwmoQ==
X-Received: by 2002:a2e:921a:: with SMTP id k26-v6mr8726296ljg.163.1538470062911;
        Tue, 02 Oct 2018 01:47:42 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id m88-v6sm3252658lje.14.2018.10.02.01.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:47:42 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:47:40 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] pinctrl: msm: Actually use function 0 for gpio selection
Message-ID: <20181002084740.GA5499@centauri.lan>
References: <20181001214905.12149-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001214905.12149-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 02:49:05PM -0700, Stephen Boyd wrote:
> This code needs to select function #0, which is the first int in the
> array of functions, not the number 0 which may or may not be the
> function for "GPIO mode" per the enum mapping. We were getting lucky on
> SDM845, where this was tested, because the function 0 matched the enum
> value for "GPIO mode". On other platforms, e.g. MSM8996, the gpio enum
> value is the last one in the list so this code doesn't work and we see a
> warning at boot. Fix it by grabbing the first element out of the array
> of functions.
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> Fixes: 1de7ddb3a15c ("pinctrl: msm: Mux out gpio function with gpio_request()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>

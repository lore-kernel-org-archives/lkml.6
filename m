Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C6BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A6A208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwyixRgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A6A208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeFRMji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:39:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46345 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeFRMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:39:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id u5-v6so3172403lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r06CF2EtJ884SBqC0CJhFy9ZVM4kJlzWyOaNx8Ri0aA=;
        b=dwyixRgUuXgDNK287GyMnhgUHiPvdI3+nVN69mYrGE29ugDtR5awwk1bQz5AXqmh8N
         siWtnZsk/uQY2Kc2Qksxx1ZuisXG1ddz93xjQhVKkgxaDWcRZ7eRE3w765CH8CVM1I2h
         Y9zf/P0aTb4ZhNuewhhV30tq7Dagpq3s/XvII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r06CF2EtJ884SBqC0CJhFy9ZVM4kJlzWyOaNx8Ri0aA=;
        b=n8GSELdFAoYB59zsei9lhV1igb9Y1WdAJCG0OsSnYQl819DwPr71nn3Gc6MPo0R8Ro
         CMOpPuSCnEIXkdkO5SQiewhMaaxgGNstJbxzryL4WkfGMhJUXlEMECCJ9K0y4P4Fxxjv
         cGp+yqz3BiijehRm9JIBLNzM1rzpIJqj4CnWfzeTDbdk0dXkka1+BUxnHTvoN8c9Gkhf
         oD0je7rsyaOlFm6joevjogHxGzsrfWuFEZPcrLZvTH9FV6+9S+jIGUeLWFxApR9NJylV
         NzFYMlGoTqxI6UiCQ5stKa0pp0d0pfwnH2qQPiIMVwmRtkM89FTVdHsjCqQ2R36lUIFU
         Q9Og==
X-Gm-Message-State: APt69E3TBuerO/Fo4umHusjy+tmuDWofiij47bL7q/7p1q/sGixxS4/p
        G+lOvbneNFT7dPPerf73W1JHlQ==
X-Google-Smtp-Source: ADUXVKI879u7qGhPqn7dd9ACiOYd3aLsj7mtKmyhFJDiPK9egQMpuLDDPAf4/2lXphJM02W42QIEnw==
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr8491280lje.140.1529325575262;
        Mon, 18 Jun 2018 05:39:35 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id g17-v6sm2694138ljg.27.2018.06.18.05.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 05:39:34 -0700 (PDT)
Date:   Mon, 18 Jun 2018 14:39:32 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     andy.gross@linaro.org, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Message-ID: <20180618123932.GA28476@centauri.lan>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org>
 <20180618110642.GA6928@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618110642.GA6928@sirena.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:06:42PM +0100, Mark Brown wrote:
> On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
> > of_platform_device_destroy is only defined when building
> > with CONFIG_OF=y. Add a depends on OF.
> 
> Is it sensible that of_platform_device_destroy() is only defined when
> building with CONFIG_OF=y?

I'm redirecting that question to the device tree maintainers.

There are a few of_* functions in include/linux/of_platform.h
that are only defined when CONFIG_OF=y:

of_platform_device_create()
of_platform_device_destroy()
of_platform_bus_probe()
of_device_alloc()

Rob, Frank, do you want me to create static inline dummy versions of these?

Regards,
Niklas

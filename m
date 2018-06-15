Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5189AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28F820896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ipc82krA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28F820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756571AbeFOVZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:25:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33697 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756331AbeFOVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:25:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so5422626plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4DnO/WT3SzyE57E2h4F+3AWOblhDcInLLLqQ0n39apo=;
        b=ipc82krAQcxTEBzjU5uyJgGd1FLhBumreAed1Jtxj+ch+4H3oGEeasIJFgf8OIlZe+
         bE9YssmkwK6IslNqP47jp0l5snF1o8DwC3vEzteSmwSLutw60PK8BlmCC/zGIhfGpECe
         LRF0+dfCosLxahRlpSLIUkGIcK3LykNtgBxnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4DnO/WT3SzyE57E2h4F+3AWOblhDcInLLLqQ0n39apo=;
        b=O17Hf4gFy1K5hwP7iv5ezO5q0scswoZqgp8w9iV6mCDwTblnBhaEu+4ZtM2uMy3bDN
         tuHmQoA0o++pXtJccVf0CNXYrLk22LKOCuCzqJ89Uak/wXRC7yFOPZSTnHSF7Go/38nM
         XB/rufQH1kvM8V+9MjC3tpvT/5TMNxZW4d9v7G3lnEftj2nL+TKKni2eOkrCwPhrsJpR
         S2MQFQvyOv4m7lrCVWNiGJRl9eGiZDPAxGbOjw/UMmZSZ/dTWe+St4qFoEV5x9/CQM0g
         rT9ohQy+QQEH4ZQjoqSRGlvg9sQAgIRPBSTWKG/Iw75uIao1APTGEIpaikMXHXTrgILe
         +CGA==
X-Gm-Message-State: APt69E38SfG6CRN5O88sh0D+tbeefHguxkQ42FapHHCguiPRzpQFaGwX
        SK8m6KXfQjAgMpeTrKdi/iOcrg==
X-Google-Smtp-Source: ADUXVKJ702CPHm0dqI5+YmTNEX1M1g0lbhGVyxAAxI1O+tYvPP3xDVqccDB0HGHkc98JRTRgIYliAg==
X-Received: by 2002:a17:902:14d:: with SMTP id 71-v6mr3848896plb.275.1529097943987;
        Fri, 15 Jun 2018 14:25:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id q4-v6sm3901374pgt.64.2018.06.15.14.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 14:25:43 -0700 (PDT)
Date:   Fri, 15 Jun 2018 14:25:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 01/12] PM / devfreq: Init user limits from OPP limits,
 not viceversa
Message-ID: <20180615212542.GP88063@google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-2-mka@chromium.org>
 <20180615210619.GA249892@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615210619.GA249892@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:06:21PM -0700, Brian Norris wrote:
> Hi,
> 
> On Thu, Jun 14, 2018 at 12:47:01PM -0700, Matthias Kaehlcke wrote:
> > Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
> > the devfreq device") introduced the initialization of the user
> > limits min/max_freq from the lowest/highest available OPPs. Later
> > commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
> > frequency") added scaling_min/max_freq, which actually represent
> > the frequencies of the lowest/highest available OPP. scaling_min/
> > max_freq are initialized with the values from min/max_freq, which
> > is totally correct in the context, but a bit awkward to read.
> > 
> > Swap the initialization and assign scaling_min/max_freq with the
> > OPP freqs and then the user limts min/max_freq with scaling_min/
> > max_freq.
> > 
> > Needless to say that this change is a NOP, intended to improve
> > readability.
> > ---
> 
> BTW, putting the '---' here means that stuff below it usually gets
> dropped when applied (e.g., with git-am). So it'll drop your
> Signed-off-by and Reviewed-by. Not a huge problem if the maintainers
> look out for that.

It wasn't intended and is related with my current workflow: To keep
easily track of deltas in my tree and have the changelog ready when
sending the patches I currently keep the changelog in the commit
message and manually move it below '---' when doing 'git send-email'.

Seems I got it wrong in this case :(

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEBCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69428206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQcH+pgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69428206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJAMab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:30:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45740 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeJAMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:30:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23-v6so8345093pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 22:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8nypFTAXIsDUoJqSIe6Ag8o6UZy1k7Tn4a5GzSrnXrE=;
        b=LQcH+pgsLVZKBHnWTl8O+/nth/7LsKsFMck3Gzu9+YdPtcbuM/LGHdAuo1dUepgnDd
         P6MGMKr9wWW4TFEqDQBEZtOh6UgdSoxe0bebEgcGRhJVEuS6/oIzEbPKPSLsgoV5au48
         Jo/VQKMTWJBKkyb3frCfnE2x2A9Cb/tlf+fjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nypFTAXIsDUoJqSIe6Ag8o6UZy1k7Tn4a5GzSrnXrE=;
        b=PcNjOVE2te0RouQPMyHH4X2YDRYW4IwF9TuLP8EEJpsO5wN7n3lc0F8rysgoIEDm9n
         Hzzv9UxoCcIIxHuwlOij+IZVwf2jMnS95tJAwbh7Rb0gjUhvNjY6WMzG6X3Vj+w0apf+
         3pxSj5ISidK5Q/ELD7VSPGd+sH632o6M5sBE9xRpfElw+5hmUfzeR1xfc8C241EqvaSl
         P8RKLEtEwAU45Wm19gdB1SnQckqxoqkMt3DATjwm8yxumMLEVPbheeEbbbWM6loMmhcz
         TtMErSn3nI02bIWuDMe3NdevdyBRxTtFde7TuqFhQOmgYEPzpipTM5voku3pNSZK5Lrd
         ufKQ==
X-Gm-Message-State: ABuFfoh+eIAQcf5wfP/rIkkIA0kxOSfAeY+xY6TyHzLO5g07uiuSYQke
        GYS3n4dhFvbYtoGyKNho78Ltvw==
X-Google-Smtp-Source: ACcGV61qcprPIxuvj0wOF84bQIr/qKRGl06/49d+fQH4qoP7yaT/JdNcc+p3PkbiFAOaRN7JfCKgFg==
X-Received: by 2002:a63:af5b:: with SMTP id s27-v6mr8718634pgo.448.1538373269103;
        Sun, 30 Sep 2018 22:54:29 -0700 (PDT)
Received: from localhost ([122.172.136.196])
        by smtp.gmail.com with ESMTPSA id j5-v6sm16087361pff.139.2018.09.30.22.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 22:54:28 -0700 (PDT)
Date:   Mon, 1 Oct 2018 11:24:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Message-ID: <20181001055426.w5rp4nfleh4tog3k@vireshk-i7>
References: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
 <1536893962-11200-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536893962-11200-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-18, 10:59, Anson Huang wrote:
> On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
> the ocotp clock needs to be enabled first. Add support for reading
> OCOTP through the nvmem API instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8831C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D0E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYDv8ETO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D0E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeKZQ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:58:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43293 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKZQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:58:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so5634268pgk.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzWIjXK5nFzBLvHNhJ1t0wqnEyn01zLBUK2kMcLtnXQ=;
        b=bYDv8ETOewF4CFtof4cg51Z8iYTIOcOfjLV3iGDV1j3x6Jmx+W06BJQCqKB6iSi7IR
         h6eZiXC0on5hnlu5fVAFEsAnBuokKe6HVOTPZY/pMi135yIks3rNAq6tNZc8zXhjlyR3
         L7AnlEjx7dBpcTWGBUuSIpzeN9daEJDcDG6nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzWIjXK5nFzBLvHNhJ1t0wqnEyn01zLBUK2kMcLtnXQ=;
        b=rJSK63NPyQDsNYshq7ZtNYSrMmgFhcToxvna6gm7lxIB79eyHJw1Y5xlsPnBTSS0yv
         XAQCX8xAlU0P3Jug9HW8G5+IyuhIEOEwYfZndZclm7h+M/hH2g4iZD/kwZ9aILx7nlfb
         oCRoTZJaDkKgzdSLa0IIodE0+0kPyLqF5CYGXroRtJvIzgHumO8e9nko2/XWZ6HMDm1k
         duG2i8lFZsQ0JApYmaykKuMGR8G4XQuhXFC+S9HE3R4A5l6wjuhSlR9MxaZOrjNKUG2f
         HtwIAkUIQLxW+fl91MR8kTQaCtCsmOa4rgVUr17HoCePxEVYE4E6Llc8G6d2IuJoQYGL
         HMlA==
X-Gm-Message-State: AA+aEWZvfhtTsa1OGKj1Expclr12xLkaUHZwtDNB4llg1a+/nw6R/eNJ
        rlOUP7lgC9FaKyaXW8Yf705Aaw==
X-Google-Smtp-Source: AFSGD/V34McLScirnXWqmlpwiaJG60ZuY4II3a4MaiuOkUL52ju8Voy8VPu5v4IzKu0RKwmORPkjZA==
X-Received: by 2002:a63:955a:: with SMTP id t26mr23812917pgn.449.1543212308563;
        Sun, 25 Nov 2018 22:05:08 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id p2sm7846931pfb.28.2018.11.25.22.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 22:05:08 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:35:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] cpufreq: imx6q: save one condition block for normal
 case of nvmem read
Message-ID: <20181126060505.vgu4serogh4brjpm@vireshk-i7>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
 <1543200853-10029-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543200853-10029-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-18, 02:59, Anson Huang wrote:
> Put return value checks of calling imx6ul_opp_check_speed_grading()
> into one block to save one condition block for normal case.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 8cb9683..9fedf62 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -405,9 +405,10 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	if (of_machine_is_compatible("fsl,imx6ul") ||
>  	    of_machine_is_compatible("fsl,imx6ull")) {
>  		ret = imx6ul_opp_check_speed_grading(cpu_dev);
> -		if (ret == -EPROBE_DEFER)
> -			return ret;
>  		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				return ret;
> +
>  			dev_err(cpu_dev, "failed to read ocotp: %d\n",
>  				ret);
>  			return ret;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

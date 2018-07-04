Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CA5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8796244D3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTU/pYYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8796244D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeGDKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:00:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34841 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbeGDKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:00:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so2448943plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3drdAB/Ysv7b/95Bp1bXTdhhQUjkvKgh+U3fUP4ZGXw=;
        b=OTU/pYYhJbFYmjBwC7NrZ2JbV5XXZJAtUvCeCxsWnVmA/LCjhco00nwNPDXEWfNC6L
         xiQfyV2MrE8W03xLUvg/5DbJYFrKyQspcHPwOkZisawLHO+6AbXe417xHeWGwd5gU1TW
         GK5PDKQY8KXiNGx4DpeHDJrNwBflSGEwDpSkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3drdAB/Ysv7b/95Bp1bXTdhhQUjkvKgh+U3fUP4ZGXw=;
        b=i6AQ39WtqBS/K0esqC/iz/tXxyHp+wev3KaUzhITwVfWbvE2b8ArqkOYhqzfi34XPZ
         IhVxrw/Z++VtzCw09JZaUZyRkIAvtMg4qc9Vq/0hMr0afuMZ8d6ZzgfkFJh7B4bNcTVG
         jkjVSWnUVorRGhxs4AZVg/h5Dp1uEcD9edsVXiuP/TAJiURXduk1IJ0KHCq6C0B4vX07
         ah8HYHwh+di/82aqj3sYQTp4HKXTh12zEMDd7el9zrZz8sEFpGCd7E5rHOElMvmpMA0+
         Z8PL7DP9co8PbpzCjyLX9QQ64qYBNKqKL20XoLI/SvB4gYtV5XhnJGeaR8I/urLn8nBj
         Rntg==
X-Gm-Message-State: APt69E1hBHXkvV96vmlaWqFkXa0eAsbm57fCl2ZAt2oFMdCsHLZI8vBR
        veY+JCdyFmhUaZ3OUxtJ/4swHw==
X-Google-Smtp-Source: AAOMgpfexN/7sBCZx1R8YTpPw7pg9tTCqcN0SNbmasEZIW4ZGXbLhvhTyafUSLA4wazw9aV3m1naGg==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr1424273plb.274.1530698407105;
        Wed, 04 Jul 2018 03:00:07 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id j129-v6sm6329936pfb.113.2018.07.04.03.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 03:00:05 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:30:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 09/12] dt-bindings: misc: add bindings for throttler
Message-ID: <20180704100003.u4fagd2vxwwbp443@vireshk-i7>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-10-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703234705.227473-10-mka@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 16:47, Matthias Kaehlcke wrote:
> The Throttler is used for non-thermal throttling of system components
> like CPUs or devfreq devices.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> --
> Changes in v5:
> - patch added to the series (replacing "dt-bindings: PM / OPP: add
>   opp-throttlers property")
> ---
>  .../devicetree/bindings/misc/throttler.txt          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
> new file mode 100644
> index 000000000000..2ea80c62dbe1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/throttler.txt
> @@ -0,0 +1,13 @@
> +Throttler driver
> +
> +The Throttler is used for non-thermal throttling of system components like
> +CPUs or devfreq devices.
> +
> +Required properties:
> +- throttler-opps	Array of OPP-v2 phandles with the OPPs used for
> +			throttling.
> +
> +Example:
> +	throttler {
> +		 throttler-opps = <&cpu0_opp03, &cpu1_opp02, &gpu_opp03>;
> +	};

All you do with these phandles for now is that you parse them and read
"opp-hz" value. For that purpose current bindings look sufficient.
From OPP point of view:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

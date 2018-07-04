Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDA4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064D624349
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTMj8gWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064D624349
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbeGDKoj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:44:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44082 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeGDKoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:44:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so2460520pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ej7+hnB4uUyXt6RZcYrgRBcX+pmFqlB3hv3sgP60R6I=;
        b=LTMj8gWCiVSUvTSaC7CbNdw13WQ8UFSm9Z/jRzUuzdJHmHS49EBWBNzpv3ACwsdut/
         BNRRZaqwowjBxvs/ALY7lLbhJS4b1VgcO8Ms7u4EBPt2NAfa4vM/V2pCH5DQfeqP/YOk
         nsGr/Vfu8mp28G7HIsiDCaKbnF3sXNAst4SFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ej7+hnB4uUyXt6RZcYrgRBcX+pmFqlB3hv3sgP60R6I=;
        b=BOk9JQ48V8K81nt3f6ncWNzJok2F2kvkIlbNXqsjmgcGIjFY0sQipjmczowQo2EIxD
         z4iCVTGyykV6Ca9B2oNlCNyM+sk+JYQJXB66is+EnHV8J7jt6vzV6obOwWeCcy6wme7F
         qlT1Zt8bp+lhrV/t1Xi999+a3KbiUwgJ40nbcR8DgHztPJCuEhW3kVL5AGIVecbMUsnG
         zAh4N1DWV9smrLfZkvM2CFEXx/rjA3qG+W2OzdrrOszOHkF1sXonefpw1QFWMegWw67m
         CHwW/9z4p0UZR7XZlwHo9yxG9EFqRHuDGUsug4lgaHEv6Iy6lw49YcnvjzIArFbPTmBI
         Zu9Q==
X-Gm-Message-State: APt69E1N2gVIPIUt9gv5K5gy9jBNBhJm3ShBtcmWU7IsDL6vaOdepfN2
        EJ9p/WR2Mfaetia7I83lyK0NTg==
X-Google-Smtp-Source: AAOMgpd0+pM6McBbSTP44ohjGMf/U343Kyua70+Ubkv0SQpi1kz31X9T6GUNyDJzjmBRoaSJLjeRsQ==
X-Received: by 2002:a62:748:: with SMTP id b69-v6mr1608912pfd.177.1530701076704;
        Wed, 04 Jul 2018 03:44:36 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id a20-v6sm4960220pgw.91.2018.07.04.03.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 03:44:35 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:14:34 +0530
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
Subject: Re: [PATCH v5 08/12] cpufreq: Add stub for cpufreq_update_policy()
Message-ID: <20180704104434.subvhwvnkkiv255c@vireshk-i7>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-9-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703234705.227473-9-mka@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 16:47, Matthias Kaehlcke wrote:
> cpufreq stubs out some functions when CONFIG_CPU_FREQ=n , but
> cpufreq_update_policy() is not among them. The throttler driver
> (https://patchwork.kernel.org/patch/10453351/) uses cpufreq as one
> possible throttling mechanism, but it can still be useful without
> cpufreq. Stubbing out cpufreq_update_policy() allows the throttler
> driver to be built without ugly #ifdef'ery when cpufreq is disabled.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - patch added to series
> ---
>  include/linux/cpufreq.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 882a9b9e34bc..dba8c4951e2e 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -210,6 +210,7 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
>  	return 0;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline void cpufreq_update_policy(unsigned int cpu) { }
>  #endif
>  
>  #ifdef CONFIG_CPU_FREQ_STAT

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

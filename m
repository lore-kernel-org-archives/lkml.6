Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D9020873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbuhqSmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D9020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeGPE7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:59:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34914 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeGPE7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:59:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so24560323pff.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 21:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gDpzzXirpndbHbcxcXi/zMd0z23itau6yYeIIs6We5U=;
        b=WbuhqSmfRiP03ZIpOp1eXP4vpwSQjJeSPCnqw2S66cjCWje1xHvZMBTTWk35iEmAzB
         XPyaiPVOFg3cZP/Qg/anoiR3/T1z04YEc4tcnoPCsnXxsaVNGSmcK92UWTN7uNqWeE6M
         Nk9gUatzAqXkDvocvZZFkFU08HSTa3Pa8Q5os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gDpzzXirpndbHbcxcXi/zMd0z23itau6yYeIIs6We5U=;
        b=DdlreABCSHN6TTGuLXF4PCA17VWpHrf5STjjrq6j89v6wI3Y6Whf54XsuyqfzSRKGd
         UihIO9LI+pz3w1jOSOeJm9NcXwflJEO6bruGEWaJa7dNxWleDXlLeBAMYDLi7QnZLcRd
         m2rPaNjGZLPFhKVhAxwdDzFCaFBd3hSUSosOQ4iQsAWe/JRnKyFtfq66tICbMeltMMSL
         EmvqsJc9ij1bXP+vpyyIFQH581nzom8kaSil2a5Ars1Tqk29G3uVBjAo7KKIptISuCHR
         E5MuOiD6100MEz/hz4WFHVIj45pWzvFtwC0BieTkdhjwRMrCMIprtDEHQ2aSXqMJzRqV
         LCGw==
X-Gm-Message-State: AOUpUlEdK2XV8TKpM+ybv8cATm9yyKNUt376hvtJlX8s7DsK2zuIZ72c
        yEhoP5uPhGrPIWLI2ICGGef6FA==
X-Google-Smtp-Source: AAOMgpdRMKn+r67EG9HrZGCzCDFd7M2bQpW1pPiPxjdIMcXpuAnOGNBUkTmqfJIOZ8TyJCkjK0a35w==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr14634894pgs.203.1531715644198;
        Sun, 15 Jul 2018 21:34:04 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id b66-v6sm23054882pgc.15.2018.07.15.21.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 21:34:03 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:04:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Allow multiple devices to
 share cooling map
Message-ID: <20180716043401.aew5yjmxjfamfqtn@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-18, 10:39, Viresh Kumar wrote:
> Allow cooling devices sharing same trip point with same contribution
> value to share the cooling map as well. Otherwise the same information
> will be duplicated for each device sharing the trip point.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index cc553f0952c5..eb7ee91556a5 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -97,8 +97,8 @@ get assigned to trip points of the zone. The cooling devices are expected
>  to be loaded in the target system.
>  
>  Required properties:
> -- cooling-device:	A phandle of a cooling device with its specifier,
> -  Type: phandle +	referring to which cooling device is used in this
> +- cooling-device:	A list of phandles of cooling devices with their specifiers,
> +  Type: phandle +	referring to which cooling devices are used in this
>      cooling specifier	binding. In the cooling specifier, the first cell
>  			is the minimum cooling state and the second cell
>  			is the maximum cooling state used in this map.
> @@ -276,12 +276,7 @@ thermal-zones {
>  			};
>  			map1 {
>  				trip = <&cpu_alert1>;
> -				cooling-device = <&fan0 5 THERMAL_NO_LIMIT>;
> -			};
> -			map2 {
> -				trip = <&cpu_alert1>;
> -				cooling-device =
> -				    <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				cooling-device = <&fan0 5 THERMAL_NO_LIMIT>, <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  			};
>  		};
>  	};

Any objections to this ? Can you guys provide Acks ?

-- 
viresh

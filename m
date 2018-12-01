Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1602082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDUQM2lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1602082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725754AbeLBFus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:50:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32932 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBFus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:50:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so4419543plo.0;
        Sat, 01 Dec 2018 10:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23Hdbk0zKsd58mBlCE/RBvxvehycCqD9tbZ/71uAUR0=;
        b=cDUQM2lhhEf9K6Ag6jrlfRF6yzcQ6CIbAWlmttgxiCDMfoRL9bnfbzkGNffQ5nJeIz
         N/KKMCH2MPxHhiQ1f48I+QnTpKaAUIT7Co25h/gYMlPMQygVR+zj39W8dw+5i73xoRis
         haoWbdOSzZS2cc/0cwsswhZhE8f2uthlXd5qEj5P7BNEaZi1D3asAst0V2UfdPvTW/mT
         6AJcuQpHnZVwxK8NTjHhkATW8GdWglI71BetHlU3E24iZ/WQ/ifT5W0exw82/DJujB5V
         zYoPs6zIpp7qvDzcG/K+/tdeGQ+Wq+MKha4710Xjr7ojiCQcov68YRkLCEs/kSz1ywsx
         ANsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=23Hdbk0zKsd58mBlCE/RBvxvehycCqD9tbZ/71uAUR0=;
        b=NKtXq3U3dHhGI+bPAH/xi5/dN3bFWY5PhmlhmJcomNWyKoEZWB3uOGCVkfYCWWcJH2
         2DCjtzPudJOaN5FW0jQmaqmO+yM2MReUKSgB6lgrA6LdY9G9mhinBLsdIVSIts/wYhRI
         pfu1aqNNdBhx6KJY9Qqx9OCDH1XQze9Kj90YHyMZw2yiOm+1A1b0qLDKHmJ95SHNrSJu
         qZ6mIiRyp72eAIXd4vZjk9p5wobiHGm6IzZYhUcn0t/pH7fRq9l6e5pLTsYYnzFAhl3L
         hH1wN3a7NdInQ89I3hj3+4Har1P8DvYgQhN1LWZq0+JncU62WMLEW6pE+bxRDKgtBoAk
         ZwAQ==
X-Gm-Message-State: AA+aEWYVnaQ1jC/1YD1xGMme8fGiGteGBfixy5Nef+1J0tbQ6PNkOuRC
        AL+l/SyAEvP1vn8Cwcrx+zRpxR4R
X-Google-Smtp-Source: AFSGD/VJzS21FLuDU3rliGczp7cvAW4ddtVJgYZOiDtBNMKzeXYaJEgLbfTaUX4onXN8PGqRddtuyg==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr10204947plb.150.1543689460491;
        Sat, 01 Dec 2018 10:37:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm8967451pgg.62.2018.12.01.10.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:37:39 -0800 (PST)
Date:   Sat, 1 Dec 2018 10:37:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add B57891S0103 thermistor from
 Epcos
Message-ID: <20181201183738.GA21777@roeck-us.net>
References: <20181117121248.32143-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117121248.32143-1-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 12:12:57PM +0000, Peter Rosin wrote:
> These are Negative Temperature Coefficient thermistors, like the others
> in the list.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Atrictly speaking that should get an Ack from a DT maintainer, but it
doesn't make sense to me to hold up the series for a one-line addition.

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
> index c3b9c4cfe8df..37f18d684f6a 100644
> --- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
> @@ -4,6 +4,7 @@ NTC Thermistor hwmon sensors
>  Requires node properties:
>  - "compatible" value : one of
>  	"epcos,b57330v2103"
> +	"epcos,b57891s0103"
>  	"murata,ncp15wb473"
>  	"murata,ncp18wb473"
>  	"murata,ncp21wb473"

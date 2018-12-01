Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AFFC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76DA2082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwrCTgnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76DA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbeLBFyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:54:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34073 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeLBFyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:54:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so4419487plz.1;
        Sat, 01 Dec 2018 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TYAxLeiYKe3dYu0rsSshM+k/2Vcm2e3F5Phi9ReV7ck=;
        b=jwrCTgnV0R/uXe4kvoPCs5U/UrXIX0nmq3xBa2pgWJO4pZElSkkV30jL3bigvDDF0c
         0eKPd0tduI4++AlMR9CSY2ep1O1ZIXoA5iXl0QyQv8GtaHrFDkFunK2658tGDmH5Ingr
         G9SxwTk2dZ1Q3NMdcj1SZv77mt6yA2CwaBvO8+QMQ52hiryo/jdbRAOiuV9FBxcJ/wbU
         YTVNWB6Ui8l8qLhSoeE7amANT4Z+WoEHBwCzk2AwKlA0BPlXSU77kkgmtQ8CLcjUUQA+
         yUNqJi038JmpupWuD6BRZb4jgJnQuBwFSIbMhg515YWGn7GhXZ3UnWjNSlVHAXG7MhUg
         qTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYAxLeiYKe3dYu0rsSshM+k/2Vcm2e3F5Phi9ReV7ck=;
        b=R3OtMKojv6s/685wtjkurA8Nf/g68AenXfYzzRSgHfsZfpKOdYc+MKnWSkXV0Qeb5L
         f0IU2qVM375QSP9kEN8XPxvdiEHY2TfqEWC6yWADt8csdq5r3HszuXjLugd7r2YLH+tq
         +wqj1u3dFG+pO8emewxyPvgPbJytMa3Vr7lx5sJ8bYFkhwxm1qCy8m6GyhcPsKzumB7k
         OZrOettv6wRmcbv56YqruTkWRhD2W6VapfcKQEw0IFy7YXaWIV1lcHR0dDMgzGY2fRhb
         xWI4KBmdwneWiFh0yHfmgIFPQHsFowr3lijQ+ueLmNimq3q5/IwoQ2tETcEQ9m7Md7zs
         XDMA==
X-Gm-Message-State: AA+aEWZGx0J52dxS14QpuvjepNun3wd3wTj9TD64cZrp72AILmkzy5g9
        Vg+x3JtA9rgnnPhiAbga5OAdLWKy
X-Google-Smtp-Source: AFSGD/Uwr0rxEHiRLP1NQ3BXDapuDOtgWhhHk/pJEidcXEnH8M7Vo3H5pi0wS1EbvJztQbvF9oYtdg==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr10248794plt.157.1543689703766;
        Sat, 01 Dec 2018 10:41:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p11sm12163084pgn.60.2018.12.01.10.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:41:43 -0800 (PST)
Date:   Sat, 1 Dec 2018 10:41:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: lm90: Document ti,tmp451 compatible
 string
Message-ID: <20181201184142.GA12484@roeck-us.net>
References: <20181123120846.16999-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123120846.16999-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:08:46PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The TI TMP451 temperature sensors are compatible with the National LM90
> temperature sensors.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/lm90.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
> index 97581266e329..c76a7ac47c34 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm90.txt
> +++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
> @@ -23,6 +23,7 @@ Required node properties:
>  		"onnn,nct1008"
>  		"winbond,w83l771"
>  		"nxp,sa56004"
> +		"ti,tmp451"
>  
>  - reg: I2C bus address of the device
>  

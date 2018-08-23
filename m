Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2996C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C667208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gag7AeaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C667208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeHWLTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:19:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45774 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeHWLTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:19:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so3345507lff.12;
        Thu, 23 Aug 2018 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q1blHs6xvSfPEQnIkNyNzZe+1jThaz+g4aVgetf+Vjc=;
        b=gag7AeaW8aXJU0XibmPYE/i+/uu1cNq2WUrGC9ysnJpoqrefdvbAjDYxamQXqmlO8S
         UCJv6BXH1Lw8RCqatSkeg6wNrL5TST3a3pb17sXLPRxUO04yhLUYGlRvNoVnpXMv2w2W
         cnV6qtCEnf2g//X2ukEJEXdZHjc/4O/XeAKCcRvsquSdgtm5/DZYkw/wCYhbaTcaG7PU
         oLxyz30MoKa48x7y0RmEb3EWLB/yb3rDNFCzZqOENLm05BnUI5t36FigQDZj8Aoev+sz
         C1h6elqezg1N242NiSKfIgfGpnKn4Txd7e+PSIqBavUj9FXNa60WdbhGuAyg8KvnYWU/
         pB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q1blHs6xvSfPEQnIkNyNzZe+1jThaz+g4aVgetf+Vjc=;
        b=lpNY2GfiMQoq9fMumZIU3gD1RinaR96F1Nc/XJDONQK4EZm8rPIGVpMs9qfV4E2dwb
         HtoRrawBxkWTH1S3XqIeMwEr/3XRy7yXcid0qyMwtqaCqaKv40j9ddyUMAQH/uYPQhXg
         v8iPuWUVG9B2g2lEOzE17zOTXs3U1c/93BljbqU6X2NfNaxMHaK0hfYXs2cIi6Nhqphi
         FkDJ3MBX9ulkbi0e0hRvCbARAb3ENOD4Zwme20FjbWx2lhERSM4SUlRCL2VI1r12dQN5
         4rHMv7hwl/Pq9F5bHwKI+uU0qSXxeRFJSxAUCeqNVcLZWYXmLfhc+oEenxdN1WXPUR8e
         Ju5g==
X-Gm-Message-State: AOUpUlGgqzGoHi5jC7nqaqCU4vWZnXAxCV46BV0IIqHt6Z0ZNJn4XKs0
        x0kFevO+GnT8R7mb8jEPcbo=
X-Google-Smtp-Source: AA+uWPydz6DcRelq6B74wlKpCj/DUMNP6MVfRRgR4W3IqUMihLhePr94owI9z5Hoyd5MeJV5Y+jjRA==
X-Received: by 2002:a19:870b:: with SMTP id j11-v6mr13417676lfd.4.1535010660242;
        Thu, 23 Aug 2018 00:51:00 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w75-v6sm714580lfk.68.2018.08.23.00.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 00:50:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fskOQ-0007FM-Rt; Thu, 23 Aug 2018 09:50:58 +0200
Date:   Thu, 23 Aug 2018 09:50:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Only register platform_device when
 supported
Message-ID: <20180823075058.GR14967@localhost>
References: <20180823024432.7000-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823024432.7000-1-d-gerlach@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:44:32PM -0500, Dave Gerlach wrote:
> Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
> the driver to probe on any platforms where the driver is built in.
> However, this should only happen on platforms that actually can make use
> of the driver. There is already functionality in place to match the
> SoC compatible so let's factor this out into a separate call and
> make sure we find a match before creating the ti-cpufreq driver device.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 3f0e2a14895a..541fdcf17b57 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -201,19 +201,31 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
>  	{},
>  };
>  
> +static const struct of_device_id *ti_cpufreq_match_node(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_node_by_path("/");
> +	match = of_match_node(ti_cpufreq_of_match, np);
> +	of_node_put(np);
> +
> +	if (!match)
> +		return NULL;
> +	else
> +		return match;

Shouldn't this just be "return match"?

> +}
> +
>  static int ti_cpufreq_probe(struct platform_device *pdev)
>  {
>  	u32 version[VERSION_COUNT];
> -	struct device_node *np;
>  	const struct of_device_id *match;
>  	struct opp_table *ti_opp_table;
>  	struct ti_cpufreq_data *opp_data;
>  	const char * const reg_names[] = {"vdd", "vbb"};
>  	int ret;
>  
> -	np = of_find_node_by_path("/");
> -	match = of_match_node(ti_cpufreq_of_match, np);
> -	of_node_put(np);
> +	match = ti_cpufreq_match_node();
>  	if (!match)
>  		return -ENODEV;
>  
> @@ -290,7 +302,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  static int ti_cpufreq_init(void)
>  {
> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +	/* Check to ensure we are on a compatible platform */
> +	if (ti_cpufreq_match_node())
> +		platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +
>  	return 0;
>  }
>  module_init(ti_cpufreq_init);

With that fixed, feel free to add:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan

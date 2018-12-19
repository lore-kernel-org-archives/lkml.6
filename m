Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC03C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A18421850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8Qa3Vlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeLSLGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:06:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52661 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbeLSLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:06:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so5648934wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 03:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDEq0xEKE5sZIIIOJo6rYMCXG3pYYRQ6TJUoMidPF1U=;
        b=c8Qa3VlbAb0xyFOn7n+U272BTOTP1pPO/ipP6So6iUWUFM9mGrKq/ig3yQkOWFYrnc
         yqStMvDqb+tsyVFsGWLuqB4XHSMJDTPseTmkg+5pT6ietTSrCBJu1d8MxuiOEgS2wCTi
         FBJk+LPxOeLChIoJYezwk4mt2GFpTHtSru6bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDEq0xEKE5sZIIIOJo6rYMCXG3pYYRQ6TJUoMidPF1U=;
        b=sp+v2BdAYw1a0Bks5UDK+7rviY9ic/UzfDMz9s3tCS+otmpUCRHjN4a1Pvlo+qv5ZA
         /GPxJWhVnTojpItDOLQ7OEp2IX55OXZuRR/WWygvGxrUZMzfG5zu1SkEEfumssNXA/cp
         oJBQdPMQy0cA76ADTkc6BL7GYGKfDaXvcC7yMSZ3k1eI3YCw9SWyPuw+GHn9PoWapgLJ
         o9keswhyMtn+lBDIDgkebBIWV49Rxf92TqzN4DLwjrQLRax3AgDza6+F6BzvAimj8h4I
         prdCI7imsA/tq205HN1ubgmZkiugJzN6xvUzBGKxcS8wLbz3BP5Fyn3sUwPWmAlKxCVK
         Lx6g==
X-Gm-Message-State: AA+aEWab6Nu9tSxo2G9XyT8z6cj6D628JrlPLklsDONZznl6trYsaLFH
        VQxjsBnv2kzKaYVDQM6CfQ8nZg==
X-Google-Smtp-Source: AFSGD/WKRl4Dre+tuzBpXSTaAcZm1YHV1gsPAYPum/p7Mh/psATqg9L5xNmroWSb5VYWi5yVi49jKQ==
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr7159274wmd.66.1545217559629;
        Wed, 19 Dec 2018 03:05:59 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
        by smtp.googlemail.com with ESMTPSA id l37sm9343331wre.69.2018.12.19.03.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 03:05:58 -0800 (PST)
Subject: Re: [PATCH v10 06/27] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-7-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <65605bbd-ceda-2266-615e-20b9d3491bed@linaro.org>
Date:   Wed, 19 Dec 2018 12:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-7-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> The CPU's idle state nodes are currently parsed at the common cpuidle DT
> library, but also when initializing back-end data for the arch specific CPU
> operations, as in the PSCI driver case.
> 
> To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
> the device node for the CPU and the index to the requested idle state node,
> as in-parameters. In case a corresponding idle state node is found, it
> returns the node with the refcount incremented for it, else it returns
> NULL.
> 
> Moreover, for ARM, there are two generic methods, to describe the CPU's
> idle states, either via the flattened description through the
> "cpu-idle-states" binding [1] or via the hierarchical layout, using the
> "power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
> take both options into account.
> 
> [1]
> Documentation/devicetree/bindings/arm/idle-states.txt
> [2]
> Documentation/devicetree/bindings/arm/psci.txt
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Nitpicking some kerneldoc formatting below.

Other than that:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v10:
> 	- None.
> 
> ---
>  drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  8 ++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 09692c9b32a7..8f6974a22006 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -429,6 +429,41 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
>  }
>  EXPORT_SYMBOL(of_cpu_node_to_id);
>  
> +/**
> + * of_get_cpu_state_node - Get CPU's idle state node at the given index
> + *
> + * @cpu_node: The device node for the CPU
> + * @index: The index in the list of the idle states
> + *
> + * Two generic methods can be used to describe a CPU's idle states, either via
> + * a flattened description through the "cpu-idle-states" binding or via the
> + * hierarchical layout, using the "power-domains" and the "domain-idle-states"
> + * bindings. This function check for both and returns the idle state node for
> + * the requested index.
> + *
> + * In case and idle state node is found at index, the refcount incremented for

s/and/an/

s/index/@index/


> + * it, so call of_node_put() on it when done. Returns NULL if not found.

The Return description must be in a separate section.

> + */
> +struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
> +					  int index)
> +{
> +	struct of_phandle_args args;
> +	int err;
> +
> +	err = of_parse_phandle_with_args(cpu_node, "power-domains",
> +					"#power-domain-cells", 0, &args);
> +	if (!err) {
> +		struct device_node *state_node =
> +			of_parse_phandle(args.np, "domain-idle-states", index);
> +
> +		of_node_put(args.np);
> +		return state_node;
> +	}
> +
> +	return of_parse_phandle(cpu_node, "cpu-idle-states", index);
> +}
> +EXPORT_SYMBOL(of_get_cpu_state_node);
> +
>  /**
>   * __of_device_is_compatible() - Check if the node matches given constraints
>   * @device: pointer to node
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a5aee3c438ad..f9f0c65c095c 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -348,6 +348,8 @@ extern const void *of_get_property(const struct device_node *node,
>  				int *lenp);
>  extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
>  extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
> +extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
> +						 int index);
>  
>  #define for_each_property_of_node(dn, pp) \
>  	for (pp = dn->properties; pp != NULL; pp = pp->next)
> @@ -762,6 +764,12 @@ static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
>  	return NULL;
>  }
>  
> +static inline struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
> +					int index)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_n_addr_cells(struct device_node *np)
>  {
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


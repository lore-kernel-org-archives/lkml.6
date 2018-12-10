Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365FBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E684020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D1+0BX7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E684020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeLJL73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:59:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeLJL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:59:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so10165203wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qaCop6a20Q0nzan8ttHGf8/SjzJGQNLWRubPwRQfQMI=;
        b=D1+0BX7fKXu+i8t0vGqEkByaaAh+qQzDGYRjkSqTqLOrJ5vxujRjXOoRgO32PLNXa2
         PRUoCeh0xFr1ENXf9YtYH22gWhqK8oIgOm0JmAtyIYio8XbZKkwKmZJcLi4XQgz0hW3u
         rKgMtGjyXKlEcALUQUVnFwZie5hc9o/4fDsW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qaCop6a20Q0nzan8ttHGf8/SjzJGQNLWRubPwRQfQMI=;
        b=BXnPL1B8QfQHi/Gyh9eUXY7ZnoH44WaDbVj7UsfAnb/dUUkXLCFafCa7VPjPJ04ZbV
         NBvV8brKaJ0dWgLfJqCVKf5H1baBkOyZQ26uhmt4hZSyX2lInF65e6Y2smAOZNHWNkSu
         yiOXMO72i1DrjVuQohNPsalcIILbFxd+wDI5L63exLis7/1V1YA2kSm/G+i67WQzliAY
         Rx6WX29JBCGqmEuEsdvUIHYrBDFP8jFrW6OeLh55dFFU6XXuLg5X301k/88Q1v4S+4C0
         6Dowuxowf7lmee7vTpfKHUi/h4A2BesHC6mP/YSyaJLELMt3AOzil+DNsdZUhILG7NmC
         PQ6A==
X-Gm-Message-State: AA+aEWYpiH8neBzKHW5A/vR0Q3czgcAIDW+7GbBF6Srq0Tyu0SbtexBS
        ijITeglGDJ4UKL7+NusjGyz5s/u+y3M=
X-Google-Smtp-Source: AFSGD/WMZ6FH/0LB50BqAbb2y7mE9InaQbsWXqgAutW2V4jH7YsxP5CxEuE0aRuQOozhiXv6NE+X0A==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr10084831wrr.162.1544443166749;
        Mon, 10 Dec 2018 03:59:26 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id e142sm30847835wmf.46.2018.12.10.03.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:59:26 -0800 (PST)
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, rjw@rjwysocki.net,
        lorenzo.pieralisi@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181120161451.21149-1-tiny.windzz@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
Date:   Mon, 10 Dec 2018 12:59:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120161451.21149-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yangtao,


On 20/11/2018 17:14, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v3:
> -update changelog
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index db2ede565f1a..650f063ef809 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
>  	/*
>  	 * Initialize the driver just for a compliant set of machines
>  	 */
> -	if (!of_match_node(compatible_machine_match, root))
> +	if (!of_match_node(compatible_machine_match, root)){
> +		of_node_put(root);
>  		return -ENODEV;
> +	}
> +
> +	of_node_put(root);

Don't duplicate the of_node_put.

I suggest:

const struct of_device_id *match_id;

[ ... ]


match_id = of_match_node(compatible_machine_match, root);

of_node_put(root);

if (!match_id)
	return -ENODEV;


>  	if (!mcpm_is_available())
>  		return -EUNATCH;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


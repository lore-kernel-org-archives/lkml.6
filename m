Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65756C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C82D20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uu8MIxIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C82D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeKZQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:55:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36151 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:55:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so6039925pfc.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r1u8K0n6rtpEId+/esDvsEnjdzMp18LIYOpA/7ZeQoY=;
        b=Uu8MIxIQ/u6lu8ohtjf93as+hA0Zd2C6NjknMQPXBzwwNjnEeCeI8JDVKxZDDV3CqS
         +on5WUIaSl8bAbTBnzT2njhDi/CDIcmVsFfKOId5NgW1ndcoYH8JBBgtnZMHyKzRemm1
         3tQKDl/eUzO1Y//2w/CE4kZzI4CVDPkKjzql8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1u8K0n6rtpEId+/esDvsEnjdzMp18LIYOpA/7ZeQoY=;
        b=OdON1u+L4Wa61ANuj0zy4Ia1czxA761p22EEtXwikzM00sRYWel1Pg5FXhSgYsclnl
         XBcx0o+QvzHImLJGLZm1dxjjz7XQGy4iSIsZQVVUJUVOCwvYP97u8htVW76SUxH5yDVy
         +Et48GyY+wTrMK9vA2dm0KiZH7o4Z/PniQU88gag7EVAwAgzbV8aYAlusWWkfEPCycem
         J8sS2KdfdqUkJqnX+WfoALu2CbrC0joiOWCwO2x1goQqTbseG0eR9gDJlG8P0Bopk00l
         a85nu5GNeccPFBX8L3EfDZmFE+H3SbLxaOj7H/WiCZv9I6hOecLp457lAevy6QFxMYIA
         lzrA==
X-Gm-Message-State: AGRZ1gLHtyN+HmZNWSnL/ysAsEhzDOm7K0U7dJyCsDMcIRd2p4L7bFyG
        fVpC+tE1WP2/Bulbr1q4367wUA==
X-Google-Smtp-Source: AJdET5fG6bRXOQmKH6ffUHgy93RTHgYoYpyCII9lbH/0T2Mmz2O8vO4NbsxmmkqDtrXDPKx0E++lOg==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr26073868pfu.3.1543212148919;
        Sun, 25 Nov 2018 22:02:28 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id y26-v6sm24668763pfi.123.2018.11.25.22.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 22:02:28 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:32:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: pmac64: add of_node_put()
Message-ID: <20181126060226.wsludir4g7bao4lk@vireshk-i7>
References: <20181123133340.26849-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123133340.26849-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-18, 08:33, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> g5_neo2_cpufreq_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes in v2:
> -update changelog
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index be623dd7b9f2..1d32a863332d 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
>  		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
>  		pfunc_vdnap0_complete =
>  			pmf_find_function(root, "slewing-done");
> +		of_node_put(root);
>  		if (pfunc_set_vdnap0 == NULL ||
>  		    pfunc_vdnap0_complete == NULL) {
>  			pr_err("Can't find required platform function\n");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

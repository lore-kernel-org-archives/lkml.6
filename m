Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9272AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5986D2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm+hdtdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5986D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeKUOcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:32:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45420 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeKUOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:32:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so3433782plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WLVfDtgQ6dMyB51L8SjOel24v6nbaFrKazs5k12L7JM=;
        b=Dm+hdtdQ7e2DxFOxslOBy1kf+z/7GfVyHKMA75HDhGlDJbiMXbnqHrkk5l0gHI7TC/
         inVbLDLPSdgY8Igc9CyeqZxzI627+2oESyRD6D3n7mu9t4/DiGkycUqYEK8oNoV5TNui
         +O0mipytwm9p3rmA5N1jGE7FdFlc55y0+QAqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WLVfDtgQ6dMyB51L8SjOel24v6nbaFrKazs5k12L7JM=;
        b=iwjoCfoeJj9JY+4OaZzKQk63jr6rzsexGgd14ETEC+x+JPDefAmZCOUMkBXTFh/9mF
         /Oi3ubmrKTkAVW4JTnzKBDqFzXRT4Kz8KtvW4vrKgCD4xsxwle2SFVJZ2u2ILhlJ4xot
         cFrXlkYbJw8qFFrJQMNav2x3ERlCrnoNnjdYbsBaFV7I+P0zOO1Mu/M05WDyavbQ1bq/
         05NH9ykBQxoeqXZlfRfLXc7HbYAh+3KN5OBLSIdAVHCEf4I6s12O7cuTp7vBAFUk2/Aa
         J/7an+IQUzBuKa++rodLVnm3fdrgsPSZwIBOC+qIEHE1+KZpcwDxqHkda5Ujgs7+6JGi
         Ldaw==
X-Gm-Message-State: AA+aEWYrOoGvwBxOjJKGhoBrimLckn5aJCIoEx/CjnZwBaZoN+BNFwwg
        ORiReAIelJceWDSsJmlYhr9dRQ==
X-Google-Smtp-Source: AFSGD/X2gxcamV/45/9rwmm/ng7Hsx5N9QgQKGtMRuT8RfPpWhca6zTlDbsHA3YwRuB8fLSZxNYxjA==
X-Received: by 2002:a17:902:76c2:: with SMTP id j2mr5142138plt.339.1542772772901;
        Tue, 20 Nov 2018 19:59:32 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id i63-v6sm11568838pfi.66.2018.11.20.19.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:59:31 -0800 (PST)
Date:   Wed, 21 Nov 2018 09:29:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pmac64: add of_node_put()
Message-ID: <20181121035925.67fsysw6jyswb3op@vireshk-i7>
References: <20181120125409.19314-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120125409.19314-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-18, 07:54, Yangtao Li wrote:
> use of_node_put to release the refcount of node.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
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

Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD24C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F92E21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J004psXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfAWHQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:16:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45047 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfAWHQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:16:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so707226pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 23:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M0OY24iaJ+LUgpnwgOEWWd2b46N5j14tE0jLJuqHeC0=;
        b=J004psXZOug1mdymxftV8S96zHa4pk9qXVZ8rkvUQh+cWfk6Cj+oIDPrJotDBA3CqQ
         OQzt09UXIhzwf4PXXzHPBB/OvTQ8V+/EBDhDaSyNiLoIqtx4hRzvlvxRn42PGsDfRjs9
         Qd4jy2QvpY01WXVfI7V3bCbIHX26h+LRbPugs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0OY24iaJ+LUgpnwgOEWWd2b46N5j14tE0jLJuqHeC0=;
        b=OAqPpOlG3FwcvvI6ZR9f/awFtSSsvHodE8g7drlKdbgGXYhV/oKSHR9NrvPmVpfPw5
         kdjiz6WtO2sbizFL0GH4d0H265G3SS/95Hpcmx+Ka9KqKGlsyPkqM0GEsAcuWFOxzfnd
         C+8ILs3MccMY8qnXcu/vO4RlgGljp2ZV2e8OKORXG8U/jEh8JVJ3dpk85AeIahFqjCfF
         M9XbDvsJrmH4TxaQDfzDQ4rfnIwwg4x1/Z7LvljxFiYLYXz0ap/GmZ3hHbwEPVIWHZlA
         c5ejFOdt5fVu66FmEAheXOeWBwVRQGcyfX/oOWFeJI8P2GSswp2Yvng8NCVWfycBNSbZ
         aI9A==
X-Gm-Message-State: AJcUukdah55FR3+WwVPyUFHibpnOfWitduthaXxqUprax52VfskAYg7j
        OHL0iEH5kUlKoL094VqVrswvJA==
X-Google-Smtp-Source: ALg8bN6Dph+164Mj0YHE20MrAORr2EL3XF4Ug5oN5nprfjYnD05QqbWSmBA5fsxhlfyVNUk2CiJi+Q==
X-Received: by 2002:a62:4587:: with SMTP id n7mr1087463pfi.118.1548227777202;
        Tue, 22 Jan 2019 23:16:17 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id h129sm46557742pfb.110.2019.01.22.23.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 23:16:16 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:46:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] opp: no need to check return value of debugfs_create
 functions
Message-ID: <20190123071614.nyzopisx4yhojgw3@vireshk-i7>
References: <20190122152151.16139-18-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-18-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-19, 16:21, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/opp/core.c    |  10 +---
>  drivers/opp/debugfs.c | 109 +++++++++++-------------------------------
>  drivers/opp/opp.h     |  15 +++---
>  3 files changed, 37 insertions(+), 97 deletions(-)

Applied with following changes. Thanks Greg.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 91d15c58eae1..d455b84cce5a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -793,7 +793,6 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
                                                struct opp_table *opp_table)
 {
        struct opp_device *opp_dev;
-       int ret;
 
        opp_dev = kzalloc(sizeof(*opp_dev), GFP_KERNEL);
        if (!opp_dev)
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index baac1ae33c55..a1c57fe14de4 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -93,7 +93,8 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
        debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
        debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
        debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
-       debugfs_create_ulong("clock_latency_ns", S_IRUGO, d, &opp->clock_latency_ns);
+       debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
+                            &opp->clock_latency_ns);
 
        opp_debug_create_supplies(opp, opp_table, d);

-- 
viresh

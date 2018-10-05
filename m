Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4399BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC47520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU/l5Hn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC47520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeJFCBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:01:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41471 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJFCBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:01:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so5485944pfi.8;
        Fri, 05 Oct 2018 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SKuVjS39dss0fkHvroG63d4smHsNEcsKSPK9HCDaGvc=;
        b=rU/l5Hn2UfVBuTabRnZakLv1dgkUSNdSNIfqi6RPHBUbfTjlp4g6JnOpE6NXicoLr3
         VC6bF9lkTvHA5GbEuBnF5NM1uvxUEtpYX/pxempM5jDpfjsvPehq2HU9tjfCLQwX1B6A
         TC28RokWaM5uCHjKcI+85TRu0wUN+O11dR42ttc2Bik7JKGHSoBJQ6mnB9fFtKtuw4Ks
         f1pFMn9RJB3XVMC+AgCGDkaCpHolP6eEaFUkDH4s5jihuAhW4oxbLeBJJ2SiaHyZ5uEy
         Bb4lLv3M/L7DAKM4eB3GKPIdAiQ0YF8ZSua1/WVfWzmgr/75kDcnx+9VfMDnc+0yXBqs
         Ewhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SKuVjS39dss0fkHvroG63d4smHsNEcsKSPK9HCDaGvc=;
        b=LioCk5kQ31m0Tk0/qJx9b9hY1mCX2lg5YpSomeWsMWPoDfLfybkz32ZzXsX6XnaUQf
         VXGCXZt8rTEaxIBHsfa9VY1FERKf4BUI/NVEu1evmavrjY1rsL/COfDuYrBap8M8rYMy
         zzut1hksGF4a87QdLHfBya47GEUp/S4iWcVeW3bpn4iAlEJ84deCAAGU88ggVVfLNK7M
         RykjZ8Q9yYwbL0kEQAxplKpAfe/l3ZII6Neh5z3EzaHAmal2AmORzKUaGKYTKXhAA2B/
         A8v/FMokkkEIPl/j3IXvNtljo3XQgLvU7EvsSwWmIQkFso9giy86MERV9RQQ7gI/pp7W
         0fCw==
X-Gm-Message-State: ABuFfohQDYQ1M/WsoEF3vISlJFB+0RmjwoSGFA7QYA/QzfEgJIqoJL36
        sT4xhezKGxLOAhctYOF1x0g=
X-Google-Smtp-Source: ACcGV62fXxPvOR8XVMeEIr8fYMn/0r0XDFKvTXsNB6jtOMfU/gEZT83wIMwKDcyX6pk7S1cP9aBXFg==
X-Received: by 2002:a63:f:: with SMTP id 15-v6mr11271387pga.15.1538766062657;
        Fri, 05 Oct 2018 12:01:02 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f25-v6sm10916996pfn.177.2018.10.05.12.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 12:01:01 -0700 (PDT)
Date:   Fri, 5 Oct 2018 12:00:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: dt-platdev: allow RK3399 to have separate
 tunables per cluster
Message-ID: <20181005190058.GA234868@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3899 has one cluster with 4 small cores, and another one with 2 big
cores, with cores in different clusters having different OPPs and thus
needing separate set of tunables. Let's enable this via
"have_governor_per_policy" platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2 changes: commit message updated.

Not tested, but we had a patch unconditionally enabling
CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag in tree we used to ship devices
based on RK3399 platform.

 drivers/cpufreq/cpufreq-dt-platdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index fe14c57de6ca..040ec0f711f9 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -78,7 +78,10 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "rockchip,rk3328", },
 	{ .compatible = "rockchip,rk3366", },
 	{ .compatible = "rockchip,rk3368", },
-	{ .compatible = "rockchip,rk3399", },
+	{ .compatible = "rockchip,rk3399",
+	  .data = &(struct cpufreq_dt_platform_data)
+		{ .have_governor_per_policy = true, },
+	},
 
 	{ .compatible = "st-ericsson,u8500", },
 	{ .compatible = "st-ericsson,u8540", },
-- 
2.19.0.605.g01d371f741-goog


-- 
Dmitry

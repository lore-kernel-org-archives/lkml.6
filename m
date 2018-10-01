Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60392C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A24E20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujrZ86Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A24E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeJBDB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:01:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37329 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBDB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:01:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so717055pfi.4;
        Mon, 01 Oct 2018 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9ANgA3JJUuVJnuk2u/VqOow+eIWBO3j8383PwPVILCc=;
        b=ujrZ86UnRjvJlzsYGqyneMwI+9L4eIvqtoIe/OLXRfAwOOUprd+z6csxIco7UAFU70
         R5buC4HJP9EJEOlFMc1RGJkTSG/RdeyVbcmUrtGLkxwQPjZqNcwJwspH7cIt6g9W+/m+
         22ows/xuuijKCw9g6McdcaRUyRIv8qaX3iz7DArLvMahzejGnISW5+Ml4ANP2NLKGz5S
         gFWuuehbJ3MmqsQP2RUjFiQO7R0qAj9qE5QnrmqjCl48KswKl/5NoSqm4UHZRYTDIy+D
         2+w2SKnXmDfEu/fZ3vfguIEFX4BdxJk/wIE2nDomj/XMIMGJUDGx9cYtc84i/NDj1tL3
         CRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9ANgA3JJUuVJnuk2u/VqOow+eIWBO3j8383PwPVILCc=;
        b=eoEMSa11MknMTwHZ7q1fw0WjIetHDWU7lT3RGWCOQd6p3nfiB3+QbTPhTDE55DMAIe
         4GLf8/cHMSsn++etZ5C28k8KIsQkJpDS9wmCEBFAPeN2rdMSpNsrkxtlXz/Tgg71fVoc
         TOb3/YqJ9NldlfMbh8uCH0zKzXXaA61+ncfwhuyU/bXAkPUEC5AzaDwdo8MLWOMIi1xS
         rfYcBzslF65aFqvCr7krccfVg8PHt+Fr50Hp1FDip1N4Z2UxbwpplBTwe7wySw45biCk
         Kg7q6DxSbcRWU19lIad065kdt7bb/p/0BJfjaRZDZhxbTZuKSX1G0oTrL/NJl19LmjDy
         dwxw==
X-Gm-Message-State: ABuFfohjlJQfqgRb+iT9DxpOD8pE7rl/YyvnTxjuMuWuXXQ/hsKsI6YY
        UHX/ELUJHwrdwd8QW1CLt5c=
X-Google-Smtp-Source: ACcGV61L8mopk4PLgrvknYM+jh29p3XrWemxaTzD4Xb143EXvY53gAjbaQi768Yc+G79fL2pN9R3yg==
X-Received: by 2002:a63:1302:: with SMTP id i2-v6mr9628730pgl.380.1538425317243;
        Mon, 01 Oct 2018 13:21:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t22-v6sm24709517pfk.141.2018.10.01.13.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 13:21:55 -0700 (PDT)
Date:   Mon, 1 Oct 2018 13:21:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: dt-platdev: mark RK3399 as having separate policies
 per cluster
Message-ID: <20181001202153.GA240123@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3399 has one cluster with 4 small cores, and another one with 2 big
cores, with cores in different clusters having different OPPs and thus
different policies. Let's enable this via "have_governor_per_policy"
platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

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

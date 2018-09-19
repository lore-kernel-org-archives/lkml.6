Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF798ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A617821521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Djc6bI6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A617821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbeITEA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38615 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbeITEA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so3349369pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=25gV/yr+DQaieOUd7LXdpHMVharUDBC9tXEOJxeQeO8=;
        b=Djc6bI6BMMVojfSs9W39ToJZ753bA6PsqPD81ey1/C6zHiIfxmZW6YnXtHhub/fUNm
         7HMSwb/5oxeFPv89MelgsJ76rIoRbPpkKQjuQSkDhXcmrMVXJXFvLri/s5j7QEj5CvVv
         Y5Tty7RqTw+A7oAp+29XLZVaByP+2HFlecf5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=25gV/yr+DQaieOUd7LXdpHMVharUDBC9tXEOJxeQeO8=;
        b=WzxdcVJ0JzChuxJbfshNR+qeeVuCuK1MZBMZKnW0zIeKbfz0RA6zayTlqLcRohTe5+
         Jv3msIXp/75LIhbz75ZVXFOWIeExPhtOqbplJ/QJnS2+/FdBMlcT3eR+lyNIr6xn1ac1
         rKWS+jANNzi6n+yuVAXijld5sAp78xYdHl+TDy89SasAV7lsQHOdOqxe+Y0HHXYMhgMt
         8vQJ0QsV9r6yKL1Veug9EMPmkeXRjKGEFk6Rsu/II93NJ+cgV4Ouzx7JUBXOKAGq3CW8
         s2QhnyN2mR2S/yjGI6ef+3SxToRXg7xP/bBBVJEJ/5gMqmY0ywS4xezYQEkaNWpMYsK6
         fhSA==
X-Gm-Message-State: APzg51D3dREZbpqhdshr2Zt7ZsWe+NwUUJfjUeNU/YQ5rO1uUipDI0jN
        TXnpeqAPfqhKb3rUF3VUDvjnSg==
X-Google-Smtp-Source: ANB0VdbnIvHZfHKwjt12/ZMC4gDh+MnJZSinZAWMt77a/ti42fjrtALCbyoQD6ymS14FPdNT8bPyeg==
X-Received: by 2002:a63:26c6:: with SMTP id m189-v6mr33939143pgm.70.1537395655114;
        Wed, 19 Sep 2018 15:20:55 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k23-v6sm23996094pgl.42.2018.09.19.15.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/12] cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
Date:   Wed, 19 Sep 2018 15:20:27 -0700
Message-Id: <883071c4bd9a6e45bf0b5e45575d110eaeb2e6d0.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_cpumask_remove_table() is going to change in the next commit
and will not remove dynamic OPPs automatically. They must be removed
with a call to dev_pm_opp_remove().

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/mvebu-cpufreq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index 31513bd42705..6d33a639f902 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -84,9 +84,10 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 
 		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
 		if (ret) {
+			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
 			clk_put(clk);
 			dev_err(cpu_dev, "Failed to register OPPs\n");
-			goto opp_register_failed;
+			return ret;
 		}
 
 		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
@@ -99,11 +100,5 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
-
-opp_register_failed:
-	/* As registering has failed remove all the opp for all cpus */
-	dev_pm_opp_cpumask_remove_table(cpu_possible_mask);
-
-	return ret;
 }
 device_initcall(armada_xp_pmsu_cpufreq_init);
-- 
2.14.1


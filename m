Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB29ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4D3206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YERew+MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4D3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbeITDSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:18:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38045 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732724AbeITDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:18:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id t84-v6so3350246pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iTchldsYhyDPFCiRic9iRa2/5REzN2/e/p1pgEkEsDM=;
        b=YERew+MCnEqT2eHkPRi61n7+ps0GuWzCkBxiU6RO9BJVrVlImcjE4bScvtFMuNlpwd
         J7zmMw7MkyMKnXiaJ95FZOz4ud6IHfsOpuYkveDIHT+VZR0oENa3njR/0knUqYKIw0cP
         9NTnkPNyUq9AxO5zGX0wI2MjSjA2x6Nvnw7RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iTchldsYhyDPFCiRic9iRa2/5REzN2/e/p1pgEkEsDM=;
        b=Hh41xtk08lRFP/0JVOlyzsdtptEj+ieQOvBYo8W83pEVv4kxTKtRYHo07McJWfsbFJ
         jffK5caYEQkwao9UqUBowwuua6IDaiOM8HthLuwQo9AzhXObb8ZjpO2Ok8B6HrE0Mcam
         PmDTr4t1mkjRxrb5NblcFkzUEhlZKc5QN1W0Kv22IcFZEVYSpf7q/QU4574u8fiqrlJE
         5Akofn1LrN2Go9cgNH+9v0RTlkppZKY5WvnLpfLr4q7cK6dHz/Kqo4ovG7pPIyhCpZ9/
         y8ykl6pnnUw7GfjpMhJdhg+iiHJFaa4Vp379YYeTyFMbKOSKXFAaDqPKlOksuc4NtVEY
         kziA==
X-Gm-Message-State: APzg51BGGKuQJnJrQLfhUQzqh9ifa5JX8Qpt35LnxnCks8gr51M5msYQ
        Z3otUD8Z+eUYaJOo1D7jt5rHxw==
X-Google-Smtp-Source: ANB0Vdax0aNlkV5VudivKkXE256ZGE0JNFaTJq5IGf00OnGrVEokTeBtAP054j8O58IN09kWXD8ezw==
X-Received: by 2002:a63:4e4e:: with SMTP id o14-v6mr137181pgl.181.1537393095065;
        Wed, 19 Sep 2018 14:38:15 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id s23-v6sm29826267pgo.44.2018.09.19.14.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 14:38:14 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:38:13 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "4.18" <stable@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices
 sharing OPP table
Message-ID: <20180919213813.cd2q6ciyuhpwgdqe@vireshk-mac-ubuntu>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
 <20180912135537.GA9985@centauri.ideon.se>
 <CAKohpomVR_U9cA2yFLWjQ0pLdjp_d8=s2C7cvbauacha0Uv8xw@mail.gmail.com>
 <20180913102113.GA25222@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913102113.GA25222@centauri.lan>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-09-18, 12:21, Niklas Cassel wrote:
> You confused me here, since you did hide the fix for this old bug in the
> middle of your new patch series :)

Actually I had to place the fix at the beginning of the series and
that caused git rebase to have some conflicts. And so never posted the
diff.

> I think that it would have been more obvious to simply paste the fix/diff
> in your reply directly, since that is the most common way to post a
> potential fix. Or, if you are really confident in your fix, post a V2
> directly.

I will post the v2 now.

> However, your branch works like a charm, so feel free to add:
> Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
> when sending out your branch as a V2.

Thanks.

Here is the new commit though which I added to this series:

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 13 Sep 2018 13:09:27 +0530
Subject: [PATCH] OPP: Don't try to remove all OPP tables on failure

dev_pm_opp_of_cpumask_add_table() creates the OPP table for all CPUs
present in the cpumask and on errors it should revert all changes it has
done.

It actually is doing a bit more than that. On errors, it tries to free
all the OPP tables, even the one it hasn't created yet. This may also
end up freeing the OPP tables which were created from separate path,
like dev_pm_opp_set_supported_hw().

Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/cpu.c | 8 ++++++--
 drivers/opp/of.c  | 4 ++--
 drivers/opp/opp.h | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 0c0910709435..2eb5e2e7ff66 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -108,7 +108,8 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of,
+				      int last_cpu)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -116,6 +117,9 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 	WARN_ON(cpumask_empty(cpumask));
 
 	for_each_cpu(cpu, cpumask) {
+		if (cpu == last_cpu)
+			break;
+
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev) {
 			pr_err("%s: failed to get cpu%d device\n", __func__,
@@ -140,7 +144,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
  */
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, false);
+	_dev_pm_opp_cpumask_remove_table(cpumask, false, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 20988c426650..86222586f27b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -592,7 +592,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
  */
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, true);
+	_dev_pm_opp_cpumask_remove_table(cpumask, true, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
@@ -627,7 +627,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 				 __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			dev_pm_opp_of_cpumask_remove_table(cpumask);
+			_dev_pm_opp_cpumask_remove_table(cpumask, true, cpu);
 			break;
 		}
 	}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 7c540fd063b2..a9d22aa534c3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -196,7 +196,7 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of, int last_cpu);
 struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF

-- 
viresh

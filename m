Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x226QyGoGC9nGpcE8CglYCVyshtnwO9BKz6h5czvxVX/8OjR91kTDJW1dSgg3OuUmwN8fyXLS
ARC-Seal: i=1; a=rsa-sha256; t=1519403081; cv=none;
        d=google.com; s=arc-20160816;
        b=s+O49ZmVD9xqxQLSbbYG/cF+VwGGvFxocuRutYvZibU+91niv+D9imnr0ddyzoM8j1
         4ZB+KJsNREdGMCezGi7arStxMiNrvCAGs+Y9tP9lfxcYCdwZGgGazc9DCS3Na3zIlEho
         ihXQlchf0ucIT0HuBg6EOqNQcfLp0NQsOJaexrZV8qE8EXN4ccEKilfFEQT2YlWkD1IR
         C0nfBHQXdWuGqmA/uu3l8NBMjcTWpl6uF3FwnsWm6OCfQjOY7gWOVPewCpUkhr4ZV6KH
         G1GKpR4VgrGI6Pj1aBPVRjZff82KwZG/cUBjg+zZMb04k/APKoPycf1iFeZqgjN05Cs5
         +diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=RSbsANuSxBwcm+kRTuCfGyuJwHa/xjk6xBT0hXu0WcE=;
        b=YSpLHnuJO4mS0F/ingKfCUt5cPGjLrldy7pPnWgUyzqr9hfPNELfAobjLjE2nYnnsd
         NYMzBo2TvYh+WKwmLuUkt6nYHluEaaG1oMbU7983i57WpRJ0wF6if50PNzZdFzMpwN12
         joqAJota9PQR4VExwery9uLopxL0W1cn2eXlr6pN46tDdPa12k+FQtGctcJhOPKkm48c
         gWOgSl86mN/ltbZBYEUTRTHhohDFuRRO4r6wrRn44pwmmGPVy3GG21s3QQBAULLz0bjp
         wz2s4WOJvl1fNZm+YWruTE6pMeXwjYJIGbiTKbEqFnPzNMkvqk9DGbmXm9VPBejBjrKw
         u16w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 20/20] cpufreq: scmi: add support for fast frequency switching
Date: Fri, 23 Feb 2018 16:23:50 +0000
Message-Id: <1519403030-21189-21-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209605546143756?=
X-GMAIL-MSGID: =?utf-8?q?1593209605546143756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cpufreq core provides option for drivers to implement fast_switch
callback which is invoked for frequency switching from interrupt context.

This patch adds support for fast_switch callback in SCMI cpufreq driver
by making use of polling based SCMI transfer. It also sets the flag
fast_switch_possible.

Cc: linux-pm@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 3745dc5fe2a8..ec0c58ddc1ed 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -69,6 +69,22 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return ret;
 }
 
+static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+
+	if (!perf_ops->freq_set(handle, priv->domain_id,
+				target_freq * 1000, true)) {
+		arch_set_freq_scale(policy->related_cpus, target_freq,
+				    policy->cpuinfo.max_freq);
+		return target_freq;
+	}
+
+	return 0;
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
@@ -168,6 +184,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = latency;
 
+	policy->fast_switch_possible = true;
 	return 0;
 
 out_free_cpufreq_table:
@@ -206,6 +223,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
+	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-- 
2.7.4

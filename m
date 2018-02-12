Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x225tarjVoTwwDvm7XGiOgpR4Zo22eczcW0N2/l62r5vzTpNv9sAdL34e9aaF0TVJMBPHo3IU
ARC-Seal: i=1; a=rsa-sha256; t=1518461175; cv=none;
        d=google.com; s=arc-20160816;
        b=wwfSxs/UA7OPU70CCjNH3X+g+TBqAybdBAODPbz0JizQcNrtbfKsQQAeDPMvNZDvHf
         uitA7lA8j1u+OP24l0ox97QUOQUgWsgwl+Tv98SZutgMXvohR48veETfAIxLuyxCt60X
         W8ZzsAb64AuWTQfhg+8Psx+K/R5F/tWOWyt5DUa7ykb1q+zZMalQkMhup49SeNkmSCmr
         JBdZtJLmFwRz+KvdpItWJbmG0S8Wnj2cMV743H2R2J132nzThQ9QnrLRrt6GMVJDLNfc
         S8GVTINkIBBc79CXdnvt6w8aQgJvEylog6nhQawBg44pxl3izZft8FKstLEvOeK5WtId
         voYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PjOe8S8Onvct3BSagmr9w+aYI5UY8YfLSSSDIIsw9bc=;
        b=Hle+KBbwJYDpeN9/WFSpE70Jk6GI/ZsJx3OGwTOOSoogZJFz+PpvoGeAyOZhtHhoAf
         a/BocBD0Ty6mjX7CyQOTf3k2Kq5bQAD550r2Qapxomdq4cqrYwik9O2IkW1bZM+69CmI
         3ieMpz7VJl794WM7lSsSnwiqMZwgKqr3tStTtLaJqeexDkwCdTsutiaKFUBVXdrj7cbN
         RKAT3572G+svdjYeK+2QHs4CTIu9++8jkv9Z9w/fzjK+DCRtNl7tAkOOly/NxbwpByaI
         e/aLlRdWO9IlJwXAZv64QQ7x2vAAdm+GWDT4kzoyihYY2Nup+BH6lK/i57NHnpslQrUG
         Zu5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 20/20] cpufreq: scmi: add support for fast frequency switching
Date: Mon, 12 Feb 2018 18:45:24 +0000
Message-Id: <1518461124-17371-21-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221946058023869?=
X-GMAIL-MSGID: =?utf-8?q?1592221946058023869?=
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
 drivers/cpufreq/scmi-cpufreq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index d6d35f7692b3..c869c99b2142 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -64,6 +64,19 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
 }
 
+static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+
+	if (!perf_ops->freq_set(handle, priv->domain_id,
+				target_freq * 1000, true))
+		return target_freq;
+
+	return 0;
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
@@ -163,6 +176,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = latency;
 
+	policy->fast_switch_possible = true;
 	return 0;
 
 out_free_cpufreq_table:
@@ -201,6 +215,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
+	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-- 
2.7.4

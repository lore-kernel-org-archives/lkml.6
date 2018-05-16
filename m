Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEPD6J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 23:58:09 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:59308 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEPD6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 23:58:08 -0400
X-Authority-Analysis: v=2.3 cv=GopsBH9C c=1 sm=1 tr=0
 a=IfKG9KDHjPrX0SZ8gMoyrg==:117 a=IfKG9KDHjPrX0SZ8gMoyrg==:17
 a=VUJBJC2UJ8kA:10 a=Q-fNiiVtAAAA:8 a=ZXcZxKTucvakvfwa_LUA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
From: Markus Mayer <code@mmayer.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: sort frequencies in ascending order
Date: Tue, 15 May 2018 20:49:54 -0700
Message-Id: <20180516034954.56475-1-code@mmayer.net>
X-Mailer: git-send-email 2.17.0
X-CMAE-Envelope: MS4wfG6fOW7KYdyKbEc2Hickmobu1EcrsiqBlHjAhFPBoNw6e+cswZFtzW3T8QI/OPdHIOTjQAEVfpyO4iXQdKQAY+hEwA7rlbsYttam+/es3nSFU2TFbtoJ
 7EHrnJw4xC8awPCL2fYgBhcyJnJwamff6Hg4aiZ82UAaryrU3ae5NFy+4PJ+OboIEEdvecWoOMPLRpOQcNecQzpeIeEt21UcWXaagS5Pt4AqvDfz63rueVrr
 /Lo950FJ7m9atg2I0jLzS8QATD0Ri/q6GijEZmspijukBaOeS4kwe1oQJONV8y+FVXl+6XjgQURfI+DQVXuqrPqLv0or7C7LwgZrEwKdLSwO5MwA3R1PdJbY
 dkdqOvqGZ+f/IgADtJGUv+gJKnM8FWkP9PNR473QGCHh017uNUf4naYp1nNvhARmeQWKglvJvcHSjJil8lwUrG48pb9XlSuxPIknXGIckKJQkUolxpbdAJTY
 dSdnhG+aYVTDo+AVY6Ex0eS+dgpwlnFLsiyKKpqrVBI+EuGd8VIsTjc6gYI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Most CPUfreq drivers (at least on ARM) seem to be sorting the available
frequencies from lowest to highest. To match this behaviour, we reverse
the sorting order in brcmstb-avs-cpufreq, so it is now also lowest to
highest.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index b07559b9ed99..7dac3205d3eb 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -403,7 +403,7 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
 {
 	struct cpufreq_frequency_table *table;
 	unsigned int pstate;
-	int i, ret;
+	int p, i, ret;
 
 	/* Remember P-state for later */
 	ret = brcm_avs_get_pstate(priv, &pstate);
@@ -415,12 +415,13 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
 	if (!table)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {
-		ret = brcm_avs_set_pstate(priv, i);
+	for (p = AVS_PSTATE_MAX, i = 0; p >= 0; p--, i++) {
+		ret = brcm_avs_set_pstate(priv, p);
 		if (ret)
 			return ERR_PTR(ret);
 		table[i].frequency = brcm_avs_get_frequency(priv->base);
-		table[i].driver_data = i;
+		/* Store the corresponding P-state with each frequency */
+		table[i].driver_data = p;
 	}
 	table[i].frequency = CPUFREQ_TABLE_END;
 
-- 
2.7.4

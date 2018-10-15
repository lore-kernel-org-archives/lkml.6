Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D94C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A582098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A582098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJPFLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:11:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51027 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeJPFLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:11:21 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 866ac9818a3d6cd2; Mon, 15 Oct 2018 23:24:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        t.bartholomae@intel.com
Subject: [PATCH] cpufreq: conservative: Take limits changes into account properly
Date:   Mon, 15 Oct 2018 23:21:05 +0200
Message-ID: <5406371.vuaACy5i7F@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0gFjBoFi=cpC2gPkZTDZof8dxdCCVx0XoAv2XuPmTfWPA@mail.gmail.com>
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com> <CAHKzcEOECQP8j6q=NKzuEjF+mc0s80fr6xWw-=NXsTtzCGGg_w@mail.gmail.com> <CAJZ5v0gFjBoFi=cpC2gPkZTDZof8dxdCCVx0XoAv2XuPmTfWPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the policy limits change between invocations of cs_dbs_update(),
the requested frequency value stored in dbs_info may not be updated
and the function may use a stale value of it next time.  Moreover, if
idle periods are takem into account by cs_dbs_update(), the requested
frequency value stored in dbs_info may be below the min policy limit,
which is incorrect.

To fix these problems, always update the requested frequency value
in dbs_info along with the local copy of it when the previous
requested frequency is beyond the policy limits and avoid decreasing
the requested frequency below the min policy limit when taking
idle periods into account.

Reported-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -80,8 +80,10 @@ static unsigned int cs_dbs_update(struct
 	 * changed in the meantime, so fall back to current frequency in that
 	 * case.
 	 */
-	if (requested_freq > policy->max || requested_freq < policy->min)
+	if (requested_freq > policy->max || requested_freq < policy->min) {
 		requested_freq = policy->cur;
+		dbs_info->requested_freq = requested_freq;
+	}
 
 	freq_step = get_freq_step(cs_tuners, policy);
 
@@ -92,7 +94,7 @@ static unsigned int cs_dbs_update(struct
 	if (policy_dbs->idle_periods < UINT_MAX) {
 		unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
 
-		if (requested_freq > freq_steps)
+		if (requested_freq > policy->min + freq_steps)
 			requested_freq -= freq_steps;
 		else
 			requested_freq = policy->min;


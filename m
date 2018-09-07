Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030F9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B501420645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B501420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeIHB7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeIHB7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:34 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4ED06FAA;
        Fri,  7 Sep 2018 21:16:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Willard <henry.willard@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 087/145] cpufreq: governor: Avoid accessing invalid governor_data
Date:   Fri,  7 Sep 2018 23:09:13 +0200
Message-Id: <20180907210911.276809645@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Willard <henry.willard@oracle.com>

commit 2a3eb51e30b9ac66fe1b75877627a7e4aaeca24a upstream.

If cppc_cpufreq.ko is deleted at the same time that tuned-adm is
changing profiles, there is a small chance that a race can occur
between cpufreq_dbs_governor_exit() and cpufreq_dbs_governor_limits()
resulting in a system failure when the latter tries to use
policy->governor_data that has been freed by the former.

This patch uses gov_dbs_data_mutex to synchronize access.

Fixes: e788892ba3cc (cpufreq: governor: Get rid of governor events)
Signed-off-by: Henry Willard <henry.willard@oracle.com>
[ rjw: Subject, minor white space adjustment ]
Cc: 4.8+ <stable@vger.kernel.org> # 4.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cpufreq_governor.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -555,12 +555,20 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_s
 
 void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct policy_dbs_info *policy_dbs;
+
+	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
+	mutex_lock(&gov_dbs_data_mutex);
+	policy_dbs = policy->governor_data;
+	if (!policy_dbs)
+		goto out;
 
 	mutex_lock(&policy_dbs->update_mutex);
 	cpufreq_policy_apply_limits(policy);
 	gov_update_sample_delay(policy_dbs, 0);
-
 	mutex_unlock(&policy_dbs->update_mutex);
+
+out:
+	mutex_unlock(&gov_dbs_data_mutex);
 }
 EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);



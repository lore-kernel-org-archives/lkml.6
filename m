Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C6C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7B721719
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HFK16bZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7B721719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeHOCvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:51:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58062 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeHOCvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:51:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7ENsvpL059074;
        Wed, 15 Aug 2018 00:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=TjBbYw3cFiY8mZloTMS2iTIORWvNHLIcrS+6TBIACts=;
 b=HFK16bZRXrlfHmt+6BGo3QpOHfdH5XX8oz5EFlkia5utS7ys009Hf9EjTJcreawyn+FM
 A6Tncmbh3KZSd8Ks/6LaMwDDplshksdJCi7Ys87EuxE1ZZoPkL4i5DABer2hRVVRt0Xf
 Tdvzmgrc/TpXXN+s0bn1OLsYg1JIBpDylR7hl1rB1VXupD62cNq5a/FRd3a/q8rxwepF
 aWR8pia84VrJgmXmryicaJvn5T7Se9lw5QmBgzbEpMozcqjTrEu/7L7my/FfLt96TBZz
 WCsftVkkr9m/iO7k1JM3FNfHVO6FwsfYqiAg2kHolEClrdmPgPjwLUXA/KRr3K/HqTbe CQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ksreq2mub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 00:01:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7F01bxZ025232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 00:01:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7F01aSc020839;
        Wed, 15 Aug 2018 00:01:36 GMT
Received: from hwillard-linux.us.oracle.com (/10.211.52.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Aug 2018 17:01:36 -0700
From:   Henry Willard <henry.willard@oracle.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <henry.willard@oracle.com>
Subject: [PATCH] cpufreq: governor: Protect cpufreq governor_data
Date:   Tue, 14 Aug 2018 17:01:02 -0700
Message-Id: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=832
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808140239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cppc_cpufreq.ko is deleted at the same time that tuned-adm is
changing profiles, there is a small chance that a race can occur
between cpufreq_dbs_governor_exit() and cpufreq_dbs_governor_limits()
resulting in a system failure when the latter tries to use
policy->governor_data that has been freed by the former.

This patch uses gov_dbs_data_mutex to synchronize access.

Signed-off-by: Henry Willard <henry.willard@oracle.com>
---
 drivers/cpufreq/cpufreq_governor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 1d50e97d49f1..43416ee55849 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -555,12 +555,20 @@ void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
 
 void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
+	struct policy_dbs_info *policy_dbs;
+
+	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit */
+	mutex_lock(&gov_dbs_data_mutex);
+	policy_dbs = policy->governor_data;
+	if (!policy_dbs)
+		goto out;
 
 	mutex_lock(&policy_dbs->update_mutex);
 	cpufreq_policy_apply_limits(policy);
 	gov_update_sample_delay(policy_dbs, 0);
 
 	mutex_unlock(&policy_dbs->update_mutex);
+out:
+	mutex_unlock(&gov_dbs_data_mutex);
 }
 EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
-- 
1.8.3.1


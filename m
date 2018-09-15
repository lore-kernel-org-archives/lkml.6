Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9620ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACFA2147E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACFA2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeIPDWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:34542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbeIPDWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="70289141"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2018 15:01:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH V2 1/9] x86/intel_rdt: Fix data type in parsing callbacks
Date:   Sat, 15 Sep 2018 14:58:19 -0700
Message-Id: <1537048707-76280-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochen Shen <xiaochen.shen@intel.com>

Each resource is associated with a parsing callback to parse the data
provided from user space when writing schemata file.

The 'data' parameter in the callbacks is defined as a void pointer which
is error prone due to lack of type check.

parse_bw() processes the 'data' parameter as a string while its caller
actually passes the parameter as a pointer to struct rdt_cbm_parse_data.
Thus, parse_bw() takes wrong data and causes failure of parsing MBA
throttle value.

To fix the issue, the 'data' parameter in the parsing callbacks is
defined and handled as a pointer to struct rdt_parse_data (renamed from
struct rdt_cbm_parse_data).

Fixes: 7604df6e16ae ("x86/intel_rdt: Support flexible data to parsing callbacks")
Fixes: 9ab9aa15c309 ("x86/intel_rdt: Ensure requested schemata respects mode")

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             | 16 ++++++++++++----
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 21 ++++++++-------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 4e588f36228f..78266c798280 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -382,6 +382,11 @@ static inline bool is_mbm_event(int e)
 		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
+struct rdt_parse_data {
+	struct rdtgroup		*rdtgrp;
+	char			*buf;
+};
+
 /**
  * struct rdt_resource - attributes of an RDT resource
  * @rid:		The index of the resource
@@ -423,16 +428,19 @@ struct rdt_resource {
 	struct rdt_cache	cache;
 	struct rdt_membw	membw;
 	const char		*format_str;
-	int (*parse_ctrlval)	(void *data, struct rdt_resource *r,
-				 struct rdt_domain *d);
+	int (*parse_ctrlval)(struct rdt_parse_data *data,
+			     struct rdt_resource *r,
+			     struct rdt_domain *d);
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
 	unsigned long		fflags;
 };
 
-int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d);
-int parse_bw(void *_buf, struct rdt_resource *r,  struct rdt_domain *d);
+int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+	      struct rdt_domain *d);
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index af358ca05160..edd5761f7336 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -64,19 +64,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(void *_buf, struct rdt_resource *r, struct rdt_domain *d)
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d)
 {
-	unsigned long data;
-	char *buf = _buf;
+	unsigned long bw_val;
 
 	if (d->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
-	if (!bw_validate(buf, &data, r))
+	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
-	d->new_ctrl = data;
+	d->new_ctrl = bw_val;
 	d->have_new_ctrl = true;
 
 	return 0;
@@ -123,18 +123,13 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	return true;
 }
 
-struct rdt_cbm_parse_data {
-	struct rdtgroup		*rdtgrp;
-	char			*buf;
-};
-
 /*
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
+int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
+	      struct rdt_domain *d)
 {
-	struct rdt_cbm_parse_data *data = _data;
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	u32 cbm_val;
 
@@ -195,7 +190,7 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
 static int parse_line(char *line, struct rdt_resource *r,
 		      struct rdtgroup *rdtgrp)
 {
-	struct rdt_cbm_parse_data data;
+	struct rdt_parse_data data;
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
 	unsigned long dom_id;
-- 
2.19.0


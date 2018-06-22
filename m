Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A78C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A852498C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A852498C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754998AbeFVWq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:46:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:22311 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933923AbeFVWmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843384"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 12/41] x86/intel_rdt: Support flexible data to parsing callbacks
Date:   Fri, 22 Jun 2018 15:42:03 -0700
Message-Id: <34baacfced4d787d994ec7015e249e6c7e619053.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each resource is associated with a configurable callback that should be
used to parse the information provided for the particular resource from
user space. In addition to the resource and domain pointers this callback
is provided with just the character buffer being parsed.

In support of flexible parsing the callback is modified to support a void
pointer as argument. This enables resources that need more data than just
the user provided data to pass its required data to the callback without
affecting the signatures for the callbacks of all the other resources.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/acc9cc5919df395755fc945dee4fcf1ed1484867.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.h             | 6 +++---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 399bb94e865b..c0c0ef817f11 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -371,7 +371,7 @@ struct rdt_resource {
 	struct rdt_cache	cache;
 	struct rdt_membw	membw;
 	const char		*format_str;
-	int (*parse_ctrlval)	(char *buf, struct rdt_resource *r,
+	int (*parse_ctrlval)	(void *data, struct rdt_resource *r,
 				 struct rdt_domain *d);
 	struct list_head	evt_list;
 	int			num_rmid;
@@ -379,8 +379,8 @@ struct rdt_resource {
 	unsigned long		fflags;
 };
 
-int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d);
-int parse_bw(char *buf, struct rdt_resource *r,  struct rdt_domain *d);
+int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d);
+int parse_bw(void *_buf, struct rdt_resource *r,  struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index b3da5b981dd8..ab4bb8731825 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -64,9 +64,10 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
+int parse_bw(void *_buf, struct rdt_resource *r, struct rdt_domain *d)
 {
 	unsigned long data;
+	char *buf = _buf;
 
 	if (d->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
@@ -126,8 +127,9 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
+int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
 {
+	char *buf = _data;
 	u32 cbm_val;
 
 	if (d->have_new_ctrl) {
-- 
2.17.0


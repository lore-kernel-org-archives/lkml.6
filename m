Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeEVTh0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:37:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:16706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752512AbeEVTcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406368"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 11/38] x86/intel_rdt: Support flexible data to parsing callbacks
Date: Tue, 22 May 2018 04:28:59 -0700
Message-Id: <acc9cc5919df395755fc945dee4fcf1ed1484867.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each resource is associated with a configurable callback that should be
used to parse the information provided for the particular resource from
user space. In addition to the resource and domain pointers this callback
is provided with just the character buffer being parsed.

In support of flexible parsing the callback is modified to support a
void pointer as argument. This enables resources that need more data
than just the user provided data to pass its required data to the
callback without affecting the signatures for the callbacks of all the
other resources.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
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
2.13.6

Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E4DC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C267B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C267B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeFTASe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:18:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55655 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeFTAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:18:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0IPN53296970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:18:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0IPp63296967;
        Tue, 19 Jun 2018 17:18:25 -0700
Date:   Tue, 19 Jun 2018 17:18:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-bfd202352970db873e5af98b1e2cbe5336648f88@git.kernel.org>
Cc:     reinette.chatre@intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, reinette.chatre@intel.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <acc9cc5919df395755fc945dee4fcf1ed1484867.1527593970.git.reinette.chatre@intel.com>
References: <acc9cc5919df395755fc945dee4fcf1ed1484867.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Support flexible data to parsing
 callbacks
Git-Commit-ID: bfd202352970db873e5af98b1e2cbe5336648f88
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bfd202352970db873e5af98b1e2cbe5336648f88
Gitweb:     https://git.kernel.org/tip/bfd202352970db873e5af98b1e2cbe5336648f88
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:36 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:30 +0200

x86/intel_rdt: Support flexible data to parsing callbacks

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

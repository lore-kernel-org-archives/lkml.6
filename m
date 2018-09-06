Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4B0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9C72077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9C72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeIFNnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:43:14 -0400
Received: from foss.arm.com ([217.140.101.70]:41108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbeIFNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:43:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3211596;
        Thu,  6 Sep 2018 02:08:45 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4ACB03F575;
        Thu,  6 Sep 2018 02:08:44 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        robert.walker@arm.com, al.grant@arm.com
Subject: [PATCH v2 01/14] coresight: Handle failures in enabling a trace path
Date:   Thu,  6 Sep 2018 10:08:22 +0100
Message-Id: <1536224915-31766-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coresight_enable_path() enables the components in a trace
path from a given source to a sink, excluding the source.
The operation is performed in the reverse order; the sink
first and then backwards in the list. However, if we encounter
an error in enabling any of the component, we simply disable
all the components in the given path irrespective of whether
we enabled some of the components in the enable iteration.
This could interfere with another trace session if one of the
link devices is turned off (e.g, TMC-ETF). So, we need to
make sure that we only disable those components which were
actually enabled from the iteration.

This patch achieves the same by refactoring the coresight_disable_path
to accept a "node" to start from in the forward order, which can
then be used from the error path of coresight_enable_path().
With this change, we don't issue a disable call back for a component
which didn't get enabled. This change of behavior triggers
a bug in coresight_enable_link(), where we leave the refcount
on the device and will prevent the device from being enabled
forever. So, we also drop the refcount in the coresight_enable_link()
if the operation failed.

Also, with the refactoring, we always start after the first node (which
is the "SOURCE" device) for disabling the entire path. This implies,
we must not find a "SOURCE" in the middle of the path. Hence, added
a WARN_ON() to make sure the paths we get are sane, rather than
simply ignoring them.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e73ca6a..f4f5075 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -187,8 +187,10 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
 		if (link_ops(csdev)->enable) {
 			ret = link_ops(csdev)->enable(csdev, inport, outport);
-			if (ret)
+			if (ret) {
+				atomic_dec(&csdev->refcnt[refport]);
 				return ret;
+			}
 		}
 	}
 
@@ -277,13 +279,21 @@ static bool coresight_disable_source(struct coresight_device *csdev)
 	return !csdev->enable;
 }
 
-void coresight_disable_path(struct list_head *path)
+/*
+ * coresight_disable_path_from : Disable components in the given path beyond
+ * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
+ * disabled.
+ */
+static void coresight_disable_path_from(struct list_head *path,
+					struct coresight_node *nd)
 {
 	u32 type;
-	struct coresight_node *nd;
 	struct coresight_device *csdev, *parent, *child;
 
-	list_for_each_entry(nd, path, link) {
+	if (!nd)
+		nd = list_first_entry(path, struct coresight_node, link);
+
+	list_for_each_entry_continue(nd, path, link) {
 		csdev = nd->csdev;
 		type = csdev->type;
 
@@ -303,7 +313,12 @@ void coresight_disable_path(struct list_head *path)
 			coresight_disable_sink(csdev);
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
-			/* sources are disabled from either sysFS or Perf */
+			/*
+			 * We skip the first node in the path assuming that it
+			 * is the source. So we don't expect a source device in
+			 * the middle of a path.
+			 */
+			WARN_ON(1);
 			break;
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
@@ -316,6 +331,11 @@ void coresight_disable_path(struct list_head *path)
 	}
 }
 
+void coresight_disable_path(struct list_head *path)
+{
+	coresight_disable_path_from(path, NULL);
+}
+
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 {
 
@@ -369,7 +389,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 out:
 	return ret;
 err:
-	coresight_disable_path(path);
+	coresight_disable_path_from(path, nd);
 	goto out;
 }
 
-- 
2.7.4


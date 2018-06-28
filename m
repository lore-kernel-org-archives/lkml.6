Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ABBC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FFF273A0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FFF273A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935037AbeF1M6O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:58:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934813AbeF1M6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:58:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 572421529;
        Thu, 28 Jun 2018 05:58:11 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 033B93F5C0;
        Thu, 28 Jun 2018 05:58:09 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 1/6] coresight: Cleanup device subtype struct
Date:   Thu, 28 Jun 2018 13:57:52 +0100
Message-Id: <1530190677-19933-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530190677-19933-1-git-send-email-suzuki.poulose@arm.com>
References: <1530190677-19933-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up our struct a little bit by using a union instead of
a struct for tracking the subtype of a device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/coresight.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 69a5c9f..7c188c2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -63,17 +63,20 @@ enum coresight_dev_subtype_source {
 };
 
 /**
- * struct coresight_dev_subtype - further characterisation of a type
+ * union coresight_dev_subtype - further characterisation of a type
  * @sink_subtype:	type of sink this component is, as defined
-			by @coresight_dev_subtype_sink.
+ *			by @coresight_dev_subtype_sink.
  * @link_subtype:	type of link this component is, as defined
-			by @coresight_dev_subtype_link.
+ *			by @coresight_dev_subtype_link.
  * @source_subtype:	type of source this component is, as defined
-			by @coresight_dev_subtype_source.
+ *			by @coresight_dev_subtype_source.
  */
-struct coresight_dev_subtype {
-	enum coresight_dev_subtype_sink sink_subtype;
-	enum coresight_dev_subtype_link link_subtype;
+union coresight_dev_subtype {
+	/* We have some devices which acts as LINK and SINK */
+	struct {
+		enum coresight_dev_subtype_sink sink_subtype;
+		enum coresight_dev_subtype_link link_subtype;
+	};
 	enum coresight_dev_subtype_source source_subtype;
 };
 
@@ -111,7 +114,7 @@ struct coresight_platform_data {
  */
 struct coresight_desc {
 	enum coresight_dev_type type;
-	struct coresight_dev_subtype subtype;
+	union coresight_dev_subtype subtype;
 	const struct coresight_ops *ops;
 	struct coresight_platform_data *pdata;
 	struct device *dev;
@@ -155,7 +158,7 @@ struct coresight_device {
 	int nr_inport;
 	int nr_outport;
 	enum coresight_dev_type type;
-	struct coresight_dev_subtype subtype;
+	union coresight_dev_subtype subtype;
 	const struct coresight_ops *ops;
 	struct device dev;
 	atomic_t *refcnt;
-- 
2.7.4


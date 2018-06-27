Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F1EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9849E26508
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W1uC4us7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fZxU5uIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9849E26508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeF0Mv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:51:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933674AbeF0MvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:51:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A107C60B19; Wed, 27 Jun 2018 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530103884;
        bh=lhkpGk75F3pQcTHccC1itm+8WL/mmT5/GA0tQYpHhrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1uC4us7FCWmiJvDPBfBzp5slp/KSlq+oSg2PqZ8T5CaiS5d+7pNb8FtWSceNslAp
         Oyyt0nhC4RYJMKnSNGy7AHPwQ9f0CcPKRxt+i5i6QGoAxbwblrt39V4AZxbX7O01m7
         OawwiiCbPQDaVyAmV8KWNHA82jL7dKcs1cczZvpE=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B2E560714;
        Wed, 27 Jun 2018 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530103882;
        bh=lhkpGk75F3pQcTHccC1itm+8WL/mmT5/GA0tQYpHhrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZxU5uIMI3VfX0QW1+kljCXJFZlioyXVYgZCfn7eUrjT66E/iUd0n+bhBNXcuKYLr
         gaiSN3m1+i0AYWDU37q6eQ2CqYbMjXmvJgftKNw9W5tG5Y+znk+Vrnwm3xpmPfS1R0
         14POuiq27dFMTAopOzJQr2jZ+T+uvSYkaJTXJtUo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B2E560714
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] device core: Add flag to autoremove device link on supplier unbind
Date:   Wed, 27 Jun 2018 18:20:56 +0530
Message-Id: <20180627125056.12851-2-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to autoremove the device links on supplier driver
unbind. This obviates the need to explicitly delete the link
in the remove path.
We remove these links only when the supplier's link to its
consumers has gone to DL_STATE_SUPPLIER_UNBIND state.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
---
 Documentation/driver-api/device_link.rst |  4 ++++
 drivers/base/core.c                      | 10 ++++++++++
 include/linux/device.h                   |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index a005b904a264..d6763272e747 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -86,6 +86,10 @@ automatically purged when the consumer fails to probe or later unbinds.
 This obviates the need to explicitly delete the link in the ``->remove``
 callback or in the error path of the ``->probe`` callback.
 
+Similarly, when the device link is added from supplier's ``->probe`` callback,
+``DL_FLAG_AUTOREMOVE_SUPPLIER`` causes the device link to be automatically
+purged when the supplier fails to probe or later unbinds.
+
 Limitations
 ===========
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14c1e3151e08..e721218bf352 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -518,6 +518,16 @@ void device_links_driver_cleanup(struct device *dev)
 
 		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
 		WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
+
+		/*
+		 * autoremove the links between this @dev and its consumer
+		 * devices that are not active, i.e. where the link state
+		 * has moved to DL_STATE_SUPPLIER_UNBIND.
+		 */
+		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
+		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+			kref_put(&link->kref, __device_link_del);
+
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 3929805cdd59..e80920452b49 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -787,11 +787,13 @@ enum device_link_state {
  * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
  * PM_RUNTIME: If set, the runtime PM framework will use this link.
  * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
+ * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
  */
 #define DL_FLAG_STATELESS		BIT(0)
 #define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
 #define DL_FLAG_PM_RUNTIME		BIT(2)
 #define DL_FLAG_RPM_ACTIVE		BIT(3)
+#define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
 
 /**
  * struct device_link - Device link representation.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


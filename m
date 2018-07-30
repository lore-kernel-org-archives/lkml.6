Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F25813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D00A20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D00A20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbeG3Oas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:30:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729104AbeG3Oar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:30:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E70D3AE5B;
        Mon, 30 Jul 2018 12:55:54 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 4F508A0BE8; Mon, 30 Jul 2018 14:55:54 +0200 (CEST)
Message-Id: <306859c07222bd90adb7dec35900133a14dc433d.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 02/23] update UAPI header copies
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:55:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to current net-next (commit 3bc950c34b28).

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 uapi/linux/ethtool.h    |  6 +++++-
 uapi/linux/net_tstamp.h | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 8cc61e9ab40b..9dd347caf4ed 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -215,12 +215,16 @@ struct ethtool_value {
 	__u32	data;
 };
 
+#define PFC_STORM_PREVENTION_AUTO	0xffff
+#define PFC_STORM_PREVENTION_DISABLE	0
+
 enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
+	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
 	/*
-	 * Add your fresh new tubale attribute above and remember to update
+	 * Add your fresh new tunable attribute above and remember to update
 	 * tunable_strings[] in net/core/ethtool.c
 	 */
 	__ETHTOOL_TUNABLE_COUNT,
diff --git a/uapi/linux/net_tstamp.h b/uapi/linux/net_tstamp.h
index 3d421d912193..97ff3c17ec4d 100644
--- a/uapi/linux/net_tstamp.h
+++ b/uapi/linux/net_tstamp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Userspace API for hardware time stamping of network packets
  *
@@ -140,4 +141,22 @@ struct scm_ts_pktinfo {
 	__u32 reserved[2];
 };
 
+/*
+ * SO_TXTIME gets a struct sock_txtime with flags being an integer bit
+ * field comprised of these values.
+ */
+enum txtime_flags {
+	SOF_TXTIME_DEADLINE_MODE = (1 << 0),
+	SOF_TXTIME_REPORT_ERRORS = (1 << 1),
+
+	SOF_TXTIME_FLAGS_LAST = SOF_TXTIME_REPORT_ERRORS,
+	SOF_TXTIME_FLAGS_MASK = (SOF_TXTIME_FLAGS_LAST - 1) |
+				 SOF_TXTIME_FLAGS_LAST
+};
+
+struct sock_txtime {
+	clockid_t	clockid;	/* reference clockid */
+	__u32		flags;		/* as defined by enum txtime_flags */
+};
+
 #endif /* _NET_TIMESTAMPING_H */
-- 
2.18.0


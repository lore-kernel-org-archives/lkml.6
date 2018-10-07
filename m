Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCBC65C24
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504CA2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CA2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeJGXm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeJGXm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE1D5C00F5DD;
        Sun,  7 Oct 2018 16:34:39 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E6955B081;
        Sun,  7 Oct 2018 16:34:37 +0000 (UTC)
Date:   Sun, 7 Oct 2018 18:35:11 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [RFC PATCH net 3/3] uapi, net/smc: provide socket state constants in
 UAPI
Message-ID: <c79442704c63498b0d910f832ea8260faa53bebf.1538929504.git.esyr@redhat.com>
References: <cover.1538929504.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538929504.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 07 Oct 2018 16:34:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As socket state itself is already exposed via sock_diag interface.

Fixes: ac7138746e14 ("smc: establish new socket family")
Fixes: b38d732477e4 ("smc: socket closing and linkgroup cleanup")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/smc_diag.h | 17 +++++++++++++++++
 net/smc/smc.h                 | 18 +-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 8cb3a6f..6798ec0 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -31,6 +31,23 @@ struct smc_diag_msg {
 	__aligned_u64	diag_inode;
 };
 
+enum smc_state {		/* possible states of an SMC socket */
+	SMC_ACTIVE	= 1,
+	SMC_INIT	= 2,
+	SMC_CLOSED	= 7,
+	SMC_LISTEN	= 10,
+	/* normal close */
+	SMC_PEERCLOSEWAIT1	= 20,
+	SMC_PEERCLOSEWAIT2	= 21,
+	SMC_APPFINCLOSEWAIT	= 24,
+	SMC_APPCLOSEWAIT1	= 22,
+	SMC_APPCLOSEWAIT2	= 23,
+	SMC_PEERFINCLOSEWAIT	= 25,
+	/* abnormal close */
+	SMC_PEERABORTWAIT	= 26,
+	SMC_PROCESSABORT	= 27,
+};
+
 /* Mode of a connection */
 enum {
 	SMC_DIAG_MODE_SMCR,
diff --git a/net/smc/smc.h b/net/smc/smc.h
index f5ff2ee..16bfd64 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -16,6 +16,7 @@
 #include <linux/compiler.h> /* __aligned */
 #include <net/sock.h>
 #include <linux/smc.h>
+#include <linux/smc_diag.h>
 
 #include "smc_ib.h"
 
@@ -26,23 +27,6 @@ extern struct proto smc_proto6;
 #define KERNEL_HAS_ATOMIC64
 #endif
 
-enum smc_state {		/* possible states of an SMC socket */
-	SMC_ACTIVE	= 1,
-	SMC_INIT	= 2,
-	SMC_CLOSED	= 7,
-	SMC_LISTEN	= 10,
-	/* normal close */
-	SMC_PEERCLOSEWAIT1	= 20,
-	SMC_PEERCLOSEWAIT2	= 21,
-	SMC_APPFINCLOSEWAIT	= 24,
-	SMC_APPCLOSEWAIT1	= 22,
-	SMC_APPCLOSEWAIT2	= 23,
-	SMC_PEERFINCLOSEWAIT	= 25,
-	/* abnormal close */
-	SMC_PEERABORTWAIT	= 26,
-	SMC_PROCESSABORT	= 27,
-};
-
 struct smc_link_group;
 
 struct smc_wr_rx_hdr {	/* common prefix part of LLC and CDC to demultiplex */
-- 
2.1.4


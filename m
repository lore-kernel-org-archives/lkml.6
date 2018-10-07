Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E42C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BA0205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BA0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeJGXmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeJGXmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D53083F45;
        Sun,  7 Oct 2018 16:34:35 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EF72016367;
        Sun,  7 Oct 2018 16:34:32 +0000 (UTC)
Date:   Sun, 7 Oct 2018 18:35:06 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [RFC PATCH net 2/3] uapi, net/smc: provide fallback diagnosis codes
 in UAPI
Message-ID: <797314a1a1d7de04a47f04f47212cc9547192da0.1538929504.git.esyr@redhat.com>
References: <cover.1538929504.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538929504.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 07 Oct 2018 16:34:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since they values to which these codes are corresponding are already
exposed via sock_diag interface.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/smc.h | 19 +++++++++++++++++++
 net/smc/smc_clc.h        | 16 ----------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 10561f8..fc7a859 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -17,6 +17,25 @@
 #define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
 #define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
 
+/* Diagnosis codes */
+#define SMC_CLC_DECL_MEM	0x01010000  /* insufficient memory resources  */
+#define SMC_CLC_DECL_TIMEOUT_CL	0x02010000  /* timeout w4 QP confirm link     */
+#define SMC_CLC_DECL_TIMEOUT_AL	0x02020000  /* timeout w4 QP add link	      */
+#define SMC_CLC_DECL_CNFERR	0x03000000  /* configuration error            */
+#define SMC_CLC_DECL_PEERNOSMC	0x03010000  /* peer did not indicate SMC      */
+#define SMC_CLC_DECL_IPSEC	0x03020000  /* IPsec usage		      */
+#define SMC_CLC_DECL_NOSMCDEV	0x03030000  /* no SMC device found	      */
+#define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
+#define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
+#define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
+#define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
+#define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
+#define SMC_CLC_DECL_INTERR	0x99990000  /* internal error                 */
+#define SMC_CLC_DECL_ERR_RTOK	0x99990001  /*	 rtoken handling failed       */
+#define SMC_CLC_DECL_ERR_RDYLNK	0x99990002  /*	 ib ready link failed	      */
+#define SMC_CLC_DECL_ERR_REGRMB	0x99990003  /*	 reg rmb failed		      */
+
+
 /* Netlink SMC_PNETID attributes */
 enum {
 	SMC_PNETID_UNSPEC,
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 18da89b..d84845a 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -27,22 +27,6 @@
 #define SMC_TYPE_D		1		/* SMC-D only		      */
 #define SMC_TYPE_B		3		/* SMC-R and SMC-D	      */
 #define CLC_WAIT_TIME		(6 * HZ)	/* max. wait time on clcsock  */
-#define SMC_CLC_DECL_MEM	0x01010000  /* insufficient memory resources  */
-#define SMC_CLC_DECL_TIMEOUT_CL	0x02010000  /* timeout w4 QP confirm link     */
-#define SMC_CLC_DECL_TIMEOUT_AL	0x02020000  /* timeout w4 QP add link	      */
-#define SMC_CLC_DECL_CNFERR	0x03000000  /* configuration error            */
-#define SMC_CLC_DECL_PEERNOSMC	0x03010000  /* peer did not indicate SMC      */
-#define SMC_CLC_DECL_IPSEC	0x03020000  /* IPsec usage		      */
-#define SMC_CLC_DECL_NOSMCDEV	0x03030000  /* no SMC device found	      */
-#define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
-#define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
-#define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
-#define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
-#define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
-#define SMC_CLC_DECL_INTERR	0x99990000  /* internal error                 */
-#define SMC_CLC_DECL_ERR_RTOK	0x99990001  /*	 rtoken handling failed       */
-#define SMC_CLC_DECL_ERR_RDYLNK	0x99990002  /*	 ib ready link failed	      */
-#define SMC_CLC_DECL_ERR_REGRMB	0x99990003  /*	 reg rmb failed		      */
 
 struct smc_clc_msg_hdr {	/* header1 of clc messages */
 	u8 eyecatcher[4];	/* eye catcher */
-- 
2.1.4


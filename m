Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEF0218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBGHql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:46:41 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44261 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfBGHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:46:39 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 Feb 2019 09:46:36 +0200
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.137.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x177kaO0026635;
        Thu, 7 Feb 2019 09:46:36 +0200
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id x177kaHm030217;
        Thu, 7 Feb 2019 09:46:36 +0200
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id x177kaku030216;
        Thu, 7 Feb 2019 09:46:36 +0200
From:   Eli Cohen <eli@mellanox.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     simon.horman@netronome.com, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, francois.theron@netronome.com,
        quentin.monnet@netronome.com, john.hurley@netronome.com,
        edwin.peer@netronome.com, Eli Cohen <eli@mellanox.com>
Subject: [PATCH net-next 1/2] net: Move all TC actions identifiers to one place
Date:   Thu,  7 Feb 2019 09:45:48 +0200
Message-Id: <20190207074549.29861-2-eli@mellanox.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190207074549.29861-1-eli@mellanox.com>
References: <20190207074549.29861-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all the TC identifiers to one place, to the same enum that defines
the identifier of police action. This makes it easier choose numbers for
new actions since they are now defined in one place. We preserve the
original values for binary compatibility. New IDs should be added inside
the enum.

Signed-off-by: Eli Cohen <eli@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
---
 include/uapi/linux/pkt_cls.h              | 43 ++++++++++++++++++++++++++++---
 include/uapi/linux/tc_act/tc_bpf.h        |  2 --
 include/uapi/linux/tc_act/tc_connmark.h   |  2 --
 include/uapi/linux/tc_act/tc_csum.h       |  2 --
 include/uapi/linux/tc_act/tc_gact.h       |  1 -
 include/uapi/linux/tc_act/tc_ife.h        |  1 -
 include/uapi/linux/tc_act/tc_ipt.h        |  3 ---
 include/uapi/linux/tc_act/tc_mirred.h     |  1 -
 include/uapi/linux/tc_act/tc_nat.h        |  2 --
 include/uapi/linux/tc_act/tc_pedit.h      |  2 --
 include/uapi/linux/tc_act/tc_sample.h     |  2 --
 include/uapi/linux/tc_act/tc_skbedit.h    |  2 --
 include/uapi/linux/tc_act/tc_skbmod.h     |  2 --
 include/uapi/linux/tc_act/tc_tunnel_key.h |  2 --
 include/uapi/linux/tc_act/tc_vlan.h       |  2 --
 tools/include/uapi/linux/tc_act/tc_bpf.h  |  2 --
 16 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 02ac251be8c4..7ab55f97e7c4 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -63,12 +63,49 @@ enum {
 #define TC_ACT_GOTO_CHAIN __TC_ACT_EXT(2)
 #define TC_ACT_EXT_OPCODE_MAX	TC_ACT_GOTO_CHAIN
 
+/* These macros are put here for binary compatibility with userspace apps that
+ * make use of them. For kernel code and new userspace apps, use the TCA_ID_*
+ * versions.
+ */
+#define TCA_ACT_GACT 5
+#define TCA_ACT_IPT 6
+#define TCA_ACT_PEDIT 7
+#define TCA_ACT_MIRRED 8
+#define TCA_ACT_NAT 9
+#define TCA_ACT_XT 10
+#define TCA_ACT_SKBEDIT 11
+#define TCA_ACT_VLAN 12
+#define TCA_ACT_BPF 13
+#define TCA_ACT_CONNMARK 14
+#define TCA_ACT_SKBMOD 15
+#define TCA_ACT_CSUM 16
+#define TCA_ACT_TUNNEL_KEY 17
+#define TCA_ACT_SIMP 22
+#define TCA_ACT_IFE 25
+#define TCA_ACT_SAMPLE 26
+
 /* Action type identifiers*/
 enum {
-	TCA_ID_UNSPEC=0,
-	TCA_ID_POLICE=1,
+	TCA_ID_UNSPEC = 0,
+	TCA_ID_POLICE = 1,
+	TCA_ID_GACT = TCA_ACT_GACT,
+	TCA_ID_IPT = TCA_ACT_IPT,
+	TCA_ID_PEDIT = TCA_ACT_PEDIT,
+	TCA_ID_MIRRED = TCA_ACT_MIRRED,
+	TCA_ID_NAT = TCA_ACT_NAT,
+	TCA_ID_XT = TCA_ACT_XT,
+	TCA_ID_SKBEDIT = TCA_ACT_SKBEDIT,
+	TCA_ID_VLAN = TCA_ACT_VLAN,
+	TCA_ID_BPF = TCA_ACT_BPF,
+	TCA_ID_CONNMARK = TCA_ACT_CONNMARK,
+	TCA_ID_SKBMOD = TCA_ACT_SKBMOD,
+	TCA_ID_CSUM = TCA_ACT_CSUM,
+	TCA_ID_TUNNEL_KEY = TCA_ACT_TUNNEL_KEY,
+	TCA_ID_SIMP = TCA_ACT_SIMP,
+	TCA_ID_IFE = TCA_ACT_IFE,
+	TCA_ID_SAMPLE = TCA_ACT_SAMPLE,
 	/* other actions go here */
-	__TCA_ID_MAX=255
+	__TCA_ID_MAX = 255
 };
 
 #define TCA_ID_MAX __TCA_ID_MAX
diff --git a/include/uapi/linux/tc_act/tc_bpf.h b/include/uapi/linux/tc_act/tc_bpf.h
index 6e89a5df49a4..653c4f94f76e 100644
--- a/include/uapi/linux/tc_act/tc_bpf.h
+++ b/include/uapi/linux/tc_act/tc_bpf.h
@@ -13,8 +13,6 @@
 
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_BPF 13
-
 struct tc_act_bpf {
 	tc_gen;
 };
diff --git a/include/uapi/linux/tc_act/tc_connmark.h b/include/uapi/linux/tc_act/tc_connmark.h
index 80caa47b1933..9f8f6f709feb 100644
--- a/include/uapi/linux/tc_act/tc_connmark.h
+++ b/include/uapi/linux/tc_act/tc_connmark.h
@@ -5,8 +5,6 @@
 #include <linux/types.h>
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_CONNMARK 14
-
 struct tc_connmark {
 	tc_gen;
 	__u16 zone;
diff --git a/include/uapi/linux/tc_act/tc_csum.h b/include/uapi/linux/tc_act/tc_csum.h
index 0ecf4d29e2f3..94b2044929de 100644
--- a/include/uapi/linux/tc_act/tc_csum.h
+++ b/include/uapi/linux/tc_act/tc_csum.h
@@ -5,8 +5,6 @@
 #include <linux/types.h>
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_CSUM 16
-
 enum {
 	TCA_CSUM_UNSPEC,
 	TCA_CSUM_PARMS,
diff --git a/include/uapi/linux/tc_act/tc_gact.h b/include/uapi/linux/tc_act/tc_gact.h
index 94273c3b81b0..37e5392e02c7 100644
--- a/include/uapi/linux/tc_act/tc_gact.h
+++ b/include/uapi/linux/tc_act/tc_gact.h
@@ -5,7 +5,6 @@
 #include <linux/types.h>
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_GACT 5
 struct tc_gact {
 	tc_gen;
 
diff --git a/include/uapi/linux/tc_act/tc_ife.h b/include/uapi/linux/tc_act/tc_ife.h
index 2f48490ef386..8c401f185675 100644
--- a/include/uapi/linux/tc_act/tc_ife.h
+++ b/include/uapi/linux/tc_act/tc_ife.h
@@ -6,7 +6,6 @@
 #include <linux/pkt_cls.h>
 #include <linux/ife.h>
 
-#define TCA_ACT_IFE 25
 /* Flag bits for now just encoding/decoding; mutually exclusive */
 #define IFE_ENCODE 1
 #define IFE_DECODE 0
diff --git a/include/uapi/linux/tc_act/tc_ipt.h b/include/uapi/linux/tc_act/tc_ipt.h
index b743c8bddd13..c48d7da6750d 100644
--- a/include/uapi/linux/tc_act/tc_ipt.h
+++ b/include/uapi/linux/tc_act/tc_ipt.h
@@ -4,9 +4,6 @@
 
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_IPT 6
-#define TCA_ACT_XT 10
-
 enum {
 	TCA_IPT_UNSPEC,
 	TCA_IPT_TABLE,
diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
index 5dd671cf5776..2500a0005d05 100644
--- a/include/uapi/linux/tc_act/tc_mirred.h
+++ b/include/uapi/linux/tc_act/tc_mirred.h
@@ -5,7 +5,6 @@
 #include <linux/types.h>
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_MIRRED 8
 #define TCA_EGRESS_REDIR 1  /* packet redirect to EGRESS*/
 #define TCA_EGRESS_MIRROR 2 /* mirror packet to EGRESS */
 #define TCA_INGRESS_REDIR 3  /* packet redirect to INGRESS*/
diff --git a/include/uapi/linux/tc_act/tc_nat.h b/include/uapi/linux/tc_act/tc_nat.h
index 086be842587b..21399c2c6130 100644
--- a/include/uapi/linux/tc_act/tc_nat.h
+++ b/include/uapi/linux/tc_act/tc_nat.h
@@ -5,8 +5,6 @@
 #include <linux/pkt_cls.h>
 #include <linux/types.h>
 
-#define TCA_ACT_NAT 9
-
 enum {
 	TCA_NAT_UNSPEC,
 	TCA_NAT_PARMS,
diff --git a/include/uapi/linux/tc_act/tc_pedit.h b/include/uapi/linux/tc_act/tc_pedit.h
index 24ec792dacc1..f3e61b04fa01 100644
--- a/include/uapi/linux/tc_act/tc_pedit.h
+++ b/include/uapi/linux/tc_act/tc_pedit.h
@@ -5,8 +5,6 @@
 #include <linux/types.h>
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_PEDIT 7
-
 enum {
 	TCA_PEDIT_UNSPEC,
 	TCA_PEDIT_TM,
diff --git a/include/uapi/linux/tc_act/tc_sample.h b/include/uapi/linux/tc_act/tc_sample.h
index bd7e9f03abd2..fee1bcc20793 100644
--- a/include/uapi/linux/tc_act/tc_sample.h
+++ b/include/uapi/linux/tc_act/tc_sample.h
@@ -6,8 +6,6 @@
 #include <linux/pkt_cls.h>
 #include <linux/if_ether.h>
 
-#define TCA_ACT_SAMPLE 26
-
 struct tc_sample {
 	tc_gen;
 };
diff --git a/include/uapi/linux/tc_act/tc_skbedit.h b/include/uapi/linux/tc_act/tc_skbedit.h
index 6de6071ebed6..800e93377218 100644
--- a/include/uapi/linux/tc_act/tc_skbedit.h
+++ b/include/uapi/linux/tc_act/tc_skbedit.h
@@ -23,8 +23,6 @@
 
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_SKBEDIT 11
-
 #define SKBEDIT_F_PRIORITY		0x1
 #define SKBEDIT_F_QUEUE_MAPPING		0x2
 #define SKBEDIT_F_MARK			0x4
diff --git a/include/uapi/linux/tc_act/tc_skbmod.h b/include/uapi/linux/tc_act/tc_skbmod.h
index 38c072f66f2f..c525b3503797 100644
--- a/include/uapi/linux/tc_act/tc_skbmod.h
+++ b/include/uapi/linux/tc_act/tc_skbmod.h
@@ -13,8 +13,6 @@
 
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_SKBMOD 15
-
 #define SKBMOD_F_DMAC	0x1
 #define SKBMOD_F_SMAC	0x2
 #define SKBMOD_F_ETYPE	0x4
diff --git a/include/uapi/linux/tc_act/tc_tunnel_key.h b/include/uapi/linux/tc_act/tc_tunnel_key.h
index be384d63e1b5..41c8b462c177 100644
--- a/include/uapi/linux/tc_act/tc_tunnel_key.h
+++ b/include/uapi/linux/tc_act/tc_tunnel_key.h
@@ -14,8 +14,6 @@
 
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_TUNNEL_KEY 17
-
 #define TCA_TUNNEL_KEY_ACT_SET	    1
 #define TCA_TUNNEL_KEY_ACT_RELEASE  2
 
diff --git a/include/uapi/linux/tc_act/tc_vlan.h b/include/uapi/linux/tc_act/tc_vlan.h
index 0d7b5fd6605b..168995b54a70 100644
--- a/include/uapi/linux/tc_act/tc_vlan.h
+++ b/include/uapi/linux/tc_act/tc_vlan.h
@@ -13,8 +13,6 @@
 
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_VLAN 12
-
 #define TCA_VLAN_ACT_POP	1
 #define TCA_VLAN_ACT_PUSH	2
 #define TCA_VLAN_ACT_MODIFY	3
diff --git a/tools/include/uapi/linux/tc_act/tc_bpf.h b/tools/include/uapi/linux/tc_act/tc_bpf.h
index 6e89a5df49a4..653c4f94f76e 100644
--- a/tools/include/uapi/linux/tc_act/tc_bpf.h
+++ b/tools/include/uapi/linux/tc_act/tc_bpf.h
@@ -13,8 +13,6 @@
 
 #include <linux/pkt_cls.h>
 
-#define TCA_ACT_BPF 13
-
 struct tc_act_bpf {
 	tc_gen;
 };
-- 
1.8.3.1


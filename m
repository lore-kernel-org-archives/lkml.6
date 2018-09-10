Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BEEC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0502086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0502086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeIJWLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:11:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59572 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbeIJWLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:11:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 723C81A0190;
        Mon, 10 Sep 2018 19:16:28 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 661751A011F;
        Mon, 10 Sep 2018 19:16:28 +0200 (CEST)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D24612060B;
        Mon, 10 Sep 2018 19:16:27 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] soc: fsl: dpio: add congestion notification support
Date:   Mon, 10 Sep 2018 20:15:43 +0300
Message-Id: <20180910171550.5659-5-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180910171550.5659-1-horia.geanta@nxp.com>
References: <20180910171550.5659-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Congestion State Change Notifications (CSCN), which
allow DPIO users to be notified when a congestion group changes its
state (due to hitting the entrance / exit threshold).

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 include/soc/fsl/dpaa2-global.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/soc/fsl/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
index 9bc0713346a8..2bfc379d3dc9 100644
--- a/include/soc/fsl/dpaa2-global.h
+++ b/include/soc/fsl/dpaa2-global.h
@@ -174,4 +174,19 @@ static inline const struct dpaa2_fd *dpaa2_dq_fd(const struct dpaa2_dq *dq)
 	return (const struct dpaa2_fd *)&dq->dq.fd[0];
 }
 
+#define DPAA2_CSCN_SIZE		sizeof(struct dpaa2_dq)
+#define DPAA2_CSCN_ALIGN	16
+#define DPAA2_CSCN_STATE_CG	BIT(0)
+
+/**
+ * dpaa2_cscn_state_congested() - Check congestion state
+ * @cscn: congestion SCN (delivered to WQ or memory)
+ *
+i * Return true is congested.
+ */
+static inline bool dpaa2_cscn_state_congested(struct dpaa2_dq *cscn)
+{
+	return !!(cscn->scn.state & DPAA2_CSCN_STATE_CG);
+}
+
 #endif /* __FSL_DPAA2_GLOBAL_H */
-- 
2.16.2


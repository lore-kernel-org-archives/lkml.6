Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161D720847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+X3LhFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161D720847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeKAIbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbeKAIJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2786E20840;
        Wed, 31 Oct 2018 23:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027374;
        bh=pC3wMmp2/pTskeHuGJa/bBSw0Liu/94Ewotp1gtTZIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+X3LhFBCGnr6xnkykp4DvF7n6ulz/q/1fnQEEgmQCdgiLRs2CxQm5JXiB4EPia71
         t5cbOaXBJrbVu2TeSu6e9c8FSRNEpxcx4hEqGWfTi1uTaCKsK9F9DjDUUL4pDeKSgu
         kl6PfB5kgQEY68fHIc86Dz7By/fiRlGunVPHmuKM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 111/126] crypto: caam - fix implicit casts in endianness helpers
Date:   Wed, 31 Oct 2018 19:07:39 -0400
Message-Id: <20181031230754.29029-111-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

[ Upstream commit aae733a3f46f5ef338fbdde26e14cbb205a23de0 ]

Fix the following sparse endianness warnings:

drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
drivers/crypto/caam/regs.h:95:1:    expected unsigned int
drivers/crypto/caam/regs.h:95:1:    got restricted __le32 [usertype] <noident>
drivers/crypto/caam/regs.h:95:1: sparse: incorrect type in return expression (different base types) @@    expected unsigned int @@    got restricted __be32unsigned int @@
drivers/crypto/caam/regs.h:95:1:    expected unsigned int
drivers/crypto/caam/regs.h:95:1:    got restricted __be32 [usertype] <noident>

drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __le32
drivers/crypto/caam/regs.h:92:1: sparse: cast to restricted __be32

Fixes: 261ea058f016 ("crypto: caam - handle core endianness != caam endianness")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/regs.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 4fb91ba39c36..ce3f9ad7120f 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -70,22 +70,22 @@
 extern bool caam_little_end;
 extern bool caam_imx;
 
-#define caam_to_cpu(len)				\
-static inline u##len caam##len ## _to_cpu(u##len val)	\
-{							\
-	if (caam_little_end)				\
-		return le##len ## _to_cpu(val);		\
-	else						\
-		return be##len ## _to_cpu(val);		\
+#define caam_to_cpu(len)						\
+static inline u##len caam##len ## _to_cpu(u##len val)			\
+{									\
+	if (caam_little_end)						\
+		return le##len ## _to_cpu((__force __le##len)val);	\
+	else								\
+		return be##len ## _to_cpu((__force __be##len)val);	\
 }
 
-#define cpu_to_caam(len)				\
-static inline u##len cpu_to_caam##len(u##len val)	\
-{							\
-	if (caam_little_end)				\
-		return cpu_to_le##len(val);		\
-	else						\
-		return cpu_to_be##len(val);		\
+#define cpu_to_caam(len)					\
+static inline u##len cpu_to_caam##len(u##len val)		\
+{								\
+	if (caam_little_end)					\
+		return (__force u##len)cpu_to_le##len(val);	\
+	else							\
+		return (__force u##len)cpu_to_be##len(val);	\
 }
 
 caam_to_cpu(16)
-- 
2.17.1


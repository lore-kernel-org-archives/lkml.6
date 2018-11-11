Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3878BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26E520869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcqCoPbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26E520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeKLJUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388695AbeKLIU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:26 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317BF21582;
        Sun, 11 Nov 2018 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975430;
        bh=5uN65YReqoVsCAzbIyKWOb27l+zSyFFYau5NfgH963Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcqCoPbrm+zprA4O6xkhxqohaPLBTbhJDX/UNIEh/YvwYPtxzWyI2FTQ46apA77PU
         bvGQLyFopxtMAHKwPscSEm/7hnIcWAo63xQMKRx9bJDSVLpP4ozlVZRjrfGekzdJXo
         wUJVtQB6vQYv5YRfeKlN8dplI8NXMsvZr3NKgJvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 171/350] crypto: caam - fix implicit casts in endianness helpers
Date:   Sun, 11 Nov 2018 14:20:35 -0800
Message-Id: <20181111221715.189295436@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Horia Geantă" <horia.geanta@nxp.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/caam/regs.h |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

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



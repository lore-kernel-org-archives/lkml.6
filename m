Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3EA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3EA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeILOEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:04:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60298 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeILODd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:03:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BF6F31A010E;
        Wed, 12 Sep 2018 10:59:57 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B2BF81A0102;
        Wed, 12 Sep 2018 10:59:57 +0200 (CEST)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 34FC2205F0;
        Wed, 12 Sep 2018 10:59:57 +0200 (CEST)
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
Subject: [PATCH v2 07/12] crypto: caam - add Queue Interface v2 error codes
Date:   Wed, 12 Sep 2018 11:59:32 +0300
Message-Id: <20180912085937.22489-8-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180912085937.22489-1-horia.geanta@nxp.com>
References: <20180912085937.22489-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to translate error codes returned by QI v2, i.e.
Queue Interface present on DataPath Acceleration Architecture
v2 (DPAA2).

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/error.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/crypto/caam/error.h |  6 +++-
 drivers/crypto/caam/regs.h  |  2 ++
 3 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/error.c b/drivers/crypto/caam/error.c
index 8da88beb1abb..db0f0d96842e 100644
--- a/drivers/crypto/caam/error.c
+++ b/drivers/crypto/caam/error.c
@@ -108,6 +108,54 @@ static const struct {
 	{ 0xF1, "3GPP HFN matches or exceeds the Threshold" },
 };
 
+static const struct {
+	u8 value;
+	const char *error_text;
+} qi_error_list[] = {
+	{ 0x1F, "Job terminated by FQ or ICID flush" },
+	{ 0x20, "FD format error"},
+	{ 0x21, "FD command format error"},
+	{ 0x23, "FL format error"},
+	{ 0x25, "CRJD specified in FD, but not enabled in FLC"},
+	{ 0x30, "Max. buffer size too small"},
+	{ 0x31, "DHR exceeds max. buffer size (allocate mode, S/G format)"},
+	{ 0x32, "SGT exceeds max. buffer size (allocate mode, S/G format"},
+	{ 0x33, "Size over/underflow (allocate mode)"},
+	{ 0x34, "Size over/underflow (reuse mode)"},
+	{ 0x35, "Length exceeds max. short length (allocate mode, S/G/ format)"},
+	{ 0x36, "Memory footprint exceeds max. value (allocate mode, S/G/ format)"},
+	{ 0x41, "SBC frame format not supported (allocate mode)"},
+	{ 0x42, "Pool 0 invalid / pool 1 size < pool 0 size (allocate mode)"},
+	{ 0x43, "Annotation output enabled but ASAR = 0 (allocate mode)"},
+	{ 0x44, "Unsupported or reserved frame format or SGHR = 1 (reuse mode)"},
+	{ 0x45, "DHR correction underflow (reuse mode, single buffer format)"},
+	{ 0x46, "Annotation length exceeds offset (reuse mode)"},
+	{ 0x48, "Annotation output enabled but ASA limited by ASAR (reuse mode)"},
+	{ 0x49, "Data offset correction exceeds input frame data length (reuse mode)"},
+	{ 0x4B, "Annotation output enabled but ASA cannote be expanded (frame list)"},
+	{ 0x51, "Unsupported IF reuse mode"},
+	{ 0x52, "Unsupported FL use mode"},
+	{ 0x53, "Unsupported RJD use mode"},
+	{ 0x54, "Unsupported inline descriptor use mode"},
+	{ 0xC0, "Table buffer pool 0 depletion"},
+	{ 0xC1, "Table buffer pool 1 depletion"},
+	{ 0xC2, "Data buffer pool 0 depletion, no OF allocated"},
+	{ 0xC3, "Data buffer pool 1 depletion, no OF allocated"},
+	{ 0xC4, "Data buffer pool 0 depletion, partial OF allocated"},
+	{ 0xC5, "Data buffer pool 1 depletion, partial OF allocated"},
+	{ 0xD0, "FLC read error"},
+	{ 0xD1, "FL read error"},
+	{ 0xD2, "FL write error"},
+	{ 0xD3, "OF SGT write error"},
+	{ 0xD4, "PTA read error"},
+	{ 0xD5, "PTA write error"},
+	{ 0xD6, "OF SGT F-bit write error"},
+	{ 0xD7, "ASA write error"},
+	{ 0xE1, "FLC[ICR]=0 ICID error"},
+	{ 0xE2, "FLC[ICR]=1 ICID error"},
+	{ 0xE4, "source of ICID flush not trusted (BDI = 0)"},
+};
+
 static const char * const cha_id_list[] = {
 	"",
 	"AES",
@@ -236,6 +284,27 @@ static void report_deco_status(struct device *jrdev, const u32 status,
 		status, error, idx_str, idx, err_str, err_err_code);
 }
 
+static void report_qi_status(struct device *qidev, const u32 status,
+			     const char *error)
+{
+	u8 err_id = status & JRSTA_QIERR_ERROR_MASK;
+	const char *err_str = "unidentified error value 0x";
+	char err_err_code[3] = { 0 };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qi_error_list); i++)
+		if (qi_error_list[i].value == err_id)
+			break;
+
+	if (i != ARRAY_SIZE(qi_error_list) && qi_error_list[i].error_text)
+		err_str = qi_error_list[i].error_text;
+	else
+		snprintf(err_err_code, sizeof(err_err_code), "%02x", err_id);
+
+	dev_err(qidev, "%08x: %s: %s%s\n",
+		status, error, err_str, err_err_code);
+}
+
 static void report_jr_status(struct device *jrdev, const u32 status,
 			     const char *error)
 {
@@ -250,7 +319,7 @@ static void report_cond_code_status(struct device *jrdev, const u32 status,
 		status, error, __func__);
 }
 
-void caam_jr_strstatus(struct device *jrdev, u32 status)
+void caam_strstatus(struct device *jrdev, u32 status, bool qi_v2)
 {
 	static const struct stat_src {
 		void (*report_ssed)(struct device *jrdev, const u32 status,
@@ -262,7 +331,7 @@ void caam_jr_strstatus(struct device *jrdev, u32 status)
 		{ report_ccb_status, "CCB" },
 		{ report_jump_status, "Jump" },
 		{ report_deco_status, "DECO" },
-		{ NULL, "Queue Manager Interface" },
+		{ report_qi_status, "Queue Manager Interface" },
 		{ report_jr_status, "Job Ring" },
 		{ report_cond_code_status, "Condition Code" },
 		{ NULL, NULL },
@@ -288,4 +357,4 @@ void caam_jr_strstatus(struct device *jrdev, u32 status)
 	else
 		dev_err(jrdev, "%d: unknown error source\n", ssrc);
 }
-EXPORT_SYMBOL(caam_jr_strstatus);
+EXPORT_SYMBOL(caam_strstatus);
diff --git a/drivers/crypto/caam/error.h b/drivers/crypto/caam/error.h
index 5aa332bac4b0..67ea94079837 100644
--- a/drivers/crypto/caam/error.h
+++ b/drivers/crypto/caam/error.h
@@ -8,7 +8,11 @@
 #ifndef CAAM_ERROR_H
 #define CAAM_ERROR_H
 #define CAAM_ERROR_STR_MAX 302
-void caam_jr_strstatus(struct device *jrdev, u32 status);
+
+void caam_strstatus(struct device *dev, u32 status, bool qi_v2);
+
+#define caam_jr_strstatus(jrdev, status) caam_strstatus(jrdev, status, false)
+#define caam_qi2_strstatus(qidev, status) caam_strstatus(qidev, status, true)
 
 void caam_dump_sg(const char *level, const char *prefix_str, int prefix_type,
 		  int rowsize, int groupsize, struct scatterlist *sg,
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index ce3f9ad7120f..457815f965c0 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -633,6 +633,8 @@ struct caam_job_ring {
 #define JRSTA_DECOERR_INVSIGN       0x86
 #define JRSTA_DECOERR_DSASIGN       0x87
 
+#define JRSTA_QIERR_ERROR_MASK      0x00ff
+
 #define JRSTA_CCBERR_JUMP           0x08000000
 #define JRSTA_CCBERR_INDEX_MASK     0xff00
 #define JRSTA_CCBERR_INDEX_SHIFT    8
-- 
2.16.2


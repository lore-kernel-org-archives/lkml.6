Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8ABECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8472083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8472083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJSUbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:31:18 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42694 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726609AbeJSUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:31:17 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9JCOOOE009672;
        Fri, 19 Oct 2018 07:25:18 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2n3e40s12n-1;
        Fri, 19 Oct 2018 07:25:18 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id BF5F7611E120;
        Fri, 19 Oct 2018 07:25:17 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Oct 2018
 13:25:16 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w9JCPGNx012324;        Fri, 19 Oct 2018 13:25:16 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Rename memory fields in wm_adsp_buffer
Date:   Fri, 19 Oct 2018 13:25:15 +0100
Message-ID: <20181019122516.26720-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=722 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810190111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm_adsp_buffer struct is the control header of a circular
buffer used to transfer data from the firmware over the
control interface to an ALSA compressed stream.

The original names of the fields pointing to the data buffer
were based on ADSP2V2 memory layout where they correspond to
{XM, XM, YM}. But this circular buffer could be used on other
types of DSP core that have different memory region types.
Also the names and description of the size fields were not
very clear. The field names and descriptions have been changed
to be generic and not imply any particular memory types.

This patch updates the wm_adsp driver to the new field names.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f61656070225..7ae10c632614 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -311,12 +311,12 @@ struct wm_adsp_alg_xm_struct {
 };
 
 struct wm_adsp_buffer {
-	__be32 X_buf_base;		/* XM base addr of first X area */
-	__be32 X_buf_size;		/* Size of 1st X area in words */
-	__be32 X_buf_base2;		/* XM base addr of 2nd X area */
-	__be32 X_buf_brk;		/* Total X size in words */
-	__be32 Y_buf_base;		/* YM base addr of Y area */
-	__be32 wrap;			/* Total size X and Y in words */
+	__be32 buf1_base;		/* Base addr of first buffer area */
+	__be32 buf1_size;		/* Size of buf1 area in DSP words */
+	__be32 buf2_base;		/* Base addr of 2nd buffer area */
+	__be32 buf1_buf2_size;		/* Size of buf1+buf2 in DSP words */
+	__be32 buf3_base;		/* Base addr of buf3 area */
+	__be32 buf_total_size;		/* Size of buf1+buf2+buf3 in DSP words */
 	__be32 high_water_mark;		/* Point at which IRQ is asserted */
 	__be32 irq_count;		/* bits 1-31 count IRQ assertions */
 	__be32 irq_ack;			/* acked IRQ count, bit 0 enables IRQ */
@@ -393,18 +393,18 @@ struct wm_adsp_buffer_region_def {
 static const struct wm_adsp_buffer_region_def default_regions[] = {
 	{
 		.mem_type = WMFW_ADSP2_XM,
-		.base_offset = HOST_BUFFER_FIELD(X_buf_base),
-		.size_offset = HOST_BUFFER_FIELD(X_buf_size),
+		.base_offset = HOST_BUFFER_FIELD(buf1_base),
+		.size_offset = HOST_BUFFER_FIELD(buf1_size),
 	},
 	{
 		.mem_type = WMFW_ADSP2_XM,
-		.base_offset = HOST_BUFFER_FIELD(X_buf_base2),
-		.size_offset = HOST_BUFFER_FIELD(X_buf_brk),
+		.base_offset = HOST_BUFFER_FIELD(buf2_base),
+		.size_offset = HOST_BUFFER_FIELD(buf1_buf2_size),
 	},
 	{
 		.mem_type = WMFW_ADSP2_YM,
-		.base_offset = HOST_BUFFER_FIELD(Y_buf_base),
-		.size_offset = HOST_BUFFER_FIELD(wrap),
+		.base_offset = HOST_BUFFER_FIELD(buf3_base),
+		.size_offset = HOST_BUFFER_FIELD(buf_total_size),
 	},
 };
 
-- 
2.11.0


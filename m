Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B3EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73265224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73265224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeKLXaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:30:06 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37694 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729460AbeKLXaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:30:06 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wACDYVh9022752;
        Mon, 12 Nov 2018 07:36:41 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nnwm9u5yv-1;
        Mon, 12 Nov 2018 07:36:41 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id D1F4A611E120;
        Mon, 12 Nov 2018 07:36:40 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 12 Nov 2018
 13:36:40 +0000
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 wACDadd8012949;        Mon, 12 Nov 2018 13:36:40 GMT
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Factor out common init code
Date:   Mon, 12 Nov 2018 13:36:39 +0000
Message-ID: <20181112133639.13444-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181112133639.13444-1-rf@opensource.cirrus.com>
References: <20181112133639.13444-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811120123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the duplicated initialization statements from
wm_adsp1_init() and wm_adsp2_init() into new function
wm_adsp_common_init().

The entire content of wm_adsp1_init() is the common code
but it is convenient to retain this exported function
to hide what we currently treat as common init (which might
change in the future) and also make clear the difference
between an ADSP1 entry point and common code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 66501b8dc46f..1dd291cebe67 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2419,7 +2419,7 @@ static int wm_adsp_create_name(struct wm_adsp *dsp)
 	return 0;
 }
 
-int wm_adsp1_init(struct wm_adsp *dsp)
+static int wm_adsp_common_init(struct wm_adsp *dsp)
 {
 	int ret;
 
@@ -2428,11 +2428,17 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 		return ret;
 
 	INIT_LIST_HEAD(&dsp->alg_regions);
+	INIT_LIST_HEAD(&dsp->ctl_list);
 
 	mutex_init(&dsp->pwr_lock);
 
 	return 0;
 }
+
+int wm_adsp1_init(struct wm_adsp *dsp)
+{
+	return wm_adsp_common_init(dsp);
+}
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
 
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
@@ -2917,7 +2923,7 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
 
-	ret = wm_adsp_create_name(dsp);
+	ret = wm_adsp_common_init(dsp);
 	if (ret)
 		return ret;
 
@@ -2939,12 +2945,8 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 		break;
 	}
 
-	INIT_LIST_HEAD(&dsp->alg_regions);
-	INIT_LIST_HEAD(&dsp->ctl_list);
 	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
-	mutex_init(&dsp->pwr_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
-- 
2.11.0


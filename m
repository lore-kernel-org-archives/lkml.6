Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeBELip (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:38:45 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33442 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752606AbeBELif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:38:35 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Don't init cache from DSP memory if control is write-only
Date: Mon, 5 Feb 2018 11:38:17 +0000
Message-ID: <20180205113817.16470-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=616 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802050148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For controls marked write-only don't initialize the cache from the
content of the DSP memory. We stil need the cache for any new data
that is written to this control, and we need to return something
for a read of the ALSA control because most user-side code assumes
all ALSA controls are readable. The cache is already created zero-
filled so the only change needed is to skip populating it from
DSP memory if the control isn't readable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 66e32f5d2917..0060aeb63a9f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1237,9 +1237,16 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
 			continue;
 
-		ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
-		if (ret < 0)
-			return ret;
+		/*
+		 * For readable controls populate the cache from the DSP memory.
+		 * For non-readable controls the cache was zero-filled when
+		 * created so we don't need to do anything.
+		 */
+		if (!ctl->flags || (ctl->flags & WMFW_CTL_FLAG_READABLE)) {
+			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeB1KbU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:31:20 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38650 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752472AbeB1KbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:31:18 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: For TLV controls only register TLV get/set
Date: Wed, 28 Feb 2018 10:31:10 +0000
Message-ID: <20180228103110.2055-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=733 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802280127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normal 512-byte get/set of a TLV isn't supported but we were
registering the normal get/set anyway and relying on omitting
the SNDRV_CTL_ELEM_ACCESS_[READ|WRITE] flags to prevent them
being called.

Trouble is if this gets broken in the core ALSA code - as it has
been since at least 4.14 - the standard get/set can be called
unexpectedly and corrupt memory.

There's no point providing functions that won't be called and
it's a trivial change. The benefit is that if the ALSA core gets
broken again we get a big fat immediate NULL dereference instead
of a memory corruption timebomb.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 9b27390cf4f1..82b0927e6ed7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1204,12 +1204,14 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 		kcontrol->put = wm_coeff_put_acked;
 		break;
 	default:
-		kcontrol->get = wm_coeff_get;
-		kcontrol->put = wm_coeff_put;
-
-		ctl->bytes_ext.max = ctl->len;
-		ctl->bytes_ext.get = wm_coeff_tlv_get;
-		ctl->bytes_ext.put = wm_coeff_tlv_put;
+		if (kcontrol->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			ctl->bytes_ext.max = ctl->len;
+			ctl->bytes_ext.get = wm_coeff_tlv_get;
+			ctl->bytes_ext.put = wm_coeff_tlv_put;
+		} else {
+			kcontrol->get = wm_coeff_get;
+			kcontrol->put = wm_coeff_put;
+		}
 		break;
 	}
 
-- 
2.11.0

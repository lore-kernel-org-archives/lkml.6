Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeBSGFy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:05:54 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41085 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeBSGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:05:52 -0500
X-Google-Smtp-Source: AH8x226iZlrS0OVix3re3ev6jZnHmN7OYjx4Hlc9Yqnfz/aG4TPCTFeFaPeqtUpGIKCo075vbpu0MQ==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: topology: Rename clock_gated to clock_cont in snd_soc_tplg_hw_config
Date: Mon, 19 Feb 2018 07:05:30 +0100
Message-Id: <20180219060531.17276-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel `soc-dai.h`, DAI clock gating is defined as following:

~~~~
\#define SND_SOC_DAIFMT_CONT		(1 << 4) /* continuous clock */
\#define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
~~~~

Therefore, the corresponding field of struct snd_soc_tplg_hw_config should
be inverted compared to the current logic:

clock_count = 1 => SND_SOC_DAIFMT_CONT
clock_count = 0 => SND_SOC_DAIFMT_GATED

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 include/uapi/sound/asoc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 69c37ecbff7e..10188850dede 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -312,7 +312,9 @@ struct snd_soc_tplg_hw_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;		/* unique ID - - used to match */
 	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
-	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 clock_cont;	/* 1 if clock is continuous, and can not be
+				 * gated to save power
+				 */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
-- 
2.13.6

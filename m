Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161115AbeBNRWE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:22:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43241 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033384AbeBNRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:22:03 -0500
From: Colin King <colin.king@canonical.com>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: TSCS42xx: make const array norm_addrs static, reduces object code size
Date: Wed, 14 Feb 2018 17:21:53 +0000
Message-Id: <20180214172153.5749-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array norm_addrs on the stack, instead make it
static.  Makes the object code smaller by over 230 bytes.  Also re-format
array data as the insertion of the static keywork made the first line
overly long.

Before:
   text	   data	    bss	    dec	    hex	filename
  53780	  34752	    256	  88788	  15ad4	linux/sound/soc/codecs/tscs42xx.o

After:
   text	   data	    bss	    dec	    hex	filename
  53461	  34840	    256	  88557	  159ed	linux/sound/soc/codecs/tscs42xx.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tscs42xx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index e7661d0315e6..205a55a0329e 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -1317,11 +1317,13 @@ static struct snd_soc_codec_driver soc_codec_dev_tscs42xx = {
 
 static inline void init_coeff_ram_cache(struct tscs42xx *tscs42xx)
 {
-	const u8 norm_addrs[] = { 0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19, 0x1f,
-		0x20, 0x25, 0x2a, 0x2f, 0x34, 0x39, 0x3f, 0x40, 0x45, 0x4a,
-		0x4f, 0x54, 0x59, 0x5f, 0x60, 0x65, 0x6a, 0x6f, 0x74, 0x79,
-		0x7f, 0x80, 0x85, 0x8c, 0x91, 0x96, 0x97, 0x9c, 0xa3, 0xa8,
-		0xad, 0xaf, 0xb0, 0xb5, 0xba, 0xbf, 0xc4, 0xc9, };
+	static const u8 norm_addrs[] = {
+		0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19, 0x1f, 0x20, 0x25, 0x2a,
+		0x2f, 0x34, 0x39, 0x3f, 0x40, 0x45, 0x4a, 0x4f, 0x54, 0x59,
+		0x5f, 0x60, 0x65, 0x6a, 0x6f, 0x74, 0x79, 0x7f, 0x80, 0x85,
+		0x8c, 0x91, 0x96, 0x97, 0x9c, 0xa3, 0xa8, 0xad, 0xaf, 0xb0,
+		0xb5, 0xba, 0xbf, 0xc4, 0xc9,
+	};
 	u8 *coeff_ram = tscs42xx->coeff_ram;
 	int i;
 
-- 
2.15.1

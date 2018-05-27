Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeE0Vcb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:32:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41996 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeE0Vc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:32:29 -0400
From: Colin King <colin.king@canonical.com>
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: xen-front: fix unsigned error check on return from to_sndif_format
Date: Sun, 27 May 2018 22:32:19 +0100
Message-Id: <20180527213219.24182-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The negative error return from the call to to_sndif_format is being
assigned to an unsigned 8 bit integer and hence the check for a negative
value is always going to be false.  Fix this by using ret as the error
return and hence the negative error can be detected and assign
the u8 sndif_format to ret if there is no error.

Detected by CoverityScan, CID#1469385 ("Unsigned compared against 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/xen/xen_snd_front_alsa.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index 5041f83e98d2..5a2bd70a2fa1 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -466,13 +466,14 @@ static int alsa_prepare(struct snd_pcm_substream *substream)
 		u8 sndif_format;
 		int ret;
 
-		sndif_format = to_sndif_format(runtime->format);
-		if (sndif_format < 0) {
+		ret = to_sndif_format(runtime->format);
+		if (ret < 0) {
 			dev_err(&stream->front_info->xb_dev->dev,
 				"Unsupported sample format: %d\n",
 				runtime->format);
-			return sndif_format;
+			return ret;
 		}
+		sndif_format = ret;
 
 		ret = xen_snd_front_stream_prepare(&stream->evt_pair->req,
 						   &stream->sh_buf,
-- 
2.17.0

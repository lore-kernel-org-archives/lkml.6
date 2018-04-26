Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756187AbeDZMqF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:46:05 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755873AbeDZMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:46:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/4] ALSA: Avoid using timespec for struct snd_ctl_elem_value
Date: Thu, 26 Apr 2018 14:44:20 +0200
Message-Id: <20180426124422.2921744-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180426124422.2921744-1-arnd@arndb.de>
References: <20180426124422.2921744-1-arnd@arndb.de>
X-Provags-ID: V03:K1:TDTPdewdp6MHvn7a74pHVhc+qASKxsLqxuFEZBUL+xm39HbziuE
 PcSLB5uC5i74pR2w0j5l1HR4hWRXxlcPn/3xevUlzR1zGfg8+2z83YNlSk2XVYd7gqXoIhx
 j61Oiwi8hiQIqeFe7nzwzeO9YAytxuwKohZ/SxLqQA9REwGxPKvzqjpWYPhop89L0Xo1S9Y
 XdQvcgjAuKpXphn+U6dhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LLyQxPRrTgI=:o+mVQxtCkX+amY035mknlC
 JBBoPo0GplMRWK+buOr1uydoctmzJbapsuGCdG1LV4f0zabdg+4lto6gw1UOomv17utPSVWUx
 rd215x3kRdPARCQ7rWQmT+XVkKr08pSucdGFG7abW+LZDS6RBLFTHgzsMydirgMrvzs1Gpe3C
 pY5BowdO/h89yJ02tnpYlkTewmw62M0ZkX8JMoLnpMJt7U4sWy8HX1OImxywxs4d+0e/G4rWW
 6QJBayPzpjlu0Jyk8ceLgSKtYh0zAWDg7X3aztM1ArqWo2TGZFjmM0SgFiw5P7C+PvbzMI5mh
 yw8VpCDrQzIe5nO6XH6jP+OiHe363+xGKU4XyudH6fknT/fAPQoTXlAFErulAKC6okfoa5e7s
 prVnSqh/qteu2NvqJpHH88e/hrQqKiXZUMc+B3G1HN85WShO+rTl7qb7NZzs4DpTXA3OWwe26
 RGdW/wVd7BbiVfG7Ikm4sEnC38MM6Veyxze7+z+qoFL7APka0rxErqJATg9YfpMIcGQmqAfmi
 7hBIOD2zmvD5DaW+YtGLrKBPSv5QGe6HPbaqdoRVd/49g4N8A2FaZ29yImlpUxRMmiwMJBmS4
 OWuH+5t8blY8v84MtfaGkKZQyh0EQf5QbV4Vk8XgfImZ453+Y9VzvlRzvRwI8ktQzCQlKeQhg
 iG1xF1fY5zI7FHUuj3DhJuLOieqJdLPQhfL+P9jYGWKvQS5rVeRjwhDEaYcMRi4sOOig=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

The struct snd_ctl_elem_value will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since there are no drivers will implemented the tstamp member of the
struct snd_ctl_elem_value, and also the stucture size will not be changed
if we change timespec to s64 for tstamp member of struct snd_ctl_elem_value.

>From Takashi's comments, "In the library, applications are not expected
to access to this structure directly. The applications get opaque pointer
to the structure and must use any control APIs to operate it. Actually the
library produce no API to handle 'struct snd_ctl_elem_value.tstamp'. This
means that we can drop this member from alsa-lib without decline of
functionality." Thus we can simply remove the tstamp member to avoid using
the type which is not year 2038 safe on 32bits system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ed0a120d4f08..1231f0a943f1 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -954,8 +954,7 @@ struct snd_ctl_elem_value {
 		} bytes;
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
-	struct timespec tstamp;
-	unsigned char reserved[128-sizeof(struct timespec)];
+	unsigned char reserved[128];
 };
 
 struct snd_ctl_tlv {
-- 
2.9.0

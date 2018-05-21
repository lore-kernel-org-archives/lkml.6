Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeEUQ5Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:57:25 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.133]:35588 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753130AbeEUQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:57:20 -0400
X-Authority-Reason: nr=8
Date: Mon, 21 May 2018 11:57:17 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] media: si470x: fix potential Spectre variant 1
Message-ID: <20180521165717.GA9167@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fKo7a-0001ft-Oj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:55076
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

band->index can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:
drivers/media/radio/si470x/radio-si470x-common.c:758 si470x_vidioc_enum_freq_bands() warn: potential spectre issue 'bands'

Fix this by sanitizing band->index before using it to index
`bands'

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/radio/si470x/radio-si470x-common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-common.c b/drivers/media/radio/si470x/radio-si470x-common.c
index c40e175..e81f9aa 100644
--- a/drivers/media/radio/si470x/radio-si470x-common.c
+++ b/drivers/media/radio/si470x/radio-si470x-common.c
@@ -110,6 +110,10 @@
 /* kernel includes */
 #include "radio-si470x.h"
 
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
+
 /**************************************************************************
  * Module Parameters
  **************************************************************************/
@@ -755,7 +759,7 @@ static int si470x_vidioc_enum_freq_bands(struct file *file, void *priv,
 		return -EINVAL;
 	if (band->index >= ARRAY_SIZE(bands))
 		return -EINVAL;
-	*band = bands[band->index];
+	*band = bands[array_index_nospec(band->index, ARRAY_SIZE(bands))];
 	return 0;
 }
 
-- 
2.7.4

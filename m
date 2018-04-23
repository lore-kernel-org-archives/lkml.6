Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeDWRva (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:51:30 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.219]:47143 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932157AbeDWRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:51:26 -0400
X-Authority-Reason: nr=8
Date: Mon, 23 Apr 2018 12:51:23 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 10/11] vivid-sdr-cap: fix potential Spectre variant 1
Message-ID: <586469aa63a9579ecdeb8ffa4fb31d441564c622.1524499368.git.gustavo@embeddedor.com>
References: <cover.1524499368.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524499368.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.48.65
X-Source-L: No
X-Exim-ID: 1fAfcb-0008BT-RO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:49622
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 67
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

band->index can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

Smatch warning:
drivers/media/platform/vivid/vivid-sdr-cap.c:323 vivid_sdr_enum_freq_bands() warn: potential spectre issue 'bands_adc'

Fix this by sanitizing band->index before using it to index
bands_adc and bands_fm.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/vivid/vivid-sdr-cap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/vivid/vivid-sdr-cap.c b/drivers/media/platform/vivid/vivid-sdr-cap.c
index cfb7cb4..684d8a2 100644
--- a/drivers/media/platform/vivid/vivid-sdr-cap.c
+++ b/drivers/media/platform/vivid/vivid-sdr-cap.c
@@ -22,6 +22,8 @@
 #include "vivid-ctrls.h"
 #include "vivid-sdr-cap.h"
 
+#include <linux/nospec.h>
+
 /* stream formats */
 struct vivid_format {
 	u32	pixelformat;
@@ -320,11 +322,15 @@ int vivid_sdr_enum_freq_bands(struct file *file, void *fh,
 	case 0:
 		if (band->index >= ARRAY_SIZE(bands_adc))
 			return -EINVAL;
+		band->index = array_index_nospec(band->index,
+						 ARRAY_SIZE(bands_adc));
 		*band = bands_adc[band->index];
 		return 0;
 	case 1:
 		if (band->index >= ARRAY_SIZE(bands_fm))
 			return -EINVAL;
+		band->index = array_index_nospec(band->index,
+						 ARRAY_SIZE(bands_fm));
 		*band = bands_fm[band->index];
 		return 0;
 	default:
-- 
2.7.4

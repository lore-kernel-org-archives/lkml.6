Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933320AbeDXMvl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:51:41 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:32422 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757247AbeDXMvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:51:32 -0400
X-Authority-Reason: nr=8
Date: Tue, 24 Apr 2018 07:51:28 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] omap3isp: ispstat: fix potential NULL pointer dereference
Message-ID: <20180424125128.GA625@embeddedor.com>
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
X-Source-IP: 189.145.48.65
X-Source-L: No
X-Exim-ID: 1fAxPv-0025S0-Hl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:55334
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new_conf is indirectly dereferenced before it is null checked, hence
there is a potential null pointer dereference.

Fix this by moving the pointer dereference after new_conf has been
properly null checked.

Addresses-Coverity-ID: 1468386 ("Dereference before null check")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/omap3isp/ispstat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
index 0b31f6c..549c7ab 100644
--- a/drivers/media/platform/omap3isp/ispstat.c
+++ b/drivers/media/platform/omap3isp/ispstat.c
@@ -522,8 +522,8 @@ int omap3isp_stat_config(struct ispstat *stat, void *new_conf)
 {
 	int ret;
 	unsigned long irqflags;
-	struct ispstat_generic_config *user_cfg = new_conf;
-	u32 buf_size = user_cfg->buf_size;
+	struct ispstat_generic_config *user_cfg;
+	u32 buf_size;
 
 	if (!new_conf) {
 		dev_dbg(stat->isp->dev, "%s: configuration is NULL\n",
@@ -531,6 +531,9 @@ int omap3isp_stat_config(struct ispstat *stat, void *new_conf)
 		return -EINVAL;
 	}
 
+	user_cfg = new_conf;
+	buf_size = user_cfg->buf_size;
+
 	mutex_lock(&stat->ioctl_lock);
 
 	dev_dbg(stat->isp->dev,
-- 
2.7.4

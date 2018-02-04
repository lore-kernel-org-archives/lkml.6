Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeBDUj6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 15:39:58 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34542 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeBDUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 15:39:28 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [RFC PATCH 3/3] pcmcia: soc_common: Handle return value of clk_prepare_enable
Date: Sun,  4 Feb 2018 21:12:06 +0100
Message-Id: <20180204201206.2300-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204201206.2300-1-linux@dominikbrodowski.net>
References: <20180204201206.2300-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
CC: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/soc_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 764650eb8897..c5f2344c189b 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -191,12 +191,16 @@ static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret = 0, i;
 
-	clk_prepare_enable(skt->clk);
+	ret = clk_prepare_enable(skt->clk);
+	if (ret)
+		return ret;
 
 	if (skt->ops->hw_init) {
 		ret = skt->ops->hw_init(skt);
-		if (ret)
+		if (ret) {
+			clk_disable_unprepare(skt->clk);
 			return ret;
+		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(skt->stat); i++) {
-- 
2.16.1

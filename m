Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD555C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCF220652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCF220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJHSZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:25:52 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:46490 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJHSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:25:51 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id kzEd1y0023XaVaC01zEdlE; Mon, 08 Oct 2018 13:14:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TUj-00055W-GR; Mon, 08 Oct 2018 13:14:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9TUj-0006lz-Et; Mon, 08 Oct 2018 13:14:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] reset: Fix potential use-after-free in __of_reset_control_get()
Date:   Mon,  8 Oct 2018 13:14:35 +0200
Message-Id: <20181008111435.25994-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling of_node_put() decreases the reference count of a device tree
object, and may free some data.

However, the of_phandle_args structure embedding it is passed to
reset_controller_dev.of_xlate() after that, so it may still be accessed.

Move the call to of_node_put() down to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/reset/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 225e34c56b94a2e3..bc9df10d31b4bae1 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -496,27 +496,28 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 			break;
 		}
 	}
-	of_node_put(args.np);
 
 	if (!rcdev) {
-		mutex_unlock(&reset_list_mutex);
-		return ERR_PTR(-EPROBE_DEFER);
+		rstc = ERR_PTR(-EPROBE_DEFER);
+		goto out;
 	}
 
 	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
-		mutex_unlock(&reset_list_mutex);
-		return ERR_PTR(-EINVAL);
+		rstc = ERR_PTR(-EINVAL);
+		goto out;
 	}
 
 	rstc_id = rcdev->of_xlate(rcdev, &args);
 	if (rstc_id < 0) {
-		mutex_unlock(&reset_list_mutex);
-		return ERR_PTR(rstc_id);
+		rstc = ERR_PTR(rstc_id);
+		goto out;
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
 	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
 
+out:
+	of_node_put(args.np);
 	mutex_unlock(&reset_list_mutex);
 
 	return rstc;
-- 
2.17.1


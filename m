Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34860C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E332184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548520716;
	bh=JFNL5cRsIxbE1lyuBEhu+ozQ1a4Gcu8r207FGpnfE6s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WhAdswq0dhOWUBAoJ4c7kyPfchJnMO1T0gL3GyEcDtA3B2M4DkhTYH9raWzZ2scpx
	 6D98fNTmKz/15IPdFnDtW3WsTA3uV1RUQQ8qjt4UlfMfQ8xHQTleFLNwHfSxUilhGX
	 IE8tTbxLW3N0f9F/kqHenzeHWyXy3b4oelwVNuuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAZQie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:38:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfAZQid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:38:33 -0500
Received: from localhost.localdomain (cpe-70-115-146-104.austin.res.rr.com [70.115.146.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB0A2184B;
        Sat, 26 Jan 2019 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548520713;
        bh=JFNL5cRsIxbE1lyuBEhu+ozQ1a4Gcu8r207FGpnfE6s=;
        h=From:To:Cc:Subject:Date:From;
        b=K3QsQ/7Jy4ZvSAKXCt8VkhgecH2NIKDmciSnSfFoWWz4zbnY2tzXBlzPWXfXdb0/Z
         I/bZnHm4ws1FroFuplUU54Xdhtn4cM8i9dc1jc6//keGq0v+npsHu83XErflU7V07+
         vjHURV5QimMrvlaCmb6AdI1fZmJZxO+xqF3D00e8=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] fpga: stratix10-soc: fix wrong of_node_put() in init function
Date:   Sat, 26 Jan 2019 10:38:29 -0600
Message-Id: <20190126163829.4998-1-atull@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

After finding a "firmware" dt node stratix10 tries to match it's
compatible string with it. To do so it's calling of_find_matching_node()
which already takes care of decreasing the refcount on the "firmware"
node. We are then incorrectly decreasing the refcount on that node
again.

This patch removes the unwarranted call to of_node_put().

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
[atull: remove unnecessary braces]
---
 drivers/fpga/stratix10-soc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index a1a09e04fab8..13851b3d1c56 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -508,14 +508,11 @@ static int __init s10_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, s10_of_match);
-	if (!np) {
-		of_node_put(fw_np);
+	if (!np)
 		return -ENODEV;
-	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
-	of_node_put(fw_np);
 	if (ret)
 		return ret;
 
-- 
2.20.1


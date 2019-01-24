Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA22CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A781A218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548362764;
	bh=b3ML7LL6HxXDmi/kR6Z3xAVmvrRzGt49J1PdUY9aejc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mVtAK1E9dUJf7ArvTB5jbPEoivH0a/KB16DUhJ9n08/MnZFy+3MTDD5vJh4mE20rW
	 moBUrjPdxIcuDzHw2FeGEbND5t7iUjboE2KpipQdZXljtLQEP4BifdBjPFFIuE86Ji
	 Iqp76O9Uh0khcycAMuYvpRev7mQuaNVBC4j77D2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfAXUqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfAXUqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:46:02 -0500
Received: from atull-730U3E-740U3E.fm.intel.com (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FABD218D0;
        Thu, 24 Jan 2019 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548362762;
        bh=b3ML7LL6HxXDmi/kR6Z3xAVmvrRzGt49J1PdUY9aejc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StBy9htgniNmj9hax1VD3FZj/nH+DiH1vB9S/IsaNOq74fiRPhWUg+3uW5+AI3Tfz
         4evOhKXFJLopj6CcNANNSyCJfneI8ETZyf91YIpb3XHdyoQ0UoMY9Gzq6GH0MZd79T
         rNvEQV1XI7GjBcPI/1AyQcOXw9CZdFpYkkk0zCGA=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 1/3] fpga: stratix10-soc: fix wrong of_node_put() in init function
Date:   Thu, 24 Jan 2019 14:45:52 -0600
Message-Id: <20190124204554.5438-2-atull@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124204554.5438-1-atull@kernel.org>
References: <20190124204554.5438-1-atull@kernel.org>
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
---
 drivers/fpga/stratix10-soc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index a1a09e0..e75dbe5 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -509,13 +509,11 @@ static int __init s10_init(void)
 
 	np = of_find_matching_node(fw_np, s10_of_match);
 	if (!np) {
-		of_node_put(fw_np);
 		return -ENODEV;
 	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
-	of_node_put(fw_np);
 	if (ret)
 		return ret;
 
-- 
2.7.4


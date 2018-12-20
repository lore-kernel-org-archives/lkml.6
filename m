Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1C621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298242;
	bh=P09k47BWZ2lvByT9vXdAzZGX+VMwRnhjaLUdb+OoJgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OXU7BXrZePdbOjSm3IhKSjLryduX4BYnTP/4ZHv/+rC0UC/WUdXJJqYtt6vy5AEte
	 AoiUMLHtKyhxXS17zXvj+8a1xqwvtKcxpanNlmZxmQ6syBYfG6xMj6C/VyQ6yQYk/b
	 XFlOjNNWbpm/GUvd6WqJ0KEPONxif3rZWP0vYsRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbeLTJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbeLTJah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CEB221741;
        Thu, 20 Dec 2018 09:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298237;
        bh=P09k47BWZ2lvByT9vXdAzZGX+VMwRnhjaLUdb+OoJgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2+9MJqD29QQF44IjaoauB+GasT4KmzpWbgQz7glfi+6TVIE/3UqgI7LMIFyeVEsu
         dsW5hak3icgxG82HL/4Y/FPnIm/rJyTHbhPXE/bxupHb33Zu7r3MpWuwHQipPk7VpB
         G2eA1vojmIpR5BruuRiQGGeG5EbvXkh26nyYum4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 50/67] ethernet: fman: fix wrong of_node_put() in probe function
Date:   Thu, 20 Dec 2018 10:19:02 +0100
Message-Id: <20181220085905.533151272@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ecb239d96d369c23c33d41708646df646de669f4 ]

After getting a reference to the platform device's of_node the probe
function ends up calling of_find_matching_node() using the node as an
argument. The function takes care of decreasing the refcount on it. We
are then incorrectly decreasing the refcount on that node again.

This patch removes the unwarranted call to of_node_put().

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index c415ac67cb7b..e80fedb27cee 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2786,7 +2786,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (!muram_node) {
 		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
 			__func__);
-		goto fman_node_put;
+		goto fman_free;
 	}
 
 	err = of_address_to_resource(muram_node, 0,
@@ -2795,11 +2795,10 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
 			__func__, err);
-		goto fman_node_put;
+		goto fman_free;
 	}
 
 	of_node_put(muram_node);
-	of_node_put(fm_node);
 
 	err = devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED,
 			       "fman", fman);
-- 
2.19.1




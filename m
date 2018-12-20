Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3592EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062582176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299196;
	bh=RHXsWMnQkBGvd/wAOd1p6b30fwFEiS0bmIChK3T6BYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CqP8YdQhX73kaj81Nbfq5XHWNGWiykumdkdBtdNspi3jPxZf3Tc3ndKEvvt/q5115
	 wUcH7f/UhNSGFbOdQYakyyRiAqfSiy3T833MiMMN8pF7vEhwwzxhZ8Xb44WgN0sp83
	 DxS4oEghtWLobSlF1vFY/gPPqWGwArul63Lxjy7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbeLTJqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbeLTJUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9646221720;
        Thu, 20 Dec 2018 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297601;
        bh=RHXsWMnQkBGvd/wAOd1p6b30fwFEiS0bmIChK3T6BYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWREi/gdxrURq6zrmf1ni+E7BcV5SI4WFLeykoM3aNERdmV6jJLfQ8oWw+DS1hd6I
         oYafYV4/P+41yWLpwioR80QpnDx0E/7vK4qxh3CBljIusxyaK9wicmKRFy2R7Dt1gh
         JBZfmKgZsKhAsGfb3bLelnraLN8zEOLiEaUOBe9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 20/31] ide: pmac: add of_node_put()
Date:   Thu, 20 Dec 2018 10:18:32 +0100
Message-Id: <20181220085743.403103143@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a51921c0db3fd26c4ed83dc0ec5d32988fa02aa5 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/pmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 2db803cd095c..57a0bd00789f 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -920,6 +920,7 @@ static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *model = of_get_property(root, "model", NULL);
 
+	of_node_put(root);
 	/* Get cable type from device-tree. */
 	if (cable && !strncmp(cable, "80-", 3)) {
 		/* Some drives fail to detect 80c cable in PowerBook */
-- 
2.19.1




Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80EBC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0D8252D0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0D8252D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031073AbeGAQfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:35:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030594AbeGAQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:35:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2276AA6;
        Sun,  1 Jul 2018 16:35:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 113/157] backlight: max8925_bl: Fix Device Tree node lookup
Date:   Sun,  1 Jul 2018 18:23:05 +0200
Message-Id: <20180701160858.185738952@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit d1cc0ec3da23e44c23712579515494b374f111c9 upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent mfd node was also prematurely freed,
while the child backlight node was leaked.

Cc: stable <stable@vger.kernel.org>     # 3.9
Fixes: 47ec340cb8e2 ("mfd: max8925: Support dt for backlight")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/backlight/max8925_bl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/backlight/max8925_bl.c
+++ b/drivers/video/backlight/max8925_bl.c
@@ -116,7 +116,7 @@ static void max8925_backlight_dt_init(st
 	if (!pdata)
 		return;
 
-	np = of_find_node_by_name(nproot, "backlight");
+	np = of_get_child_by_name(nproot, "backlight");
 	if (!np) {
 		dev_err(&pdev->dev, "failed to find backlight node\n");
 		return;
@@ -125,6 +125,8 @@ static void max8925_backlight_dt_init(st
 	if (!of_property_read_u32(np, "maxim,max8925-dual-string", &val))
 		pdata->dual_string = val;
 
+	of_node_put(np);
+
 	pdev->dev.platform_data = pdata;
 }
 



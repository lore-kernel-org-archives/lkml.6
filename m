Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B27C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5BD20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f98Hov3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5BD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeJPMM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbeJPMDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C034C214DC;
        Tue, 16 Oct 2018 04:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663292;
        bh=KT8oUO4dUjDsnkTT/2tl/y/vXsVMTuxQmuG4kT9Wofo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f98Hov3DUTFxe2P4nAXgbo3kfeWab+Jz8NfKAzXTPgS9hNKgO9LgjroQjc/Oox+Kw
         YBEO+67lKz381wiIokS1pGrVq9SRU+5hUyU6YLGxgAKC9ZzeQqsFhhFd9zM+PzjvjD
         0qLel8hAs2g5kNqG5O0ul5v36dFQBIFqPKHYIJQo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 51/61] declance: Fix continuation with the adapter identification message
Date:   Tue, 16 Oct 2018 00:13:53 -0400
Message-Id: <20181016041403.135678-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@linux-mips.org>

[ Upstream commit fe3a83af6a50199bf250fa331e94216912f79395 ]

Fix a commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
continuation lines") regression with the `declance' driver, which caused
the adapter identification message to be split between two lines, e.g.:

declance.c: v0.011 by Linux MIPS DECstation task force
tc6: PMAD-AA
, addr = 08:00:2b:1b:2a:6a, irq = 14
tc6: registered as eth0.

Address that properly, by printing identification with a single call,
making the messages now look like:

declance.c: v0.011 by Linux MIPS DECstation task force
tc6: PMAD-AA, addr = 08:00:2b:1b:2a:6a, irq = 14
tc6: registered as eth0.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing continuation lines")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/declance.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/declance.c b/drivers/net/ethernet/amd/declance.c
index 82cc81385033..c7cde58feaf7 100644
--- a/drivers/net/ethernet/amd/declance.c
+++ b/drivers/net/ethernet/amd/declance.c
@@ -1029,6 +1029,7 @@ static int dec_lance_probe(struct device *bdev, const int type)
 	int i, ret;
 	unsigned long esar_base;
 	unsigned char *esar;
+	const char *desc;
 
 	if (dec_lance_debug && version_printed++ == 0)
 		printk(version);
@@ -1214,19 +1215,20 @@ static int dec_lance_probe(struct device *bdev, const int type)
 	 */
 	switch (type) {
 	case ASIC_LANCE:
-		printk("%s: IOASIC onboard LANCE", name);
+		desc = "IOASIC onboard LANCE";
 		break;
 	case PMAD_LANCE:
-		printk("%s: PMAD-AA", name);
+		desc = "PMAD-AA";
 		break;
 	case PMAX_LANCE:
-		printk("%s: PMAX onboard LANCE", name);
+		desc = "PMAX onboard LANCE";
 		break;
 	}
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = esar[i * 4];
 
-	printk(", addr = %pM, irq = %d\n", dev->dev_addr, dev->irq);
+	printk("%s: %s, addr = %pM, irq = %d\n",
+	       name, desc, dev->dev_addr, dev->irq);
 
 	dev->netdev_ops = &lance_netdev_ops;
 	dev->watchdog_timeo = 5*HZ;
-- 
2.17.1


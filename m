Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01597C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C845920854
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2tLJVUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C845920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbeKCDuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeKCDuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:12 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C72C2084D;
        Fri,  2 Nov 2018 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184120;
        bh=9cbaC3He9QnMqEo939Oj1g6JQD2L2ZksNF1sVBqxrT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2tLJVUzY6Hrb0A6iGO9jenrKdtbGRPhcxGUTT91cpKO/jCjhaobV1P/OdgSYyIc0
         ur/N8b6WX/mCBZGy5DrOlKtLqubG/FjAflGAn1b8K7NxB4DRemqVCPtltMVGuL0a5k
         EBMGNOoYFlgOSZFzWk5TF+styv2BV/a3S2pCA68w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 061/150] declance: Fix continuation with the adapter identification message
Date:   Fri,  2 Nov 2018 19:33:43 +0100
Message-Id: <20181102182907.830146018@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 116997a8b593..00332a1ea84b 100644
--- a/drivers/net/ethernet/amd/declance.c
+++ b/drivers/net/ethernet/amd/declance.c
@@ -1031,6 +1031,7 @@ static int dec_lance_probe(struct device *bdev, const int type)
 	int i, ret;
 	unsigned long esar_base;
 	unsigned char *esar;
+	const char *desc;
 
 	if (dec_lance_debug && version_printed++ == 0)
 		printk(version);
@@ -1216,19 +1217,20 @@ static int dec_lance_probe(struct device *bdev, const int type)
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




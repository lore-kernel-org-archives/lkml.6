Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8438222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899436;
	bh=/Uth2yVs47cZWNc0aro3mml8pIjQbMmWFyM79Zvgc30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N1Oh3u7ImfFp2jRtDk6sF0mKQBrTqcY0xq5VAQH7VMhmRCEysCwrc1ecVcYxDzUAL
	 sBqh4yEorJi8qEBx1UmUTf6qx6W+h9Wd64gTjL2rKAGuCADaKf7gkvBxp39RTgXBGe
	 YZDykU0utjC4V59P6L/gNFcr8+QFnVqaPhe+ppZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbfBKPhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387801AbfBKOvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A609820700;
        Mon, 11 Feb 2019 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896678;
        bh=/Uth2yVs47cZWNc0aro3mml8pIjQbMmWFyM79Zvgc30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2YFg9zmx1AtIAUY18029Q3sZHyTp0iOEdm0YVVRH4DgUGTMOV1yVLfnbocQb3o8E4
         WR8/75KA1krjTbwbwCC1oEIf8pCckk4+6oE8TZqb2VeeGmLNjEpR5uBexydJ4c9SJi
         iqFNMkGurdqW5mfXt9+So1b/YYE1Uru/SDpmFho4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 265/313] net: dsa: mv88e6xxx: Fix counting of ATU violations
Date:   Mon, 11 Feb 2019 15:19:05 +0100
Message-Id: <20190211141911.017231195@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 75c05a74e745ae7d663b04d75777af80ada2233c ]

The ATU port vector contains a bit per port of the switch. The code
wrongly used it as a port number, and incremented a port counter. This
resulted in the wrong interfaces counter being incremented, and
potentially going off the end of the array of ports.

Fix this by using the source port ID for the violation, which really
is a port number.

Reported-by: Chris Healy <Chris.Healy@zii.aero>
Tested-by: Chris Healy <Chris.Healy@zii.aero>
Fixes: 65f60e4582bd ("net: dsa: mv88e6xxx: Keep ATU/VTU violation statistics")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/global1_atu.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -314,6 +314,7 @@ static irqreturn_t mv88e6xxx_g1_atu_prob
 {
 	struct mv88e6xxx_chip *chip = dev_id;
 	struct mv88e6xxx_atu_entry entry;
+	int spid;
 	int err;
 	u16 val;
 
@@ -336,6 +337,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob
 	if (err)
 		goto out;
 
+	spid = entry.state;
+
 	if (val & MV88E6XXX_G1_ATU_OP_AGE_OUT_VIOLATION) {
 		dev_err_ratelimited(chip->dev,
 				    "ATU age out violation for %pM\n",
@@ -344,23 +347,23 @@ static irqreturn_t mv88e6xxx_g1_atu_prob
 
 	if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
 		dev_err_ratelimited(chip->dev,
-				    "ATU member violation for %pM portvec %x\n",
-				    entry.mac, entry.portvec);
-		chip->ports[entry.portvec].atu_member_violation++;
+				    "ATU member violation for %pM portvec %x spid %d\n",
+				    entry.mac, entry.portvec, spid);
+		chip->ports[spid].atu_member_violation++;
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_MISS_VIOLATION) {
 		dev_err_ratelimited(chip->dev,
-				    "ATU miss violation for %pM portvec %x\n",
-				    entry.mac, entry.portvec);
-		chip->ports[entry.portvec].atu_miss_violation++;
+				    "ATU miss violation for %pM portvec %x spid %d\n",
+				    entry.mac, entry.portvec, spid);
+		chip->ports[spid].atu_miss_violation++;
 	}
 
 	if (val & MV88E6XXX_G1_ATU_OP_FULL_VIOLATION) {
 		dev_err_ratelimited(chip->dev,
-				    "ATU full violation for %pM portvec %x\n",
-				    entry.mac, entry.portvec);
-		chip->ports[entry.portvec].atu_full_violation++;
+				    "ATU full violation for %pM portvec %x spid %d\n",
+				    entry.mac, entry.portvec, spid);
+		chip->ports[spid].atu_full_violation++;
 	}
 	mutex_unlock(&chip->reg_lock);
 



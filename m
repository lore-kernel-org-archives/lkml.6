Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D7E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="q2w2Jx24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D7E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeGILQx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:16:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeGILQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NzZWqkqeBr2zS+JmHCD+L05FlLdr5BR52W+srK0a9Ho=; b=q2w2Jx24vtbW
        PfrU/LjT/TEmHjmMo9MFA3BQc0QHxEvcx4kE2M5DQ8kIwO22fDGa1xdCrrFmR6badfIp72bQySPir
        liLb8vxtaLVWKN2EKc5wefekI5Y8HONQ/pGOvXKM+N6H+UbtWzDtTsNVw7CMNY6unpIvqErjHE8h3
        5HCyw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcU9v-0003hn-7H; Mon, 09 Jul 2018 11:16:47 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcU9u-0005dI-QC; Mon, 09 Jul 2018 12:16:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max8997: clean up a condition in max8997_list_voltage()" to the regulator tree
In-Reply-To:  <20180706083718.n3b7ejg42fknnwb2@kili.mountain>
Message-Id: <E1fcU9u-0005dI-QC@debutante>
Date:   Mon, 09 Jul 2018 12:16:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8997: clean up a condition in max8997_list_voltage()

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 1aa1b918946537c089716bffd1399e30a2981cb7 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 6 Jul 2018 11:37:18 +0300
Subject: [PATCH] regulator: max8997: clean up a condition in
 max8997_list_voltage()

The current code generates a static cehcker warnings because "rid < 0"
is always false:

    drivers/regulator/max8997-regulator.c:169 max8997_list_voltage()
    warn: condition is always false

The problem is that because of type promotion, if "rid" is negative the
comparison against ARRAY_SIZE() is type promoted to size_t and it's
treated as a very high positive value.  I've changed the order of the
checks so now everyone is happy.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8997-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index a8ea30ee18a6..029a6ee426ab 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -165,8 +165,7 @@ static int max8997_list_voltage(struct regulator_dev *rdev,
 	int rid = rdev_get_id(rdev);
 	int val;
 
-	if (rid >= ARRAY_SIZE(reg_voltage_map) ||
-			rid < 0)
+	if (rid < 0 || rid >= ARRAY_SIZE(reg_voltage_map))
 		return -EINVAL;
 
 	desc = reg_voltage_map[rid];
-- 
2.18.0.rc2


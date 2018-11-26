Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C8020989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OWKk5kWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C8020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeK0EQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:16:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48338 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeK0EQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w2tXLPzAxSv13SBE+5WcmkEsFJFz06qWZyKgmvPSd9s=; b=OWKk5kWvVIST
        qbY+vqpJwY5JsFB5J69kDfCb7/CSAvn1xbEW38pSlUecx0fwSSVVi0v1yF3Pgzxz29kjgYQvnZS9Z
        hFTySp0IYinT1BwqsKdQnJOhtf1Wd29Vj29rGy9FnKO7yVeyYa17dtyNY/Bl72zjmSrH8YJs5nA14
        CG4rE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRKZM-0005Tu-LL; Mon, 26 Nov 2018 17:21:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 50017112519F; Mon, 26 Nov 2018 17:21:12 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Brian Masney <masneyb@onstation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Apply system load even if no consumer loads" to the regulator tree
In-Reply-To: 
Message-Id: <20181126172112.50017112519F@debutante.sirena.org.uk>
Date:   Mon, 26 Nov 2018 17:21:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Apply system load even if no consumer loads

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

From fa94e48e13a1aaf814b9e956d8e5a52ef303b569 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 26 Nov 2018 09:08:27 -0800
Subject: [PATCH] regulator: core: Apply system load even if no consumer loads

Prior to commit 5451781dadf8 ("regulator: core: Only count load for
enabled consumers") we used to always add up the total load on every
enable in _regulator_enable().  After that commit we only updated the
total load when enabling / disabling a regulator where a consumer
specified a load or when changing the consumer load on an enabled
regulator.

The problem with the new scheme is that if there is a system load
specified for a regulator but no consumers specify a load then we
never account for it.

Let's account for the system load in set_machine_constraints().

NOTE: with the new scheme we end up with a bit of a quandry.  What if
someone specifies _both_ an initial mode and a system load?  If we
take the system load into account right at init time then it will
effectively clobber the initial mode.  We'll resolve this by saying
that if both are specified then the initial mode will win.  The system
load will then only take effect if/when a consumer specifies a load.
If no consumers ever specify a load then the initial mode will persist
and the system load will have no effect.

Fixes: 5451781dadf8 ("regulator: core: Only count load for enabled consumers")
Reported-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03a03763457c..757619878068 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1342,6 +1342,12 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 			rdev_err(rdev, "failed to set initial mode: %d\n", ret);
 			return ret;
 		}
+	} else if (rdev->constraints->system_load) {
+		/*
+		 * We'll only apply the initial system load if an
+		 * initial mode wasn't specified.
+		 */
+		drms_uA_update(rdev);
 	}
 
 	/* If the constraints say the regulator should be on at this point
-- 
2.19.0.rc2


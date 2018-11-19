Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7039C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBBC20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PmI5w2iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBBC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeKSXeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:34:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49712 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbeKSXd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=scu8o1aDQDyt5wj5cl4oDhPJyKu7E1QutFS7BxAI9NU=; b=PmI5w2iQsg21
        jU6Aesptx8x5HqYA9byxid75rdBb8s/kOHw1eqoiMJVq23UVNQorHROhea5Zwr8SrHYeL1y2TP2Zb
        XeiNndsmYxtoiNT3jg9bhBPZ135iEuqVn7tBsbCk4Cx6qhUl92uGjEItJiqm6I3qdWGQzrzai7FJD
        1zYNM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gOjJl-0000A5-D6; Mon, 19 Nov 2018 13:10:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 20A9D1125031; Mon, 19 Nov 2018 13:10:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Keep regulators-list locked while traversing the list" to the regulator tree
In-Reply-To: 
Message-Id: <20181119131021.20A9D1125031@debutante.sirena.org.uk>
Date:   Mon, 19 Nov 2018 13:10:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Keep regulators-list locked while traversing the list

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

From ff9b34b615a37a3f4d359bf82fc97f5e0310b301 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Mon, 19 Nov 2018 00:56:19 +0300
Subject: [PATCH] regulator: core: Keep regulators-list locked while traversing
 the list

It's unlikely that regulators may disappear/appear while regulators
debug-summary is being prepared, but let's be consistent and avoid that
situation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e46e53aa43db..fd237bc0fa7c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4936,7 +4936,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 			regulator_disable(rdev->supply);
 		regulator_put(rdev->supply);
 	}
+
 	mutex_lock(&regulator_list_mutex);
+
 	debugfs_remove_recursive(rdev->debugfs);
 	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
@@ -4944,8 +4946,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	regulator_ena_gpio_free(rdev);
-	mutex_unlock(&regulator_list_mutex);
 	device_unregister(&rdev->dev);
+
+	mutex_unlock(&regulator_list_mutex);
 }
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
@@ -5278,6 +5281,8 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 	struct regulator_dev *old_contended_rdev = NULL;
 	int err;
 
+	mutex_lock(&regulator_list_mutex);
+
 	ww_acquire_init(ww_ctx, &regulator_ww_class);
 
 	do {
@@ -5304,6 +5309,8 @@ static void regulator_summary_unlock(struct ww_acquire_ctx *ww_ctx)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_summary_unlock_one);
 	ww_acquire_fini(ww_ctx);
+
+	mutex_unlock(&regulator_list_mutex);
 }
 
 static int regulator_summary_show_roots(struct device *dev, void *data)
-- 
2.19.0.rc2


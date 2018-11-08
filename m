Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E6ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D47E2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fTYd5lSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D47E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeKIBy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:54:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46118 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeKIBy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mFjEXbAbkDgHi3MeE75Cx85N6MFTrH+pRIQnh4lHFH4=; b=fTYd5lSN/wtu
        vUnmeEZS2YBpwKuFtVBpnsmZYPeR6O5Vq4/5hongsjqWltorJvKpPSC4EZWK/aK0hDYAiyxSu/bOy
        aHHWXGFzb+krB1vDJ6dLNpm6pJu0UMpWFZS4WcWjNNknwRYF+lzvrEb9wBHMgFdwa8gF7B+Z7N0Zs
        0bJ5w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKn12-0000CT-Fz; Thu, 08 Nov 2018 16:18:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 318481124D9E; Thu,  8 Nov 2018 16:18:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Don't allow to get regulator until all couples resolved" to the regulator tree
In-Reply-To: 
Message-Id: <20181108161844.318481124D9E@debutante.sirena.org.uk>
Date:   Thu,  8 Nov 2018 16:18:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Don't allow to get regulator until all couples resolved

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

From 79d6f049f4f05f5cb6e1647a9a253dad14bfabbe Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 5 Oct 2018 18:36:31 +0300
Subject: [PATCH] regulator: core: Don't allow to get regulator until all
 couples resolved

Don't allow to get regulator until all of its couples resolved because
consumer will get EPERM and coupling shall be transparent for the drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 925df9e6f1e3..089e8ad8ef57 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1747,6 +1747,16 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
+	mutex_lock(&regulator_list_mutex);
+	ret = (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled);
+	mutex_unlock(&regulator_list_mutex);
+
+	if (ret != 0) {
+		regulator = ERR_PTR(-EPROBE_DEFER);
+		put_device(&rdev->dev);
+		return regulator;
+	}
+
 	ret = regulator_resolve_supply(rdev);
 	if (ret < 0) {
 		regulator = ERR_PTR(ret);
-- 
2.19.0.rc2


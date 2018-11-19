Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D68C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627420831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZhICwh8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C627420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeKSXd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:33:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbeKSXd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=k+puHK7Mryz/fAkkjP+c7+vOaynj1dr6Er2mBy+twh0=; b=ZhICwh8X3bj1
        zROg+EnaNsQ1WP5a5HO757KPFnhG4kp8R0IwCNjbFbBIZ8qZDM1o/g4A+70gMSNoUOeiTfVGFKvSj
        rGNBX5sUpjxTy/gntaJEWPJe0ocrb8XjnqYlQ9Cw2cKVZqrcwdu2DpZP4yuNinE8pyGndVxkQhUyu
        Bfto0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gOjJj-00009z-Or; Mon, 19 Nov 2018 13:10:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7B2B41125031; Mon, 19 Nov 2018 13:10:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Change regulator-coupled-max-spread property" to the regulator tree
In-Reply-To: 
Message-Id: <20181119131019.7B2B41125031@debutante.sirena.org.uk>
Date:   Mon, 19 Nov 2018 13:10:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Change regulator-coupled-max-spread property

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

From a8d8ee437ea0bf21f840f33ca87f8e1641727aae Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Mon, 19 Nov 2018 00:56:16 +0300
Subject: [PATCH] regulator: Change regulator-coupled-max-spread property

Redefine binding for regulator-coupled-max-spread property in a way that
max-spread values are defined per regulator couple instead of defining
single max-spread for the whole group of coupled regulators.

With that change the following regulators coupling configuration will be
possible:

regA: regulatorA {
	regulator-coupled-with = <&regB &regC>;
	regulator-coupled-max-spread = <100000 300000>;
};

regB: regulatorB {
	regulator-coupled-with = <&regA &regC>;
	regulator-coupled-max-spread = <100000 200000>;
};

regC: regulatorC {
	regulator-coupled-with = <&regA &regB>;
	regulator-coupled-max-spread = <300000 200000>;
};

Note that the regulator-coupled-max-spread property does not have any
users yet, hence it's okay to change the binding.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index ca96f70bd2de..e3a7a7a0316b 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -79,8 +79,9 @@ Optional properties:
 - regulator-coupled-with: Regulators with which the regulator
   is coupled. The linkage is 2-way - all coupled regulators should be linked
   with each other. A regulator should not be coupled with its supplier.
-- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
-  in microvolts.
+- regulator-coupled-max-spread: Array of maximum spread between voltages of
+  coupled regulators in microvolts, each value in the array relates to the
+  corresponding couple specified by the regulator-coupled-with property.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.19.0.rc2


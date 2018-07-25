Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B17520833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/Rb59ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B17520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbeGYRFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbeGYRFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:05:44 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5EE4204EC;
        Wed, 25 Jul 2018 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532534008;
        bh=tyy8aIVbDKmWAGamNXfrs5LpPPxkq0D02Ww7HHNjegs=;
        h=From:To:Subject:Date:From;
        b=t/Rb59otcJrXj/4s7QskNe6ODEav2oo7SkLFkyN63I805XpudweFiJidOA9XETvRx
         3AD8CGN/Whb8mOwV+1tls9p4XZt+KeF701PKgz3wASmzOsjfEViJtTUrMwM8d87Wb/
         a0GqFKrUNElBxqK+2vRTqGwz8/TmOhGr+DyrU8dI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] mfd: sec: Export OF module alias table
Date:   Wed, 25 Jul 2018 17:53:02 +0200
Message-Id: <20180725155302.4718-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of Device Tree platforms, even though the Samsung PMIC sec
device is instantiated from DT, the driver is still matched through I2C
module alias.  That is because I2C core always reports an I2C module
alias instead of DT one.

This could change in the future so export DT module alias.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/sec-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index ca6b80d08ffc..9613b4257302 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -146,6 +146,7 @@ static const struct of_device_id sec_dt_match[] = {
 		/* Sentinel */
 	},
 };
+MODULE_DEVICE_TABLE(of, sec_dt_match);
 #endif
 
 static bool s2mpa01_volatile(struct device *dev, unsigned int reg)
-- 
2.14.1


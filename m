Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC08D2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TARDOJ4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC08D2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeHaTWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:22:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45994 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:22:10 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VFE9e7006424;
        Fri, 31 Aug 2018 10:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535728450;
        bh=q08HEBU4gy9nnMAsEz95z1AcP5gY6iBXy/JhjiFNE/c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TARDOJ4PDjlayK/q3K87zyhOrS9h7otgiOSxUSSj6MC3uSryoyrJ5/5xf1D5zg/6a
         atsEHt5jtFKU+Sr759svPpbxiabtDe5ZCHaWSw9A0BSIiGNYxjn4CuNOpRrj2yDLQ+
         lecrd5eTBfFWjEd3y3tCs3YiJGGVeL7DpsJRtK7E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFE9wa030814;
        Fri, 31 Aug 2018 10:14:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 10:14:09 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 10:14:09 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFE99V025663;
        Fri, 31 Aug 2018 10:14:09 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VFE8x19331;
        Fri, 31 Aug 2018 10:14:09 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/3] ASoC: tas6424: Print full register name in error message
Date:   Fri, 31 Aug 2018 10:14:06 -0500
Message-ID: <20180831151407.18864-2-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831151407.18864-1-afd@ti.com>
References: <20180831151407.18864-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current short version of the register name may be
ambiguous when another fault register detection is added.
Use the full name.

While here fix comment about clearing faults, the CLEAR_FAULT
register actually only clears sticky bits, which are only
warnings, fault bits can only cleared by resolving the fault.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tas6424.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 0d6145549a98..aac559fffc1a 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -408,7 +408,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT1, &reg);
 	if (ret < 0) {
-		dev_err(dev, "failed to read FAULT1 register: %d\n", ret);
+		dev_err(dev, "failed to read GLOB_FAULT1 register: %d\n", ret);
 		goto out;
 	}
 
@@ -453,7 +453,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 check_global_fault2_reg:
 	ret = regmap_read(tas6424->regmap, TAS6424_GLOB_FAULT2, &reg);
 	if (ret < 0) {
-		dev_err(dev, "failed to read FAULT2 register: %d\n", ret);
+		dev_err(dev, "failed to read GLOB_FAULT2 register: %d\n", ret);
 		goto out;
 	}
 
@@ -530,7 +530,7 @@ static void tas6424_fault_check_work(struct work_struct *work)
 	/* Store current warn value so we can detect any changes next time */
 	tas6424->last_warn = reg;
 
-	/* Clear any faults by toggling the CLEAR_FAULT control bit */
+	/* Clear any warnings by toggling the CLEAR_FAULT control bit */
 	ret = regmap_write_bits(tas6424->regmap, TAS6424_MISC_CTRL3,
 				TAS6424_CLEAR_FAULT, TAS6424_CLEAR_FAULT);
 	if (ret < 0)
-- 
2.18.0


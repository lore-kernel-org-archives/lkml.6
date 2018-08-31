Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A67C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E46220839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J9/6RsUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E46220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeHaSzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:55:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46954 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeHaSzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:55:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VElGZ4035698;
        Fri, 31 Aug 2018 09:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535726836;
        bh=hmcVhzlpBnBqV/ip6etNiwNVhZ1s9Os5Gh4X5r8zPmU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J9/6RsUJ9Z70/hLNj3jLewOzmyDdryHQcZ1OdfKNjI6lVkEGERl2SZGsrIyUlSFdT
         ozxsurp0hxgI5SweVoQEOtrKcejOw1OQA6/hXEheVNAISeu0AG7lqg0iHrPQvtmKSE
         RrWzoMaJnGvraq6etgD39FxbJ3jQr6QXb46IpDrU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VElGkV018558;
        Fri, 31 Aug 2018 09:47:16 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 09:47:15 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 09:47:15 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VElFk6019840;
        Fri, 31 Aug 2018 09:47:15 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VElFx17479;
        Fri, 31 Aug 2018 09:47:15 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v2 2/2] ASoC: codecs: tas5720: add TAS5722 TDM slot width setting support
Date:   Fri, 31 Aug 2018 09:47:14 -0500
Message-ID: <20180831144714.16499-2-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831144714.16499-1-afd@ti.com>
References: <20180831144714.16499-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Dannenberg <dannenberg@ti.com>

Unlike the TAS5720, the TAS5722 can be configured to utilize 16-bit wide
slots in TDM mode. This can help easing audio clocking/frequency
requirements.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---

Changes from v1:
 - Use switch over if

 sound/soc/codecs/tas5720.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 3c469112477a..6bd0e5d5347f 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -152,6 +152,7 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				    int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
+	struct tas5720_data *tas5720 = snd_soc_component_get_drvdata(component);
 	unsigned int first_slot;
 	int ret;
 
@@ -185,6 +186,20 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		goto error_snd_soc_component_update_bits;
 
+	/* Configure TDM slot width. This is only applicable to TAS5722. */
+	switch (tas5720->devtype) {
+	case TAS5722:
+		ret = snd_soc_component_update_bits(component, TAS5722_DIGITAL_CTRL2_REG,
+						    TAS5722_TDM_SLOT_16B,
+						    slot_width == 16 ?
+						    TAS5722_TDM_SLOT_16B : 0);
+		if (ret < 0)
+			goto error_snd_soc_component_update_bits;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 
 error_snd_soc_component_update_bits:
-- 
2.18.0


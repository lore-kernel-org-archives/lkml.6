Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DFDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F7B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Clv/6rnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfBUNRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:17:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33680 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:17:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so14193589plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=i9dnmQKikQDAfv387S9/Csb5/zqc1ZkYICOw/M9dd+4=;
        b=Clv/6rnSVFy3mxLUnS8/e4lPiCFX4xO7X3SVB4bSl98/yy9VWvZW7my0FXEd2h8xwg
         hqAZ0RfwHLztIryk3ipkPP+JwdJMVn8LtC179ZAETqHgEU1wIo2WF38p3uGiZR1G0Pbo
         zN8pFzPuDGldT+KFeenNyJomKgykmn4yMYv/hg+laAXhGypN4o9tnZPttiRNScLw1FAH
         l2ZqRnnfL/3/ipeqeRExiO691Cil7A0mTr91mQ8WSLEWoHlv/WQERUsCfubM0L/sGAhw
         9gojgGGwX/VU6FXHb5c8HPV7iYAdRzNApMcynzhrh8Ys/A1q7vpNNcMJ0bt7MAkaEMEy
         JNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i9dnmQKikQDAfv387S9/Csb5/zqc1ZkYICOw/M9dd+4=;
        b=pXMHowf9fvTE+VKVRcGTpOx0KcZNs9FkvYS4bhZi7bMA/g1JBdte8GuZkIhVGtTW0d
         JEBNR7I0EFMbGcs3t3A+FQ255s/OBSbeZezaM78WFnk8GPfdStsp++vUvIyGG8sLRleb
         bjxDsxWwCnLGPO95WWjebt14W2Ffx+IJ9AjcUirLLmaIq7xYE+XP47R4XEV5Qn3rdGFJ
         6RrXvdQwVbaqFE1+kQv5cFuetgGDPvI3lloYVJNvP0sEUD4OpGi/Pt1sgOc3ZnC9B8PC
         QlY+1Y2n4+nh3+SBu1s43nH+HTJcnF+w0ZbGcimZ3KaJ1Z37lAsz086Cdg9igwluQx29
         1CfA==
X-Gm-Message-State: AHQUAua+J1VkDd33NfO/2AeiNst0WgwX4s2/HqX3TqJSoUvW2VRdFxLu
        QeJ/vplIyl49NX4rokhkPfRiGw==
X-Google-Smtp-Source: AHgI3IbJwCIOi+VlW2VQIoJB8pwJn9LYlRseRu45GcuZFaTdBNHZHlkjKFALPbc/nmz2cE7O+mngpA==
X-Received: by 2002:a17:902:b01:: with SMTP id 1mr43251258plq.331.1550755070867;
        Thu, 21 Feb 2019 05:17:50 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id e21sm79046676pfh.45.2019.02.21.05.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 05:17:49 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: s5m8767: Constify s5m8767_opmode_reg
Date:   Thu, 21 Feb 2019 21:17:21 +0800
Message-Id: <20190221131722.12278-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s5m8767_opmode_reg should never change, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/s5m8767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index b581f01f3395..5b0e1fe6723f 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -115,7 +115,7 @@ static const struct sec_voltage_desc *reg_voltage_map[] = {
 	[S5M8767_BUCK9] = &buck_voltage_val3,
 };
 
-static unsigned int s5m8767_opmode_reg[][4] = {
+static const unsigned int s5m8767_opmode_reg[][4] = {
 	/* {OFF, ON, LOWPOWER, SUSPEND} */
 	/* LDO1 ... LDO28 */
 	{0x0, 0x3, 0x2, 0x1}, /* LDO1 */
-- 
2.17.1


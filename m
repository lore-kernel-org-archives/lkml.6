Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C641C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABCA2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UsgvHeAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfBDTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:07:55 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41901 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfBDTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:07:55 -0500
Received: by mail-yb1-f195.google.com with SMTP id n6so39248ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UBXiUcp8uf1Oo1Bd5TzSmKDG4tWcAAfQDfqWBtCoGlw=;
        b=UsgvHeAmfHXSN67i6BwXOnxWoTlId5vsn9CytyEsyX4eNdARxvpKTIu3uVuo2/p7aE
         LRMkge7XrHCmoOmVLcOLd94Z4D9DabW+BY6vUxjmOS23PZ1mDUyDTvku4/uoAeLZCTK+
         TWgpsDdy37gEMH2sHclYH2AwZ1iWJrIcvod2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UBXiUcp8uf1Oo1Bd5TzSmKDG4tWcAAfQDfqWBtCoGlw=;
        b=chOVKyQ/gVRxGU++VaGS8hhKnkh8cpsVIl2K443An6bIWxR6sIRshU855Dda8t8yYg
         lnYSWcknPz6YKSGBYjOhUn8OxBSmJyzb+sN7rhlY6Ah4JHX4yuxLWHR/K1WFv33vlUEr
         22+ELeDq+7xPDvCM1EKbCJNjWo+apsNN0sBrqwPi7WMh4Ds5uggN9e5jau4FmBoWj7WZ
         k0BuHxrfG1TkxGH/nIntEoUxOGhO/4Xki0jdMl8iK3IiJv6fORxrKJ/pJjehRWl0+e/6
         LC1/J0KRi1Q9HeSP5yDf43XVqaW/48Oleq3H962R1Yl02AE1P0G0OUVqSO8z8yNSA0sX
         5JNA==
X-Gm-Message-State: AHQUAuZE+Dqm+mZQvfc8Ee5+bmPWWd2Z38wdFiBcTrlLoWuVH2QsJWkH
        hk+uJA5UIhcL/621KGOB7tLXQQ==
X-Google-Smtp-Source: AHgI3IZMexC0lXb/jyCnbEfQua6O+Q8idvliiNMhgoJSvxRgU7dnxPnbTEx+PlvlMDS8t3lXXB03ag==
X-Received: by 2002:a25:2386:: with SMTP id j128mr870250ybj.120.1549307274251;
        Mon, 04 Feb 2019 11:07:54 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w70sm680582yww.76.2019.02.04.11.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 11:07:53 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Qingmin Liu <qingmin.liu@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH] phy: bcm-sr-pcie: Change operation when PIPEMUX=1
Date:   Mon,  4 Feb 2019 11:07:45 -0800
Message-Id: <20190204190745.93170-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qingmin Liu <qingmin.liu@broadcom.com>

When PIPEMIX=1, change the operation from 2x8 EP to 1x8 EP + 1x8 RC.

Signed-off-by: Qingmin Liu <qingmin.liu@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/phy/broadcom/phy-bcm-sr-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
index c10e95f86de5..96a3af126a78 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
@@ -78,8 +78,8 @@ struct sr_pcie_phy_core {
 static const u8 pipemux_table[] = {
 	/* PIPEMUX = 0, EP 1x16 */
 	0x00,
-	/* PIPEMUX = 1, EP 2x8 */
-	0x00,
+	/* PIPEMUX = 1, EP 1x8 + RC 1x8, core 7 */
+	0x80,
 	/* PIPEMUX = 2, EP 4x4 */
 	0x00,
 	/* PIPEMUX = 3, RC 2x8, cores 0, 7 */
-- 
2.17.1


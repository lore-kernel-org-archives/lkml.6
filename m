Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467EDC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B2218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549518342;
	bh=DRfV4szs40ya1bPVdGMiDE25rLGT0suhLe2d7FVAIxM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=x5FrqWOvW+s7u7u2adksB+zXxpb7M9ew25wKGcaFrf8SoPnPLGX6ZMlnyEpWPpb0k
	 3GTeJc0I/tDCIyRdNLpwWGpYTBl3i29Qx26s14a2ti4U0Wv7FfiJGh7WcJUb8lJWx5
	 4EUGE+8+sX8vWFerX97PYl6dcqLdg2H4vLkixUBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfBGFpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:45:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33045 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfBGFpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:45:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id z8so1674544plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 21:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/XuKC06w0o2tfOG+IZnGnEkIbmY1Io4BgDh5iGJOPY=;
        b=Y5Xsv+tS0rV5IBZHCHPK6KvVNSKng94MA/BvC7/GQ7sBGTSsKNaPTF44A+5k88l+sO
         XCTSxIMHh4QTwCVRav5Q1FYI0esF+XNkZs9INkpx29ddE2QHIjEjOZn8QOj3qD7ki2bN
         u5M1Bzkf4Dyz22V4UcaJBG2JeDG/eqdqIOpsWgLdIgaLVuh2gdS6PC2HODAQbKFxHJsY
         VJ35rmANQj5dTBqBdQdxgWkaMqRkPF6dZRXXNhuoc+1weciNWdD8BFo+I9xmjKJZuV4L
         vGjXxExUuPJo3t8CLWHl+pRyROUQ/7Rf7PKSA+59nII5V0sAUfbRY38nATtLFd8olt/f
         SMPw==
X-Gm-Message-State: AHQUAuaPZkpsIMLyg5yluF0YIhj3Ib2YlmkY5sixRdVAD/Jrww3apouK
        fBlpxuY4QqzUXRiBrRSMDwuMHw==
X-Google-Smtp-Source: AHgI3IbUDAOfIEn43rGSI5w0tZaQ96eaAsFZkda7/euF95HRQPbL5Oc26Rpo0HSHB9LiOLPumuxuhA==
X-Received: by 2002:a17:902:be11:: with SMTP id r17mr14824848pls.308.1549518338861;
        Wed, 06 Feb 2019 21:45:38 -0800 (PST)
Received: from localhost ([2601:647:4700:93d:6db5:e35d:dacd:7872])
        by smtp.gmail.com with ESMTPSA id t3sm11702771pfa.50.2019.02.06.21.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 21:45:38 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        hkallweit1@gmail.com, f.fainelli@gmail.com, andrew@lunn.ch,
        moritz@ettus.com, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 net-next] net: phy: fixed_phy: Fix fixed_phy not checking GPIO
Date:   Wed,  6 Feb 2019 21:45:29 -0800
Message-Id: <20190207054529.2865-1-mdf@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix fixed_phy not checking GPIO if no link_update callback
is registered.

In the original version all users registered a link_update
callback so the issue was masked.

Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Added Andrew's Reviewed-by: tag
- Added Fixes: tag (Thanks for digging, Andrew!)

---
 drivers/net/phy/fixed_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index f136a23c1a35..d810f914aaa4 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -85,11 +85,11 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 				s = read_seqcount_begin(&fp->seqcount);
 				fp->status.link = !fp->no_carrier;
 				/* Issue callback if user registered it. */
-				if (fp->link_update) {
+				if (fp->link_update)
 					fp->link_update(fp->phydev->attached_dev,
 							&fp->status);
-					fixed_phy_update(fp);
-				}
+				/* Check the GPIO for change in status */
+				fixed_phy_update(fp);
 				state = fp->status;
 			} while (read_seqcount_retry(&fp->seqcount, s));
 
-- 
2.20.1


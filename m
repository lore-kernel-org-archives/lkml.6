Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23165C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A22175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691051;
	bh=2zemEJYtsJJ7GM4i4k5tRcHzbBkjfOZWmjYdTmImLjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PbuYKN9QJbA/QegaDMZf4jLjeQjqrnJeJocX/Wlr5CWQJW2iHZPDVGZq6tUx1wOUp
	 WaKgbF9Lrf7Ft8/pyuL6idd6TwlVI0miTKY4yWw2hqUeEYE6Jw4WCDaBv4qwRNFwzo
	 JbBVGlqZQhJHpAWrfvKLThr+ISil2LMuucF+NQEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfA1P53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbfA1P50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:57:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A52021841;
        Mon, 28 Jan 2019 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691045;
        bh=2zemEJYtsJJ7GM4i4k5tRcHzbBkjfOZWmjYdTmImLjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psaJmptrBlsG1bw6G29Pee3TTNuk+I/rgXzE6uUN/JH1WwZ8dQ+rHxrq5Gc1OiTOw
         RmVP3DJZWu9k/zhHmFVa03RiTYfBsfy2UmjOzROlSMQfysfsDOPqt/d5kn9Ibun2n5
         rSx6/it4eZFhPQzxohsl009r7q+dtyl1C1oGS9Ww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 272/304] niu: fix missing checks of niu_pci_eeprom_read
Date:   Mon, 28 Jan 2019 10:43:09 -0500
Message-Id: <20190128154341.47195-272-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 26fd962bde0b15e54234fe762d86bc0349df1de4 ]

niu_pci_eeprom_read() may fail, so we should check its return value
before using the read data.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Shannon Nelson <shannon.lee.nelson@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sun/niu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 9319d84bf49f..d84501441edd 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -8100,6 +8100,8 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
 		start += 3;
 
 		prop_len = niu_pci_eeprom_read(np, start + 4);
+		if (prop_len < 0)
+			return prop_len;
 		err = niu_pci_vpd_get_propname(np, start + 5, namebuf, 64);
 		if (err < 0)
 			return err;
@@ -8144,8 +8146,12 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
 			netif_printk(np, probe, KERN_DEBUG, np->dev,
 				     "VPD_SCAN: Reading in property [%s] len[%d]\n",
 				     namebuf, prop_len);
-			for (i = 0; i < prop_len; i++)
-				*prop_buf++ = niu_pci_eeprom_read(np, off + i);
+			for (i = 0; i < prop_len; i++) {
+				err = niu_pci_eeprom_read(np, off + i);
+				if (err >= 0)
+					*prop_buf = err;
+				++prop_buf;
+			}
 		}
 
 		start += len;
-- 
2.19.1


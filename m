Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99215C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5963C20811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693265;
	bh=Gzyeu7neu68PbQir2lRhlHmao3Em4XafQgNrKV7LYco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fk+eTwI7Lc+NVrCfkMqkQEi+WIsH4NlTWY9OX03yqotiQF4K6NaXvPW0h2AUO/8V+
	 X7a4iUWCWrzC2jWbCGlXtp1VlPejAndjbf7/NcI19KE22jbtNuNC1DD3PSkie4O8Fs
	 slz53XwzJiwp/Cx7JkXhuiPcpKoUwV46iLWLU+3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbfA1QeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:34:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389344AbfA1Q0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:26:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631A12147A;
        Mon, 28 Jan 2019 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692764;
        bh=Gzyeu7neu68PbQir2lRhlHmao3Em4XafQgNrKV7LYco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFd9Vw+pOA8uq7M9onIb8bwvaOkwqDKGu7jt2ELJ7BghLt8WO+sN/P0oPvQ3oJH32
         bJQt6TSwACWO+NumDdWQypNxm61WoXMy/QI5aL3+CNVxQKKs/RAJKDHXRQYJ+0LS7P
         /gLWDeqWtf/Ql8LG3/BQWEXkTaW7rZxxDbUMmknk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 70/80] niu: fix missing checks of niu_pci_eeprom_read
Date:   Mon, 28 Jan 2019 11:23:51 -0500
Message-Id: <20190128162401.58841-70-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
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
index ccebf89aa1e4..85f3a2c0d4dd 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -8121,6 +8121,8 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
 		start += 3;
 
 		prop_len = niu_pci_eeprom_read(np, start + 4);
+		if (prop_len < 0)
+			return prop_len;
 		err = niu_pci_vpd_get_propname(np, start + 5, namebuf, 64);
 		if (err < 0)
 			return err;
@@ -8165,8 +8167,12 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
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


Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0C4222AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896573;
	bh=TpjV7DA8BLZsiTGhJkCmRCQBRVyiuWRqNZTBM2c0KVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i0vvWkGuuu1WcLj3e9zammZocoRxxg5Ae09sOb8kFaeveCVIEHHWczKVmyLk1UyEA
	 P4rZfQdIM1oveJp3F4251LSg8pE8SMVGejHr7x1dPD+rqzqSvQVKk1QPBWjRzEmkhX
	 6nSExnfe8Q1PajF6GQcDcQC01fpuCpSOpKg845pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfBKOtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387885AbfBKOt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:49:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A093F206BA;
        Mon, 11 Feb 2019 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896567;
        bh=TpjV7DA8BLZsiTGhJkCmRCQBRVyiuWRqNZTBM2c0KVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLlFhffL7hr9sXQvSgiMUv75OkRJSsha9kY0wUrQONT9qkqjtFZEoz+VhCWXAt7bk
         iggtRO6TM+osC9eLbfN5n/vWGWMg8sjqE8RvjeNnR/2KNB3BpAc4FllostrYbGNQZf
         SvPYjqoS7bpNBBkWtjxiK9onCUTXzslbrmK0G8D8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Shannon Nelson <shannon.lee.nelson@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 220/313] niu: fix missing checks of niu_pci_eeprom_read
Date:   Mon, 11 Feb 2019 15:18:20 +0100
Message-Id: <20190211141907.889565744@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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




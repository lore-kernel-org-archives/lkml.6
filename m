Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744E3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414BB21872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218445;
	bh=WvmyV0pnUZdP08F9OvmayR12Lg+ykRElKGNEOxcoGmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B9pQ12gsoHIfu3z0ATTWkgjIq025SZV51qYrPqtk/q/2wGnO1z11WenxozViwV9Pa
	 DaGWkKsvsJZgitkxT4PxwmZlmV6T5XfeB6c+pJeJWKDV4E1swfjIiZYO2yKS79oDON
	 YZe+gESCB9T5Vuftx5JA52ZshZXPRF/Y5bCud3FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbfAKOhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390613AbfAKOhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF06204EC;
        Fri, 11 Jan 2019 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217454;
        bh=WvmyV0pnUZdP08F9OvmayR12Lg+ykRElKGNEOxcoGmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXJSsXI/RnR730eODr1GvrRWDWBXYVYCEANxju4Le/zgihTdOATWt0NeUYGHDPDpN
         jq6C1NNU7QrLitibinWCN+kvIgiHjLxhI8TCZEPx4DqOSGqcCgiMob54VPfQ2RQ7wA
         H4aQyt3NnMcgBNl12LluEzyutT7rBduf+6/05k3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/148] ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done
Date:   Fri, 11 Jan 2019 15:13:26 +0100
Message-Id: <20190111131115.431998226@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit 8e41cae64b08fe2e86a9ffb88b295c6b4b3a3322 ]

gcc warning this:

drivers/net/ieee802154/ca8210.c:730:10: warning:
 comparison is always false due to limited range of data type [-Wtype-limits]

'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
This patch change the type of 'len' to unsigned int to avoid this,also fix
the gcc warning.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/ca8210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 0ff5a403a8dc..b2ff903a9cb6 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -721,7 +721,7 @@ static void ca8210_mlme_reset_worker(struct work_struct *work)
 static void ca8210_rx_done(struct cas_control *cas_ctl)
 {
 	u8 *buf;
-	u8 len;
+	unsigned int len;
 	struct work_priv_container *mlme_reset_wpc;
 	struct ca8210_priv *priv = cas_ctl->priv;
 
@@ -730,7 +730,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 	if (len > CA8210_SPI_BUF_SIZE) {
 		dev_crit(
 			&priv->spi->dev,
-			"Received packet len (%d) erroneously long\n",
+			"Received packet len (%u) erroneously long\n",
 			len
 		);
 		goto finish;
-- 
2.19.1




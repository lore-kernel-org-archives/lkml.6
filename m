Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD27C218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863808;
	bh=4EaZmnm2eWUTnKaWpHg4OsMp9uLjbesjclJAs9BLnDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DPlNPRRkmRE3T+B/KuRbftBaZ1OPzIU+aMrDa5ZgxaJGScoQKiJdBH70yWk1rKUxY
	 HKhIE5h+TH7s2AF4JCEl+E1Aou5jIdX/zoNLEdmuek/oNouhy9apXp6dFLCDK8VT+O
	 OyYhpFXcSH5QlDq4JivwjW+EpDi4Tq46vSAwAGoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbeLZWgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbeLZWgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230D1218EA;
        Wed, 26 Dec 2018 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863803;
        bh=4EaZmnm2eWUTnKaWpHg4OsMp9uLjbesjclJAs9BLnDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wd8I0oQ+qv7JrizjvbEPeKAEniv8oDy0ZBv6mZxsl6slZdEyFMCufMqfOpRjHSFIo
         Ni6ozkys6X5aKZg5g6uVrMvrnKIgXeSFgTKOqy3r6mVy2JpYECuyX8ZyOY6ENZ2dKX
         8wPY0WQOpn0PNErQNmLz4XLU6OkJU7q7oUF5bCls=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/97] ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done
Date:   Wed, 26 Dec 2018 17:34:49 -0500
Message-Id: <20181226223557.149329-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

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


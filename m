Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258D720833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z4o9HE26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258D720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeKCDqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:33 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2168E2081B;
        Fri,  2 Nov 2018 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183902;
        bh=/Obbd6lxG9ZCtQe3FHn8IAknEm06mvJizVfB7TWigPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4o9HE26Wl0MT/1R6GXMdGG1aWGS50l+mV63PhYe1sA7Ein/EdYP93WuC7BQOODKN
         Lt30XVa7bTY/t6lmDZvIlSt0Uo8AKemuqlwacRGNj8Ejw/Bp7Knh2snAy7IRcyeZrB
         tjQZ3p6Zd4zsjGIXZ4xk6hh3qnb719+YlpV0c/Io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 015/150] drm/i2c: tda9950: set MAX_RETRIES for errors only
Date:   Fri,  2 Nov 2018 19:32:57 +0100
Message-Id: <20181102182903.857860761@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e0dccce1193f87597548d0db6ecc942fb92c04cd ]

The CEC_TX_STATUS_MAX_RETRIES should be set for errors only to
prevent the CEC framework from retrying the transmit. If the
transmit was successful, then don't set this flag.

Found by running 'cec-compliance -A' on a beaglebone box.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i2c/tda9950.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index f2186409f0cf..ccd355d0c123 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -188,7 +188,8 @@ static irqreturn_t tda9950_irq(int irq, void *data)
 			break;
 		}
 		/* TDA9950 executes all retries for us */
-		tx_status |= CEC_TX_STATUS_MAX_RETRIES;
+		if (tx_status != CEC_TX_STATUS_OK)
+			tx_status |= CEC_TX_STATUS_MAX_RETRIES;
 		cec_transmit_done(priv->adap, tx_status, arb_lost_cnt,
 				  nack_cnt, 0, err_cnt);
 		break;
-- 
2.17.1




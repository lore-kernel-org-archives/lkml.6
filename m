Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6BDC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF382147E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHy8DYHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF382147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJPMYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbeJPMBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176662145D;
        Tue, 16 Oct 2018 04:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663158;
        bh=maZJ9NLPVBL0UKyT8kfj+/gwVeO9r1Daq4OM+rhQwvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHy8DYHdv/g4ENXLJc1ykwMgY8oB1ogWkJDHLMJKIk/rLDpmpNIx1Hd+zRNtdWymf
         qmq9CiYggpYZHlXIVfVMor8mznkflG3pLdTPHpz1/t+bwY1ov7/eSr+hTDG5ekfUeJ
         ZBLmK7Or4fPURqmU4DFt2nESUnQHogFl1iFRnn0Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 015/100] drm/i2c: tda9950: set MAX_RETRIES for errors only
Date:   Tue, 16 Oct 2018 00:10:56 -0400
Message-Id: <20181016041221.135528-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

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


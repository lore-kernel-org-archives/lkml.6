Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1D0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E3620849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676338;
	bh=iLWdxCW4UzB/f8IQdPxe9uDf+wEDaLxuX5/9SHWYNec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EywebyxMggHBsVFypUhVxXvnnfPHQcZ6eTALWr/XREsZbC2g72ipl9dr/Ck9KO3xB
	 h6PRV9Gm2YYyKyRO9b32q7YjHIFvtg4j1kSbhbdVYZbqx/PIaVEwZdA78N+8hz8zmB
	 c1NHI4meBU1zZYPp813SutIdll/Tef1i0FMgu194=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E3620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeLMEaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeLMEax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65AB20873;
        Thu, 13 Dec 2018 04:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675452;
        bh=iLWdxCW4UzB/f8IQdPxe9uDf+wEDaLxuX5/9SHWYNec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjyUtN7Z9L2HzOrbgnDknvpzbOUuXz2vwYIdwXWTaGjxgp+YX14ZWaJkTs+rCvxE8
         DhJTjh9WHRbsHDBiXoYCauO3TTsA5rx/CMUViNhWXOPQO/yL+0/k8X2klxeruhEiru
         Pwjq1BkVgjqfi+WU/LSs+IQdpfMfB0c02gFK/Gto=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 72/73] Revert "net/ibm/emac: wrong bit is used for STA control"
Date:   Wed, 12 Dec 2018 23:28:37 -0500
Message-Id: <20181213042838.75160-72-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ Upstream commit 5b3279e2cba2238b37f6c18adfdea8bddb32715a ]

This reverts commit 624ca9c33c8a853a4a589836e310d776620f4ab9.

This commit is completely bogus. The STACR register has two formats, old
and new, depending on the version of the IP block used. There's a pair of
device-tree properties that can be used to specify the format used:

	has-inverted-stacr-oc
	has-new-stacr-staopc

What this commit did was to change the bit definition used with the old
parts to match the new parts. This of course breaks the driver on all
the old ones.

Instead, the author should have set the appropriate properties in the
device-tree for the variant used on his board.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/emac/emac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/emac.h b/drivers/net/ethernet/ibm/emac/emac.h
index e2f80cca9bed..0d2de6f67676 100644
--- a/drivers/net/ethernet/ibm/emac/emac.h
+++ b/drivers/net/ethernet/ibm/emac/emac.h
@@ -231,7 +231,7 @@ struct emac_regs {
 #define EMAC_STACR_PHYE			0x00004000
 #define EMAC_STACR_STAC_MASK		0x00003000
 #define EMAC_STACR_STAC_READ		0x00001000
-#define EMAC_STACR_STAC_WRITE		0x00000800
+#define EMAC_STACR_STAC_WRITE		0x00002000
 #define EMAC_STACR_OPBC_MASK		0x00000C00
 #define EMAC_STACR_OPBC_50		0x00000000
 #define EMAC_STACR_OPBC_66		0x00000400
-- 
2.19.1


Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F20C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64A52082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRlOgxZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64A52082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbeKCD72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbeKCD72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:28 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DECF62082D;
        Fri,  2 Nov 2018 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184673;
        bh=x6CQ0s9Aa3WathYO6waZll+VY+raGYIHjGhpjy+SVAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRlOgxZff6ZS/INj1NDPVmLZrv5RdtMw3mekheQ1QUmffbxxn3Mh088vhIiOAMhsd
         Xi/dqg3shkvCIfC2QGTo2Fq4rKPM0e0qBN0KqmcKUWrGKHT3RoVM/P2xo2h0DxsCBH
         AwJikidK2CrVxsU3PU9jwKpLxloK+OKEV26+tJ4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 064/143] net: phy: Add general dummy stubs for MMD register access
Date:   Fri,  2 Nov 2018 19:34:09 +0100
Message-Id: <20181102182902.279267153@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5df7af85ecd88e8b5f1f31d6456c3cf38a8bbdda ]

For some phy devices, even though they don't support the MMD extended
register access, it does have some side effect if we are trying to
read/write the MMD registers via indirect method. So introduce general
dummy stubs for MMD register access which these devices can use to avoid
such side effect.

Fixes: b6b5e8a69118 ("gianfar: Disable EEE autoneg by default")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 17 +++++++++++++++++
 include/linux/phy.h          |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a174d05a9752..fe76e2c4022a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1641,6 +1641,23 @@ int genphy_config_init(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_config_init);
 
+/* This is used for the phy device which doesn't support the MMD extended
+ * register access, but it does have side effect when we are trying to access
+ * the MMD register via indirect method.
+ */
+int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad, u16 regnum)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(genphy_read_mmd_unsupported);
+
+int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
+				 u16 regnum, u16 val)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(genphy_write_mmd_unsupported);
+
 int genphy_suspend(struct phy_device *phydev)
 {
 	int value;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index dca9e926b88f..efc04c2d92c9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -879,6 +879,10 @@ static inline int genphy_no_soft_reset(struct phy_device *phydev)
 {
 	return 0;
 }
+int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
+				u16 regnum);
+int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
+				 u16 regnum, u16 val);
 
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
-- 
2.17.1




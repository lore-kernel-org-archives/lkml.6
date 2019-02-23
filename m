Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B968BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6D320661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957181;
	bh=Pp9K+JXdNblV0676UJJ+CBRYoOeW9fSnBRcUFrj8uxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t43C6bnVO32zUwh6WYpU3M728VUpGOF/3vUp4w159FbcGIm9xDFbhLMYOy+c/iAYC
	 xBMnYmUfvEzAjoHz3ONF0bev4hoR5/C44g1Lqu6lk/CWuOfhGRhS4txnT8HUnkGgc6
	 231z0CNLNc2mJqmd8e5INtmNcJ4R+HrVpCpatBw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfBWV0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbfBWVHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A45820855;
        Sat, 23 Feb 2019 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956055;
        bh=Pp9K+JXdNblV0676UJJ+CBRYoOeW9fSnBRcUFrj8uxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5eLhHQTfZKoHtzdI51LW805vj1TiTkg0mizUKauj+6Pr9M/TH+JyZr503+xilgSO
         3LD1aNH7xgtVyOA3D1Ktg+e/Y6t6iIfUjOhg6oPOLvlD1FkCwhMjyivbfq2TFSDUHW
         9MB31+olrTkDqmQoLOItE8j8oI8n5xHrG4c499EI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 31/65] net: hns: Fix wrong read accesses via Clause 45 MDIO protocol
Date:   Sat, 23 Feb 2019 16:06:06 -0500
Message-Id: <20190223210640.200911-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit cec8abba13e6a26729dfed41019720068eeeff2b ]

When reading phy registers via Clause 45 MDIO protocol, after write
address operation, the driver use another write address operation, so
can not read the right value of any phy registers. This patch fixes it.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 017e08452d8c0..baf5cc251f329 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -321,7 +321,7 @@ static int hns_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 		}
 
 		hns_mdio_cmd_write(mdio_dev, is_c45,
-				   MDIO_C45_WRITE_ADDR, phy_id, devad);
+				   MDIO_C45_READ, phy_id, devad);
 	}
 
 	/* Step 5: waitting for MDIO_COMMAND_REG 's mdio_start==0,*/
-- 
2.19.1


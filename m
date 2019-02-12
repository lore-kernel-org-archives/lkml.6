Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3694C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F96222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cjgDeV0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfBLTGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:06:54 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19468 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbfBLTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:06:51 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c63194b0001>; Tue, 12 Feb 2019 11:06:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2019 11:06:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Feb 2019 11:06:50 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 19:06:49 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 19:06:49 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 19:06:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.70]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6319490008>; Tue, 12 Feb 2019 11:06:49 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>,
        <skomatineni@nvidia.com>
CC:     <wsa@the-dreams.de>, <peda@axentia.se>, <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
Subject: [PATCH V19 3/7] i2c: tegra: fix maximum transfer size
Date:   Tue, 12 Feb 2019 11:06:44 -0800
Message-ID: <1549998408-9137-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549998411; bh=iiQhzWWb/jKZV8rK6QC2pxZyMkeAc+VLBisMEvR/32g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cjgDeV0C/8kjzRwNkupY22KExfFyP8U9uBHgyeHMeXacAjaeGraR2Hl408jF/JQal
         V+tC5SD7CM5oWK2rTrF9IdDgCCpogWLgxN7FrXNuAzukYYvbaxejSolE4DO0onMSgx
         7e3Lu3+O9aRsPECWQCNn8veBRhDesigeMkcYL8FuQpjo8PFDDQr358MXtGQ6PFXQGR
         ntcZlDq0mBRCXjirl22gqAcKx0O65ZJP5D+mURmvOdsVoirBh4uz/wYm2sltIbm9mI
         tS9uojKQY2bD97XDWwtSypSs1tDypcwei+6M0fAXPmVpPrJTMRxsFYsFWRskGRvCc6
         VMY5wvAQoEUyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 and prior supports maximum 4K bytes per packet transfer
including 12 bytes of packet header.

This patch fixes max write length limit to account packet header
size for transfers.

Cc: stable@vger.kernel.org # 4.4+

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V19]	: Splitted maximum transfer limit patch into 2 separate patches to
	  allow this fix for old Tegra chips and next patch in this series for
	  Tegra194.
 [V18] 	: Using Max of SZ_64K (65536) size for dma buffer instead of 65535
 [V16/V17] : I2C core max message size is 65535. So, max_read_len of 65535 is NOP.
	  Removed it leaving max_write_len
 [V15]	: This is new patch in this series.


 drivers/i2c/busses/i2c-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index a46446dbc48a..036cab795426 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -901,7 +901,7 @@ static const struct i2c_algorithm tegra_i2c_algo = {
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
 	.max_read_len = 4096,
-	.max_write_len = 4096,
+	.max_write_len = 4096 - 12,
 };
 
 static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
-- 
2.7.4


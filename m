Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5B12147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfBSD1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:27:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfBSD1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:27:01 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E6B81D6EC4E9B8D78626;
        Tue, 19 Feb 2019 11:26:58 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 11:26:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <keescook@chromium.org>,
        <natechancellor@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtlwifi: Remove set but not used variables 'dataempty, hoffset'
Date:   Tue, 19 Feb 2019 11:26:48 +0800
Message-ID: <20190219032648.25492-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtlwifi/efuse.c: In function 'efuse_pg_packet_write':
drivers/staging/rtlwifi/efuse.c:922:24: warning:
 variable 'dataempty' set but not used [-Wunused-but-set-variable]

drivers/staging/rtlwifi/efuse.c: In function 'efuse_get_current_size':
drivers/staging/rtlwifi/efuse.c:1185:5: warning:
 variable 'hoffset' set but not used [-Wunused-but-set-variable]

They're never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtlwifi/efuse.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtlwifi/efuse.c b/drivers/staging/rtlwifi/efuse.c
index abb0f72..54add99 100644
--- a/drivers/staging/rtlwifi/efuse.c
+++ b/drivers/staging/rtlwifi/efuse.c
@@ -919,7 +919,7 @@ static int efuse_pg_packet_write(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct pgpkt_struct target_pkt;
 	u8 write_state = PG_STATE_HEADER;
-	int continual = true, dataempty = true, result = true;
+	int continual = true, result = true;
 	u16 efuse_addr = 0;
 	u8 efuse_data;
 	u8 target_word_cnts = 0;
@@ -946,7 +946,6 @@ static int efuse_pg_packet_write(struct ieee80211_hw *hw,
 	while (continual && (efuse_addr < (EFUSE_MAX_SIZE -
 	       rtlpriv->cfg->maps[EFUSE_OOB_PROTECT_BYTES_LEN]))) {
 		if (write_state == PG_STATE_HEADER) {
-			dataempty = true;
 			badworden = 0x0F;
 			RTPRINT(rtlpriv, FEEPROM, EFUSE_PG,
 				"efuse PG_STATE_HEADER\n");
@@ -1182,13 +1181,12 @@ static u16 efuse_get_current_size(struct ieee80211_hw *hw)
 {
 	int continual = true;
 	u16 efuse_addr = 0;
-	u8 hoffset, hworden;
+	u8 hworden;
 	u8 efuse_data, word_cnts;
 
 	while (continual && efuse_one_byte_read(hw, efuse_addr, &efuse_data) &&
 	       (efuse_addr < EFUSE_MAX_SIZE)) {
 		if (efuse_data != 0xFF) {
-			hoffset = (efuse_data >> 4) & 0x0F;
 			hworden = efuse_data & 0x0F;
 			word_cnts = efuse_calculate_word_cnts(hworden);
 			efuse_addr = efuse_addr + (word_cnts * 2) + 1;
-- 
2.7.0



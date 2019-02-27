Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9A8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722A0218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfB0DUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:20:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729128AbfB0DUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:20:12 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7D5899AA402CB5D0165;
        Wed, 27 Feb 2019 11:20:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Wed, 27 Feb 2019 11:20:08 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <Larry.Finger@lwfinger.net>, <florian.c.schilhabel@googlemail.com>,
        <straube.linux@gmail.com>, <kernel-janitors@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: rtl8712: assign initial value to a static variable in r8712_efuse_pg_packet_write()
Date:   Wed, 27 Feb 2019 11:33:22 +0800
Message-ID: <20190227033322.127177-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

repeat_times is a static variable, but each time when it enters
r8712_efuse_pg_packet_write(), it is set to zero,
this value is not consistent with last calling, so next behavior
is not our expect.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/staging/rtl8712/rtl8712_efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index 8bc45ffd3029..3e8421255170 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -358,7 +358,7 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
 	u8 pg_header = 0;
 	u16 efuse_addr = 0, curr_size = 0;
 	u8 efuse_data, target_word_cnts = 0;
-	static int repeat_times;
+	static int repeat_times = 0;
 	int sub_repeat;
 	u8 bResult = true;
 
@@ -368,7 +368,6 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
 		return false;
 	pg_header = MAKE_EFUSE_HEADER(offset, word_en);
 	target_word_cnts = calculate_word_cnts(word_en);
-	repeat_times = 0;
 	efuse_addr = 0;
 	while (efuse_addr < efuse_available_max_size) {
 		curr_size = r8712_efuse_get_current_size(padapter);
-- 
2.20.1


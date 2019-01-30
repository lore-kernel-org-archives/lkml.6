Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551BD20815
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfA3Kbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:31:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbfA3Kbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:31:33 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 19EFB5B44EB254D3C21C;
        Wed, 30 Jan 2019 18:31:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 18:31:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dsterba@suse.com>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <jikos@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] tty: ipwireless: Fix potential NULL pointer dereference
Date:   Wed, 30 Jan 2019 18:30:51 +0800
Message-ID: <20190130103051.5256-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential NULL pointer dereference in case
alloc_ctrl_packet() fails and returns NULL.

Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix return value
---
 drivers/tty/ipwireless/hardware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index b0baa4c..1e21ae3 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -1516,6 +1516,8 @@ static void ipw_send_setup_packet(struct ipw_hardware *hw)
 			sizeof(struct ipw_setup_get_version_query_packet),
 			ADDR_SETUP_PROT, TL_PROTOCOLID_SETUP,
 			TL_SETUP_SIGNO_GET_VERSION_QRY);
+	if (!ver_packet)
+		return;
 	ver_packet->header.length = sizeof(struct tl_setup_get_version_qry);
 
 	/*
-- 
2.7.0



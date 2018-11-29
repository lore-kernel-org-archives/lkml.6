Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB669C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F12D21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zboV2V/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F12D21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeK2RCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeK2RCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:21 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16FE208E7;
        Thu, 29 Nov 2018 05:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471090;
        bh=NKzrLOMQzyUCSQTd+LAu5dfTWbf9TqnXUYi+ec8EXKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zboV2V/yKMXhDivb3ld3/PaaRTqkE8kgTJyHU7U7hc/xTZbFtKr0RoLoiSUf6N1Wt
         S5vAehuUrGFsqXaImz7Z76jyv7g0VrsDswxvepOc2tTEO1zGLBfBP7mH93PkQ28QaI
         cZXw9O8gl5Lcoj+l8Vu8oHl45N7dvKj1/7Gq11Ag=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 26/68] bnxt_en: Fix filling time in bnxt_fill_coredump_record()
Date:   Thu, 29 Nov 2018 00:55:17 -0500
Message-Id: <20181129055559.159228-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 8dc5ae2d48976764cf3498e97963fa06befefb0e ]

Fix the year and month offset while storing it in
bnxt_fill_coredump_record().

Fixes: 6c5657d085ae ("bnxt_en: Add support for ethtool get dump.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index e52d7af3ab3e..da9b87689996 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2862,8 +2862,8 @@ bnxt_fill_coredump_record(struct bnxt *bp, struct bnxt_coredump_record *record,
 	record->asic_state = 0;
 	strlcpy(record->system_name, utsname()->nodename,
 		sizeof(record->system_name));
-	record->year = cpu_to_le16(tm.tm_year);
-	record->month = cpu_to_le16(tm.tm_mon);
+	record->year = cpu_to_le16(tm.tm_year + 1900);
+	record->month = cpu_to_le16(tm.tm_mon + 1);
 	record->day = cpu_to_le16(tm.tm_mday);
 	record->hour = cpu_to_le16(tm.tm_hour);
 	record->minute = cpu_to_le16(tm.tm_min);
-- 
2.17.1


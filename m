Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE80C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0163E2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544363;
	bh=30GIALfjgWxMhKADEfJXrTVf4gh4vI8PwZIcXzDG0MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OG+RYUzRKw6TlX2+1cFF2cqp4OcNWYC3LK+/tXeC/eLJb0tAv7VDua3Sc0ByJ4bM5
	 g8WXwH10Ziq/9NDdLC/7sNRBik/CBd08dZLinYRpYjqoJooKGS2aqXZTk1NwZ3CMBl
	 BEEfva5hjVh/qCrCx2gDw8Fuw61w8k/qLXjpKKxA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0163E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeLKPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbeLKPyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF3D20855;
        Tue, 11 Dec 2018 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543691;
        bh=30GIALfjgWxMhKADEfJXrTVf4gh4vI8PwZIcXzDG0MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anrualZDY4kn3KE+Sky2LaHFED/pRuYcIIxOdeGGjtZHZ9FlbttIoqeFNCyIU3g0J
         PFzNF99/r3TdoFFePBJ3ZtfUdE4G1BiCyC4O7XCF41KgUPdLhkCxPqMh+BDohFYpm7
         US5sfok2qO0tNs3Q38Cz8E9vU78m3wumKdjYYIJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/118] bnxt_en: Fix filling time in bnxt_fill_coredump_record()
Date:   Tue, 11 Dec 2018 16:40:45 +0100
Message-Id: <20181211151645.296085178@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1




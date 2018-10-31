Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D625FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B78220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4HmD2xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B78220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeKAIfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbeKAIJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6313F2081B;
        Wed, 31 Oct 2018 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027340;
        bh=VRRnCaeiF4oUnCzgOggLu75dDRm5tTpA4QMRMSJ1xPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4HmD2xd2p1/ZbGBCeaklnG5T4hf8XqJS0JAXI+bmYLGn7jdJblS1JLJhWzinL58F
         Otcfj1qM0wKfCw9ki/c7795G3YPJXAqNMwK7UPxbtmFU7wmr9wriB5Ji+KhttFV+Y9
         Z7pqSCKoscp1lfsOZe5kDI4zYIxYm8BGFMTRY/kM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Diego Viola <diego.viola@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 071/126] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
Date:   Wed, 31 Oct 2018 19:06:59 -0400
Message-Id: <20181031230754.29029-71-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diego Viola <diego.viola@gmail.com>

[ Upstream commit a435ab4f80f983c53b4ca4f8c12b3ddd3ca17670 ]

med_power_with_dipm causes my T450 to freeze with a SAMSUNG
MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).

Switching the LPM to max_performance fixes this issue.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Diego Viola <diego.viola@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 99bf0c0394f8..321a9579556d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4552,6 +4552,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", "DXT02L5Q", ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.17.1


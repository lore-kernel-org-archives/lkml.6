Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8520A21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="inE60iz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8520A21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeK2RFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeK2RFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:05:53 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0FD2133F;
        Thu, 29 Nov 2018 06:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471301;
        bh=HvvEv4+yf9qW7q14mpvet3O/vqfG3j8yAPtGUvsnC0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inE60iz/qS0dadPqZcudV/a8nPGKSQAEI4cPbFWn6wMc2wElTWj6lMW3kNWj+EYYM
         oBzmn06+LgsOIpButNaljZnQz0007cpUaBr6xKHVUXQc/XOaT+LZ7uwBCxiisd7OCG
         w2WQ0HWwsv1DN1aRQ+V+S/h1f7lKM/SvM63Psiic=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 06/35] test_firmware: fix error return getting clobbered
Date:   Thu, 29 Nov 2018 01:00:40 -0500
Message-Id: <20181129060110.159878-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 8bb0a88600f0267cfcc245d34f8c4abe8c282713 ]

In the case where eq->fw->size > PAGE_SIZE the error return rc
is being set to EINVAL however this is being overwritten to
rc = req->fw->size because the error exit path via label 'out' is
not being taken.  Fix this by adding the jump to the error exit
path 'out'.

Detected by CoverityScan, CID#1453465 ("Unused value")

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index e7008688769b..71d371f97138 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -838,6 +838,7 @@ static ssize_t read_firmware_show(struct device *dev,
 	if (req->fw->size > PAGE_SIZE) {
 		pr_err("Testing interface must use PAGE_SIZE firmware for now\n");
 		rc = -EINVAL;
+		goto out;
 	}
 	memcpy(buf, req->fw->data, req->fw->size);
 
-- 
2.17.1


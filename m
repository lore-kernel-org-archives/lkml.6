Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CFEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5BC20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdEzMssY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5BC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeK2RBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeK2RBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:01:34 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C33820834;
        Thu, 29 Nov 2018 05:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471044;
        bh=uktaMXQwIPlO+JqfVB3dJpuTsv78xg4+sqW7ENCTt8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdEzMssYcirvlMgVR4t8GW10A/Eb2RSMp1R6KdkoC6x+9Sx5a4XsUnX2ciQLWMA90
         Z7Lsq1pI5972Qng5izklDkdcAs7//9w/ndWs4y4TFWT3Z+oTznaV3vtpwKYofTCg2t
         9KivlANEyERWYy8owQyjabj9WGTvP/VtUDOflG8Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 12/68] test_firmware: fix error return getting clobbered
Date:   Thu, 29 Nov 2018 00:55:03 -0500
Message-Id: <20181129055559.159228-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
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
index b984806d7d7b..7cab9a9869ac 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -837,6 +837,7 @@ static ssize_t read_firmware_show(struct device *dev,
 	if (req->fw->size > PAGE_SIZE) {
 		pr_err("Testing interface must use PAGE_SIZE firmware for now\n");
 		rc = -EINVAL;
+		goto out;
 	}
 	memcpy(buf, req->fw->data, req->fw->size);
 
-- 
2.17.1


Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70AFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FEA20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="diTlvgYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FEA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbeJYWtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeJYWtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:35 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C187620854;
        Thu, 25 Oct 2018 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476998;
        bh=Nsmgz6XxhKXhN9rpJNfF4K36+lf5owguKdSnlli4EMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diTlvgYpCJdQoK+hlMYn6LlLUUwaUa0GR/UN0Zc1x3BahPxEoUbWaJF6T0casNMd/
         Sh3/oMAb7Mk18fOE1K5SwD0XNdBxWTrPaSEpWxD+lKSkztt/C3yqS6GwtvH8txnRJd
         1rNjMuwAYBZeeBG9h1laA04zaEsAxPDk5qktUijM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Verkamp <daniel.verkamp@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 92/98] nvmet: fix space padding in serial number
Date:   Thu, 25 Oct 2018 10:14:17 -0400
Message-Id: <20181025141423.213774-92-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Verkamp <daniel.verkamp@intel.com>

[ Upstream commit c73996984902516745bc587d5e8a0b2e034aea05 ]

Commit 42de82a8b544 previously attempted to fix this, and it did
correctly pad the MN and FR fields with spaces, but the SN field still
contains 0 bytes.  The current code fills out the first 16 bytes with
hex2bin, leaving the last 4 bytes zeroed.  Rather than adding a lot of
error-prone math to avoid overwriting SN twice, just set the whole thing
to spaces up front (it's only 20 bytes).

Fixes: 42de82a8b544 ("nvmet: don't report 0-bytes in serial number")
Signed-off-by: Daniel Verkamp <daniel.verkamp@intel.com>
Reviewed-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2caed285fd7b..cdb7752dcbb7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -192,6 +192,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->vid = 0;
 	id->ssvid = 0;
 
+	memset(id->sn, ' ', sizeof(id->sn));
 	bin2hex(id->sn, &ctrl->subsys->serial,
 		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
 	copy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1);
-- 
2.17.1


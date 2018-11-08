Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA03ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6096E2147D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWzclA5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6096E2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbeKIHnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbeKIHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:49 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E531208A3;
        Thu,  8 Nov 2018 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714778;
        bh=22Zl0kcgs/bCN+mBw+5lzKpf3Q9liFP9h45+CQAKURY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWzclA5oMffHCEyK8z35S8HHsCDCDgwv316jAKnKr+FslMW1VzkfrPisQ9Ls+SAx1
         6NXXNnzR9UJJC+5iEBr1WEf6NeVFb37JGASrSSW7MoxM/CGFSDvIQtxRo41nL52O+a
         43snyqtBIA/dkrjoxlWvv1wAZrSwcqm0YPV5Jnls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Verkamp <daniel.verkamp@intel.com>,
        Martin Wilck <mwilck@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 119/171] nvmet: fix space padding in serial number
Date:   Thu,  8 Nov 2018 13:51:29 -0800
Message-Id: <20181108215135.902989711@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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




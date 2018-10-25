Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66D5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDEE2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASMGyFMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDEE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbeJYWxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730900AbeJYWxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:11 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39D32086D;
        Thu, 25 Oct 2018 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477213;
        bh=oAA2aeFnsMgprRsS3wlrSDHqHgBRopZPCwAr05t02QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASMGyFMRAxSVAZlLZcvCr4V5HYRum5fhuYrYUsKMotqhdMAfn+lOYn2xHTlmGt88M
         To9igaJ3ZxwfbgvfFlu6AegGJU6Meu2F911usdmkF+IoICjS2Tlh1nTLaVLXSjiOQx
         fL5oUpItyrD/yWdVpIVQ2l/+AHF5nCLstTd4+/DI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 52/98] quota: Fix maximum quota limit settings
Date:   Thu, 25 Oct 2018 10:18:07 -0400
Message-Id: <20181025141853.214051-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 7e08da50cf706151f324349f9235ebd311226997 ]

Currently quota format that supports 64-bit usage sets maximum quota
limit as 2^64-1. However quota core code uses signed numbers to track
usage and even limits themselves are stored in long long. Checking of
maximum allowable limits worked by luck until commit 14bf61ffe6ac
(quota: Switch ->get_dqblk() and ->set_dqblk() to use bytes as space
units) because variable we compared with was unsigned. After that commit
the type we compared against changed to signed and thus checks for
maximum limits with the newest VFS quota format started to refuse any
non-negative value. Later the problem was inadvertedly fixed by commit
b10a08194c2b (quota: Store maximum space limit in bytes) because we
started to compare against unsigned type as well.

Fix possible future problems of this kind by setting maximum limits to
2^63-1 to avoid overflow issues.

Reported-by: Carlos Carvalho <carlos@fisica.ufpr.br>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/quota_v2.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index d1a8054bba9a..5d9fc7918e24 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -117,12 +117,16 @@ static int v2_read_file_info(struct super_block *sb, int type)
 	qinfo = info->dqi_priv;
 	if (version == 0) {
 		/* limits are stored as unsigned 32-bit data */
-		info->dqi_max_spc_limit = 0xffffffffULL << QUOTABLOCK_BITS;
+		info->dqi_max_spc_limit = 0xffffffffLL << QUOTABLOCK_BITS;
 		info->dqi_max_ino_limit = 0xffffffff;
 	} else {
-		/* used space is stored as unsigned 64-bit value in bytes */
-		info->dqi_max_spc_limit = 0xffffffffffffffffULL; /* 2^64-1 */
-		info->dqi_max_ino_limit = 0xffffffffffffffffULL;
+		/*
+		 * Used space is stored as unsigned 64-bit value in bytes but
+		 * quota core supports only signed 64-bit values so use that
+		 * as a limit
+		 */
+		info->dqi_max_spc_limit = 0x7fffffffffffffffLL; /* 2^63-1 */
+		info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
 	}
 	info->dqi_bgrace = le32_to_cpu(dinfo.dqi_bgrace);
 	info->dqi_igrace = le32_to_cpu(dinfo.dqi_igrace);
-- 
2.17.1


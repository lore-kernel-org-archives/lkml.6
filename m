Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB7C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FB620844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN4VcGnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FB620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeKIHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbeKIHdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:43 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A0821104;
        Thu,  8 Nov 2018 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714175;
        bh=zy0wBWQZSp+DSESzmyU1yVbn7SjcLyLKV+klaklbx54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aN4VcGnfzSHBc9H0jTTiaCrpwoXhNBO4MMdlcqfVB4FxOvv11s1KskZN6hL3GPXiX
         vgivBmagPb3BAEQerd+wm8uLEkfS817TigebDdkg+oYnSGrfsNSWscQDU7572J1+1P
         gQsCVBbAdZ5wBBRUoMVqb5F+DgiugD+oaBAUIJvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carlos Carvalho <carlos@fisica.ufpr.br>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 081/144] quota: Fix maximum quota limit settings
Date:   Thu,  8 Nov 2018 13:50:52 -0800
Message-Id: <20181108215101.225793829@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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




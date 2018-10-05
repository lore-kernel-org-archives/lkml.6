Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD077C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745F9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA1o4VuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745F9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeJEXOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbeJEXOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25796214DA;
        Fri,  5 Oct 2018 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756107;
        bh=IuN4o2yTbC0AiaNOIS19SgyEAaRjsn4xkwLN1zPCTFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oA1o4VuPOipVBhPPPePU/JGnC5iuaRez+GU9F1dSWzyvcMknlZtlsRemcpGc/OklS
         fZvFoyWPi1IaNeSaDUHj0yKcUqMlFCIf0PE7HsbmSIqVd0hxvGCLkCp59qVcBcSj4o
         jMBe0hy2SiK9NMboo8rlx+4fjh8rN1DB1243GeZ4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 47/48] ubifs: Check for name being NULL while mounting
Date:   Fri,  5 Oct 2018 12:14:23 -0400
Message-Id: <20181005161424.20521-47-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 37f31b6ca4311b94d985fb398a72e5399ad57925 ]

The requested device name can be NULL or an empty string.
Check for that and refuse to continue. UBIFS has to do this manually
since we cannot use mount_bdev(), which checks for this condition.

Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
Reported-by: syzbot+38bd0f7865e5c6379280@syzkaller.appspotmail.com
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ubifs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index c5466c70d620..2a82aeeacba5 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1929,6 +1929,9 @@ static struct ubi_volume_desc *open_ubi(const char *name, int mode)
 	int dev, vol;
 	char *endptr;
 
+	if (!name || !*name)
+		return ERR_PTR(-EINVAL);
+
 	/* First, try to open using the device node path method */
 	ubi = ubi_open_volume_path(name, mode);
 	if (!IS_ERR(ubi))
-- 
2.17.1


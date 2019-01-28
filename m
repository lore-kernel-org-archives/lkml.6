Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDAD21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694788;
	bh=1Kkbcgj3qy/wrbMLk0ih5ihgYgd23PI2FrGdLfYQQTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cgEi/YySyCmsKYqDy3RpNaLDI7SHukqilC8qIA3Sfg8LrkUOoTgtkagbIrXWDx77Z
	 a+ZQJ5FdFJKv2EBZVKeUlyhj9X5S7sxSW5/oIMH+sT8KbdK562dpHnr0DviAK0DJZ/
	 +S9bcrMo336+g445gUN4r2x09nKj3YLxXG+EGXkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfA1QQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387885AbfA1QPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02962148E;
        Mon, 28 Jan 2019 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692155;
        bh=1Kkbcgj3qy/wrbMLk0ih5ihgYgd23PI2FrGdLfYQQTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xIFmxS1nZfAW42wM15S9vYZf0yk6qxZ/GlA8/vA8aGJ9Y8BI7/socNSim+5U4VkJR
         zsQOTdGnehCJdczK59UsdcvVaKlsYTmtHCrLhjicI1TDHnO7FrFq36XHyU6XEUO8p/
         zZJ0+5GKIPRgDeHJMrU70Z2AzInyrtygpJA4ee9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 092/170] udf: Fix BUG on corrupted inode
Date:   Mon, 28 Jan 2019 11:10:42 -0500
Message-Id: <20190128161200.55107-92-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit d288d95842f1503414b7eebce3773bac3390457e ]

When inode is corrupted so that extent type is invalid, some functions
(such as udf_truncate_extents()) will just BUG. Check that extent type
is valid when loading the inode to memory.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 8dacf4f57414..28b9d7cca29b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1357,6 +1357,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 
 	iinfo->i_alloc_type = le16_to_cpu(fe->icbTag.flags) &
 							ICBTAG_FLAG_AD_MASK;
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_SHORT &&
+	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_LONG &&
+	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		ret = -EIO;
+		goto out;
+	}
 	iinfo->i_unique = 0;
 	iinfo->i_lenEAttr = 0;
 	iinfo->i_lenExtents = 0;
-- 
2.19.1


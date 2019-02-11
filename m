Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACBDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFE820700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896298;
	bh=e87+Vc3YJpLGr3peU/K3ngDpkGFdPFP6JmH7ieLu73U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VyQqgGs4J9lAA1gxWVc+3ZdZX1Iqtw4dHi2JlJBD+JG97EZwYvnvUXZ0CB58jfwMz
	 zGAEkDhRxtpAUB9VGKNaAZy+XgxoJ9knI8yUSVsMSagtg81aMFkeC6SiyYIkz8KZY9
	 JlhM+k9V/nQZOqs1gYDa0inJa2vrqDDWjU7UXfNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbfBKOoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732727AbfBKOov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3FA206BA;
        Mon, 11 Feb 2019 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896291;
        bh=e87+Vc3YJpLGr3peU/K3ngDpkGFdPFP6JmH7ieLu73U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ya5wIAnataPPYadLbXDCqNWS2x+NBYt2xJnkmapUdGUcFpmPyn4TujtuZS76RhKn4
         dCsIx8ZxsFsyCWgXMBw58Moy50CiV1WATDP5/PGxMshtPeGM62YIRk1swuGWBbuNlE
         +E/Fp/YDCn9Bbn6GnTWDXQGM855mUHVkDSQ/nCCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/313] udf: Fix BUG on corrupted inode
Date:   Mon, 11 Feb 2019 15:16:56 +0100
Message-Id: <20190211141902.772546212@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
index 5df554a9f9c9..ae796e10f68b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1357,6 +1357,12 @@ reread:
 
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




Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF31C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A0F217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499027;
	bh=RR4plLRY0EQcphnGBdFbWo3eUOpiuGvCeyGApmbDIbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eVsgnQAhU5KElhp7VAJZexBkiqO493RrkemxyiBEA9LC4xqKIt49Y3hs1m6BYbmGX
	 HkV18w2Ptn/dT25OwYPpF4kK2t2GZs/ptEAZP2ANBTVMoeVo0+Sr0EN3vz0CbrqPDq
	 6wrYtobJBvdLQbIcztBiDGOEA4wo2B8OfP/KVDDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391471AbfBROKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391441AbfBROKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:10:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95150217D7;
        Mon, 18 Feb 2019 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499019;
        bh=RR4plLRY0EQcphnGBdFbWo3eUOpiuGvCeyGApmbDIbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16Iked49kT1hqKMBsg1IjTWIC9bK6H7tw9DlHae5WhwRqYbTVuRmtAqgvf8SvE4i7
         iAgHolCboy/ennWdvkuwF2JodnZdF26aBZZxUjMEeIBNN7RZZB10sCB5/4GzMLxl1Q
         hJ/EkT4kFr50hTkevqt9HL/Wc4+wVDt+hkxONzAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 025/108] udf: Fix BUG on corrupted inode
Date:   Mon, 18 Feb 2019 14:43:21 +0100
Message-Id: <20190218133520.688249574@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
index 0c1ca254d616..00c2caff1743 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1366,6 +1366,12 @@ reread:
 
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




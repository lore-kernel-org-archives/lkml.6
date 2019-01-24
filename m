Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105A3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D413D217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360946;
	bh=36NiZoxiQVL/d181ujMqa3FgplCu5TKdganrEwkC1dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wlddeL3CxmzLvPi3tTvFmNcQ80GIqtwcRAKtDK3b8tHtRIscxxHyflHlW+bnbhXPW
	 5Bx97Kea0P1/z2DFGWpCHmB3yOExT+lVqwBZo57zLKJCuVeCOtttnGReAtXKY+I2ZO
	 zmkVTh+3jIkk+D0pIZtpcOz0jUW+v7MobnZ0vjgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfAXUPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfAXTYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818D2218EA;
        Thu, 24 Jan 2019 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357854;
        bh=36NiZoxiQVL/d181ujMqa3FgplCu5TKdganrEwkC1dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQcgcueum4UK0Nb+SKMDBB2y7KOUO40XZv4NzuoCwEDrdVktCnuzKLwi5cM9U8Mbp
         c4MI86Wesmae6xCliZ5uMIfhTHTPIrC/WKn2HCv6L+v1uMjoW8JcNrh2wSL3i6y97P
         NnAmMbxylmRUZbCG9DMDB+b4FvvmUs0ET/sqgAG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 012/104] f2fs: not allow to write illegal blkaddr
Date:   Thu, 24 Jan 2019 20:19:01 +0100
Message-Id: <20190124190156.240200220@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlei He <heyunlei@huawei.com>

commit bb413d6acd4e1c361daebf8486efc3923f429792 upstream.

we came across an error as below:

[build_nat_area_bitmap:1710] nid[0x    1718] addr[0x         1c18ddc] ino[0x    1718]
[build_nat_area_bitmap:1710] nid[0x    1719] addr[0x         1c193d5] ino[0x    1719]
[build_nat_area_bitmap:1710] nid[0x    171a] addr[0x         1c1736e] ino[0x    171a]
[build_nat_area_bitmap:1710] nid[0x    171b] addr[0x        58b3ee8f] ino[0x815f92ed]
[build_nat_area_bitmap:1710] nid[0x    171c] addr[0x         fcdc94b] ino[0x49366377]
[build_nat_area_bitmap:1710] nid[0x    171d] addr[0x        7cd2facf] ino[0xb3c55300]
[build_nat_area_bitmap:1710] nid[0x    171e] addr[0x        bd4e25d0] ino[0x77c34c09]

... ...

[build_nat_area_bitmap:1710] nid[0x    1718] addr[0x         1c18ddc] ino[0x    1718]
[build_nat_area_bitmap:1710] nid[0x    1719] addr[0x         1c193d5] ino[0x    1719]
[build_nat_area_bitmap:1710] nid[0x    171a] addr[0x         1c1736e] ino[0x    171a]
[build_nat_area_bitmap:1710] nid[0x    171b] addr[0x        58b3ee8f] ino[0x815f92ed]
[build_nat_area_bitmap:1710] nid[0x    171c] addr[0x         fcdc94b] ino[0x49366377]
[build_nat_area_bitmap:1710] nid[0x    171d] addr[0x        7cd2facf] ino[0xb3c55300]
[build_nat_area_bitmap:1710] nid[0x    171e] addr[0x        bd4e25d0] ino[0x77c34c09]

One nat block may be stepped by a data block, so this patch forbid to
write if the blkaddr is illegal

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -576,8 +576,8 @@ static inline void check_seg_range(struc
 
 static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
 {
-	f2fs_bug_on(sbi, blk_addr < SEG0_BLKADDR(sbi)
-					|| blk_addr >= MAX_BLKADDR(sbi));
+	BUG_ON(blk_addr < SEG0_BLKADDR(sbi)
+			|| blk_addr >= MAX_BLKADDR(sbi));
 }
 
 /*



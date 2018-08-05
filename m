Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8001C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9463521899
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWhdHWU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9463521899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeHEROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeHEROs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:14:48 -0400
Received: from localhost.localdomain (unknown [49.77.238.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1118921888;
        Sun,  5 Aug 2018 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533481794;
        bh=dyoYvJAxYahZeTGYz3ja8IZQoUhcZcpWrlQ4AzKWbr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWhdHWU/TXVVpbPFC+o9EBlDUy8H3v6C8w//FQlg85cnfa0u63OEkuE8pUjRlkjV0
         jt6Q8arr/fbsN5C5mmhGRlWu1NfGaFSPOw/3E84RjyivBPhx/NmM6x418mz156+vpL
         Higj99LZPzLEWxZaGteUcQA/FmT83kKbPetXJdos=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix incorrect range->len in f2fs_trim_fs()
Date:   Sun,  5 Aug 2018 23:09:00 +0800
Message-Id: <20180805150900.9941-2-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180805150900.9941-1-chao@kernel.org>
References: <20180805150900.9941-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

generic/260 reported below error:

     [+] Default length with start set (should succeed)
     [+] Length beyond the end of fs (should succeed)
     [+] Length beyond the end of fs with start set (should succeed)
    +./tests/generic/260: line 94: [: 18446744073709551615: integer expression expected
    +./tests/generic/260: line 104: [: 18446744073709551615: integer expression expected
     Test done
    ...

In f2fs_trim_fs(), if there is no discard being trimmed, we need to correct
range->len before return.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 24b7147456e9..7b470a1fe92b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2626,8 +2626,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 	trimmed += __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
-	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
+	if (!err)
+		range->len = F2FS_BLK_TO_BYTES(trimmed);
 	return err;
 }
 
-- 
2.18.0


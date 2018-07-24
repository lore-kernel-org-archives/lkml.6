Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE7CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD73920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD73920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbeGXKlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:41:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38388 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeGXKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:41:07 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LltrB-1gHEXX1gzR-00Zf8p; Tue, 24 Jul 2018 11:35:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
        Yunlei He <heyunlei@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix 32-bit format string warning
Date:   Tue, 24 Jul 2018 11:34:54 +0200
Message-Id: <20180724093509.1637386-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:eO0/1mjkQmQYAFR7yrPQe7gfyQy116CWDBFK48rRw1gWe/8Bd+z
 aadV3rRcB9GRj8O023RA+rCPgtAaOF7y3CvO6UzO6ToZ6NDhLfWlSAB6gWTdYxsov9kjKaJ
 kdY3Popd59V/Xni2G6bYT73fE8TTBKoqJaRPBVwVN9gVdYNOiwr8dtTm97yeZ32PsdQ18tn
 KRY/dfivZ7Ji9Fudn+4rA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f9JlQkJ5rzU=:uLZPkmQ8SqllTc6rU3peub
 NlWAnYenrg0k2kYUOYXfl+NcFDJynj51w3pGRO2XgHWrDRinWaormr8Lvra7MhmxKrl0Jt61G
 8L/aoqCmHJGn3JdoP3wXBQ7NY28wCE6rVzt+/UrXVr2T5C/zma79X+4921dBx9biWaKsEq4Bq
 TV1Pzc53RcMwPGcyfvc9F/ZeT/8dJg/zoEQfGXYpP1wvNb7lV51opeFsQhLyP+i2SLg+RZ3Y1
 mt3PJkVu6Oa+wWnxkQiXOYzO11QwthJbm3Y4jxvi3oqfDYnvrC3oYBF5/bLpO8Rf762mUMABR
 /bYqgF3+SEk5BjrB8Az/mnlRwZ7yrDA3vjlhhP8t7CzBiyNvqm2zhQTlrdQApRZNNhgT5Wt+B
 8/2OLfu6E23RYOk78BhV89Tv39ws6BplggAaYCvbj+b6kSal72/42e51ELQ4LHLSy+Xn5BfwB
 q6qJDtff6p0G9CVNRDorovhgDqjbba5sjyM1DL1uI42z5KXhk7eDNcuUs/7+1tLOBreZLdQwL
 R3Bc1jSxyXQJYTAnhnr4tsQLT7f58f9iyfcGcgBeleu3j/XFY/6BNZll9j79YE8MgLU4Z8PwG
 nrFv1FhumAtioncOHYPBD5Ryu8SX29kwUVZ2D0AkQpWlotSX9cxcc2ehVuhHQQiUiq9HCS6SL
 zAkb2oJvQPe+fE/JBG12KoZ9JfOqiq3u2hodW9WHqfmW4J8HMcyT+LOpZh6O2AxQzLmQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
causes a warning:

fs/f2fs/inode.c: In function 'sanity_check_inode':
fs/f2fs/inode.c:247:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]

The correct format string is %zu.

Fixes: ba3a252d3367 ("f2fs: fix to do sanity check with i_extra_isize")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3fe63b0c7325..4fd339fd3ff2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -245,7 +245,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
-			"max: %lu",
+			"max: %zu",
 			__func__, inode->i_ino, fi->i_extra_isize,
 			F2FS_TOTAL_EXTRA_ATTR_SIZE);
 		return false;
-- 
2.18.0


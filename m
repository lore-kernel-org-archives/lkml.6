Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B69C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B1F2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B1F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966861AbeFSPvZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:51:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53049 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966555AbeFSPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:51:24 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MYeLS-1fj6Oj1pdy-00VROj; Tue, 19 Jun 2018 17:51:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: use time64_t for otime
Date:   Tue, 19 Jun 2018 17:51:02 +0200
Message-Id: <20180619155110.3950450-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:O6nfG/zPSAATmGKLLiNfuY3DOBplkWNX4ISrhaRKX9G0JpJjKqg
 5L38YWeF7FGurjpRho3S8IPeHQW2edDZ03KHr21+cADo4KEOoTZ5qhG8YjX9DGaaJPvHQQz
 nLmAHZC7R2hQQQdm9AdO6yjopPWkwrQKGv/0jYjAe5amdElrJoHpxWqD6DpXwTPVt6j04Tg
 O7RDmsHnF6JNJV3+fVEQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z/2X8TFxDP0=:aSdzr2LT3ev+Uei7ObnkqA
 DmRTIA+fFI6/SF4FWRXWlmqWAdd6oChFtoi0t8pj7zQBOp2bvQSvJReK6LQwvwXP65VM5cmQh
 pEcNgnY+xkIPnrEGzi1nrFuBuQzVEfCWdHf64RuFlanh+FBksUBOHD1flxS2Ok++56CdDumAu
 jeP1kfGZIWEi6cTt+gPXGT9zTir4lTQu2NQOJLyJIqc+G50oNkLZdniaOrsYOuq0Db5czWFJ/
 8K1Bxi1cqmxy0pmRcqrwmG9WVZfFea54edDbljJrjFG9o7ByOdyzsHLFQFSkVZcLfThGcKfM7
 hF7uJZC5Jv3j5LBcZx7OG9iaRQ2JEwDAbxDn2k37bwzwuOVtECy7GeAA9md01hiF1qDG7R+99
 pdN2ufaN6rHgXRJ9NNm6FhbhGPzsAXnWlOSzWhynhDqTf87rJoWrUe8ttna/blBVZIOCVs+HX
 x/3YID23J0RI8AQ4fGed32Q03p/SJKo2xXfOwEXeTxRFkOA3qDr5xJV04g8PCTExLoGcEEzDC
 vIiKWfYSoOPLrSF6Uj5DvHTjRn3xR10Tvqev5u57Gr/SkBM4fTTRNiV8h+BLSRvFPdzOy8BIS
 Crzlm6orM10HGtnwcO4rG25yKy/eWrKEpyIbqh/J6YHF/JIKTcxWnPTPLm3TkZcH4xSF3s69U
 VtEX2rT1SItXlEvDrJd+6S77dyejO+agTDZnCIoR4StvfVnc74TF+gBicMfaIBYJKIao=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file creation time in the inode uses time_t which is defined differently
on 32-bit and 64-bit architectures and deprecated. The representation in
the inode uses an unsigned 32-bit number, but this gets wrapped around
after year 2038 when assigned to a time_t.

This changes the type to time64_t, so we can support the full range of
timestamps between 1970 and 2106 on 32-bit systems like we do on 64-bit
systems already, and matching what we do for the atime/ctime/mtime stamps
since the introduction of 64-bit timestamps in VFS.

Note: the otime stamp is not actually used anywhere at the moment in
the kernel, it is just set when writing a file, so none of this really
makes a difference unless we implement setting the btime field in the
getattr() callback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jfs/jfs_incore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 1f26d1910409..d5c46f86b2ef 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -43,7 +43,7 @@ struct jfs_inode_info {
 	pxd_t	ixpxd;		/* inode extent descriptor	*/
 	dxd_t	acl;		/* dxd describing acl	*/
 	dxd_t	ea;		/* dxd describing ea	*/
-	time_t	otime;		/* time created	*/
+	time64_t otime;		/* time created	*/
 	uint	next_index;	/* next available directory entry index */
 	int	acltype;	/* Type of ACL	*/
 	short	btorder;	/* access order	*/
-- 
2.9.0


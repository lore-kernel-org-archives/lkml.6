Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD3C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186442098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186442098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJMPz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:55:59 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:59878 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeJMPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:55:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2C594180230D1;
        Sat, 13 Oct 2018 10:19:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     gregkh@linuxfoundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        dunlap@infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Fix WARN_ON logic in exit path
Date:   Sat, 13 Oct 2018 10:18:41 +0200
Message-Id: <20181013081841.13369-1-richard@nod.at>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ubifs_assert() is not WARN_ON(), so we have to invert
the checks.
Randy faced this warning with UBIFS being a module, since
most users use UBIFS as builtin because UBIFS is the rootfs
nobody noticed so far. :-(
Including me.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 54169ddd382d ("ubifs: Turn two ubifs_assert() into a WARN_ON()")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
Greg,

can you please take this patch directly?
It fixes a brown paper bug which was introduced in rc1, I'd like to avoid
having it in a release and going the -stable path.

Thanks,
//richard
---
 fs/ubifs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index bf000c8aeffb..fec62e9dfbe6 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2337,8 +2337,8 @@ late_initcall(ubifs_init);
=20
 static void __exit ubifs_exit(void)
 {
-	WARN_ON(list_empty(&ubifs_infos));
-	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) =3D=3D 0);
+	WARN_ON(!list_empty(&ubifs_infos));
+	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) !=3D 0);
=20
 	dbg_debugfs_exit();
 	ubifs_compressors_exit();
--=20
2.19.1


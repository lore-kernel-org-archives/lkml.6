Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56883C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC162084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pinc-software.de header.i=@pinc-software.de header.b="bVceAiWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfBANuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:50:10 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:18732 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfBANuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549029008;
        s=strato-dkim-0002; d=pinc-software.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=YUSBFTCheBPLkiFac+dldIdZlTGP/GxvRz7w8WnOiPs=;
        b=bVceAiWqJ7/jgbArJplfpu8ZWhMSf/0gP0gav4uEOa6zuf5CF/Xx8ltV5Z4TinTQAG
        dKMOObQWfT1uuqVLS1sCrdTSmuL1G3MLuvmyH2XpFFys1FvghyAZpXuxIfWtiyutoA/0
        1tX8a0JSBtbQYKiAsHt3J+O9GmHw7eLxy0yW9Z+9det22proOySMBSZe9+sJZN6KXrWo
        DpA7/Dn0UsPRuGVaaE4QJkNKZnKPdXW//6u7WyaVhCXHnbocJdq/mUagDIMqK5t2/eH1
        bCEDDBSbpakuIrtQWq+hvBe7ZmrD55np2Z6ThFeD6vc6N5t1WG9FfkKjbTbIx1t+ibTS
        /9KA==
X-RZG-AUTH: ":LXQBeUSIa/ZoedDIRs9YOPxY4/Y41LMYtYgA+S704F0fcsNycI1rqp7htm44FTK51uUkj61fqRw="
X-RZG-CLASS-ID: mo00
Received: from localhost
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id f084e9v11Do7XjN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 1 Feb 2019 14:50:07 +0100 (CET)
From:   =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
To:     Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
Subject: [PATCH] befs: Allow file sizes beyond 2GiB
Date:   Fri,  1 Feb 2019 14:49:57 +0100
Message-Id: <20190201134957.19696-1-axeld@pinc-software.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Dörfler <axeld@pinc-software.de>
---
 fs/befs/linuxvfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index a92355cc4..4113d8250 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -899,6 +899,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_magic = BEFS_SUPER_MAGIC;
 	/* Set real blocksize of fs */
 	sb_set_blocksize(sb, (ulong) befs_sb->block_size);
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &befs_sops;
 	sb->s_export_op = &befs_export_operations;
 	root = befs_iget(sb, iaddr2blockno(sb, &(befs_sb->root_dir)));
-- 
2.17.1


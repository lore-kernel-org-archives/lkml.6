Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9AFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAFC2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pinc-software.de header.i=@pinc-software.de header.b="LL7HEFKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfBANyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:54:44 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:29566 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfBANyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:54:44 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 08:54:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549029282;
        s=strato-dkim-0002; d=pinc-software.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=FRCuWDk/dgUA29mLsek4X2I9wb69JRwozIeDbsvyOvI=;
        b=LL7HEFKqVc4LfaD193pAiterGrRBPewyQJemb18oO2+1affMd6ejMaZiVjNAFHQ5KS
        pr8EJahvnv7OCkHEF7E2BfqlglOJOJJfb5Z2qWlo8CNbm5RBWXoOtSJ9dyF5BS/m7s2M
        UTnkfN84r5SoOHID1hJBKRQ9Jp3ggipuorBPOnGfW0U95q1wHWcJLYHFxkfOoYKZPRlT
        aLHNcqoDG6dPAw9DNAoQk6ssI8IIY6/eSSnAbdXU05bU5k15cypEKJraORhvaXfhQULe
        7mZXYxu5zafZ653DanFqFDjHmY7IJnSSd4xidxEfGedmdQKt+lZtdu55dBfMixtlFc9u
        bgMg==
X-RZG-AUTH: ":LXQBeUSIa/ZoedDIRs9YOPxY4/Y41LMYtYgA+S704F0fcsNycI1rqp7htm44FTK51uUkj61fqRw="
X-RZG-CLASS-ID: mo00
Received: from localhost
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id f084e9v11DmOXij
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 1 Feb 2019 14:48:24 +0100 (CET)
From:   =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
To:     Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
Subject: [PATCH] befs: Removed incorrect check
Date:   Fri,  1 Feb 2019 14:48:01 +0100
Message-Id: <20190201134801.19436-1-axeld@pinc-software.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relation between ag_shift and blocks_per_ag is a bit more complex,
and also depends on the fs block size.
Since blocks_per_ag is not even being used, simply omit the check.

Signed-off-by: Axel Dörfler <axeld@pinc-software.de>
---
 fs/befs/super.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c9..29fa37557 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -99,13 +99,6 @@ befs_check_sb(struct super_block *sb)
 		return BEFS_ERR;
 	}
 
-
-	/* ag_shift also encodes the same information as blocks_per_ag in a
-	 * different way, non-fatal consistency check
-	 */
-	if ((1 << befs_sb->ag_shift) != befs_sb->blocks_per_ag)
-		befs_error(sb, "ag_shift disagrees with blocks_per_ag.");
-
 	if (befs_sb->log_start != befs_sb->log_end ||
 	    befs_sb->flags == BEFS_DIRTY) {
 		befs_error(sb, "Filesystem not clean! There are blocks in the "
-- 
2.17.1


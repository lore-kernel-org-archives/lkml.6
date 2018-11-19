Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD103C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C692148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2efMg9fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C692148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbeKTDKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387731AbeKTDKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D6C2145D;
        Mon, 19 Nov 2018 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645968;
        bh=jy0yeGvFwV6ANF4ERqWLKoVsSw2CCUWDO7mLQzhpSpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2efMg9feAHYZxf1vS6dxUEIat8cTUNgsDyVfEg5V3i8gmhCXjW5GyS/Sxh+1c9/BY
         krU09FRESdAn8Umib1O5pGCJb2VXY4wOapI3LGXcz8xVu9srN+woXaQLEHHVAW2eMF
         Fq0n31TGgFm+kLK3sLFOKrrMOpFsgYYBtCWb5x4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.18 120/171] ext4: fix buffer leak in ext4_expand_extra_isize_ea() on error path
Date:   Mon, 19 Nov 2018 17:28:36 +0100
Message-Id: <20181119162637.085303858@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit 53692ec074d00589c2cf1d6d17ca76ad0adce6ec upstream.

Fixes: de05ca852679 ("ext4: move call to ext4_error() into ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 4.17
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2708,7 +2708,6 @@ int ext4_expand_extra_isize_ea(struct in
 			       struct ext4_inode *raw_inode, handle_t *handle)
 {
 	struct ext4_xattr_ibody_header *header;
-	struct buffer_head *bh;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	static unsigned int mnt_count;
 	size_t min_offs;
@@ -2749,13 +2748,17 @@ retry:
 	 * EA block can hold new_extra_isize bytes.
 	 */
 	if (EXT4_I(inode)->i_file_acl) {
+		struct buffer_head *bh;
+
 		bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
 		error = -EIO;
 		if (!bh)
 			goto cleanup;
 		error = ext4_xattr_check_block(inode, bh);
-		if (error)
+		if (error) {
+			brelse(bh);
 			goto cleanup;
+		}
 		base = BHDR(bh);
 		end = bh->b_data + bh->b_size;
 		min_offs = end - base;



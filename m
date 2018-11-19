Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4923CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10809214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0URoSo3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10809214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbeKTDJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387653AbeKTDJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:09:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFEB621104;
        Mon, 19 Nov 2018 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645915;
        bh=s4X9eve3B2wznXgaqBqfFiMbmocNLEHxpTmVXcORAVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0URoSo3gZfBKqAhpbP3R8ViwnqlTtdq8iXxcLLScrTNO9EVvwzztdxT29zt2lXzBe
         DgkklI0n+p7ivW18EIlBYUSyWw+p32UZQmFzPCSezRWSu1P8UYmGEe1Yv7vAeayq4W
         aihmzL6yVewBrZGoPbSZPYUYaYevOr2FqE6eM6VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4.18 137/171] gfs2: Fix metadata read-ahead during truncate (2)
Date:   Mon, 19 Nov 2018 17:28:53 +0100
Message-Id: <20181119162638.529632522@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

commit e7445ceddfc220c1aede6d42758a5acb8844e9c3 upstream.

The previous attempt to fix for metadata read-ahead during truncate was
incorrect: for files with a height > 2 (1006989312 bytes with a block
size of 4096 bytes), read-ahead requests were not being issued for some
of the indirect blocks discovered while walking the metadata tree,
leading to significant slow-downs when deleting large files.  Fix that.

In addition, only issue read-ahead requests in the first pass through
the meta-data tree, while deallocating data blocks.

Fixes: c3ce5aa9b0 ("gfs2: Fix metadata read-ahead during truncate")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/bmap.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1652,10 +1652,16 @@ static int punch_hole(struct gfs2_inode
 			if (ret < 0)
 				goto out;
 
-			/* issue read-ahead on metadata */
-			if (mp.mp_aheight > 1) {
-				for (; ret > 1; ret--) {
-					metapointer_range(&mp, mp.mp_aheight - ret,
+			/* On the first pass, issue read-ahead on metadata. */
+			if (mp.mp_aheight > 1 && strip_h == ip->i_height - 1) {
+				unsigned int height = mp.mp_aheight - 1;
+
+				/* No read-ahead for data blocks. */
+				if (mp.mp_aheight - 1 == strip_h)
+					height--;
+
+				for (; height >= mp.mp_aheight - ret; height--) {
+					metapointer_range(&mp, height,
 							  start_list, start_aligned,
 							  end_list, end_aligned,
 							  &start, &end);



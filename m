Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DD8223DD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHot/xTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DD8223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbeKLIQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeKLIQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:53 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5370216FD;
        Sun, 11 Nov 2018 22:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975217;
        bh=89N7itqN3eeg1ox3ffVrvLyO8vJA8jQC4S0KYRkCqwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHot/xTW191lhEloryxnHhEfX9bKnIxgU8IVJgCRheh37St8FS4fGAaATUMMLxvHS
         K5CLg9lsKhWbq8ePuLx2DZ37xth7mnORWxRfTWfAGTrFr94buSxo6anr3huLXX3wzy
         3NCkHPxo3P5uKqksoPvM+IKZC4mGACncp/cuDrgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 017/361] jffs2: free jffs2_sb_info through jffs2_kill_sb()
Date:   Sun, 11 Nov 2018 14:16:04 -0800
Message-Id: <20181111221622.204526777@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

commit 92e2921f7eee63450a5f953f4b15dc6210219430 upstream.

When an invalid mount option is passed to jffs2, jffs2_parse_options()
will fail and jffs2_sb_info will be freed, but then jffs2_sb_info will
be used (use-after-free) and freeed (double-free) in jffs2_kill_sb().

Fix it by removing the buggy invocation of kfree() when getting invalid
mount options.

Fixes: 92abc475d8de ("jffs2: implement mount option parsing and compression overriding")
Cc: stable@kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jffs2/super.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -285,10 +285,8 @@ static int jffs2_fill_super(struct super
 	sb->s_fs_info = c;
 
 	ret = jffs2_parse_options(c, data);
-	if (ret) {
-		kfree(c);
+	if (ret)
 		return -EINVAL;
-	}
 
 	/* Initialize JFFS2 superblock locks, the further initialization will
 	 * be done later */



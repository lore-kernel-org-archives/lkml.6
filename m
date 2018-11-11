Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E43C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1C620871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxjcFNUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1C620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbeKLJeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387538AbeKLITM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:12 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C59022360;
        Sun, 11 Nov 2018 22:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975356;
        bh=8zFc+X5EKQuYqE//lJCt3DXkIxggDlo5s1F27ZxNiUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxjcFNUmCxg8/6+iZXVxe0lUUVIknhiZUvJ8z+WREXgpBDTF/vRWguON2pM8NsgML
         XUXGIOAUKVd+dyOOW3oc/5DJIRDwNmXO8N+8L+qVduvdw0JFvTloCiTTVJvHR+nENn
         KSx6MHzMBEIyTi7R6OKcnL8x/0fKmfyTxXeI8iSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.18 012/350] jffs2: free jffs2_sb_info through jffs2_kill_sb()
Date:   Sun, 11 Nov 2018 14:17:56 -0800
Message-Id: <20181111221707.678375290@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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



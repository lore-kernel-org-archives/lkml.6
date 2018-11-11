Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EE3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDF020866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPzd+FeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDF020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbeKLIRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbeKLIRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:53 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741ED21582;
        Sun, 11 Nov 2018 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975278;
        bh=9aFlQKOJfwyxwvES6+vftQY8h/W4E6w9NRt6CUlIw2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPzd+FeN5VyJ9k+v4LIULZIuzX6F6vd1ajBCLtYeXFMFH0EVz12yR7HmwTCYpMuEu
         krfRNZu4vAVrN3MtO4mmuVVJNc9K5GQT4NdhVVUz3c8d7mMXIuqX4pJLI/tMONLnfu
         kUMI0O1iPDG1SjDa4zBhAeoSDhUsEP+1uZ36kp0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.19 193/361] f2fs: fix missing up_read
Date:   Sun, 11 Nov 2018 14:19:00 -0800
Message-Id: <20181111221647.547379227@linuxfoundation.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 89d13c38501df730cbb2e02c4499da1b5187119d upstream.

This patch fixes missing up_read call.

Fixes: c9b60788fc76 ("f2fs: fix to do sanity check with block address in main area")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/node.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1542,8 +1542,10 @@ static int __write_node_page(struct page
 	}
 
 	if (__is_valid_data_blkaddr(ni.blk_addr) &&
-		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC))
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC)) {
+		up_read(&sbi->node_write);
 		goto redirty_out;
+	}
 
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;



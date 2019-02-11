Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5842D21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900483;
	bh=JeuBIwNRYaeRrhrbmgxpqv2VqdDPAeqOUysVJ6GWBtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iue7CCXxCbiDqwr+MzdhsR1IdjGGcRW41QB+pQ8/ZTWXDTi7n2TgvUYHsrR4I7g5j
	 +z2bLzR/H2W6GtRUIeXjsXtSVsMZfhbTxvpL5hxkPy3Yob6siox6YKCXvLX+jXNfcQ
	 +zAhm1hGooHEtKHgARhY1rSMWjjLi4+4H78ro8os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfBKPxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731236AbfBKOgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710B420700;
        Mon, 11 Feb 2019 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895784;
        bh=JeuBIwNRYaeRrhrbmgxpqv2VqdDPAeqOUysVJ6GWBtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0d2/d1W8wItUZlQkvQhNlyMPWie82NZwoiFLX1/pLQh7J3+ftbZ+OohsA2GnX8Jst
         TDyHoBOHTJhr9nvJ8Gmy/KpaxEdGb+E2IG43QOLLt30fR58XwHXoIRJOjw7VT8+NEJ
         sIut2A9z9Ut7tqMxjEgVcmQccwWGFDFz7oqYiTmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.20 322/352] fuse: handle zero sized retrieve correctly
Date:   Mon, 11 Feb 2019 15:19:09 +0100
Message-Id: <20190211141907.332307834@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 97e1532ef81acb31c30f9e75bf00306c33a77812 upstream.

Dereferencing req->page_descs[0] will Oops if req->max_pages is zero.

Reported-by: syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com
Tested-by: syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com
Fixes: b2430d7567a3 ("fuse: add per-page descriptor <offset, length> to fuse_req")
Cc: <stable@vger.kernel.org> # v3.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1742,7 +1742,6 @@ static int fuse_retrieve(struct fuse_con
 	req->in.h.nodeid = outarg->nodeid;
 	req->in.numargs = 2;
 	req->in.argpages = 1;
-	req->page_descs[0].offset = offset;
 	req->end = fuse_retrieve_end;
 
 	index = outarg->offset >> PAGE_SHIFT;
@@ -1757,6 +1756,7 @@ static int fuse_retrieve(struct fuse_con
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		req->pages[req->num_pages] = page;
+		req->page_descs[req->num_pages].offset = offset;
 		req->page_descs[req->num_pages].length = this_num;
 		req->num_pages++;
 



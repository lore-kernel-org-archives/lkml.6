Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF91CC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195C222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896887;
	bh=/HOMIb2nU0UzXKSzJ0AmkixYcrZCF2pc+cRzDocAj+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wbfo6dnNMlCw9s9kUmOFxTrBWinKBkiqU/Rt1sAaUUALeOsYSAigMnX6j/I9huPjJ
	 hpAiBV+R8nr2bAElbwH4yGHExPFia2o1/9EMyNuTsx4J4heQFwObS0ZV87GKWZ9ahJ
	 nK5H8E1y1M5CiUFIDOtzp7YqTFKF618lvaz59ys0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbfBKOxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388674AbfBKOxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:53:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC8120700;
        Mon, 11 Feb 2019 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896822;
        bh=/HOMIb2nU0UzXKSzJ0AmkixYcrZCF2pc+cRzDocAj+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SE43mGxGkt1rdVO+Gy/cN/bYrKXoxckm9+dwOZzHuVMnQpt/QkfoY3Kb4t6lJv2Nj
         PVUTua/nli938XuNCV1D1ubwuc60fkwrka5Kjm6fgz+4HixOpBfL6hLENhpUCYNESP
         qMiq10cLnGht468lFilEzGBUMk0N3qdHhI8ssF4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 286/313] fuse: handle zero sized retrieve correctly
Date:   Mon, 11 Feb 2019 15:19:26 +0100
Message-Id: <20190211141912.270347341@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1698,7 +1698,6 @@ static int fuse_retrieve(struct fuse_con
 	req->in.h.nodeid = outarg->nodeid;
 	req->in.numargs = 2;
 	req->in.argpages = 1;
-	req->page_descs[0].offset = offset;
 	req->end = fuse_retrieve_end;
 
 	index = outarg->offset >> PAGE_SHIFT;
@@ -1713,6 +1712,7 @@ static int fuse_retrieve(struct fuse_con
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		req->pages[req->num_pages] = page;
+		req->page_descs[req->num_pages].offset = offset;
 		req->page_descs[req->num_pages].length = this_num;
 		req->num_pages++;
 



Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5749C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFFD217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499070;
	bh=WRMRhMN3G7C0wxSd9EI6ykCEvg21hgaTroPbBTrCtFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vJDpXoQX3YPMOx+/0eqDfogDjaGPXpmoPq1IRbSMjGTxdetNQdFyeFQArp4+dfTY9
	 Ww4cFn1bJpddMAjdfGEeTSBrQS7xIv4Hv5KPKRuKbP/r8oqQBzJMC88/mI7988kp/1
	 E9kUYXR8vGNLq/rRL4wB8DGTx/lPL5Vky2YTFSjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbfBROLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391646AbfBROLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8CF217D7;
        Mon, 18 Feb 2019 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499062;
        bh=WRMRhMN3G7C0wxSd9EI6ykCEvg21hgaTroPbBTrCtFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1j2d1SM8S6WXsw0ZpmQyybVFN/vi/hqacRfvArtceDs7ElaXSbcx3x3anvNjjMjnH
         y0Z6aTdVATd59mnohRJuDrPtg44f0kC12HJT+mCdN36WGPgpdWuB2tezS0VltAb+jh
         jDHuly5SG46M28IamPviYEDR1dp9h7QmGoGr8RFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 3.18 065/108] fuse: handle zero sized retrieve correctly
Date:   Mon, 18 Feb 2019 14:44:01 +0100
Message-Id: <20190218133522.537535951@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1645,7 +1645,6 @@ static int fuse_retrieve(struct fuse_con
 	req->in.h.nodeid = outarg->nodeid;
 	req->in.numargs = 2;
 	req->in.argpages = 1;
-	req->page_descs[0].offset = offset;
 	req->end = fuse_retrieve_end;
 
 	index = outarg->offset >> PAGE_CACHE_SHIFT;
@@ -1660,6 +1659,7 @@ static int fuse_retrieve(struct fuse_con
 
 		this_num = min_t(unsigned, num, PAGE_CACHE_SIZE - offset);
 		req->pages[req->num_pages] = page;
+		req->page_descs[req->num_pages].offset = offset;
 		req->page_descs[req->num_pages].length = this_num;
 		req->num_pages++;
 



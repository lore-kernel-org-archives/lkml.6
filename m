Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683DE222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897374;
	bh=xBhMphdUPayMhzcwE8atPzeY7WUOtsvXP3KH6HnfIhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4qMA9AdFW1A7I+mBLNTfNOSS0C03zDUKGH1dD+X/2rPQrGFnVCY51GWsoLt3GAfg
	 jVbyzp7e0Tgx+IeyLtcun+seYC//cFC/WdoHNqRRfxGBCrlsDEzVlEBzOjXoVJu0/n
	 YzniMfLwGyz+3nJ7UCzNpTJyTVfbWDav06wc9Hxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390498AbfBKPCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390480AbfBKPCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:02:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8990C222A7;
        Mon, 11 Feb 2019 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897366;
        bh=xBhMphdUPayMhzcwE8atPzeY7WUOtsvXP3KH6HnfIhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCC7yLPMcWKjjCV8Jo4KNxU0uWUowj7p8fAdBnEmJBYKgXXdtiz8rfxSaEbWoA3yy
         KVWfqGt8fyYGSuNhWp1eFzzhpBp1IKQxQnM830KBMdHIdI1vYVqDvHlEKRLk1+mWxQ
         YbM6OZnCAPPqqr0V8f2MNcbfI18liNggHbeUdZ/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 178/205] fuse: decrement NR_WRITEBACK_TEMP on the right page
Date:   Mon, 11 Feb 2019 15:19:36 +0100
Message-Id: <20190211141840.020762776@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit a2ebba824106dabe79937a9f29a875f837e1b6d4 upstream.

NR_WRITEBACK_TEMP is accounted on the temporary page in the request, not
the page cache page.

Fixes: 8b284dc47291 ("fuse: writepages: handle same page rewrites")
Cc: <stable@vger.kernel.org> # v3.13
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1777,7 +1777,7 @@ static bool fuse_writepage_in_flight(str
 		spin_unlock(&fc->lock);
 
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(page, NR_WRITEBACK_TEMP);
+		dec_node_page_state(new_req->pages[0], NR_WRITEBACK_TEMP);
 		wb_writeout_inc(&bdi->wb);
 		fuse_writepage_free(fc, new_req);
 		fuse_request_free(new_req);



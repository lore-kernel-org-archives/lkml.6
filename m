Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2147BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C6920818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895790;
	bh=S9ZU50Us0aiowbJCNg2cE8aEg7nvx8Y2AVMFpMsfzGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2iij0D05hxtxoiXsPHsRpMntinem5C8/RA7OgX4M0J1uRLLjdoYJYCDPkGVzlZWny
	 L4ZB3zaS3oB70qL/d7WKuhTa8yqjvJTLuaBGPzQp72u70cCsTVJ/Wm7XEYOFoDJdWh
	 dHl4e4GlhjZEmzMmvyJlNkXJg6qNPmrE2We42MlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfBKOg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbfBKOgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E058320700;
        Mon, 11 Feb 2019 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895781;
        bh=S9ZU50Us0aiowbJCNg2cE8aEg7nvx8Y2AVMFpMsfzGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ7tocLziKn7OyxtLfIB7cJ7lnFcsJ3pflGhG0e9kTjfZ2rN21m8/zuK9lGuBsP+t
         0ha6SoLYAMQjHG3JjK7gTMVruhyvVsbt83ULVxcirIoRmUi6dEY8AMAO3XSXuvEBcv
         B8wBMUKZGQMRv3/wNSMrANPKCAOu68KQCy+JE43I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.20 321/352] fuse: decrement NR_WRITEBACK_TEMP on the right page
Date:   Mon, 11 Feb 2019 15:19:08 +0100
Message-Id: <20190211141907.243470004@linuxfoundation.org>
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
@@ -1782,7 +1782,7 @@ static bool fuse_writepage_in_flight(str
 		spin_unlock(&fc->lock);
 
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(page, NR_WRITEBACK_TEMP);
+		dec_node_page_state(new_req->pages[0], NR_WRITEBACK_TEMP);
 		wb_writeout_inc(&bdi->wb);
 		fuse_writepage_free(fc, new_req);
 		fuse_request_free(new_req);



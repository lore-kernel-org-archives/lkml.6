Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FD721908
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498683;
	bh=4C/lufUo4iMYPZ4ykF0iA1wOBaYOYy1ZMroD57Q4MRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RvI9u2XQwlcrkugFdxCu/kzxJ/yYeB4Z6XNEZsC9HIT8iQ4gXyxDFHX8RChSvWE0X
	 R4JTjqmGi21+mwMMWuiqadKvLJ/dqJ/IlcjA/V6n0pKFPLtUMpySEylhHQqGlWE5Fy
	 G1wlFStrfiTQ9m16TwXT2LWXXUx2Garre1hcaea4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbfBROEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389002AbfBROEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:04:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B3E21901;
        Mon, 18 Feb 2019 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498678;
        bh=4C/lufUo4iMYPZ4ykF0iA1wOBaYOYy1ZMroD57Q4MRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3W+NtODcVQjvE/nnAGlX2nDy37W9oA/2COR44m4Qe9AwC+4oBRDFGUfVYol0Cm3p
         NmwNGEh8f0LjIx2gmevrJkhai1IL9xaM0lj3OYOiY5Qxk63Qeqqfq858pxWW6ocAjk
         rwt9X0owHlM3z2gOMVLzTqwr7dU5QXdFJyl57K5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 086/143] fuse: decrement NR_WRITEBACK_TEMP on the right page
Date:   Mon, 18 Feb 2019 14:43:34 +0100
Message-Id: <20190218133532.208764580@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1784,7 +1784,7 @@ static bool fuse_writepage_in_flight(str
 		spin_unlock(&fc->lock);
 
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_zone_page_state(page, NR_WRITEBACK_TEMP);
+		dec_zone_page_state(new_req->pages[0], NR_WRITEBACK_TEMP);
 		wb_writeout_inc(&bdi->wb);
 		fuse_writepage_free(fc, new_req);
 		fuse_request_free(new_req);



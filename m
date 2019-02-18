Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D9021901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499065;
	bh=Uimo8Bqa7Iptbc8qZ8ySsV7Ngqio3qItis6Akx6Cnd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SlwYWvpUB1oYu098RtND9F8nSRNsnXI6XtIjWrIMsBBBMTZgBHTdSmfR5pKXaEPXM
	 T467e77rFckUGDKO6KTUajuFtOpeuB/mCCOK0e9iYF3o2ir16+CLvm1MvsC91Li/bY
	 OkdndQyMzNIT1mG0HCgjsRjvt3iJI2QdBO74vPtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbfBROLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391640AbfBROK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:10:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD9C21903;
        Mon, 18 Feb 2019 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499059;
        bh=Uimo8Bqa7Iptbc8qZ8ySsV7Ngqio3qItis6Akx6Cnd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lgyu8kLdpTglCl/DwMpr8w2o93mphjDBrJTF8EpJ32761tFqyt+1e5JK2ro6pAYYz
         gnhOpAff/quBTKl3Ni5rVfLoYKMwusE9rJRgqf/kyuviPJFG6HVRookirO8nFmRb4P
         yw9ZCVc0bFYeo3nqc/RBqHjVFRWIh8GdLsRS9bfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 3.18 064/108] fuse: decrement NR_WRITEBACK_TEMP on the right page
Date:   Mon, 18 Feb 2019 14:44:00 +0100
Message-Id: <20190218133522.490385933@linuxfoundation.org>
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
@@ -1844,7 +1844,7 @@ static bool fuse_writepage_in_flight(str
 		spin_unlock(&fc->lock);
 
 		dec_bdi_stat(bdi, BDI_WRITEBACK);
-		dec_zone_page_state(page, NR_WRITEBACK_TEMP);
+		dec_zone_page_state(new_req->pages[0], NR_WRITEBACK_TEMP);
 		bdi_writeout_inc(bdi);
 		fuse_writepage_free(fc, new_req);
 		fuse_request_free(new_req);



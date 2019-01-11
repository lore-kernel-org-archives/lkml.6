Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED661206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217598;
	bh=XBkteS0z+j3oy6MAWgwNhBhcbpkQJNpCsvxBVhvf3ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YS7KbSY4UDL59G5SuOVugZhjgXya5qjHhnUc/7j+LpUyIMeY1uSE4UvB8MLCX3UX/
	 ksP2fXIqXH0gA3GarcPvQGzsH7dtUnQU1gLMbsy5SOgPwrkSCKQPmapRG30Effxckg
	 makcz1WGASR6JoQSbvL5KCbDy2eABucxIqyAslSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391125AbfAKOj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391098AbfAKOjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE632063F;
        Fri, 11 Jan 2019 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217591;
        bh=XBkteS0z+j3oy6MAWgwNhBhcbpkQJNpCsvxBVhvf3ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J/bqy+nzQ7x5iTjA7uQBsXUqHP+Hkrpd80DT/2HpVwF1ZyLRU3RJ1awXIw+WRinAc
         q0QB/MbJ+zDQOEj8DtgWOsIzFGKG9/WvGRf7+Ien6j4DAsR1n0ebKD5JKKnzYLcRTl
         A5joRtIB1KJmV+nvkfNOrPQ7x+oNdCyZzKjRMSHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.19 119/148] gfs2: Fix loop in gfs2_rbm_find
Date:   Fri, 11 Jan 2019 15:14:57 +0100
Message-Id: <20190111131119.011132400@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 2d29f6b96d8f80322ed2dd895bca590491c38d34 upstream.

Fix the resource group wrap-around logic in gfs2_rbm_find that commit
e579ed4f44 broke.  The bug can lead to unnecessary repeated scanning of the
same bitmaps; there is a risk that future changes will turn this into an
endless loop.

Fixes: e579ed4f44 ("GFS2: Introduce rbm field bii")
Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/rgrp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1747,9 +1747,9 @@ static int gfs2_rbm_find(struct gfs2_rbm
 			goto next_iter;
 		}
 		if (ret == -E2BIG) {
+			n += rbm->bii - initial_bii;
 			rbm->bii = 0;
 			rbm->offset = 0;
-			n += (rbm->bii - initial_bii);
 			goto res_covered_end_of_rgrp;
 		}
 		return ret;



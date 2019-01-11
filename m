Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B44CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA8C2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217611;
	bh=FGFxA5Me/4Oj9pcsXGhfUHvRbTJy4KGcQVt76UIu/n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2cjRQxFB7gUArmp82G+DUGpG1jASXWI1wSvWj6L1LAxwNHAQKFVnRj1sLYZden42
	 Ts2E4hg4OmpGEb8xLkuKnDQu+ANErQexArDvaCxc8Am7qgOFtdCyAB4+Hx1xBJ3cx8
	 Lge2TDGf6bfR3I6Yapis/eBZfpEyTzQtwZTK2D4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbfAKOkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403847AbfAKOkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A5C2063F;
        Fri, 11 Jan 2019 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217607;
        bh=FGFxA5Me/4Oj9pcsXGhfUHvRbTJy4KGcQVt76UIu/n4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JC70NUvo1PP0UvkV7lrpG2CxcBk3D82jGwS0um6+oikcaCrsBsh6Zu4zUGKASouMc
         rbUa23I7bOrfx9YRoB6EDMwG/rBqHpnfrKQztjVZqzBHbRQOVlLorzZM34FM7Pm1d1
         mF+Xt4Tbe+uaZ4Y/uqXHL7lMuDBCo3npoIy0+6Vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 124/148] nfsd4: zero-length WRITE should succeed
Date:   Fri, 11 Jan 2019 15:15:02 +0100
Message-Id: <20190111131119.212173111@linuxfoundation.org>
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

From: J. Bruce Fields <bfields@redhat.com>

commit fdec6114ee1f0f43b1ad081ad8d46b23ba126d70 upstream.

Zero-length writes are legal; from 5661 section 18.32.3: "If the count
is zero, the WRITE will succeed and return a count of zero subject to
permissions checking".

This check is unnecessary and is causing zero-length reads to return
EINVAL.

Cc: stable@vger.kernel.org
Fixes: 3fd9557aec91 "NFSD: Refactor the generic write vector fill helper"
Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4proc.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1015,8 +1015,6 @@ nfsd4_write(struct svc_rqst *rqstp, stru
 
 	nvecs = svc_fill_write_vector(rqstp, write->wr_pagelist,
 				      &write->wr_head, write->wr_buflen);
-	if (!nvecs)
-		return nfserr_io;
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, filp,



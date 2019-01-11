Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9267320872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217880;
	bh=PDGhRl3P3HViSQ8R7Jrh3BDjmi0Z6/Lm0NKkaC+9koo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvsvAf+CTZ10R2ey58TlMU4uBoUxHhUaWQ91I11YcgbFpkUUAPvrG5BPi0+HNGvi7
	 Uh4KdewJJ1PJ/7szSi2Nuj/kURf69tvlbBToW1nOZg3x1vfnEeduXvAlU44CXFoqMI
	 h4lHqJSC5g7QVx2ZXxUmrTzua3sX7OUuiKAc2Kfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404626AbfAKOoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404202AbfAKOoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D3B20872;
        Fri, 11 Jan 2019 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217874;
        bh=PDGhRl3P3HViSQ8R7Jrh3BDjmi0Z6/Lm0NKkaC+9koo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVKSnapzhmlcK9ebZ+FQgvhVre+rU22GgVazcwmfG/04ysXsHjzwetWGTrg0eI1Vq
         QGRM+c213w1UkGd1Lf8skXMTwyfDW4sQkUYuRbXaOas7EmhnQm9pnrIWVcZpGtpieH
         TrGFMTaA6AaWjWNR5zU4Z+C1qQEL1sg0Mp+GFSbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.20 40/65] nfsd4: zero-length WRITE should succeed
Date:   Fri, 11 Jan 2019 15:15:26 +0100
Message-Id: <20190111131102.049766318@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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
@@ -1016,8 +1016,6 @@ nfsd4_write(struct svc_rqst *rqstp, stru
 
 	nvecs = svc_fill_write_vector(rqstp, write->wr_pagelist,
 				      &write->wr_head, write->wr_buflen);
-	if (!nvecs)
-		return nfserr_io;
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, filp,



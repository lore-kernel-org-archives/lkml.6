Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948FE20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9wsra+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948FE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbeKLJpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732652AbeKLISV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:21 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236CB21707;
        Sun, 11 Nov 2018 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975305;
        bh=WVomlRGZ+TpigkKJYugZPNTy5MIpt4fBy8nD3S4lY9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9wsra+TKG1LRlhzzNZ0okFd93t0lRClrhMoH/08jJLhrlnzlY13/mKFFJnd+RdCd
         o80wUNT/PCtakg4KqEORpI2OgDlguil2SX0o5VfSkpTQuBySXMOQG546lLu6KibCES
         zkrSIjVdr6eS3w1XvB5ytY0nb/3J7U6n3LC5mXHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Elble <aweits@rit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 272/361] nfsd: correctly decrement odstate refcount in error path
Date:   Sun, 11 Nov 2018 14:20:19 -0800
Message-Id: <20181111221655.121747331@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Elble <aweits@rit.edu>

commit bd8d725078867cda250fe94b9c5a067b4a64ca74 upstream.

alloc_init_deleg() both allocates an nfs4_delegation, and
bumps the refcount on odstate. So after this point, we need to
put_clnt_odstate() and nfs4_put_stid() to not leave the odstate
refcount inappropriately bumped.

Signed-off-by: Andrew Elble <aweits@rit.edu>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4364,7 +4364,7 @@ nfs4_set_delegation(struct nfs4_client *
 
 	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
 	if (!fl)
-		goto out_stid;
+		goto out_clnt_odstate;
 
 	status = vfs_setlease(fp->fi_deleg_file, fl->fl_type, &fl, NULL);
 	if (fl)
@@ -4389,7 +4389,6 @@ out_unlock:
 	vfs_setlease(fp->fi_deleg_file, F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
-out_stid:
 	nfs4_put_stid(&dp->dl_stid);
 out_delegees:
 	put_deleg_file(fp);



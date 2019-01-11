Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C18C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1662E2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218237;
	bh=QMeKnzzLME5AEvIoEFXsvEzMw/XNkwf3Qz9fKTkC3gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v7N74ojIEHwty8lsXP+/XnwyZMrmJcAEqQv/l+v8fSsGf28jGLGjnX3K9RvYHyv/f
	 sxenl/hTfGEkDh5lquVapFLMcWXP6mVmVLKydNp9Xt3hnAdiPNH8/gqbyC3QKODvB5
	 kabxJJ1EAVyQzwwgQCI4IBDEIF3CLOE5o97UY/jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403854AbfAKOkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391164AbfAKOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A044021841;
        Fri, 11 Jan 2019 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217605;
        bh=QMeKnzzLME5AEvIoEFXsvEzMw/XNkwf3Qz9fKTkC3gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyPCOFicjBM4AWCuVQKE/ZUZWi6c1w/jIMBq7gy8R3WL2+sOgCOI44N3s10J7peg9
         VtvaR5CSpO/pM4zgA2OtJdYKKeb6sCHDPx3FyTcumDilTkpUNlWRG+DP1ZTXlVaQ2+
         isUO6C0U7hKR+ELyKB3YGEkjdfgWtMnfKeavYa3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 123/148] lockd: Show pid of lockd for remote locks
Date:   Fri, 11 Jan 2019 15:15:01 +0100
Message-Id: <20190111131119.171201756@linuxfoundation.org>
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

From: Benjamin Coddington <bcodding@redhat.com>

commit b8eee0e90f9797b747113638bc75e739b192ad38 upstream.

Commit 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid
for remote locks") specified that the l_pid returned for F_GETLK on a local
file that has a remote lock should be the pid of the lock manager process.
That commit, while updating other filesystems, failed to update lockd, such
that locks created by lockd had their fl_pid set to that of the remote
process holding the lock.  Fix that here to be the pid of lockd.

Also, fix the client case so that the returned lock pid is negative, which
indicates a remote lock on a remote file.

Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific...")
Cc: stable@vger.kernel.org

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/lockd/clntproc.c |    2 +-
 fs/lockd/xdr.c      |    4 ++--
 fs/lockd/xdr4.c     |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -442,7 +442,7 @@ nlmclnt_test(struct nlm_rqst *req, struc
 			fl->fl_start = req->a_res.lock.fl.fl_start;
 			fl->fl_end = req->a_res.lock.fl.fl_end;
 			fl->fl_type = req->a_res.lock.fl.fl_type;
-			fl->fl_pid = 0;
+			fl->fl_pid = -req->a_res.lock.fl.fl_pid;
 			break;
 		default:
 			status = nlm_stat_to_errno(req->a_res.status);
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -127,7 +127,7 @@ nlm_decode_lock(__be32 *p, struct nlm_lo
 
 	locks_init_lock(fl);
 	fl->fl_owner = current->files;
-	fl->fl_pid   = (pid_t)lock->svid;
+	fl->fl_pid   = current->tgid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
 	start = ntohl(*p++);
@@ -269,7 +269,7 @@ nlmsvc_decode_shareargs(struct svc_rqst
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
 	lock->svid = ~(u32) 0;
-	lock->fl.fl_pid = (pid_t)lock->svid;
+	lock->fl.fl_pid = current->tgid;
 
 	if (!(p = nlm_decode_cookie(p, &argp->cookie))
 	 || !(p = xdr_decode_string_inplace(p, &lock->caller,
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -119,7 +119,7 @@ nlm4_decode_lock(__be32 *p, struct nlm_l
 
 	locks_init_lock(fl);
 	fl->fl_owner = current->files;
-	fl->fl_pid   = (pid_t)lock->svid;
+	fl->fl_pid   = current->tgid;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_type  = F_RDLCK;		/* as good as anything else */
 	p = xdr_decode_hyper(p, &start);
@@ -266,7 +266,7 @@ nlm4svc_decode_shareargs(struct svc_rqst
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
 	lock->svid = ~(u32) 0;
-	lock->fl.fl_pid = (pid_t)lock->svid;
+	lock->fl.fl_pid = current->tgid;
 
 	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
 	 || !(p = xdr_decode_string_inplace(p, &lock->caller,



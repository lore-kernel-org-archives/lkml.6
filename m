Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A2BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6917217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277574;
	bh=CrGNj08iYgbx5vR+sSqDcDZHTzXtsBPnesS0KAWE49k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PnZo7L58Cu1QQ9TJdMkU3bEuHQJejk6YGtfXQlYC1mdhV75DOh149dDy4x8Ge3rIW
	 Y46/0aJxqxJWPR2v2BlwTvUY5/TAVyi4a3r+P+PqbyT2+NApCK7ColylzHDlKx/Cnp
	 /sZ+Pge57nOg7lmHSAlbGuHYtRCCkAFJ0m5T0Se0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfBDKwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732670AbfBDKwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2706E2070C;
        Mon,  4 Feb 2019 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277570;
        bh=CrGNj08iYgbx5vR+sSqDcDZHTzXtsBPnesS0KAWE49k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SD+xwOAvHBhZkOZhTHsZ00vifhdrgemVbFSj9oBsbXsm7ogsAsDIOeKQsIfz7wz1d
         X8CzV+veKaWP5vi2fvdP8w1aPiv8EGYl63pqbRTBaZlw4pi3THDOhhto3wg6rqRRnX
         rhws7Y58F4XK/APm7pU3J0xSm7j566UijVqkxuVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 37/80] CIFS: Fix trace command logging for SMB2 reads and writes
Date:   Mon,  4 Feb 2019 11:36:57 +0100
Message-Id: <20190204103625.166496823@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 7d42e72fe8ee5ab70b1af843dd7d8615e6fb0abe upstream.

Currently we log success once we send an async IO request to
the server. Instead we need to analyse a response and then log
success or failure for a particular command. Also fix argument
list for read logging.

Cc: <stable@vger.kernel.org> # 4.18
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |   46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3139,8 +3139,17 @@ smb2_readv_callback(struct mid_q_entry *
 		rdata->mr = NULL;
 	}
 #endif
-	if (rdata->result)
+	if (rdata->result) {
 		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
+		trace_smb3_read_err(0 /* xid */,
+				    rdata->cfile->fid.persistent_fid,
+				    tcon->tid, tcon->ses->Suid, rdata->offset,
+				    rdata->bytes, rdata->result);
+	} else
+		trace_smb3_read_done(0 /* xid */,
+				     rdata->cfile->fid.persistent_fid,
+				     tcon->tid, tcon->ses->Suid,
+				     rdata->offset, rdata->got_bytes);
 
 	queue_work(cifsiod_wq, &rdata->work);
 	DeleteMidQEntry(mid);
@@ -3215,13 +3224,11 @@ smb2_async_readv(struct cifs_readdata *r
 	if (rc) {
 		kref_put(&rdata->refcount, cifs_readdata_release);
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
-		trace_smb3_read_err(rc, 0 /* xid */, io_parms.persistent_fid,
-				   io_parms.tcon->tid, io_parms.tcon->ses->Suid,
-				   io_parms.offset, io_parms.length);
-	} else
-		trace_smb3_read_done(0 /* xid */, io_parms.persistent_fid,
-				   io_parms.tcon->tid, io_parms.tcon->ses->Suid,
-				   io_parms.offset, io_parms.length);
+		trace_smb3_read_err(0 /* xid */, io_parms.persistent_fid,
+				    io_parms.tcon->tid,
+				    io_parms.tcon->ses->Suid,
+				    io_parms.offset, io_parms.length, rc);
+	}
 
 	cifs_small_buf_release(buf);
 	return rc;
@@ -3265,10 +3272,11 @@ SMB2_read(const unsigned int xid, struct
 		if (rc != -ENODATA) {
 			cifs_stats_fail_inc(io_parms->tcon, SMB2_READ_HE);
 			cifs_dbg(VFS, "Send error in read = %d\n", rc);
+			trace_smb3_read_err(xid, req->PersistentFileId,
+					    io_parms->tcon->tid, ses->Suid,
+					    io_parms->offset, io_parms->length,
+					    rc);
 		}
-		trace_smb3_read_err(rc, xid, req->PersistentFileId,
-				    io_parms->tcon->tid, ses->Suid,
-				    io_parms->offset, io_parms->length);
 		free_rsp_buf(resp_buftype, rsp_iov.iov_base);
 		return rc == -ENODATA ? 0 : rc;
 	} else
@@ -3354,8 +3362,17 @@ smb2_writev_callback(struct mid_q_entry
 		wdata->mr = NULL;
 	}
 #endif
-	if (wdata->result)
+	if (wdata->result) {
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
+		trace_smb3_write_err(0 /* no xid */,
+				     wdata->cfile->fid.persistent_fid,
+				     tcon->tid, tcon->ses->Suid, wdata->offset,
+				     wdata->bytes, wdata->result);
+	} else
+		trace_smb3_write_done(0 /* no xid */,
+				      wdata->cfile->fid.persistent_fid,
+				      tcon->tid, tcon->ses->Suid,
+				      wdata->offset, wdata->bytes);
 
 	queue_work(cifsiod_wq, &wdata->work);
 	DeleteMidQEntry(mid);
@@ -3497,10 +3514,7 @@ smb2_async_writev(struct cifs_writedata
 				     wdata->bytes, rc);
 		kref_put(&wdata->refcount, release);
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
-	} else
-		trace_smb3_write_done(0 /* no xid */, req->PersistentFileId,
-				     tcon->tid, tcon->ses->Suid, wdata->offset,
-				     wdata->bytes);
+	}
 
 async_writev_out:
 	cifs_small_buf_release(req);



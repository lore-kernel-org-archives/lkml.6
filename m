Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30F3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A18E2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A18E2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeKLGDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:03:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52768 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731286AbeKLGDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:03:18 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvss-0000l9-6P; Sun, 11 Nov 2018 19:59:02 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001gH-If; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Paulo Alcantara" <palcantara@suse.de>,
        "Lars Persson" <lars.persson@axis.com>,
        "Steve French" <stfrench@microsoft.com>,
        "Lars Persson" <larper@axis.com>,
        "Pavel Shilovsky" <pshilov@microsoft.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.523759728@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 231/366] cifs: Fix use after free of a mid_q_entry
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lars Persson <lars.persson@axis.com>

commit 696e420bb2a6624478105651d5368d45b502b324 upstream.

With protocol version 2.0 mounts we have seen crashes with corrupt mid
entries. Either the server->pending_mid_q list becomes corrupt with a
cyclic reference in one element or a mid object fetched by the
demultiplexer thread becomes overwritten during use.

Code review identified a race between the demultiplexer thread and the
request issuing thread. The demultiplexer thread seems to be written
with the assumption that it is the sole user of the mid object until
it calls the mid callback which either wakes the issuer task or
deletes the mid.

This assumption is not true because the issuer task can be woken up
earlier by a signal. If the demultiplexer thread has proceeded as far
as setting the mid_state to MID_RESPONSE_RECEIVED then the issuer
thread will happily end up calling cifs_delete_mid while the
demultiplexer thread still is using the mid object.

Inserting a delay in the cifs demultiplexer thread widens the race
window and makes reproduction of the race very easy:

		if (server->large_buf)
			buf = server->bigbuf;

+		usleep_range(500, 4000);

		server->lstrp = jiffies;

To resolve this I think the proper solution involves putting a
reference count on the mid object. This patch makes sure that the
demultiplexer thread holds a reference until it has finished
processing the transaction.

Signed-off-by: Lars Persson <larper@axis.com>
Acked-by: Paulo Alcantara <palcantara@suse.de>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[bwh: Backported to 3.16: Drop redundant assignment to mid_entry]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/cifsglob.h      |  1 +
 fs/cifs/cifsproto.h     |  1 +
 fs/cifs/connect.c       |  8 +++++++-
 fs/cifs/smb1ops.c       |  1 +
 fs/cifs/smb2ops.c       |  1 +
 fs/cifs/smb2transport.c |  1 +
 fs/cifs/transport.c     | 18 +++++++++++++++++-
 7 files changed, 29 insertions(+), 2 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1232,6 +1232,7 @@ typedef void (mid_callback_t)(struct mid
 /* one of these for every pending CIFS request to the server */
 struct mid_q_entry {
 	struct list_head qhead;	/* mids waiting on reply from this server */
+	struct kref refcount;
 	struct TCP_Server_Info *server;	/* server corresponding to this mid */
 	__u64 mid;		/* multiplex id */
 	__u32 pid;		/* process id */
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -74,6 +74,7 @@ extern struct mid_q_entry *AllocMidQEntr
 					struct TCP_Server_Info *server);
 extern void DeleteMidQEntry(struct mid_q_entry *midEntry);
 extern void cifs_delete_mid(struct mid_q_entry *mid);
+extern void cifs_mid_q_entry_release(struct mid_q_entry *midEntry);
 extern void cifs_wake_up_task(struct mid_q_entry *mid);
 extern int cifs_call_async(struct TCP_Server_Info *server,
 			struct smb_rqst *rqst,
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -903,8 +903,11 @@ cifs_demultiplex_thread(void *p)
 		else
 			length = mid_entry->receive(server, mid_entry);
 
-		if (length < 0)
+		if (length < 0) {
+			if (mid_entry)
+				cifs_mid_q_entry_release(mid_entry);
 			continue;
+		}
 
 		if (server->large_buf)
 			buf = server->bigbuf;
@@ -920,6 +923,8 @@ cifs_demultiplex_thread(void *p)
 
 			if (!mid_entry->multiRsp || mid_entry->multiEnd)
 				mid_entry->callback(mid_entry);
+
+			cifs_mid_q_entry_release(mid_entry);
 		} else if (server->ops->is_oplock_break &&
 			   server->ops->is_oplock_break(buf, server)) {
 			cifs_dbg(FYI, "Received oplock break\n");
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -104,6 +104,7 @@ cifs_find_mid(struct TCP_Server_Info *se
 		if (compare_mid(mid->mid, buf) &&
 		    mid->mid_state == MID_REQUEST_SUBMITTED &&
 		    le16_to_cpu(mid->command) == buf->Command) {
+			kref_get(&mid->refcount);
 			spin_unlock(&GlobalMid_Lock);
 			return mid;
 		}
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -138,6 +138,7 @@ smb2_find_mid(struct TCP_Server_Info *se
 		if ((mid->mid == hdr->MessageId) &&
 		    (mid->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (mid->command == hdr->Command)) {
+			kref_get(&mid->refcount);
 			spin_unlock(&GlobalMid_Lock);
 			return mid;
 		}
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -531,6 +531,7 @@ smb2_mid_entry_alloc(const struct smb2_h
 		return temp;
 	else {
 		memset(temp, 0, sizeof(struct mid_q_entry));
+		kref_init(&temp->refcount);
 		temp->mid = smb_buffer->MessageId;	/* always LE */
 		temp->pid = current->pid;
 		temp->command = smb_buffer->Command;	/* Always LE */
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -58,6 +58,7 @@ AllocMidQEntry(const struct smb_hdr *smb
 		return temp;
 	else {
 		memset(temp, 0, sizeof(struct mid_q_entry));
+		kref_init(&temp->refcount);
 		temp->mid = get_mid(smb_buffer);
 		temp->pid = current->pid;
 		temp->command = cpu_to_le16(smb_buffer->Command);
@@ -80,6 +81,21 @@ AllocMidQEntry(const struct smb_hdr *smb
 	return temp;
 }
 
+static void _cifs_mid_q_entry_release(struct kref *refcount)
+{
+	struct mid_q_entry *mid = container_of(refcount, struct mid_q_entry,
+					       refcount);
+
+	mempool_free(mid, cifs_mid_poolp);
+}
+
+void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
+{
+	spin_lock(&GlobalMid_Lock);
+	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
+	spin_unlock(&GlobalMid_Lock);
+}
+
 void
 DeleteMidQEntry(struct mid_q_entry *midEntry)
 {
@@ -108,7 +124,7 @@ DeleteMidQEntry(struct mid_q_entry *midE
 		}
 	}
 #endif
-	mempool_free(midEntry, cifs_mid_poolp);
+	cifs_mid_q_entry_release(midEntry);
 }
 
 void


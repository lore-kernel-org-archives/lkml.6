Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeDEUaW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752018AbeDEUaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:30:19 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/20] afs: Dump bad status record
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:30:17 +0100
Message-ID: <152296021747.31027.11571535007053732032.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump an AFS FileStatus record that is detected as invalid.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 75554ee98d02..90aa3eb2c893 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -43,6 +43,26 @@ static void xdr_decode_AFSFid(const __be32 **_bp, struct afs_fid *fid)
 	*_bp = bp;
 }
 
+/*
+ * Dump a bad file status record.
+ */
+static void xdr_dump_bad(const __be32 *bp)
+{
+	__be32 x[4];
+	int i;
+
+	pr_notice("AFS XDR: Bad status record\n");
+	for (i = 0; i < 5 * 4 * 4; i += 16) {
+		memcpy(x, bp, 16);
+		bp += 4;
+		pr_notice("%03x: %08x %08x %08x %08x\n",
+			  i, ntohl(x[0]), ntohl(x[1]), ntohl(x[2]), ntohl(x[3]));
+	}
+
+	memcpy(x, bp, 4);
+	pr_notice("0x50: %08x\n", ntohl(x[0]));
+}
+
 /*
  * decode an AFSFetchStatus block
  */
@@ -97,6 +117,20 @@ static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
 	EXTRACT(status->abort_code); /* spare 4 */
 	*_bp = bp;
 
+	switch (status->type) {
+	case AFS_FTYPE_FILE:
+	case AFS_FTYPE_DIR:
+	case AFS_FTYPE_SYMLINK:
+		break;
+	case AFS_FTYPE_INVALID:
+		if (status->abort_code != 0)
+			goto out;
+		/* Fall through */
+	default:
+		xdr_dump_bad(bp - 2);
+		goto out;
+	}
+
 	if (size != status->size) {
 		status->size = size;
 		changed |= true;
@@ -145,6 +179,7 @@ static void xdr_decode_AFSFetchStatus(const __be32 **_bp,
 		status->data_version = data_version;
 	}
 
+out:
 	if (vnode)
 		write_sequnlock(&vnode->cb_lock);
 }

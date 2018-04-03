Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753747AbeDCVWf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:22:35 -0400
Received: from gateway34.websitewelcome.com ([192.185.150.107]:42645 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752495AbeDCVWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:22:33 -0400
Date: Tue, 3 Apr 2018 15:55:12 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] cifs: cifssmb: Fix potential NULL pointer dereference
Message-ID: <20180403205512.GA28804@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3Sxe-000Db2-I5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:53564
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcon->ses is being dereferenced before it is null checked, hence
there is a potential null pointer dereference.

Fix this by moving the pointer dereference after tcon->ses has
been properly null checked.

Addresses-Coverity-ID: 1467426 ("Dereference before null check")
Fixes: 93012bf98416 ("cifs: add server->vals->header_preamble_size")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 fs/cifs/smb2pdu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index f7741ce..e5ac474 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3454,7 +3454,7 @@ static int
 build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon, int level,
 		   int outbuf_len, u64 persistent_fid, u64 volatile_fid)
 {
-	struct TCP_Server_Info *server = tcon->ses->server;
+	struct TCP_Server_Info *server;
 	int rc;
 	struct smb2_query_info_req *req;
 	unsigned int total_len;
@@ -3464,6 +3464,8 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon, int level,
 	if ((tcon->ses == NULL) || (tcon->ses->server == NULL))
 		return -EIO;
 
+	server = tcon->ses->server;
+
 	rc = smb2_plain_req_init(SMB2_QUERY_INFO, tcon, (void **) &req,
 			     &total_len);
 	if (rc)
-- 
2.7.4

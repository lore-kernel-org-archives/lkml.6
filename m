Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqxkt/3AsG29uQw8FTigq5iP7iNl3DtHYxwT5USgyAZuQ3PsK/iNF3x76/1S+4dtNsH/20R
ARC-Seal: i=1; a=rsa-sha256; t=1525116507; cv=none;
        d=google.com; s=arc-20160816;
        b=OS9ycL6LSExMvFWZs438tmlgU8zYuwK0T5YthUPIpEJecLCURA6PODCW45Yp1CSq7d
         mb5fVK59s/IZxDkKMuJfGJV0uXgiCRf5RJVl1NeOJD9CThHl/XoLmQrNRgDQttOI+Deb
         X0yrAIKKoDztQT5ZFG55Wo16MSnZlxOZ8wawpRQbiGoTZLyDLe5TZ9YjJrMBCTx8guRO
         kfLf6OCq2AHFOJiuSLi3JY7UxUpTHet8XH4/gnceWVXJGpZPbjq29wE3Mdi3DtK/kYiV
         zjGc+Fi/nHHjtjknzfc1f9+VDTEfQ0n2zIS2H76Bd4Bh6rRD1s+XIURzW/o+3ijA+fgX
         szqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NZOK8a2W9sac1dxmndh2Limie5/EXA+pcqQmcoT1slA=;
        b=rd+rDDR8W5DskAnlOtr9ydxyiL8M7WpBneqiFAthB1hHlXZZwq0mb+KTvK1pi1SXFI
         2de2+qhkU1WXhpBKC/XQ5X2qlUOFKvKq+tpulK1QbVAgN6+GvxUdBu/xiK5kViQtNkqk
         JA+fQZ5l/EozNXIX7FgfhfkKi3gldVkoWVWblm/n1P+KGptItOJeGFkPMn9HL9Mq8qvt
         H1fhQCOKS3z88zQ2g7M5HK3cD6p9kQ1m9byJR/yXkK2Sq0lgQjr9ytFEQg/djjzqAT5L
         YJtg38aijsP9QVqwoQXUna3NACWr3lUDNT82PXi/3Uk9jmjOkSAVs7rqcp3BPpfcQKCj
         1xjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01A822DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.16 037/113] cifs: smbd: Dont use RDMA read/write when signing is used
Date: Mon, 30 Apr 2018 12:24:08 -0700
Message-Id: <20180430184016.617700186@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200566679902815?=
X-GMAIL-MSGID: =?utf-8?q?1599200566679902815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit bb4c0419476bd3982ba802f0f49de83cd79532d8 upstream.

SMB server will not sign data transferred through RDMA read/write. When
signing is used, it's a good idea to have all the data signed.

In this case, use RDMA send/recv for all data transfers. This will degrade
performance as this is not generally configured in RDMA environemnt. So
warn the user on signing and RDMA send/recv.

Signed-off-by: Long Li <longli@microsoft.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifssmb.c |    3 +++
 fs/cifs/smb2ops.c |   18 ++++++++++++++----
 fs/cifs/smb2pdu.c |    4 ++--
 3 files changed, 19 insertions(+), 6 deletions(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -453,6 +453,9 @@ cifs_enable_signing(struct TCP_Server_In
 		server->sign = true;
 	}
 
+	if (cifs_rdma_enabled(server) && server->sign)
+		cifs_dbg(VFS, "Signing is enabled, and RDMA read/write will be disabled");
+
 	return 0;
 }
 
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -252,9 +252,14 @@ smb2_negotiate_wsize(struct cifs_tcon *t
 	wsize = volume_info->wsize ? volume_info->wsize : CIFS_DEFAULT_IOSIZE;
 	wsize = min_t(unsigned int, wsize, server->max_write);
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->rdma)
-		wsize = min_t(unsigned int,
+	if (server->rdma) {
+		if (server->sign)
+			wsize = min_t(unsigned int,
+				wsize, server->smbd_conn->max_fragmented_send_size);
+		else
+			wsize = min_t(unsigned int,
 				wsize, server->smbd_conn->max_readwrite_size);
+	}
 #endif
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
 		wsize = min_t(unsigned int, wsize, SMB2_MAX_BUFFER_SIZE);
@@ -272,9 +277,14 @@ smb2_negotiate_rsize(struct cifs_tcon *t
 	rsize = volume_info->rsize ? volume_info->rsize : CIFS_DEFAULT_IOSIZE;
 	rsize = min_t(unsigned int, rsize, server->max_read);
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->rdma)
-		rsize = min_t(unsigned int,
+	if (server->rdma) {
+		if (server->sign)
+			rsize = min_t(unsigned int,
+				rsize, server->smbd_conn->max_fragmented_recv_size);
+		else
+			rsize = min_t(unsigned int,
 				rsize, server->smbd_conn->max_readwrite_size);
+	}
 #endif
 
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2479,7 +2479,7 @@ smb2_new_read_req(void **buf, unsigned i
 	 * If we want to do a RDMA write, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of read request
 	 */
-	if (server->rdma && rdata &&
+	if (server->rdma && rdata && !server->sign &&
 		rdata->bytes >= server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;
@@ -2857,7 +2857,7 @@ smb2_async_writev(struct cifs_writedata
 	 * If we want to do a server RDMA read, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of write request
 	 */
-	if (server->rdma && wdata->bytes >=
+	if (server->rdma && !server->sign && wdata->bytes >=
 		server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;

Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpXlINXcUVF5CQzGbXOUvfv+SlCf0QFy+zY1cwF2UIndQkNNRsTKA8OUZ3WoWeJ9pm0DAa9
ARC-Seal: i=1; a=rsa-sha256; t=1525116500; cv=none;
        d=google.com; s=arc-20160816;
        b=YI7zYx6FwU9Z2vlDb1KbmgkJuyK7EW9bdqjWajqFZoZ0Ql06I6r1Sh1hAHq6DqnD1z
         hMN5e2m0Q7asONQBTdDlhi0y2Yh9sOmQEahe4h2EY7VGxBnY3GkQW2X3QFs7Uterv8iZ
         Fp/0zMTZP1OH8bmZcQN797Imer9nUrlYh0KwoV+LWqiK2+Ad8bHAZdskz4fxd7TWddX1
         /pqVvcTuNQyAmrTvzYNdN8HtzunlPkn5DABIlad/IstSpSHykGYrrKuBZHvvuzsl8CXp
         /hMOSC1/ztDGn0BDiVTM6CmLIuApzA5GcZ1gJ3B1CU5RZS3FThrv8hK7smbl69onD8TA
         Jcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UYyAtUFuV6EMIiPrRzOMOuuAttxv/XfowVIykF3Sgeo=;
        b=kBNCMT427JJjQWzsK93zL7i+TzLXi/hWf3ViR/qKJWGIqeX6REQRfNv92ZqNy87pkJ
         M65oitc+hebGFcNpM+mb8OH47/lnh+yvxE06lU05gxvEWutAAFgm0PRliZc/aotyHre8
         URfxY9x82M4csHDz1BWS27MZB7V4gxJlacSGEr1SgYVmnaJGcWNLMhvFZEQopseNYpWZ
         p846vwloYfOo1WTegXvsDJOtznAVIRPV5Gi7ruELwkSBfx+8ehFdZaeLzhgyNPAlTAD1
         EX9Mgai7z8+ae5McMPz3L7/9I0F+OrB0arf39LQufnt759mibxKhZuRURyH3HXP/OPrR
         pUiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E31222E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matt Redfearn <matt.redfearn@mips.com>,
	Long Li <longli@microsoft.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.16 036/113] cifs: smbd: Avoid allocating iov on the stack
Date: Mon, 30 Apr 2018 12:24:07 -0700
Message-Id: <20180430184016.580365072@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200559945507697?=
X-GMAIL-MSGID: =?utf-8?q?1599200559945507697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit 8bcda1d2a79da4ab84162574eee2c9f6e1a12a03 upstream.

It's not necessary to allocate another iov when going through the buffers
in smbd_send() through RDMA send.

Remove it to reduce stack size.

Thanks to Matt for spotting a printk typo in the earlier version of this.

CC: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Long Li <longli@microsoft.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smbdirect.c |   36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2086,7 +2086,7 @@ int smbd_send(struct smbd_connection *in
 	int start, i, j;
 	int max_iov_size =
 		info->max_send_size - sizeof(struct smbd_data_transfer);
-	struct kvec iov[SMBDIRECT_MAX_SGE];
+	struct kvec *iov;
 	int rc;
 
 	info->smbd_send_pending++;
@@ -2096,32 +2096,20 @@ int smbd_send(struct smbd_connection *in
 	}
 
 	/*
-	 * This usually means a configuration error
-	 * We use RDMA read/write for packet size > rdma_readwrite_threshold
-	 * as long as it's properly configured we should never get into this
-	 * situation
-	 */
-	if (rqst->rq_nvec + rqst->rq_npages > SMBDIRECT_MAX_SGE) {
-		log_write(ERR, "maximum send segment %x exceeding %x\n",
-			 rqst->rq_nvec + rqst->rq_npages, SMBDIRECT_MAX_SGE);
-		rc = -EINVAL;
-		goto done;
-	}
-
-	/*
-	 * Remove the RFC1002 length defined in MS-SMB2 section 2.1
-	 * It is used only for TCP transport
+	 * Skip the RFC1002 length defined in MS-SMB2 section 2.1
+	 * It is used only for TCP transport in the iov[0]
 	 * In future we may want to add a transport layer under protocol
 	 * layer so this will only be issued to TCP transport
 	 */
-	iov[0].iov_base = (char *)rqst->rq_iov[0].iov_base + 4;
-	iov[0].iov_len = rqst->rq_iov[0].iov_len - 4;
-	buflen += iov[0].iov_len;
+
+	if (rqst->rq_iov[0].iov_len != 4) {
+		log_write(ERR, "expected the pdu length in 1st iov, but got %zu\n", rqst->rq_iov[0].iov_len);
+		return -EINVAL;
+	}
+	iov = &rqst->rq_iov[1];
 
 	/* total up iov array first */
-	for (i = 1; i < rqst->rq_nvec; i++) {
-		iov[i].iov_base = rqst->rq_iov[i].iov_base;
-		iov[i].iov_len = rqst->rq_iov[i].iov_len;
+	for (i = 0; i < rqst->rq_nvec-1; i++) {
 		buflen += iov[i].iov_len;
 	}
 
@@ -2194,14 +2182,14 @@ int smbd_send(struct smbd_connection *in
 						goto done;
 				}
 				i++;
-				if (i == rqst->rq_nvec)
+				if (i == rqst->rq_nvec-1)
 					break;
 			}
 			start = i;
 			buflen = 0;
 		} else {
 			i++;
-			if (i == rqst->rq_nvec) {
+			if (i == rqst->rq_nvec-1) {
 				/* send out all remaining vecs */
 				remaining_data_length -= buflen;
 				log_write(INFO,

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+06RXz5xaCv1GcZpissOM7Lrgl4Ejn2/VUa10EEoWnyCumvYwBUfBF6RyJT4UKalo4en7d
ARC-Seal: i=1; a=rsa-sha256; t=1524405909; cv=none;
        d=google.com; s=arc-20160816;
        b=V9cI536ZYlDDHv7wN4PYzCS+U8QrQWJ0MyCYHr8lPpxBdxceqejBCSJrhBbDN5Ypux
         NqeepWsIzMu1vzEeVr09W9osi5Mw3OYfSkngaK1o/4L+H4ZZvYTgiUuYkx4uVu6DsMvL
         zkeh9FdMqSdGA+vethWx7jQHOtI4kmerj7zrPfnHsN/qoUFtxW/TRk4XQotGOUuim6wk
         eGAgs4motLgrtOUV+XpUFbiUGZ/GZlxL6kx4FvkXo8bK3/0Bd+b/2WKg31MR9PDaOYrB
         XusU3nb+byZtb+Gbw9oRNkb8wr7OMrw7zaxjUTA1RDuwCv9Fjq4+U1Oq+U2IXCX4cGtm
         TpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PIYNv8bDmydS7UxA3W94HU7QSBAF5j9x2xlvq29NvvY=;
        b=bLKzfQgUwWSvlmAA+OJnWms2NDV3MLAYo0Jc376Q8b4FNluOoA62vhTc5Gb7XrsPrn
         ijYPfq833uoB1U+GFCB/hEflmXf+MCjxIuZLQA0yP2etS9Xm6pcDSdpS6KJwYk6p3X+K
         kSZakjAWGUSXrLlbjPfXlRAsleqxzOWGgxJMZ05DOS6BakWbIwtTSmWkIp8qUpLiMu29
         YsQfSOamMf/q/uO1krYi/oZNOhTe+EWyR9G46Zfz6s8gJKY1iVhlFkgM+lN8XdRiZR8a
         42XRelNVw2Jel/mDrf8EDNUTE7sWukoP7ba4BUduE0jquLb+VomajQgze4AkhR/bAc8z
         DYKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.14 043/164] fix smb3-encryption breakage when CONFIG_DEBUG_SG=y
Date: Sun, 22 Apr 2018 15:51:50 +0200
Message-Id: <20180422135137.175002018@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455002136448051?=
X-GMAIL-MSGID: =?utf-8?q?1598455450888982865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 262916bc69faf90104aa784d55e10760a4199594 upstream.

We can not use the standard sg_set_buf() fucntion since when
CONFIG_DEBUG_SG=y this adds a check that will BUG_ON for cifs.ko
when we pass it an object from the stack.

Create a new wrapper smb2_sg_set_buf() which avoids doing that particular check
and use it for smb3 encryption instead.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2060,6 +2060,15 @@ fill_transform_hdr(struct smb2_transform
 	inc_rfc1001_len(tr_hdr, orig_len);
 }
 
+/* We can not use the normal sg_set_buf() as we will sometimes pass a
+ * stack object as buf.
+ */
+static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
+				   unsigned int buflen)
+{
+	sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
+}
+
 static struct scatterlist *
 init_sg(struct smb_rqst *rqst, u8 *sign)
 {
@@ -2074,16 +2083,16 @@ init_sg(struct smb_rqst *rqst, u8 *sign)
 		return NULL;
 
 	sg_init_table(sg, sg_len);
-	sg_set_buf(&sg[0], rqst->rq_iov[0].iov_base + 24, assoc_data_len);
+	smb2_sg_set_buf(&sg[0], rqst->rq_iov[0].iov_base + 24, assoc_data_len);
 	for (i = 1; i < rqst->rq_nvec; i++)
-		sg_set_buf(&sg[i], rqst->rq_iov[i].iov_base,
+		smb2_sg_set_buf(&sg[i], rqst->rq_iov[i].iov_base,
 						rqst->rq_iov[i].iov_len);
 	for (j = 0; i < sg_len - 1; i++, j++) {
 		unsigned int len = (j < rqst->rq_npages - 1) ? rqst->rq_pagesz
 							: rqst->rq_tailsz;
 		sg_set_page(&sg[i], rqst->rq_pages[j], len, 0);
 	}
-	sg_set_buf(&sg[sg_len - 1], sign, SMB2_SIGNATURE_SIZE);
+	smb2_sg_set_buf(&sg[sg_len - 1], sign, SMB2_SIGNATURE_SIZE);
 	return sg;
 }
 

Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoWkCJ3PEZn2e5XPS7JsxXJMNROIeZ60kyj+ad3hmMiLF/jf6Yl0BFBBLYWq9nZbG32ScMr
ARC-Seal: i=1; a=rsa-sha256; t=1526281031; cv=none;
        d=google.com; s=arc-20160816;
        b=F7brFsyzjwo/waXHPNPH0gvBrFpw9RO33MqdLRgLLZ9aOl2G81ST8ryEzdSz43l2eZ
         p2fC2VKTxPNp1qMWOYNU8YgelFVMnysuKLE3BQVm0KoE99Fdvv94vCCt1eBS3wmfNLm1
         s8IW6A3N2tbTVdvzIkS4Uyf8t52l0+3w+FQPw6YqAAZ0phAOk5UkLdftT+SRIUqalJ2n
         bPme/fQ1XKXXVSZHyp1b2WQg82jktglUizYnq8M+jCYg5JS/j6PMQRl7Lq+NMbq1SPFu
         CtLXPQyKvikb7wodGoZ1zCNIcGlyr3CnhEqrRBSgq/StqjFhTQ37IV/0+Y/nVTgARpUe
         YGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ffFH83pEkIU8RHDkNFvgD5JAInJD66XuuxUQ4j5ePj4=;
        b=SOK7xxxHGmeTt1e6+L69xzcBwbCwkmlUNi03S8zaVUzc0woUurc0ykBEcj0FFsfUtW
         xiUrt7w3Fyf0iNgNsRuCULFexb0RDL03mfnGdpj9Tdym4LaR9zGFM7A8ajAaiGFWtLd/
         641YX3KJW9NNxrHnaptM1WdccXkWu/JAUru6M6A4+NE97fLYef8KeKE7Jkw84D5GQaxW
         +zw6I9Ecva7ZZunH+kQVWvAdVxMKGxK0I3JMR84uhZOXSHZ8e3C2JudZ32zCULs528WM
         z5bpuZlYXkmIDK9q9durLUrTdyKg7/aZr7q/he2z+QM8OYUCHBBAIdPdRq5VS0JImo9Y
         Nzww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wYDB/0eB;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wYDB/0eB;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.14 53/62] smb3: directory sync should not return an error
Date: Mon, 14 May 2018 08:49:09 +0200
Message-Id: <20180514064819.435588113@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421658029253120?=
X-GMAIL-MSGID: =?utf-8?q?1600421658029253120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <smfrench@gmail.com>

commit 6e70c267e68d77679534dcf4aaf84e66f2cf1425 upstream.

As with NFS, which ignores sync on directory handles,
fsync on a directory handle is a noop for CIFS/SMB3.
Do not return an error on it.  It breaks some database
apps otherwise.

Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsfs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1045,6 +1045,18 @@ out:
 	return rc;
 }
 
+/*
+ * Directory operations under CIFS/SMB2/SMB3 are synchronous, so fsync()
+ * is a dummy operation.
+ */
+static int cifs_dir_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	cifs_dbg(FYI, "Sync directory - name: %pD datasync: 0x%x\n",
+		 file, datasync);
+
+	return 0;
+}
+
 static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 				struct file *dst_file, loff_t destoff,
 				size_t len, unsigned int flags)
@@ -1173,6 +1185,7 @@ const struct file_operations cifs_dir_op
 	.copy_file_range = cifs_copy_file_range,
 	.clone_file_range = cifs_clone_file_range,
 	.llseek = generic_file_llseek,
+	.fsync = cifs_dir_fsync,
 };
 
 static void

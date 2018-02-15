Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2264AuADaKvK57V0yklDIyRb2+qO0sAFex+hSruzzIU353etkep8dhzqHmip+GuE/LzT9UGt
ARC-Seal: i=1; a=rsa-sha256; t=1518708364; cv=none;
        d=google.com; s=arc-20160816;
        b=QadBAospZo86zoHoMZfUdvyINYnS/MWgXh53NBrdr7Z20fyn6Ae0Afi0XRfuNUXelV
         mZFdDjjrGuk+qLWEddscMko7UpWfov5aTIqOQFeiTSOMQ3Xvl2Ti8UPuRqUjDHxSp30S
         ZsRs2iXfcaf8/xKOC4nMRrVoSQ8nwEzT7JlBek+rZOtekATTdou+opG7MWvf7XoaWDhi
         r6Az1u6B5nn8QaVxHr9NH9rm2LzP4Q4vtQVRQ5Aw1LM1QeWaVodueGw7DuOfnnNJMvgf
         0ix356PBM5vJoPIylbzBaTzf7Ff/33Ex8kitUQAzxiLx0kAfu0M9BDw19Dwr+iuHH3qr
         LYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yicYBpa/+EqMBtepcWCnuvvYYB9PAwvZsLkfYCotYzM=;
        b=uRBgqACusff4rli/PjG4BCzrz0HulGrrF7X2gD7fRI3u8q2emIqFt1i68gC+eqHe+G
         FQ+421EglE7DkHahhyBSXbQBwWEAGNubGq3tNq8EAS7sBInxoRNyuF0YnCEHC9wCVKcp
         Um1eNYnQ4H/NbP84Uzb4HQn0tNX0Fypc0U4ZW36hzn0SEXzOQML0BmZm7zHa91lAYz6n
         35LVAcdr9OaMJppcpM668wM/gB6h7eEjVrwcidbZG7RBO7oqc1Cvm8USZIXqf2NaMGkf
         /XSucqEpWP9yVqmy+2w4kmYvDmEDv6r5eRfpwiSdPprX83T7Z/iIN80GFbn0TkZztEyS
         +68A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.9 02/88] cifs: Fix missing put_xid in cifs_file_strict_mmap
Date: Thu, 15 Feb 2018 16:16:29 +0100
Message-Id: <20180215151222.778686350@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480676888603545?=
X-GMAIL-MSGID: =?utf-8?q?1592481142332717629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit f04a703c3d613845ae3141bfaf223489de8ab3eb upstream.

If cifs_zap_mapping() returned an error, we would return without putting
the xid that we got earlier.  Restructure cifs_file_strict_mmap() and
cifs_file_mmap() to be more similar to each other and have a single
point of return that always puts the xid.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3285,20 +3285,18 @@ static const struct vm_operations_struct
 
 int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	int rc, xid;
+	int xid, rc = 0;
 	struct inode *inode = file_inode(file);
 
 	xid = get_xid();
 
-	if (!CIFS_CACHE_READ(CIFS_I(inode))) {
+	if (!CIFS_CACHE_READ(CIFS_I(inode)))
 		rc = cifs_zap_mapping(inode);
-		if (rc)
-			return rc;
-	}
-
-	rc = generic_file_mmap(file, vma);
-	if (rc == 0)
+	if (!rc)
+		rc = generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops = &cifs_file_vm_ops;
+
 	free_xid(xid);
 	return rc;
 }
@@ -3308,16 +3306,16 @@ int cifs_file_mmap(struct file *file, st
 	int rc, xid;
 
 	xid = get_xid();
+
 	rc = cifs_revalidate_file(file);
-	if (rc) {
+	if (rc)
 		cifs_dbg(FYI, "Validation prior to mmap failed, error=%d\n",
 			 rc);
-		free_xid(xid);
-		return rc;
-	}
-	rc = generic_file_mmap(file, vma);
-	if (rc == 0)
+	if (!rc)
+		rc = generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops = &cifs_file_vm_ops;
+
 	free_xid(xid);
 	return rc;
 }

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227t+xQ2D7MboUZzgIE4E7lUlIQd4afjLf9Qvv1YwrvrYOo58ucFeXiof9XFWB81aC9+TBDZ
ARC-Seal: i=1; a=rsa-sha256; t=1518709137; cv=none;
        d=google.com; s=arc-20160816;
        b=rUjOO9sGRoUbmJUU9pBMJnlBm0J2t4ltfpGj83QRFiJjKQ7P7ZPKl5pFHNbqyp5q93
         b29yvfJgqchggy5GNZgiAYYqAEVWFVPGgyZ7Qkd0CgVzqAYra3mfLlcifYkuDBcHJs4R
         DT0mAkbRawjK8ul7fWhomPKQodB8w4Phm3hs22Jsn+QvvhwL7yzWS460c9PDL9o3x6sI
         konu03NDzsNzhSzfeBgYcw6qgeD9z7QyqNyHJflhjX+3fX6C5RrxZ6hpbENYU3UNCsAN
         7mtdk+5IfPLLqD7EMLpeYyxmQ+jHq2vIwQH6ayXQuU3xgPz+Hr9dPZbrGsU6oJY/PyXT
         7r3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0o9b27m69hLhs80A6ncpopSqhM5iNjDvgzGHFs9AA1k=;
        b=UsT4kvan5pU7kv91RqaGfgSTs4z11RkXz9NKmgf0RQc6f2K7sWkYlojbY0ZBv72bdF
         j89Yq68PUGToSvn2mFdGAiQmL3BabD6zE7c4/CzDqJPc39m+xqdJFpiKwDW5QQnfeT7Z
         otdHbbG2MuliogFmG1NfltjQfjk5zpkWZXwLpe7EzgMJ0gAxZB0IH2leW27fhqVpgijV
         KWKua/KDyuumto+NQ6E5urD3ULV/vJu6QTa27u9++z2yTqXgaWPBWy+Wwdx4qJ2B77Dg
         TH/TOO9QF+q7r0hmFd9bcSERIobPr2w/yWm+DUZDuooMNrPt8vOO+fbd7Hpc7c7UrW/A
         QZ4g==
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
Subject: [PATCH 4.15 002/202] cifs: Fix missing put_xid in cifs_file_strict_mmap
Date: Thu, 15 Feb 2018 16:15:02 +0100
Message-Id: <20180215151712.895834141@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480676888603545?=
X-GMAIL-MSGID: =?utf-8?q?1592481952986844792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3471,20 +3471,18 @@ static const struct vm_operations_struct
 
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
@@ -3494,16 +3492,16 @@ int cifs_file_mmap(struct file *file, st
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

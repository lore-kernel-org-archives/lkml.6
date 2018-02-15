Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224/3Z08dyaM48ZEbdIUFPgekJoZf2aixo1t6vLF7sSEpjPI5/RGcBxtLbeqxvbk/MHc0Czu
ARC-Seal: i=1; a=rsa-sha256; t=1518707921; cv=none;
        d=google.com; s=arc-20160816;
        b=i7hrmMdKn86RY854o6Be9zlcX0AcrcupcEiB8X+bIjJNjRLGJVQNjDWrgNR6ATUPPM
         +N581IpUSFyNiQNiIplAHa/9gI679itWTGajQKWen3Uq2+PSu3HHT6AeppDfB2+YB2+c
         m0KwIpFOzPqRmBVBP7BTW8rivlYy0wK7yEh+TfTTWm8QOWToZwkXNjEILpvPZP4touog
         +BzPdjHuVbzpu8xzchpBd0gK6Fowb/EeIavnwLV1T84gPOpzSevdvABHhBqIvT1xMIhs
         ob7/Lt+pVBFBIT24Jxe0jVBDYJfdWVxzj3MHXKkkr9D0Ijquhk2WOnbwUyyQLhHN4WJ7
         iYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AV5EAT+15a/FjtzF/IGutP9TVW4mIE0BW/2G8B/Y6l0=;
        b=uXu+t69i3S1MDYKWMQW6uPrat69U5ktq3jeJuKMXGemRDXbI7tjOq8LntP2180cTK/
         dKdOs9AZo8N7rXdcnZBeOebROCgz1TC8a3i0hL/yt4YLp74ZGc/D3MpWl8yTD2pnnnNN
         7gHJrhmIdgK+Sdn1kr1i8qXgx2/T2G7Jav0jru+UoM524rDoofvAGz/1oECg0VpwyVu8
         RCG7oVesboZBwG3kn7JUNsGvxckdKlovjHDElzRqhJnmWvt1S/mAtMuZn2U2HnumbGzH
         dDQcAvq7HcGkOnO1rjLJyVNSAvAJx7FTgawKzErmK4awuPPYjxgExS9qXwcktm+2QN8W
         6U+Q==
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
Subject: [PATCH 3.18 11/45] cifs: Fix missing put_xid in cifs_file_strict_mmap
Date: Thu, 15 Feb 2018 16:17:02 +0100
Message-Id: <20180215144118.213061765@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480676888603545?=
X-GMAIL-MSGID: =?utf-8?q?1592480676888603545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3261,20 +3261,18 @@ static struct vm_operations_struct cifs_
 
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
@@ -3284,16 +3282,16 @@ int cifs_file_mmap(struct file *file, st
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

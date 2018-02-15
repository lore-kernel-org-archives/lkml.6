Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ZC8XDAjp/3NbBhqVoYv/RXbNtJ9orhBokvLhY/VVS5b0uIb1Yt4oU+gwSlVyVTCS+skqI
ARC-Seal: i=1; a=rsa-sha256; t=1518708845; cv=none;
        d=google.com; s=arc-20160816;
        b=Jul5bX4Ziuu98HDd0oArY5Pqvgm1Jct9bTUDspbwgntNT1lg+iqcenma9rmFST+N6R
         Xmiei8qbGjM2Vjqo5LuUy4VyRS9wlX1FoefFIUwr4fC5hCgOsq8+8nGPx17mwjMvM0O4
         ZbGCM4NrmOs8ySy8SLUT0wHK0zNB/EnrNski/C8EDvEmVFN1dHiOXXcQrCjgJMgQ6aj9
         4m2umEs3JTGdAdsQ5vmpwK0350fTUIf8M6bbpzUeQeb80eWucKyStQH8CAFdkZIgThAt
         CkCqHWV2NyLn6LH9ZRmJIAl4L1nPuEZPAwhlqHUTaJH0m1skcyYZLWoSPcyps8+Pweut
         S1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LpZReAYB2gy+n8L+lbA/BnCLqnexoBC10r89rdtc0QA=;
        b=ukO7UUsrdbJm8kHzYq7PXaS/3UQJgogGFPEr1KgLDPlvZ/BIT+EFRcBa8dp6hMJAjM
         OSp/X1VGiwCGdzBxJQI2uI+hkM8dsHwT4MvJlcazGnHRbg5j2AgbIH9EZ7NogEmFZAvc
         fF5ttqdU7jD9ekPK0nstr/ROCZIdyYzt/WOobmHpWVTpGiPjkFB+k55UujM7YbE45Tk6
         8W5WU1f3TmT2ApWIecmesBVp7MGonymlE5y05BB6Ndu9AlKiGWDOWIcsMrV8VZaSYbGC
         jWHK3nMlA66SbWuRDgXLkaKUtc270AqKvxj7CLrwKttvUCvVdDZpGj5yMQol4t9+s7BT
         HxdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 102/195] ubifs: free the encrypted symlink target
Date: Thu, 15 Feb 2018 16:16:33 +0100
Message-Id: <20180215151710.794958655@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481646014393123?=
X-GMAIL-MSGID: =?utf-8?q?1592481646014393123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 6b46d444146eb8d0b99562795cea8086639d7282 upstream.

ubifs_symlink() forgot to free the kmalloc()'ed buffer holding the
encrypted symlink target, creating a memory leak.  Fix it.

(UBIFS could actually encrypt directly into ui->data, removing the
temporary buffer, but that is left for the patch that switches to use
the symlink helper functions.)

Fixes: ca7f85be8d6c ("ubifs: Add support for encrypted symlinks")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/dir.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1216,10 +1216,8 @@ static int ubifs_symlink(struct inode *d
 		ostr.len = disk_link.len;
 
 		err = fscrypt_fname_usr_to_disk(inode, &istr, &ostr);
-		if (err) {
-			kfree(sd);
+		if (err)
 			goto out_inode;
-		}
 
 		sd->len = cpu_to_le16(ostr.len);
 		disk_link.name = (char *)sd;
@@ -1251,11 +1249,10 @@ static int ubifs_symlink(struct inode *d
 		goto out_cancel;
 	mutex_unlock(&dir_ui->ui_mutex);
 
-	ubifs_release_budget(c, &req);
 	insert_inode_hash(inode);
 	d_instantiate(dentry, inode);
-	fscrypt_free_filename(&nm);
-	return 0;
+	err = 0;
+	goto out_fname;
 
 out_cancel:
 	dir->i_size -= sz_change;
@@ -1268,6 +1265,7 @@ out_fname:
 	fscrypt_free_filename(&nm);
 out_budg:
 	ubifs_release_budget(c, &req);
+	kfree(sd);
 	return err;
 }
 

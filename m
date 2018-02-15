Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227BELGrYWeMFJ3c7AOfYajAkz1DgihfAExNsJqxY/dZSaoL+/5aCtHM/lemDf+/0ooKj9j2
ARC-Seal: i=1; a=rsa-sha256; t=1518709372; cv=none;
        d=google.com; s=arc-20160816;
        b=IbwuRCENn7+d/B1n8dtR5YKMWOlrsFtSPKWvb9eXKPrDIouNswEblgxUCkHKDQsM0a
         LSbwK/dJQ6Fey/2bkVeyvvjRacnLXnhmPntNGs78c77fkaoCAE1D3MHRLIYrzhZq4Ixv
         w0ulDft9ljvyvriCuFkc3HZ9YBfm1K7XYaXx4nUcF4f3MUuu9aL7tibR6iCq8EvgKxTH
         8TolkB3X33/tJC0TmCSmwKRqcOEhvD3y2YhpoJfVamgIODr6JXg73yfSXSQW9h3SNk9I
         shE9SRJQOUQOtpqMxNO5H6TK/AgXPqfWmdKHhcl83n9ecZGXFy6JrO3atClU9AQjM7GZ
         oUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mvGFAPP/yRCn+y1x3vuGQlzzNMKm8xEgGRUj8dGTDAI=;
        b=bClhw4WQNiFlC0xkcxbu2lvBvblTrtg9tePdpY9JBSDzL4Phd+6E8BJG1vubhiHreP
         W271/a+7RnDlJeQXUNn45VFclE0+gN17e8LNZEmv35/jz6czVFNIJdMx/X3RlZhfKOOe
         2QHkEExLlN+RZCmdok4P7q/+ocGZKqn7G1V1z5DQW9Cjy/WekO2H6M8OeVHAet6PdXRO
         Q4Bs632gX523dRIzydD6DaSY9WJk5gsw51LLpsuleMwbnr7T62JTOfHoegPCEJMERvBh
         D5fxGIO0HprB1TJs8KweDj+kywFgpLDy/pC9pcmAvIsTfnTifGZkvDSoSDL83lu6Weky
         y6ig==
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
Subject: [PATCH 4.15 095/202] ubifs: free the encrypted symlink target
Date: Thu, 15 Feb 2018 16:16:35 +0100
Message-Id: <20180215151718.347947986@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481646014393123?=
X-GMAIL-MSGID: =?utf-8?q?1592482199265160714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 

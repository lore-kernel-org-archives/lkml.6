Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2263yj/fwc9dTL5tZtfpg4ZO1RRfIGqtFU7GliHyD+HGi7hK/QAaKm9/gfS9A9VCxJ2ZLc6R
ARC-Seal: i=1; a=rsa-sha256; t=1518708310; cv=none;
        d=google.com; s=arc-20160816;
        b=bYT6Q5q+lG2WhC+2vPX3mhyu1cXTouEtz+y7JrPx9xpLDok1rkBpyG4obWs197T1+4
         eupBTQjC8tBC2SGpYT+3yl+CA/qr43UlaVBRolGRhpEHHk/PEpFYXxZ0eqR0BDQYu/5u
         bHJAMipVv7PgkKMIR5Bz4tZh3zMCPWXGKcXT0L8Tvbd/ruaGEGxtpgDgnJI2suwvzz5v
         NjxivG/5ln8Babqb/VpqAjjCBzVRWk1cAhpzem0JBW0pzoWBCozFG6h0kcC3yBouGLYw
         LUrwfzlp3uXUIC/e1qOITLmUEgnU0Q2QBP+wIm0zcH3wFL9EaIR1RWHzvwBonUCzHoS9
         f68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ynFsxpRuqZg9DQ0mshmxsoSkEuMPdMP7Z5UF6d3Szks=;
        b=Vh+Wa0BC1PnPqHzYk/gRpp1aT0awtBr1bAhRoeAaJcBdo1nmjV0+gjEpPsczMi/LV6
         ufsvDVtdJ6nQQq/j1G5yuuBYlkg1VRG9v/CgqSODd9682ySNyE4sMmsFurxFdM87k0Iz
         G7NtvAxfQ5o4GfYm00G2KVnmtb5PyPr//q/sAIWCqRd8LOguLT16Im0GtxMmOlxVu5KC
         9+1SrMHLqKC5U/a0jYPBToKay92YglwdjZ0j+PtbQZoDZJtVuySfGhz3aLLYp0PlwFmb
         pWCGZufSXnhuGwp8CttqATpIbdwGtx0QYT8brrHiH+BrjwWQtRK2Jdsw1dtCKUyqCBVf
         pJkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Raphael Hertzog <raphael@ouaza.com>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 106/108] ovl: fix failure to fsync lower dir
Date: Thu, 15 Feb 2018 16:17:43 +0100
Message-Id: <20180215151237.052435531@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481085875936301?=
X-GMAIL-MSGID: =?utf-8?q?1592481085875936301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit d796e77f1dd541fe34481af2eee6454688d13982 upstream.

As a writable mount, it is not expected for overlayfs to return
EINVAL/EROFS for fsync, even if dir/file is not changed.

This commit fixes the case of fsync of directory, which is easier to
address, because overlayfs already implements fsync file operation for
directories.

The problem reported by Raphael is that new PostgreSQL 10.0 with a
database in overlayfs where lower layer in squashfs fails to start.
The failure is due to fsync error, when PostgreSQL does fsync on all
existing db directories on startup and a specific directory exists
lower layer with no changes.

Reported-by: Raphael Hertzog <raphael@ouaza.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Raphaël Hertzog <hertzog@debian.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/readdir.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -441,10 +441,14 @@ static int ovl_dir_fsync(struct file *fi
 	struct dentry *dentry = file->f_path.dentry;
 	struct file *realfile = od->realfile;
 
+	/* Nothing to sync for lower */
+	if (!OVL_TYPE_UPPER(ovl_path_type(dentry)))
+		return 0;
+
 	/*
 	 * Need to check if we started out being a lower dir, but got copied up
 	 */
-	if (!od->is_upper && OVL_TYPE_UPPER(ovl_path_type(dentry))) {
+	if (!od->is_upper) {
 		struct inode *inode = file_inode(file);
 
 		realfile = lockless_dereference(od->upperfile);

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2252sokRGqsD1LZbv1f5RBD74LBwhznHWHbqVf66VR4iC/2pNzu+gBbfX3I9uXzRhHuAqCVw
ARC-Seal: i=1; a=rsa-sha256; t=1518709652; cv=none;
        d=google.com; s=arc-20160816;
        b=POHpNpuiwauVTCZlOpXAKqoCJ/o7VaVDdXlGBnSD+nBUzDv9zkGb3h/LU5oaAvnG9l
         HMOFqhftMIyWBVW+1c1U8SdyGEpjc/UzdkMeAcfv/ZGV9/yAdZj/U3/K9MiggkX/flbq
         ZW2mgH0C7O5EaXZFcyTwAdnoIJhnfxhleFQYZLGzcx+rNfHNO47KZW9tZBXAmib5Hu5h
         tYxhIzHtnpkENSxya2hhhSQTr7AYOHp2yH5VQ+emRzf5vsPyM71eFzMSbW/q75w/CMsw
         1hiDMPpo5DqiMSUqPV8tXQ1FQ4KKegroMpbTET/zwqOFBRpwxm4zwT/yusFvAMKeel7n
         eLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KQr0z9vp6eKGO7CHxIBDaH7OJRzTAeB2ly7Dmi26uXU=;
        b=SSYexlXaDwbqpLneyC0RE6ck995WQa/w2GonBWVt11Ip386a7H3ZAjEbWSbDBVRP+j
         hbj2xtujsglRE5FUtyuTXzBrwr7KfKIYoaWMEBZcry2ltNPHJ1A81g/7TebGYnEleJts
         FQUEZqCQ/lWAMc5eknaVUxpmi0NZuq8WnI4ZpEJ4kul/wxHxH8Z+2zGMSrKn6O200DON
         GcpPiT2qR+HEpy6ndrM6PmjGsudsS7p+OAYLSS4u7A3Q3zCjJRxI4eB1uTBncU2mYoyC
         od2I4DVmyq3xPoWsMAnb5+M2EA+OPyHIOkxH+A8rrTLgNj95QB83tcCa8qarUKL0NaGc
         5PIg==
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
Subject: [PATCH 4.15 193/202] ovl: fix failure to fsync lower dir
Date: Thu, 15 Feb 2018 16:18:13 +0100
Message-Id: <20180215151722.802240019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481085875936301?=
X-GMAIL-MSGID: =?utf-8?q?1592482492195650512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -769,10 +769,14 @@ static int ovl_dir_fsync(struct file *fi
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
 
 		realfile = READ_ONCE(od->upperfile);

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224/jW9UptW/zGb/RcXGFw8+AlZjnQkUiltw0t3Sr5E6HWSWBcfJeUEYHgcbHkDM/U3xd7ZV
ARC-Seal: i=1; a=rsa-sha256; t=1518709094; cv=none;
        d=google.com; s=arc-20160816;
        b=TtHKC+voQ7mkKiPKeiKMEfZZkti8QBNPK4x5yiJZ7QlFYpmxH3lB0iiseSrWuqhFrQ
         bedAs0FmW6I4PD1JiaQwgNNa9Fydo1jwlgFRzi0oRY5cw7TRDGgLIL5usq6RxICsYMbb
         haJ9rPfOgT693anHDNTJhmZGN268pWL/0qr1xkHp1kzzFRKGYtzOkOR+y9mu7w/y03eb
         QW9T31tajHgJfCch/ysPm01Hhlb0JR9Vi6WLU8cX9viJCrq+NlMNeyJF2Kf2zH0hpvoZ
         C3U2fantWQCn2puQZWMZ/rW8MkwSvW1NHK7TJXpLvHcXR7hFjydusSGmMQAUU3F3mh1g
         HHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ggp7hr74LX7pHB1D9oUF+MwkM/SWqM9RCOeRs/93Op4=;
        b=Vi8UHHXN09sDBL8PYdcOw4L/B3tda0W0yN93OHhdiL9wcJn0tRLyhz5IV7+DewwOCL
         IupXa2sphYdSOk6dwAxW4CyYm20PTahG2bBMOkYmnF5+swqNd0MjCsFxXcBCmgLFH0Gv
         yJ5bmc8LcmzT2gOoIS7eIGD5C15OuRwiThB/yFidzvY6FiVLY/BKloNT8u6tafWoybfh
         GSHYcNwK0gpISDA+9OR872Tae3or8WvorMh0Qho0uqZTIKgTpiV8VesxJizKN3g7dYna
         7STNZfS3S263Twlwn+MFc5owC85NcjRAh0z588OBgffit4QT+kTT+5kfkrzsmr8MkRrE
         Y05g==
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
Subject: [PATCH 4.14 188/195] ovl: fix failure to fsync lower dir
Date: Thu, 15 Feb 2018 16:17:59 +0100
Message-Id: <20180215151715.700123636@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481085875936301?=
X-GMAIL-MSGID: =?utf-8?q?1592481906841844745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -751,10 +751,14 @@ static int ovl_dir_fsync(struct file *fi
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

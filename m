Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrwfXEUrbQ/ZZVLgbRPQe4PvAOZavt3S7UYzYW3pieIow9/HaiZhFD4KX6uHiCYq/A16j+/
ARC-Seal: i=1; a=rsa-sha256; t=1527157751; cv=none;
        d=google.com; s=arc-20160816;
        b=UHr9Jt8rwsrvouxR4wT4Wt0cXNZ+74h1F4q0fNf352f8MiuO3VUP9T4kft12GfUjH2
         K6E7f9cVYEb3iUquLgk3XcXNvUEdveyS+lUR8DgIqfexjRLk5qikIz1FlI863gAE6wJE
         akA/n1IYRos0CFresKroFwESgUO4fDqNgvIge4JrfKKbaasjk8Xfr6I74iGqXnpN8ivK
         FemKKMWKKnTkjKXVOpKc7m7dOk/GnBNCAavQRBs89fFNrydX+4FhsV4xq06ctuEJSDPH
         sJaatB8piXsS1t1iC6WxSbWTS3Wbgh7z4rtJ9/FcIGS+H6zYviHN6gCZd2twNCif1rdX
         NgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=yY+ofUSgldrphUKQ1XGAOk4KsZ2IovRzY8YpE9BOqVg=;
        b=V5d8KNgn7v1nTKgmbhKtlTA6d1zit4Ei27MFVXzHh4bF5JhOsUa7zV/pZor+6qmya5
         BaznmABJx0b6Rs1wUUKcEyWzB6yZiWrUDRBdMu7PtewP3uF6lU7Zdo+nIU5Ye5cA2fZa
         v/y2Mv2KPWW1qWNvS7EzNBJd9xvXYBJpOlujRYiaSFpZ6I8AYbJ1o2D2KG6xVdT94AT2
         u8P72X+pj5j01MqbCsCH2vHoUze+nDt2n4TTQIxZ3Q2HVhZL85IRo5OtPtrnL9ngwjCY
         FFAv+mizgMFnhc9j+/XeGbFd5KFfOVnedk5IPDr9rs0qClrDDJ12IhWih/PaWOrQ75ax
         7qNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EWfPtR1F;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EWfPtR1F;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 08/96] ext2: fix a block leak
Date: Thu, 24 May 2018 11:37:51 +0200
Message-Id: <20180524093606.086245224@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601340960342171264?=
X-GMAIL-MSGID: =?utf-8?q?1601340966305248543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 5aa1437d2d9a068c0334bd7c9dafa8ec4f97f13b upstream.

open file, unlink it, then use ioctl(2) to make it immutable or
append only.  Now close it and watch the blocks *not* freed...

Immutable/append-only checks belong in ->setattr().
Note: the bug is old and backport to anything prior to 737f2e93b972
("ext2: convert to use the new truncate convention") will need
these checks lifted into ext2_setattr().

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/inode.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1258,21 +1258,11 @@ do_indirects:
 
 static void ext2_truncate_blocks(struct inode *inode, loff_t offset)
 {
-	/*
-	 * XXX: it seems like a bug here that we don't allow
-	 * IS_APPEND inode to have blocks-past-i_size trimmed off.
-	 * review and fix this.
-	 *
-	 * Also would be nice to be able to handle IO errors and such,
-	 * but that's probably too much to ask.
-	 */
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
 	if (ext2_inode_is_fast_symlink(inode))
 		return;
-	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return;
 
 	dax_sem_down_write(EXT2_I(inode));
 	__ext2_truncate_blocks(inode, offset);

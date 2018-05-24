Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrXpe2t9q61/KYuH31NcqTGP7jFlF2XdxNQxYChXdaWbM0gsCCE07xXyrEz6h2UXQO7iHcz
ARC-Seal: i=1; a=rsa-sha256; t=1527157754; cv=none;
        d=google.com; s=arc-20160816;
        b=Z66Rj9L1f1HHI4dJnvnh3yD1wvSmO2wPnx1UMBVDT2+257JiB4CaPnsALAoT4A8oGg
         H8SAt/oill5ICwvssP/BiUlguFJLObSUae6m2G6YYHCdJlq4xVgVWqayE1FbUJ8Bz6/H
         9pkOg4sIOldPmo/6B4UQS5HxfwC2baxxlhSolTXumfeeKySrJU+Vln6BO3fLCC9bVQY2
         AZ0VKVZuL9unpZUiPhCtD5+zuVKg0r/qoVf76u1alwwejz5mXtHwVzcy6E/kKSA+Aa37
         ODVucXdzqTYNLx6TryDVDKOLFrj3CINFKqcqUX6dLrEdaIPKPufu3cYnYcJ3YK7luINe
         PBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HGeW5hPNPp4dBzJ0NeAMAkyaIkRma5dTtDTfOyHichY=;
        b=J0U3FDmoKl0PjFnXtLx0NUJivw8Z/1LSF7ZUk9SLl9LguaRwEoKThGho1fxgCq9Zdb
         XbTZnS6gmGaoJpUvWkShBg+pIbuMv7xd73GpZJmTWGjlG+IMKhDeTjD1jjVdw2X2SMwf
         d+DhQcldZu7ZZXfgl0T8AHihFFC3yyub38BnC5xBeXSxIh0krJ8mVGrWv5EBUgci7O+A
         6k5BpYR7QHzmoo0Jvpqng4C6ETbw2xcm+xGhaiR06XAP+tcL97NF6sd2mAFGD4hkhztv
         pPfV6ySa9jihSG7nCs5M/NnFdO10uEIfmdiX7MHYQ7gbdSxhuj3Kj2I994wc6nTUJuLL
         sKvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B0YPBiya;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=B0YPBiya;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 036/165] ext2: fix a block leak
Date: Thu, 24 May 2018 11:37:22 +0200
Message-Id: <20180524093623.432369640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601340960342171264?=
X-GMAIL-MSGID: =?utf-8?q?1601340969313582732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1261,21 +1261,11 @@ do_indirects:
 
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

Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZolpEr+8WD/kF3mFJf+CTjomI+r6vIYI2IGQjKEfrFYU2D/tQ84tlAfB0SZjb/4c9BqV0eG
ARC-Seal: i=1; a=rsa-sha256; t=1527157745; cv=none;
        d=google.com; s=arc-20160816;
        b=EVM9sROWu6pFRiH2ROLujdF++f1llEIcjoCVoEEvsZTi8Xn6CbQ/+XqqmtsTJ0OOJ4
         g2lD5DYfe1gG7JI/mvKBme9x+kJr2ce6TJm9/0h/MFTQ6XAhgCcDXmL6k5PQxLJMyBtG
         bSVu3GwQ5/AjyI0CjB9fe2+/felbP1PkViMB5q4fxI3ZFTFiaV41u9VAzoB5jNwDNcDx
         6xRTaNGMEOdNxbWyMGyrXSodCuXpvyixFFVbo1YgbfWQhLeHNxcWrKLvtRPWL5auC75e
         LEvcwzpCIHY1ujMlaTudjDYlGNFGmvYP2Wj1d7fYlv9XmNU2zZUW7s9vuMCgerwws98T
         mXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+C4oVBZ41o8UeV5leCPrFzpFLREnKYigFXGgx0QquWI=;
        b=rLIB4iwtmJc/IsyYt70qBz2hvvmt2aDPHUucMQmHod6CmitgJDTsHcHA3RA+mKZG7l
         hfQRm0LKNYVDLy9YyrAesuiA2RP5AFk2Zst0E29Z9skdsh+fdBKCPslDBiW54UsgYGVa
         KuperG7Z9w3huT1pZvpnBcPFFjh1K1OSFoanJX6HRRrss4PCvnU+WvpErCnn502g4uIs
         vVstTX69kB+8VeAakYRZaLoo0SxlfssqoM0Bhhn7wCkJ2CJmFjdGozH36TKA+DQu6H7w
         70+qyRWQmyhkkim11B7Tdr2KhNUM5yKjhyiofvAJSHy6mPPxz07NFTNkaXzf6irw8ODu
         RQhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=03BEk5mh;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=03BEk5mh;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 40/45] ext2: fix a block leak
Date: Thu, 24 May 2018 11:38:48 +0200
Message-Id: <20180524093126.021804958@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601340960342171264?=
X-GMAIL-MSGID: =?utf-8?q?1601340960342171264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1169,21 +1169,11 @@ do_indirects:
 
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
 	__ext2_truncate_blocks(inode, offset);
 }
 

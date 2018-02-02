Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2240D5szjAbCbYJKp++kImWBW/NPqBAVlDs6x3DFinuqOsFQQCmlgbXs+lWMlNoESCCV4RVX
ARC-Seal: i=1; a=rsa-sha256; t=1517591437; cv=none;
        d=google.com; s=arc-20160816;
        b=0vqP856mtcGvXc2rCBdq9AoC/Paeb1wFHraULayuMI4BaXJZxqAGK9k5nYGU45sMmf
         dyGN7eIYWTxhoyZr4/3lkqlJsZGmXgTQAbQdYxkn9HxQaOKPWOSsDNtXLoAG860PSFOC
         trhs9nmysxvx0E5WlV1GvgY8C3hhdXejcLHJ3/VWdgCEV7TQ4qzilVQBOJFp9GsAgh+m
         H++09hnmcYvgWYxYuFrXIHrpFyt+yFtJM5agi4g5b7uHYnGXVitYnaHrEpCjiE9cScGI
         Y5fv1i/15qbe2h8d4xT3Uxrj2TgBb3EVDEqdkSDADex7+ukqbbPra3cy6RAPXd63Up3S
         g9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DLkjqxx7zFksDN+5PAndDuwGrfuMNQOgdnvRC/vHOBQ=;
        b=M0DCW3PKKIc9vndWqGyyznJyn8euox8c4ylvyI429a31Ahbpt5xpbYfFui0WUvrnyg
         NaZkjTXdnlVKcjFoMWmCkL31oTRfJeJ9hpFDonkkCzLT9v1GpLewyZLbKOnoZ5qwCWQH
         6f/DEfE6pbN4npBnYZ7PliaNl2MH4Yz/Z6bc1QY7U+Eas21hasYzZwcX09Bn+HCJKcG1
         8G2ROFCxXvHPS2W1x0E6FYni2qral7fS4rGhwimy8BiwhbiVZcm+DrThyPOOUptWht7p
         uKHcxtFJZKly9dXohlKN2NxYjJ424qQJy4YMlvDcFxAAstCY6kpM5kp/GqrnaQh8c00C
         YvGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 080/156] xfs: always free inline data before resetting inode fork during ifree
Date: Fri,  2 Feb 2018 17:57:41 +0100
Message-Id: <20180202140843.894623238@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309565328883023?=
X-GMAIL-MSGID: =?utf-8?q?1591309958927743419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <darrick.wong@oracle.com>


[ Upstream commit 98c4f78dcdd8cec112d1cbc5e9a792ee6e5ab7a6 ]

In xfs_ifree, we reset the data/attr forks to extents format without
bothering to free any inline data buffer that might still be around
after all the blocks have been truncated off the file.  Prior to commit
43518812d2 ("xfs: remove support for inlining data/extents into the
inode fork") nobody noticed because the leftover inline data after
truncation was small enough to fit inside the inline buffer inside the
fork itself.

However, now that we've removed the inline buffer, we /always/ have to
free the inline data buffer or else we leak them like crazy.  This test
was found by turning on kmemleak for generic/001 or generic/388.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_inode.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2422,6 +2422,24 @@ retry:
 }
 
 /*
+ * Free any local-format buffers sitting around before we reset to
+ * extents format.
+ */
+static inline void
+xfs_ifree_local_data(
+	struct xfs_inode	*ip,
+	int			whichfork)
+{
+	struct xfs_ifork	*ifp;
+
+	if (XFS_IFORK_FORMAT(ip, whichfork) != XFS_DINODE_FMT_LOCAL)
+		return;
+
+	ifp = XFS_IFORK_PTR(ip, whichfork);
+	xfs_idata_realloc(ip, -ifp->if_bytes, whichfork);
+}
+
+/*
  * This is called to return an inode to the inode free list.
  * The inode should already be truncated to 0 length and have
  * no pages associated with it.  This routine also assumes that
@@ -2458,6 +2476,9 @@ xfs_ifree(
 	if (error)
 		return error;
 
+	xfs_ifree_local_data(ip, XFS_DATA_FORK);
+	xfs_ifree_local_data(ip, XFS_ATTR_FORK);
+
 	VFS_I(ip)->i_mode = 0;		/* mark incore inode as free */
 	ip->i_d.di_flags = 0;
 	ip->i_d.di_dmevmask = 0;

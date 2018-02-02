Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227t5tW/qKNnS2z6nXmzWPqjaPprcQMzDegPl3WVephdwlL+vR+s5V1LRYy2K8sOF0vu+kVZ
ARC-Seal: i=1; a=rsa-sha256; t=1517591061; cv=none;
        d=google.com; s=arc-20160816;
        b=vJBBjAx+wfBIh+UHFAoGHzkC7RSUpjkSblHNw5QRpCdKucW4mrUtc/wnfb712Lje6g
         XuHCPTyEz2GyheEcVoSnCsYznJXE611p3TIfECg3R6l6zHC1nrFDFWTDJX5CZIjBKXBu
         9b4D42zC8io8mRir273c1Ul74qeMFOoKxI3Zp+EiQlPK5FEbshN7BDyEnf4nlcEdvhAQ
         KwsZQHZkGorcaiDjvY3tvyyZZkNm8s5PvEwi2XjcnKqYWkD2qWQKKGjZk0lboR7+RnRo
         ED4dFMQjKd3Kp/TsTnD7dnztXM2gWa4CZg4ODKar6ajr/PFvTUCIV1T8TTsfgTcEBdMP
         dCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cQHXWN9cb+DTpkmMvWEJZ9ANrZmKniW68+ZcENKXJXU=;
        b=cjAgYHPgv/s8p2KHfbtojzD/7fxoLUdQLXdXhlK4yW5VaT41DLA4ZChiDlN7zwo5yK
         FNp2sGxPo1oGUrxYyNS/GTCncHyaz52QWaMQXem/6rTLYo0WtpvQRhAnsaOmJSMNAOK4
         dEVb6AGkVCcL90yqW9BRJAmkCXNdfZCI2cy1l0h0/JHwTZKce+ehRATSMnmQqzzsSWVs
         Xa3qdhZ7Vm2/pt2tbVUtAM6NvheRfx4LRd1yY5k3nYPG6UOrmiZx7V3I7C4GV4oqyoHv
         Kr7MyhfZctNzTeDrdJuzOQO+5IQnePfFnpxM6MMDot6Lm/yUNOMeExjACes/K59khPS6
         cZdQ==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 38/86] xfs: always free inline data before resetting inode fork during ifree
Date: Fri,  2 Feb 2018 17:57:58 +0100
Message-Id: <20180202140825.972875915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309565328883023?=
X-GMAIL-MSGID: =?utf-8?q?1591309565328883023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_inode.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2430,6 +2430,24 @@ retry:
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
@@ -2466,6 +2484,9 @@ xfs_ifree(
 	if (error)
 		return error;
 
+	xfs_ifree_local_data(ip, XFS_DATA_FORK);
+	xfs_ifree_local_data(ip, XFS_ATTR_FORK);
+
 	VFS_I(ip)->i_mode = 0;		/* mark incore inode as free */
 	ip->i_d.di_flags = 0;
 	ip->i_d.di_dmevmask = 0;

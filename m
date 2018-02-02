Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227vra/tqBK0fV21uCxaaeYPGPXYgRk1DlevGCVdFfSf4M/xDfrcRlkWANuoMs6nMZnzEKtm
ARC-Seal: i=1; a=rsa-sha256; t=1517591126; cv=none;
        d=google.com; s=arc-20160816;
        b=z+qWyXw8iGDdw7iKagpTeMz+LoaLvgWy3i8kpoMnA45Xn+Pmv9UGyxvH43OkVlLw0P
         qpPBEbImItO4sSng0lqXaL8Etty3oNGKbQGo6W1O4z7ywg2gnCu26NXe890PfT4BJ9pk
         y3zfpGESB0bdhx3v1IejTmfHCpPsoPk61FbNTSi9B+DMapMc1m61timawiUi921tLRJB
         m4FC5OfbL7T3NooKiEi8/PrUZUcg31UbKw0W7kQxc5V64Ra0MO0Tc1Y4vpyTTIAAQI7Q
         DvhVLdWDvfOuUWVWKIqmnHFT/IvifCH4NAQYk9Wfn+uOmf8YZjoL9JpIFuMrd/jKqidW
         KtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2YtZjnB0oXTsiMDqOQ12Nh8TQJF8ruJ5uYf5ebns/+Y=;
        b=va+IwRiEg+/tlFPefKoP7MgiqOjIwsTTa3oiQb0FanqE2UBibTWLYPWbxiuD/21y1N
         lBi0K94XoZ6DUK6ycGdIL5wxH03RgtxLV/daTwCZ0jYIwAQplqsNH7UnFd4HGQrx4Dl1
         nYkjvoKhFctPwIp6b+Zve2NvvIdjiXY8zcmCsa43XeBj6JBQ2L70X7eA1XooqFYxXET6
         22OSvVUa1Qr26HH5g0mXrQ0FClqdIvHbbzyoHK7Auh49yA/XjCa+Y+1nDEmXC/xTyxbD
         PFYcaRN/Gseb/oPKazWWIhI+v246uX/6EVOq6sIskUpaNVqYnTiwYdqBCYob9GsHWCNm
         9H7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Brian Foster <bfoster@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 61/86] xfs: ubsan fixes
Date: Fri,  2 Feb 2018 17:58:21 +0100
Message-Id: <20180202140828.126283200@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309387877960768?=
X-GMAIL-MSGID: =?utf-8?q?1591309633166583573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <darrick.wong@oracle.com>


[ Upstream commit 22a6c83777ac7c17d6c63891beeeac24cf5da450 ]

Fix some complaints from the UBSAN about signed integer addition overflows.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_aops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -391,7 +391,7 @@ xfs_map_blocks(
 	       (ip->i_df.if_flags & XFS_IFEXTENTS));
 	ASSERT(offset <= mp->m_super->s_maxbytes);
 
-	if (offset + count > mp->m_super->s_maxbytes)
+	if ((xfs_ufsize_t)offset + count > mp->m_super->s_maxbytes)
 		count = mp->m_super->s_maxbytes - offset;
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1295,7 +1295,7 @@ xfs_map_trim_size(
 	if (mapping_size > size)
 		mapping_size = size;
 	if (offset < i_size_read(inode) &&
-	    offset + mapping_size >= i_size_read(inode)) {
+	    (xfs_ufsize_t)offset + mapping_size >= i_size_read(inode)) {
 		/* limit mapping to block that spans EOF */
 		mapping_size = roundup_64(i_size_read(inode) - offset,
 					  i_blocksize(inode));
@@ -1347,7 +1347,7 @@ __xfs_get_blocks(
 	lockmode = xfs_ilock_data_map_shared(ip);
 
 	ASSERT(offset <= mp->m_super->s_maxbytes);
-	if (offset + size > mp->m_super->s_maxbytes)
+	if ((xfs_ufsize_t)offset + size > mp->m_super->s_maxbytes)
 		size = mp->m_super->s_maxbytes - offset;
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + size);
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ri2QfFdjqVt1A6csBkIX/wURQR/A/TZjKg1ZYRARt9w0juPiZ2xiADtV2BMmGjpI/R8dd
ARC-Seal: i=1; a=rsa-sha256; t=1517591536; cv=none;
        d=google.com; s=arc-20160816;
        b=LclHuicF8w8Vl30ftpD04hu4+VW6PJTFhzBv153YBNwqehGPDW9is/qZMCygcyIqI2
         8SaiI/ccWEu9tF3zarSNx3dBsRGNB5lAEQTUOn9m93ByUZlci0hPvGpyLw3EEjnZaRSF
         zgJRtgge0yNnMml8J5fvzRb0Qo/9UncWrXtAdmOeyNvrnGalDXjkS3jLKUbeFtl+Ef6m
         VeGEXJSu7dxoNpdEJFVwnJIiRHD9i86Z+spxZ1HZVs60oE75ACePRdxPfHMc/BHdz6L4
         ar0NzhDqmOLJ8Apwemr3MT8x4rnUekTkENM3NTXlNjGTMklwPYwyU7ybV8+Bf52YF0Qq
         KyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hiAea9G7+pAFUE+xzgLen/7lF6F7zsZSn7wDsv2YZEs=;
        b=0IvXGQ5I4uvf/i3fQWrqV22DaXCDXN3KuFYDKWAPDsKZD7UiQG0KaRqb4sXV/D+6Xm
         fz8//Bt0aYQkAJlzRjeQPk+XI0AQDZLqHiP4pwc6GOEOli8zvtNn0tlDZkhA6VTP6b7W
         qLWk4urljn/prBdAKndlgBR3DUThmW9fqxg3I7hZkEWyjo5L+MP9iDNfdGaSgHSP5D+B
         BpL3xyhGGv3XP2vfh8rWpoDukgtc2ukcA6fDEXiIbxpJvvmj/Vxo0fuKZtbG+ivlwVLo
         MVLAMgXgvn2AdxjRLzlMFD+o6iVkOYenLugyOb0GqZN3Iyp0CboDcPAkRjVjSSSQ3JWb
         bE8Q==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 114/156] xfs: ubsan fixes
Date: Fri,  2 Feb 2018 17:58:15 +0100
Message-Id: <20180202140845.335861525@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309387877960768?=
X-GMAIL-MSGID: =?utf-8?q?1591310062688159908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <darrick.wong@oracle.com>


[ Upstream commit 22a6c83777ac7c17d6c63891beeeac24cf5da450 ]

Fix some complaints from the UBSAN about signed integer addition overflows.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_aops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -399,7 +399,7 @@ xfs_map_blocks(
 	       (ip->i_df.if_flags & XFS_IFEXTENTS));
 	ASSERT(offset <= mp->m_super->s_maxbytes);
 
-	if (offset + count > mp->m_super->s_maxbytes)
+	if ((xfs_ufsize_t)offset + count > mp->m_super->s_maxbytes)
 		count = mp->m_super->s_maxbytes - offset;
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1265,7 +1265,7 @@ xfs_map_trim_size(
 	if (mapping_size > size)
 		mapping_size = size;
 	if (offset < i_size_read(inode) &&
-	    offset + mapping_size >= i_size_read(inode)) {
+	    (xfs_ufsize_t)offset + mapping_size >= i_size_read(inode)) {
 		/* limit mapping to block that spans EOF */
 		mapping_size = roundup_64(i_size_read(inode) - offset,
 					  i_blocksize(inode));
@@ -1312,7 +1312,7 @@ xfs_get_blocks(
 	lockmode = xfs_ilock_data_map_shared(ip);
 
 	ASSERT(offset <= mp->m_super->s_maxbytes);
-	if (offset + size > mp->m_super->s_maxbytes)
+	if ((xfs_ufsize_t)offset + size > mp->m_super->s_maxbytes)
 		size = mp->m_super->s_maxbytes - offset;
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + size);
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);

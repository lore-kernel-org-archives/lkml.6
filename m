Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpXeNWIHjn3D/Nr6O0+DCCNLk/OWREah6zwXGVFS2QMwEuflgdCBZljTj+XvA0mQrMTHUTz
ARC-Seal: i=1; a=rsa-sha256; t=1526280684; cv=none;
        d=google.com; s=arc-20160816;
        b=PhN+NbSJ9XNLzXqprlN2IXBrmObtEfBmpZT5SaX96J+BD9oPTeOl/Yg1CA6SgIfzuc
         e+l5oFttITIbQCUkGeaXI9t4oL7x0UbSTi4oqX1XLOM3uKad0WR8C7uhieC8roD0pdpY
         cUold3jOlkoaoT53TUlaZE0jk4hh5evvTHQitMPIc84z3K5fcfUC0EmJflFsKNG3I+es
         l4S82HoPJKxFjfX9sV9Q3H29lqJCor7TLVZlCJCpNh3BYJVcOh8VaJp6pfD0TzMJUjNx
         U5/yybiK/Sv7MnkmeZfF7Z2kEYmzp7CkGnX/FpXX7F/YC5LlwBsFdAEX4/qkHsnhNStx
         1jNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9iPSzpzGc6HOvRZdesJ0EXMVA/Lt804cnXBvwJU6O+M=;
        b=KJsLJGPtHzXHtpDSaz4pSOXz9gBfSlam0YrH0rP9YtDsZ0Y6+0qYogLml/RJCe5qdM
         MV4gDttAX0VFLzYDLiTq04NUUNCioMA+qkJblUbD/G2cbpUVxE70hDztQ5y3DIqutkCJ
         dL5D/NwajzSvXoykSk4jyCnKWrgODVa7fJoB3ThbjCphjmgGrTCxz7NAeZcElPK/UCf8
         DgPhm07zyDbafxkpKbjQXp4drhgH4t+spdTTJXRftynyTcKOoN8grV2u5bg3cE+ALi+W
         OqlnkB2odemo7ir9Ui/9+banj7yt2oUvKpjkAN+0KY2ZJLdEJ3TBVS9+bWuA+D2wOuD4
         aTgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nt6RFseZ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nt6RFseZ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.4 19/56] xfs: prevent creating negative-sized file via INSERT_RANGE
Date: Mon, 14 May 2018 08:48:24 +0200
Message-Id: <20180514064756.810779737@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421295105523065?=
X-GMAIL-MSGID: =?utf-8?q?1600421295105523065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <darrick.wong@oracle.com>

commit 7d83fb14258b9961920cd86f0b921caaeb3ebe85 upstream.

During the "insert range" fallocate operation, i_size grows by the
specified 'len' bytes.  XFS verifies that i_size + len < s_maxbytes, as
it should.  But this comparison is done using the signed 'loff_t', and
'i_size + len' can wrap around to a negative value, causing the check to
incorrectly pass, resulting in an inode with "negative" i_size.  This is
possible on 64-bit platforms, where XFS sets s_maxbytes = LLONG_MAX.
ext4 and f2fs don't run into this because they set a smaller s_maxbytes.

Fix it by using subtraction instead.

Reproducer:
    xfs_io -f file -c "truncate $(((1<<63)-1))" -c "finsert 0 4096"

Fixes: a904b1ca5751 ("xfs: Add support FALLOC_FL_INSERT_RANGE for fallocate")
Cc: <stable@vger.kernel.org> # v4.1+
Originally-From: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
[darrick: fix signed integer addition overflow too]
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_file.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -969,22 +969,26 @@ xfs_file_fallocate(
 		if (error)
 			goto out_unlock;
 	} else if (mode & FALLOC_FL_INSERT_RANGE) {
-		unsigned int blksize_mask = i_blocksize(inode) - 1;
+		unsigned int	blksize_mask = i_blocksize(inode) - 1;
+		loff_t		isize = i_size_read(inode);
 
-		new_size = i_size_read(inode) + len;
 		if (offset & blksize_mask || len & blksize_mask) {
 			error = -EINVAL;
 			goto out_unlock;
 		}
 
-		/* check the new inode size does not wrap through zero */
-		if (new_size > inode->i_sb->s_maxbytes) {
+		/*
+		 * New inode size must not exceed ->s_maxbytes, accounting for
+		 * possible signed overflow.
+		 */
+		if (inode->i_sb->s_maxbytes - isize < len) {
 			error = -EFBIG;
 			goto out_unlock;
 		}
+		new_size = isize + len;
 
 		/* Offset should be less than i_size */
-		if (offset >= i_size_read(inode)) {
+		if (offset >= isize) {
 			error = -EINVAL;
 			goto out_unlock;
 		}

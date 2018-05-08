Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpH3dw8PU7AjrEanaKxSebHJf6HR7z3ejl9opTEAJZyklAFVVL2cScUMI9orSfBVVQ7OoMq
ARC-Seal: i=1; a=rsa-sha256; t=1525767142; cv=none;
        d=google.com; s=arc-20160816;
        b=nlCeD0yav0Eszwib7cn2ctgs52YDwD7DwlELlUom+F2zO6eBwm92LaTgYDMLF6WrrA
         8cIn6bAfU6XdxEJy7SUOAxywAhL6nKGGT0qRTXANBlICf0pTDTmfRKTKPUObs/n/MJTo
         NwZRVT91H6yet7pPii1SxwTqOexJqbp2hZLS5h7QUEcQcUh+ktd7raRUf6wHADRdFn/n
         czVKV6sgclk38xcBIuJDkOhof1ZMueTH67MBjtCwxKVodCWh0uWc4uuuHlYeMEi3LMzO
         xXbUWe54DI4zMbvKdjpPu7aHhO/qIypSDbofZxImDBaAnzMi6VaAkQ32yBokv4k8OMyZ
         JbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rPDKuSvY9PItdTyDbS20Y4k/j7oOakQto4Vs2ejonak=;
        b=cO7sUlc3CsBjda7zU//bR3IANwjV0rkHQgW2oIYxovzuQRrJPNtU5+h1ppNwq3hE3a
         nlOm5RptN85AFyKdoREzNvB/E1PuCPeXJhLTjo+hr5Dqq+UORDZyfM8VVBbIY5yDmIme
         5j5GNLjpg0nMBdpD+UtnUDjZSA2iJzO5UJzBboTcoGYK/YXrpqpNCNt1AxhdYgj8CeFQ
         6U1D/bGwuPvKussZ02tYMLCKSUluW+6vZ8o0oF9L53l4phKFoX7WtnzsCgODQbkLTEwu
         39Zc5z2zMeIzIt3UwuON7/FvhjjE7VSWAgR3lG1p2Mm7zfHqk/ARUQiV5ddGvN445pT8
         jW9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RLo2C67T;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RLo2C67T;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4.16 16/52] xfs: prevent creating negative-sized file via INSERT_RANGE
Date: Tue,  8 May 2018 10:10:14 +0200
Message-Id: <20180508073930.206710821@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882807260392086?=
X-GMAIL-MSGID: =?utf-8?q?1599882807260392086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -812,22 +812,26 @@ xfs_file_fallocate(
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

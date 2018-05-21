Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqnlIyTV8UhWEBQ6NAu/vGCJVQhk0TY85H+ZM5jZ/Tl6MWTp63ON5gQxoBobnueVqv0YDM7
ARC-Seal: i=1; a=rsa-sha256; t=1526937570; cv=none;
        d=google.com; s=arc-20160816;
        b=PYGbCiZpoiqBdaqkYrs4s1v48vMt8ck9tippGq1HeBh3YxZKgMEFeTFPKt8QmttEe+
         06MTVb2n0zWj6+XstFjg2NGiQXF0xPDuU/nuVtdZhampPJGGsyED0FGom+/lfnGpQlnT
         AdeF8GZY+y+RAs3p6pqeNw9VLokQpHD1nT7rBqv0yZ5LCX1ZSv5ygxYqW4T06jVBdK1J
         xl4WEEo7qJ0nd/r9K6xRVSyky9k0Z3aQVXgJBPxKJrC6d3eP0f/Ujzw6WCs+OiXsccS+
         axgdCLFIhoS/z+45RYaLwm6pVdORKyIlQpOTBUYUDps5lmlXuR8cazbLIjmJ+VrXezOd
         HuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8xgsCZC1IslD9sz8I6SQJ3J4iRkUkvp+UGO5HJ7wOIw=;
        b=Si0J32do4PehyDs/ZlGz+JD6ejX6r6gaW92TU2hiUKJ/sLCOuLJN4VoebqIVPrWZwT
         ITWm5OqZuL5/RjFc5LRbvilav9C0K+YWN4d/m1XxfatIn3PQ/7BJ5cyWehKm7dAQyxU+
         7JjGJNepoD0NQPyanX1DhBJHzRDUrBSmLwlW/Dxh9WeT15h2Sjf9oVeJVbZL+jZBahwK
         viDeR1IWBNSHKcG5SPj6u2ibsMaVpRw3uuoWygqrMLoVKlLvK/iGbnXGhMjqypj3s9Qk
         Ufuxik7Mr3YB46NHBpb2M9mD/z2D/HHYgFeXfd0BI0Du10bzsPqILl1xTcqfCh3ZLwc+
         qdtA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=z4wisNXW;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=z4wisNXW;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 43/95] btrfs: property: Set incompat flag if lzo/zstd compression is set
Date: Mon, 21 May 2018 23:11:33 +0200
Message-Id: <20180521210456.868325387@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110089757768866?=
X-GMAIL-MSGID: =?utf-8?q?1601110089757768866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

commit 1a63c198ddb810c790101d693c7071cca703b3c7 upstream.

Incompat flag of LZO/ZSTD compression should be set at:

 1. mount time (-o compress/compress-force)
 2. when defrag is done
 3. when property is set

Currently 3. is missing and this commit adds this.

This could lead to a filesystem that uses ZSTD but is not marked as
such. If a kernel without a ZSTD support encounteres a ZSTD compressed
extent, it will handle that but this could be confusing to the user.

Typically the filesystem is mounted with the ZSTD option, but the
discrepancy can arise when a filesystem is never mounted with ZSTD and
then the property on some file is set (and some new extents are
written). A simple mount with -o compress=zstd will fix that up on an
unpatched kernel.

Same goes for LZO, but this has been around for a very long time
(2.6.37) so it's unlikely that a pre-LZO kernel would be used.

Fixes: 5c1aab1dd544 ("btrfs: Add zstd support")
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add user visible impact ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/props.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -400,6 +400,7 @@ static int prop_compression_apply(struct
 				  const char *value,
 				  size_t len)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int type;
 
 	if (len == 0) {
@@ -410,14 +411,17 @@ static int prop_compression_apply(struct
 		return 0;
 	}
 
-	if (!strncmp("lzo", value, 3))
+	if (!strncmp("lzo", value, 3)) {
 		type = BTRFS_COMPRESS_LZO;
-	else if (!strncmp("zlib", value, 4))
+		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
+	} else if (!strncmp("zlib", value, 4)) {
 		type = BTRFS_COMPRESS_ZLIB;
-	else if (!strncmp("zstd", value, len))
+	} else if (!strncmp("zstd", value, len)) {
 		type = BTRFS_COMPRESS_ZSTD;
-	else
+		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
+	} else {
 		return -EINVAL;
+	}
 
 	BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
 	BTRFS_I(inode)->flags |= BTRFS_INODE_COMPRESS;

Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr/oKk8YOL9ieouaQ8WPMTGBHvAzCcVC2a8i3+JcDj2gENcXnfpne4bNhFwCWYRy+D1dPrR
ARC-Seal: i=1; a=rsa-sha256; t=1526937875; cv=none;
        d=google.com; s=arc-20160816;
        b=T+dstSw7ULkmsIqD7x8MakxDdDb6xjipjCaeIxhKz61iB5wHzE//9MeQ5we+bClmV+
         O/V8i2PaOfMIKbH9JJBDaPCN0lFGuByqet3wQ8vJZudpApHj8f6XI17xzhMr1u2IgvFb
         kqiuYXPELAMWCZc3HIe8OeHKAqc6E4OWWlAi7ADv2OKz14oawk1qakQSG/rPaHogxcqq
         Ic47yEifG79OxCGC52RUrgGv7SnSiem9FDdtyNmJDbhTxvogH1PicbQPWw9kxQ7+FOWW
         Kj8Upig8PLkpfsqmQEBqIurfFy7Y/c/lKjBjplUXlqmSlxVeb/unSYCk3W983yjR/zvU
         3/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9WYMAVlUtwZnkBrDP0CMr5+bkLNuMIyN98pLMTcwi8E=;
        b=JVpr2HiPwTL4E1/eUqZEQHZ8X3Nr61kVI9VFbdFh63EeyQfkIDbkkJrVbDbunU/iox
         ueS8eoL9/D34Gi2Zu5aoSpssLFWjwRkSp56GOTPbIWIIXhgNsugZxNUTHlqHOiXtM9IH
         FMO4o3zaz6yyEhqGkjMbFAJJgaOrKEjNRV659dcaaniesRx706bF4qbgMSQIJJsCWqES
         YrcO+0TMplE5oBDEaRaIdSanV1W8Q/uv2nieMehBL/KkHD+19exmKFM9uJULqxuKnrRm
         1R++BwcUNCBUkNEwzu/eM0EVKVYzaYM7c4GV9IuIvsnx62BuSOlDGpLj6+RIDuXHtS8l
         MOcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wedlB5O6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wedlB5O6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.16 057/110] btrfs: property: Set incompat flag if lzo/zstd compression is set
Date: Mon, 21 May 2018 23:11:54 +0200
Message-Id: <20180521210510.840166368@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110089757768866?=
X-GMAIL-MSGID: =?utf-8?q?1601110409464811464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -393,6 +393,7 @@ static int prop_compression_apply(struct
 				  const char *value,
 				  size_t len)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int type;
 
 	if (len == 0) {
@@ -403,14 +404,17 @@ static int prop_compression_apply(struct
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

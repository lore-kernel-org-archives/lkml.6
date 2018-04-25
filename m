Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZrl42CNEv5Em/UcrlWM+RfjJCFAJ48sq7/T8hbFc3hUXYYg9W2DCYl8huRXz4uut5y+P4iC
ARC-Seal: i=1; a=rsa-sha256; t=1524652652; cv=none;
        d=google.com; s=arc-20160816;
        b=iCpBhWcOtaep5C0Rn7xeqqFLA5Yqi0se5tild6xDIKMBV+e2WTlNnxqyoBzETTqbLw
         1Rka4OmApgSEma3f057e8XCP6lHfkS28UHFEkF4ust8jXlskBXKAsKEWakMjfkZ+/euC
         f6+DZA5XJYSVDKtwRuEeFCQe4lK+yzDvYKhfpbkYRm9amJaauV1zXwISIN5QsgT0/kJ1
         KdAMr1ml+Az+ivku3A/oHUFVta/3qpxy6r6QdcxdiWB9/55Wf3l351ikZMvlLhujG1OZ
         jcPajtvaSC/UY8bhz9TlrRn3qnImpKzJfJ+HyAJvAUFMb/UK/3GgmpcbIIbgKidR8CP8
         C8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J6F9yC81d9rvlNl/8i2ULVtFFLwtninHb1u4JFtzeWU=;
        b=mZq7r6YdiBIBsV1KFpx48sMIId/ZnYuabGLFUPhRCu1L909pfyrsCfOqlcs8F/pUWN
         R9zQTJ38lCdBZrc82q7QKokNSt1+kRWtGSxCW2Y7EkmmPR2BaNxBkun/OZ4uInymTA9A
         7xcet/2KKHc4FWuZPimRSNQ4xHb9JTjuRxv+uxlLhhrzKPUlHTIkFVtn5ifB8x6BmMBF
         Tb+ls9NSoBHsxVIa3TUJSVSSORVfIcAA5dWyjmBeLMPLATQX/39ms7NKHB2160Bdira6
         HMP8EsQILxq/DYB/PhGzCbZKytP0q80F43Ptuc8QMIsuM9Go7iN0yBNVhKIJP8Ks4vr6
         0eIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.liu@linux.alibaba.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 002/183] btrfs: fix unaligned access in readdir
Date: Wed, 25 Apr 2018 12:33:42 +0200
Message-Id: <20180425103242.696627331@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714003012608660?=
X-GMAIL-MSGID: =?utf-8?q?1598714179778432819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

commit 92d32170847bfff2dd08af2c016085779f2fd2a1 upstream.

The last update to readdir introduced a temporary buffer to store the
emitted readdir data, but as there are file names of variable length,
there's a lot of unaligned access.

This was observed on a sparc64 machine:

  Kernel unaligned access at TPC[102f3080] btrfs_real_readdir+0x51c/0x718 [btrfs]

Fixes: 23b5ec74943 ("btrfs: fix readdir deadlock with pagefault")
CC: stable@vger.kernel.org # 4.14+
Reported-and-tested-by: René Rebe <rene@exactcode.com>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -42,6 +42,7 @@
 #include <linux/blkdev.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/uio.h>
+#include <asm/unaligned.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -5980,11 +5981,13 @@ static int btrfs_filldir(void *addr, int
 		struct dir_entry *entry = addr;
 		char *name = (char *)(entry + 1);
 
-		ctx->pos = entry->offset;
-		if (!dir_emit(ctx, name, entry->name_len, entry->ino,
-			      entry->type))
+		ctx->pos = get_unaligned(&entry->offset);
+		if (!dir_emit(ctx, name, get_unaligned(&entry->name_len),
+					 get_unaligned(&entry->ino),
+					 get_unaligned(&entry->type)))
 			return 1;
-		addr += sizeof(struct dir_entry) + entry->name_len;
+		addr += sizeof(struct dir_entry) +
+			get_unaligned(&entry->name_len);
 		ctx->pos++;
 	}
 	return 0;
@@ -6078,14 +6081,15 @@ again:
 		}
 
 		entry = addr;
-		entry->name_len = name_len;
+		put_unaligned(name_len, &entry->name_len);
 		name_ptr = (char *)(entry + 1);
 		read_extent_buffer(leaf, name_ptr, (unsigned long)(di + 1),
 				   name_len);
-		entry->type = btrfs_filetype_table[btrfs_dir_type(leaf, di)];
+		put_unaligned(btrfs_filetype_table[btrfs_dir_type(leaf, di)],
+				&entry->type);
 		btrfs_dir_item_key_to_cpu(leaf, di, &location);
-		entry->ino = location.objectid;
-		entry->offset = found_key.offset;
+		put_unaligned(location.objectid, &entry->ino);
+		put_unaligned(found_key.offset, &entry->offset);
 		entries++;
 		addr += sizeof(struct dir_entry) + name_len;
 		total_len += sizeof(struct dir_entry) + name_len;

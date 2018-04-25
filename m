Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZoN6DE7dYfpN9CQJB4vsgESB5/XYVzDUmv5pU/16hoc2QxXDdec3dyiYFYBZPhbYKA9+fuh
ARC-Seal: i=1; a=rsa-sha256; t=1524652483; cv=none;
        d=google.com; s=arc-20160816;
        b=hCd9TTaljHI0OoWn8oXrwgZwAe+1AofuWAmVvMGFzLnjmy+YpKlFyTMJtzWB2f1SdT
         g04n9yFpHH6NIGk9p7++6Mc2r8JrrtUj8ZlIXcgeCmoihCVuXVQWOb74wPVOiqld+O6t
         AYwmDQhVRsQNDteRTUOCOyJeJZD2qNkeLnjeGb+ukb/SO/lrJAOqY8stso2gl+TV4W+A
         47kZOkYNxWYFTX8z9eHkjl+bV8FyVOsGpDcQYJhI0Nhcf+hNex4VccDUwKxtXRG5x35p
         OL3IZ/JqVfGcKQhs2LYJxW3jnQtUdd4OQsyAuwgXgn+FqUgkjOm5aX/GFaOE03fCxV8I
         0VKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Zt4Aufn1jn/Hcue5j/NYyvJOe8jI65f/Hz33HP+C7eU=;
        b=n6TckBl0Lb8oi2PhmGa2wHLfi9q7Vsc8q/sFdoKVcnXZDgGHUumpVNxaHxfb+nuFNl
         OgHR7NJ8PtVhhBGDc7FmL9L/q/+4Od3DwGGP15E/iPXz+j0CueRLUhRpGq2tpS2+xi/x
         NyFdBJdYhgDW64t5qUl41USpv1SLeIvUiB4yjEqffQB2G5uxcTOSoBhUOY2jxkpVxg/R
         +4XIXaS7BWjyUETHFt4GlmVK+r1x8ySGz5IqRjYDX5ZjdZlMXuic1Xw/CW4VQO4I/+0x
         txOD3bB1z/3VL7Cp7OIhg7voqnFKElwdAkGCS6lzyfljYakeMBm9lUkXVjukdrRIImHQ
         HACQ==
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
Subject: [PATCH 4.16 03/26] btrfs: fix unaligned access in readdir
Date: Wed, 25 Apr 2018 12:33:12 +0200
Message-Id: <20180425103314.976907494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714003012608660?=
X-GMAIL-MSGID: =?utf-8?q?1598714003012608660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -44,6 +44,7 @@
 #include <linux/uio.h>
 #include <linux/magic.h>
 #include <linux/iversion.h>
+#include <asm/unaligned.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -5951,11 +5952,13 @@ static int btrfs_filldir(void *addr, int
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
@@ -6045,14 +6048,15 @@ again:
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

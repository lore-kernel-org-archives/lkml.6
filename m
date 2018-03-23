Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv9NkTk+fR9yq03oxZSrtg8Ew7dqTedfp6a7RDTozJqDnLXBhg1bZu/YocVEqEpnjaq5It+
ARC-Seal: i=1; a=rsa-sha256; t=1521800166; cv=none;
        d=google.com; s=arc-20160816;
        b=qHHNdiACaj9VXGzenDf8WhSYoVlsvYb+FVankrkd7C7E/e2k3qHynX7HGhTOs3Cj51
         IAhamV1/a/0BIhnIQO0ejOCSxfq8TqYBr3drt8yN4A1Kubj69mGC9Qc2ec9YdVKByQJ9
         8fXDjswX6LyvkPYz5xheSvCPXm9W5fOQS6IPsNKwPXVxcCTEsfoSv2OSnpyTI/A27Po+
         b8wllOZ9qpmZpHorbaBo/pET89Ic3Hw4i8eAYAYNxJrv7mf82bdMx38zE3o6T4DKwnrm
         /HbHB0JDMhuSzk6CJvaqqeRnw1fUvBtFNU/fZD35E6bXzM2CX+wy+d03cVQlviKjb6Kd
         vitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GZUBqjv2rGx1i0YGReOgDu/z4E9F9qQCOQEH583BIbo=;
        b=ShDqAom1e1AnixZ23NiigL0RqMe1CkS5yubFMhr0EQ40fOsZN7KuQzFZA7my7GPtwZ
         3H+9gw0IzdzNB+Nh1hj3IBM0UxA2LzbwpGYdHT54aqSf4AUNjXka+YcrFz6t/88ksi9Y
         VzNGv6P4L1JQO13Siw3xqeB2MKVPRlcD3HkiAOs5X1X+KY9rZc9zi2qN7KDD4HyJCWrR
         9jMlDvuEzbR/12M3NWjret+fjhCok028DF4yZ7vDUhkgc/1bo+/nKavAvoZBWC/X+oQh
         gvjTwqCUdQhYYzDIV73D7rh/wtUs7qlriiC103N366i0JstFCGJfvK3rMv5NQhbOPSyy
         s6Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Liu Bo <bo.li.liu@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 49/97] Btrfs: send, fix file hole not being preserved due to inline extent
Date: Fri, 23 Mar 2018 10:54:36 +0100
Message-Id: <20180323094200.358040036@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722632353760429?=
X-GMAIL-MSGID: =?utf-8?q?1595723132113565912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>


[ Upstream commit e1cbfd7bf6dabdac561c75d08357571f44040a45 ]

Normally we don't have inline extents followed by regular extents, but
there's currently at least one harmless case where this happens. For
example, when the page size is 4Kb and compression is enabled:

  $ mkfs.btrfs -f /dev/sdb
  $ mount -o compress /dev/sdb /mnt
  $ xfs_io -f -c "pwrite -S 0xaa 0 4K" -c "fsync" /mnt/foobar
  $ xfs_io -c "pwrite -S 0xbb 8K 4K" -c "fsync" /mnt/foobar

In this case we get a compressed inline extent, representing 4Kb of
data, followed by a hole extent and then a regular data extent. The
inline extent was not expanded/converted to a regular extent exactly
because it represents 4Kb of data. This does not cause any apparent
problem (such as the issue solved by commit e1699d2d7bf6
("btrfs: add missing memset while reading compressed inline extents"))
except trigger an unexpected case in the incremental send code path
that makes us issue an operation to write a hole when it's not needed,
resulting in more writes at the receiver and wasting space at the
receiver.

So teach the incremental send code to deal with this particular case.

The issue can be currently triggered by running fstests btrfs/137 with
compression enabled (MOUNT_OPTIONS="-o compress" ./check btrfs/137).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5008,13 +5008,19 @@ static int is_extent_unchanged(struct se
 	while (key.offset < ekey->offset + left_len) {
 		ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		right_type = btrfs_file_extent_type(eb, ei);
-		if (right_type != BTRFS_FILE_EXTENT_REG) {
+		if (right_type != BTRFS_FILE_EXTENT_REG &&
+		    right_type != BTRFS_FILE_EXTENT_INLINE) {
 			ret = 0;
 			goto out;
 		}
 
 		right_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
-		right_len = btrfs_file_extent_num_bytes(eb, ei);
+		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
+			right_len = btrfs_file_extent_inline_len(eb, slot, ei);
+			right_len = PAGE_ALIGN(right_len);
+		} else {
+			right_len = btrfs_file_extent_num_bytes(eb, ei);
+		}
 		right_offset = btrfs_file_extent_offset(eb, ei);
 		right_gen = btrfs_file_extent_generation(eb, ei);
 
@@ -5028,6 +5034,19 @@ static int is_extent_unchanged(struct se
 			goto out;
 		}
 
+		/*
+		 * We just wanted to see if when we have an inline extent, what
+		 * follows it is a regular extent (wanted to check the above
+		 * condition for inline extents too). This should normally not
+		 * happen but it's possible for example when we have an inline
+		 * compressed extent representing data with a size matching
+		 * the page size (currently the same as sector size).
+		 */
+		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
+			ret = 0;
+			goto out;
+		}
+
 		left_offset_fixed = left_offset;
 		if (key.offset < ekey->offset) {
 			/* Fix the right offset for 2a and 7. */

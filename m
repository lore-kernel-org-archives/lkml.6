Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt/MqddehhO8fJxYUhmV3vDOLXKION9LkwITQtjl5Ot2EJMYtXKYH/VDUKCfydep2o0nGwX
ARC-Seal: i=1; a=rsa-sha256; t=1521800359; cv=none;
        d=google.com; s=arc-20160816;
        b=wPO+ENQYIvQ4NxT3ZCul9xawDASfk4dSwT61c8roo2hAgLYWS3Ou8Ln1cNXYvhosVb
         YhlAUpOr4YiHTs5wsFIvu7JLafnOpdkGrmX6ZvcgRv4tZ1dSLLKzkpdUpqg1ZwtIE5Hq
         FDQcpKfjFkzmvDT9K/yDwSFcvpSAgX3YuHH4cn3sQO9T+b+xBgY5y8Ze/xQqXex4Juw6
         wm0pGVDreHLDXfIEA90JTaqEg9MLaZ2mhTpohk3wA/OLNsRQjlRPfDfenkVNEJ8+7aPC
         Cxkf0WSld+bHy9/Ds943rXUKUtjKun/u3emZ4tBL62RLCndW1THZR6XhJ0ICzd428omQ
         osrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eMVoRQbY+pT/rMwYV5SiywF2rE/Rud3Q7/PRiysEPjY=;
        b=xFPtsGxIf+n14cUM0kZD8fuP45pJeudELEXAl3P2qdHFyGftEVZRq33RFRV74gFTEM
         2hGI627WWu8u0As2/6u/98//s5XJhhHsl4JT3EDaYMGDm2MO623ZSrsw+qliQOI/zYuQ
         Bs8TRC+k/719dP4BzQakmOeql1KJFoehgBFtXde6TfAfHRFj28t6Ma4+wrvOXd9OdY2X
         3vIUY4DS5jRYGRoIEpcqxjTKfwd0QRtT1XUkbiYNEOX32LJWPlST0EMAGi7LkbPcWEO0
         RyHEV2ujCWvzzi7EZkdWWB0N97na9XPegv4z7KcT8IuVq/c6tg6O6oCZ78gugzzFrJ7s
         StYg==
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
Subject: [PATCH 3.18 25/47] Btrfs: send, fix file hole not being preserved due to inline extent
Date: Fri, 23 Mar 2018 10:55:16 +0100
Message-Id: <20180323094249.194276396@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722632353760429?=
X-GMAIL-MSGID: =?utf-8?q?1595723334000992506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4663,13 +4663,19 @@ static int is_extent_unchanged(struct se
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
 
@@ -4683,6 +4689,19 @@ static int is_extent_unchanged(struct se
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

Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr59AE7ATFfWQAjpICFg3DtzGRlppOQAwOAqh0bQObrSwMoR6yk0+/FUuyPGDyeNDsJicEP
ARC-Seal: i=1; a=rsa-sha256; t=1525116399; cv=none;
        d=google.com; s=arc-20160816;
        b=NCfQrvUAj8RCjDzwJZ2hraIqoVk7UemgXwTXHTkGJ+8g5fKgZuddEazJLMpJJBUJ2W
         GTe2xWDbViNWOK/s1jLjnMDxJfE+SNLm4dG5v0XnFVEAqTwORN9n3sL6dcQnlZoV9kPb
         oG+Qpx50XQOcn17EPJ3VkkpINkJagoQJlv8KQD58JyZcRVLy7WSTthnqx8C584kDBZcJ
         qq6hPa6KPHkabZgbC9ue7dgDxdE2zHzgN+tUL0/WATzN/zscEYs8z+7AD9sQ+zmTiiS6
         priQEG5H0/kaLEDxuiUV8M+XmQ+hm3Xw/J8n//ZVjsl48PhbCnZPf0CnzKIqBGxkjbvg
         G+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kF4ivaeEtMWPjOKUHkei05Fcx7rXCZ/buYyo5WmLDvk=;
        b=G+RtE2SS4kXBkm28cdYvXorKGl8eVsk7mvGfJLwhajTZzTutYTNX1zBFkWfG24DAhJ
         WvxZDegMqg42rvugQmgWqcUVjAkUwpS1m9FXiT/yfYJN5/5t3p3DuEs1CRgbqhhsodXc
         WH56CR3u3uVAiA3KOzq5qL1B3QZFd4uzSptiehN/JcflB82hLpI2/NVqzujorfjwzvMe
         LTro+doFV3fPLSNOyDZIOja8YY2dhW/ABTgMgN/dLabFcoAhijbg3y+H5ppNIrEiGq/H
         O8lnUQlT/kr1FDe6v/P1vqcIYrm0zHwJZF2Rxx3FQlvY9j6+r2gY6epwBBSZUXolj1NP
         fz9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1033422DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+06c885be0edcdaeab40c@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 01/61] ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS
Date: Mon, 30 Apr 2018 12:24:04 -0700
Message-Id: <20180430183951.424844189@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200396004789064?=
X-GMAIL-MSGID: =?utf-8?q?1599200453731515758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 349fa7d6e1935f49bf4161c4900711b2989180a9 upstream.

During the "insert range" fallocate operation, extents starting at the
range offset are shifted "right" (to a higher file offset) by the range
length.  But, as shown by syzbot, it's not validated that this doesn't
cause extents to be shifted beyond EXT_MAX_BLOCKS.  In that case
->ee_block can wrap around, corrupting the extent tree.

Fix it by returning an error if the space between the end of the last
extent and EXT4_MAX_BLOCKS is smaller than the range being inserted.

This bug can be reproduced by running the following commands when the
current directory is on an ext4 filesystem with a 4k block size:

        fallocate -l 8192 file
        fallocate --keep-size -o 0xfffffffe000 -l 4096 -n file
        fallocate --insert-range -l 8192 file

Then after unmounting the filesystem, e2fsck reports corruption.

Reported-by: syzbot+06c885be0edcdaeab40c@syzkaller.appspotmail.com
Fixes: 331573febb6a ("ext4: Add support FALLOC_FL_INSERT_RANGE for fallocate")
Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/extents.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5356,8 +5356,9 @@ ext4_ext_shift_extents(struct inode *ino
 	stop = le32_to_cpu(extent->ee_block);
 
        /*
-	 * In case of left shift, Don't start shifting extents until we make
-	 * sure the hole is big enough to accommodate the shift.
+	* For left shifts, make sure the hole on the left is big enough to
+	* accommodate the shift.  For right shifts, make sure the last extent
+	* won't be shifted beyond EXT_MAX_BLOCKS.
 	*/
 	if (SHIFT == SHIFT_LEFT) {
 		path = ext4_find_extent(inode, start - 1, &path,
@@ -5377,9 +5378,14 @@ ext4_ext_shift_extents(struct inode *ino
 
 		if ((start == ex_start && shift > ex_start) ||
 		    (shift > start - ex_end)) {
-			ext4_ext_drop_refs(path);
-			kfree(path);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (shift > EXT_MAX_BLOCKS -
+		    (stop + ext4_ext_get_actual_len(extent))) {
+			ret = -EINVAL;
+			goto out;
 		}
 	}
 

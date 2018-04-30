Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrG3Yb3TWj5pkj83XPar60Zr89CcTiSKX8X/Mb5A/Jy5ffqZNG8jLZKvriMrLYn5RczNvP7
ARC-Seal: i=1; a=rsa-sha256; t=1525116472; cv=none;
        d=google.com; s=arc-20160816;
        b=qjIVPtWWv8iC4dwHYxZkiGpJPR8kHTeTmlE/Fcs+vaPEE5PgWap7bP6+zdBEdDPQbb
         lFmChuP6xLLdeA3efj7gvGl3IxtixVkPUV/+5MnhNeFzANPF1iBx+tqM+4c/ksz2GQnU
         +k0HL9dqFv35il7bvb8vLeK4IxPSWmz2hLjPc5UvKnxX0wEztikwmn7k9ftxrdFiRbFJ
         2t6OjLVALUjhzSck0GGuzyloti4fGHU5EjEsYgNhK/jTXzJlvuoFekJQMYWaaaL9poS9
         9svfmfO3Or6DH3S2a9y4Wp98usEowvOoHBV/YdZl/d077M6CQpbIMu+J2+jDpvpf3yK0
         rcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UTrCA0h931/lQb02B9Fh1sVmvspJc4zFX68xIthdcNU=;
        b=iDkIu1+9o0pNFCDQeamAyan6gGFyiyWqbJXf6ygg16fpoEaEmtqvH1tfChub9sIQO0
         bVHrtXp9S55RIXbNDMjLEaT2L6uJUyl00UTHwAPG9fqQ7BuLiR3Se+lLyI4kSErswUhr
         zoRu0croHqcs5/HinmJKaH6+qLo2tC6+946PL+m9LXRsPv7kgFy9l20WqIlMD4xSU5MC
         i1kPkDDgoOsn3LnhCs4bZNJhR3rTMGT0qCo9yPayQhGEOQhxo3p6mWy6KPujC85CdVKn
         jxKU6FAzUQ1ATRR8ZqcET/8mM3KbHUSeQNoJiciDVYSP+hsnKbP7ywhvE30Y5tQNWzJQ
         aT/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BF722DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+06c885be0edcdaeab40c@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 001/113] ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS
Date: Mon, 30 Apr 2018 12:23:32 -0700
Message-Id: <20180430184015.120135692@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200396004789064?=
X-GMAIL-MSGID: =?utf-8?q?1599200530145057094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5334,8 +5334,9 @@ ext4_ext_shift_extents(struct inode *ino
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
@@ -5355,9 +5356,14 @@ ext4_ext_shift_extents(struct inode *ino
 
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
 

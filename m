Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrHhpnI5IQKvJkKOA6D2V7hB2MTWxeZSZ6Aqx/ZxJik5wQJCuCAxTH245v4bPiCf4/X072O
ARC-Seal: i=1; a=rsa-sha256; t=1525116414; cv=none;
        d=google.com; s=arc-20160816;
        b=nY3ct1B8yLY9XuI+WBHsp3SBo1HPKfEQkLb3jVvbzn89XEEugbxLRCiePoNUiK5+j5
         xHKf4EkCAXAU6MqPCxneo1t/ZM1/otlDPJvg9lofTtwd+FlxDm5bXtfMDG/wlGJ4BfEe
         5Kwb+yvxxBfXz25SdE5+nRDhkkSE2cJnkUJgLo0fqkjC6HgN63HtEOR8bgs8ocW4y4Op
         JnbQs3bg2uDZN/3NTiggFFs8WxGbBktPtd3HwoxoofkBI0/h5tz4Xwcm9icSvqOZhRQv
         BY0xh0XF+527FnV/w001pzgOV1Bpj0kReIARvJBX9wcl0nNt8SckgPgSIBCCpOqhyE19
         lYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kptHCitcJTE0eJc4cdeM+6lBMTG2Ek4B/BUn8Pfd5Dc=;
        b=kiUjme0WsemBwJQ/liwwZWpTkOd4/wZgKxw6eJxCm4/ipZTaNNF3v23rLKzg7LnBmx
         643F2Hv2Ml2NVE4OvQzhAdB+CMJiZKqILfvKJlpqsS7nLj2EGOmpaPkoYldULnk3VoWW
         WVbg0WvGzwo+kgaU8RyeZjoeP92N/BXSPkzWWUYemiAk7dLvIMBaigirlFTLs2VjFp0i
         4fJj8LIsIO3sMQ9afkD2+c9WPVjkXbEgshOs/mI/0bpDkicyVTojY3swTCbz0qZ6Fq7j
         P5j81Copu2YmbLyaLRLFwdWnk8wWStDIvjBrFWaIVUCREEdcqy3KxfnwY42T7Kv9jrTu
         /2MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6645122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+06c885be0edcdaeab40c@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 01/91] ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS
Date: Mon, 30 Apr 2018 12:23:43 -0700
Message-Id: <20180430184004.287281402@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200396004789064?=
X-GMAIL-MSGID: =?utf-8?q?1599200469763213368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5346,8 +5346,9 @@ ext4_ext_shift_extents(struct inode *ino
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
@@ -5367,9 +5368,14 @@ ext4_ext_shift_extents(struct inode *ino
 
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
 

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49v/16++Gp33L03+rqtPewNc33DWwu2VBlqFw16zRhpTuMcs7rT4lANC0w1ZeMqRLmNh8AI
ARC-Seal: i=1; a=rsa-sha256; t=1524406020; cv=none;
        d=google.com; s=arc-20160816;
        b=QnUurtYkq41CyErM/QoIicOL+qXLxkEDsJGvw+VizbUfmpC5rqA8cL5BL3dHRAzRnv
         wQINS9iHhrLpfZlMxaa7cBp3lUKbTdcPGAoZINdJEIjHTdFLDG3DkRTL49DE1e9k7ykH
         OdT3xEv4CrLwlOWS3jdEtrem8NqTnkqO+Ey3QQepF2Xb2ClVjBC6kKtUj4jxB/sbi5OS
         4qTdxzUSOf+0ZcuYX9tOKAO8rlEWRJdD/9lViQklKbL5cGQCLiz4KJgx5UwcSa/BwdWg
         lSp+Y0Gto4+M8VObD9oth2h1yZj1eqOSFlVwsmOWjMpWDdxc38Pna8a37cZgJr5s1s9N
         8c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h3CeJKHURuvT8v4hZAQT09XRKtTyyous/fqRBtE0i7A=;
        b=gQOHTq6s01/sIs52nfKhoMEdZEV+8Smzdnnu4mEf8gD/XUGo+eMRkpGGhtyGZAKsZv
         AYt6YLo25kABuNIZ+iCoMD9XDuoWHqq7D1mZb7+w3ZiHsEIxFiO7KO32IwuvpFlVEsGY
         Kxp1Ei/pF48fJ7o/Qw0ulDFKOg2PaRrGZwKSwHPKqpWzTOX4nqjzzr4FqOOWXW1hasMn
         D9GbmJ9C6uO55OgYaQgnG52pd967rUCDYukmjVA6YGDbqdhnx8YwTq9UCZGgKdN4nUJ6
         okFopqEDKNNuby9fA5fbkOs21A7FfJov6RFISef5BaxsK4zo7j+ctTgH4W62W00jY2s+
         4S5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 4.14 084/164] ext4: add extra checks to ext4_xattr_block_get()
Date: Sun, 22 Apr 2018 15:52:31 +0200
Message-Id: <20180422135138.871042914@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455044329858347?=
X-GMAIL-MSGID: =?utf-8?q?1598455567139236230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 54dd0e0a1b255f115f8647fc6fb93273251b01b9 upstream.

Add explicit checks in ext4_xattr_block_get() just in case the
e_value_offs and e_value_size fields in the the xattr block are
corrupted in memory after the buffer_verified bit is set on the xattr
block.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |   26 +++++++++++++++++++-------
 fs/ext4/xattr.h |   11 +++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -196,7 +196,7 @@ ext4_xattr_check_entries(struct ext4_xat
 	while (!IS_LAST_ENTRY(entry)) {
 		u32 size = le32_to_cpu(entry->e_value_size);
 
-		if (size > INT_MAX)
+		if (size > EXT4_XATTR_SIZE_MAX)
 			return -EFSCORRUPTED;
 
 		if (size != 0 && entry->e_value_inum == 0) {
@@ -539,8 +539,10 @@ ext4_xattr_block_get(struct inode *inode
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
+	error = -ERANGE;
+	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
+		goto cleanup;
 	if (buffer) {
-		error = -ERANGE;
 		if (size > buffer_size)
 			goto cleanup;
 		if (entry->e_value_inum) {
@@ -549,8 +551,12 @@ ext4_xattr_block_get(struct inode *inode
 			if (error)
 				goto cleanup;
 		} else {
-			memcpy(buffer, bh->b_data +
-			       le16_to_cpu(entry->e_value_offs), size);
+			u16 offset = le16_to_cpu(entry->e_value_offs);
+			void *p = bh->b_data + offset;
+
+			if (unlikely(p + size > end))
+				goto cleanup;
+			memcpy(buffer, p, size);
 		}
 	}
 	error = size;
@@ -588,8 +594,10 @@ ext4_xattr_ibody_get(struct inode *inode
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
+	error = -ERANGE;
+	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
+		goto cleanup;
 	if (buffer) {
-		error = -ERANGE;
 		if (size > buffer_size)
 			goto cleanup;
 		if (entry->e_value_inum) {
@@ -598,8 +606,12 @@ ext4_xattr_ibody_get(struct inode *inode
 			if (error)
 				goto cleanup;
 		} else {
-			memcpy(buffer, (void *)IFIRST(header) +
-			       le16_to_cpu(entry->e_value_offs), size);
+			u16 offset = le16_to_cpu(entry->e_value_offs);
+			void *p = (void *)IFIRST(header) + offset;
+
+			if (unlikely(p + size > end))
+				goto cleanup;
+			memcpy(buffer, p, size);
 		}
 	}
 	error = size;
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -71,6 +71,17 @@ struct ext4_xattr_entry {
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*
+ * XATTR_SIZE_MAX is currently 64k, but for the purposes of checking
+ * for file system consistency errors, we use a somewhat bigger value.
+ * This allows XATTR_SIZE_MAX to grow in the future, but by using this
+ * instead of INT_MAX for certain consistency checks, we don't need to
+ * worry about arithmetic overflows.  (Actually XATTR_SIZE_MAX is
+ * defined in include/uapi/linux/limits.h, so changing it is going
+ * not going to be trivial....)
+ */
+#define EXT4_XATTR_SIZE_MAX (1 << 24)
+
+/*
  * The minimum size of EA value when you start storing it in an external inode
  * size of block - size of header - size of 1 entry - 4 null bytes
 */

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755189AbeEHN1B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:27:01 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:42784 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbeEHN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:26:58 -0400
X-Google-Smtp-Source: AB8JxZpfxvZBaiRUOiv+FSCyLgeUEAlJz56sZo+r1eIs20QalVYRheN0XYMXiQFimFUB/97eHTWPKQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/7] bitops: Introduce the for_each_set_port_word macro
Date: Tue,  8 May 2018 09:26:51 -0400
Message-Id: <c919f6c2ff54a29114bd5e566997f11e5ebf29c3.1525785532.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525785532.git.vilhelm.gray@gmail.com>
References: <cover.1525785532.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro iterates for each group of bits (port word) with set bits,
within a bitmap memory region. For each iteration, "port_word" is set to
the found port word index, "word_index" is set to the word index of the
bitmap containing the found port word, and "word_offset" is set to the
bit offset of the found port word within the respective bitmap word.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 26 ++++++++++++++++++++++++++
 include/linux/bitops.h            |  9 +++++++++
 lib/find_bit.c                    | 28 ++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..c59514547e63 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_BITOPS_FIND_H_
 #define _ASM_GENERIC_BITOPS_FIND_H_
 
+#include <linux/types.h>
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -80,4 +82,28 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+/**
+ * find_next_port_word - find next port word with set bits in a memory region
+ * @word_index: location to store bitmap word index of found port word
+ * @word_offset: bits offset of the found port word in respective bitmap word
+ * @bits: address to base the search on
+ * @size: bitmap size in number of ports
+ * @offset: port word index to start searching at
+ * @port_size: port word size in bits
+ *
+ * Returns the port index for the next port word with set bits; the respective
+ * bitmap word index is stored at the location pointed by @word_index, and the
+ * bits offset of the found port word within the respective bitmap word is
+ * stored at the location pointed by @word_offset. If no bits are set, returns
+ * @size.
+ */
+size_t find_next_port_word(size_t *const word_index,
+			   unsigned int *const word_offset,
+			   const unsigned long *const bits, const size_t size,
+			   const size_t offset, const unsigned int port_size);
+
+#define find_first_port_word(word_index, word_offset, bits, size, port_size) \
+	find_next_port_word((word_index), (word_offset), (bits), (size), 0, \
+			    (port_size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 4cac4e1a72ff..c3b7caf4ad2d 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -59,6 +59,15 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_port_word(port_word, word_index, word_offset, bits, size, \
+			       port_size) \
+	for ((port_word) = find_first_port_word(&(word_index), &(word_offset), \
+					   (bits), (size), (port_size)); \
+	     (port_word) < (size); \
+	     (port_word) = find_next_port_word(&(word_index), &(word_offset), \
+					  (bits), (size), (port_word) + 1, \
+					  (port_size)))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index ee3df93ba69a..628c94d63d6b 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -20,6 +20,7 @@
 #include <linux/bitmap.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/types.h>
 
 #if !defined(find_next_bit) || !defined(find_next_zero_bit) || \
 		!defined(find_next_and_bit)
@@ -218,3 +219,30 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+size_t find_next_port_word(size_t *const word_index,
+			   unsigned int *const word_offset,
+			   const unsigned long *const bits, const size_t size,
+			   const size_t offset, const unsigned int port_size)
+{
+	size_t i;
+	unsigned int bits_offset;
+	unsigned long word_mask;
+	const unsigned long port_mask = GENMASK(port_size - 1, 0);
+
+	for (i = offset; i < size; i++) {
+		bits_offset = i * port_size;
+
+		*word_index = BIT_WORD(bits_offset);
+		*word_offset = bits_offset % BITS_PER_LONG;
+
+		word_mask = bits[*word_index] & (port_mask << *word_offset);
+		if (!word_mask)
+			continue;
+
+		return i;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(find_next_port_word);
-- 
2.17.0

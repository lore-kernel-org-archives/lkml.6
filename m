Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeFDG72 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbeFDG7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 04/29] tools: add more bitmap functions
Date: Mon,  4 Jun 2018 08:58:00 +0200
Message-Id: <20180604065802.333101611@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <willy@linux.intel.com>

commit b328daf3b7130098b105c18bdae694ddaad5b6e3 upstream.

I need the following functions for the radix tree:

  bitmap_fill
  bitmap_empty
  bitmap_full

Copy the implementations from include/linux/bitmap.h

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/linux/bitmap.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -35,6 +35,32 @@ static inline void bitmap_zero(unsigned
 	}
 }
 
+static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
+{
+	unsigned int nlongs = BITS_TO_LONGS(nbits);
+	if (!small_const_nbits(nbits)) {
+		unsigned int len = (nlongs - 1) * sizeof(unsigned long);
+		memset(dst, 0xff,  len);
+	}
+	dst[nlongs - 1] = BITMAP_LAST_WORD_MASK(nbits);
+}
+
+static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
+{
+	if (small_const_nbits(nbits))
+		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_bit(src, nbits) == nbits;
+}
+
+static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_zero_bit(src, nbits) == nbits;
+}
+
 static inline int bitmap_weight(const unsigned long *src, int nbits)
 {
 	if (small_const_nbits(nbits))

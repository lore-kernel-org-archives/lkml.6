Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeDAUoZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754471AbeDAUoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:23 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 41/45] C++: Cast in bitops
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:21 +0100
Message-ID: <152261546159.30503.11719145019451087798.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the generic bitops functions, cast the void* bits pointer to unsigned
long* before using it to avoid things like:

include/asm-generic/bitops/le.h:15:28: error: invalid conversion from 'const void*' to 'const long unsigned int*' [-fpermissive]

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/bitops/le.h |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 188d3eba3ace..8b0fb40da390 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -12,19 +12,19 @@
 static inline unsigned long find_next_zero_bit_le(const void *addr,
 		unsigned long size, unsigned long offset)
 {
-	return find_next_zero_bit(addr, size, offset);
+	return find_next_zero_bit(static_cast<const unsigned long *>(addr), size, offset);
 }
 
 static inline unsigned long find_next_bit_le(const void *addr,
 		unsigned long size, unsigned long offset)
 {
-	return find_next_bit(addr, size, offset);
+	return find_next_bit(static_cast<const unsigned long *>(addr), size, offset);
 }
 
 static inline unsigned long find_first_zero_bit_le(const void *addr,
 		unsigned long size)
 {
-	return find_first_zero_bit(addr, size);
+	return find_first_zero_bit(static_cast<const unsigned long *>(addr), size);
 }
 
 #elif defined(__BIG_ENDIAN)
@@ -52,47 +52,55 @@ extern unsigned long find_next_bit_le(const void *addr,
 
 static inline int test_bit_le(int nr, const void *addr)
 {
-	return test_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	return test_bit(nr ^ BITOP_LE_SWIZZLE,
+			static_cast<const unsigned long *>(addr));
 }
 
 static inline void set_bit_le(int nr, void *addr)
 {
-	set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	set_bit(nr ^ BITOP_LE_SWIZZLE, static_cast<unsigned long *>(addr));
 }
 
 static inline void clear_bit_le(int nr, void *addr)
 {
-	clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	clear_bit(nr ^ BITOP_LE_SWIZZLE,
+		  static_cast<unsigned long *>(addr));
 }
 
 static inline void __set_bit_le(int nr, void *addr)
 {
-	__set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	__set_bit(nr ^ BITOP_LE_SWIZZLE,
+		  static_cast<unsigned long *>(addr));
 }
 
 static inline void __clear_bit_le(int nr, void *addr)
 {
-	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	__clear_bit(nr ^ BITOP_LE_SWIZZLE,
+		    static_cast<unsigned long *>(addr));
 }
 
 static inline int test_and_set_bit_le(int nr, void *addr)
 {
-	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE,
+				static_cast<unsigned long *>(addr));
 }
 
 static inline int test_and_clear_bit_le(int nr, void *addr)
 {
-	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE,
+				  static_cast<unsigned long *>(addr));
 }
 
 static inline int __test_and_set_bit_le(int nr, void *addr)
 {
-	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE,
+				  static_cast<unsigned long *>(addr));
 }
 
 static inline int __test_and_clear_bit_le(int nr, void *addr)
 {
-	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
+	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE,
+				    static_cast<unsigned long *>(addr));
 }
 
 #endif /* _ASM_GENERIC_BITOPS_LE_H_ */

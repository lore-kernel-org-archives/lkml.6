Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDPTdD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:33:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeDPTdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:33:01 -0400
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] textsearch: fix kernel-doc warnings and add kernel-api
 section
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <8f871cc5-dba8-c4d8-9dfb-ea61a2aa35a7@infradead.org>
Date: Mon, 16 Apr 2018 12:32:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Make lib/textsearch.c usable as kernel-doc.
Add textsearch() function family to kernel-api documentation.
Fix kernel-doc warnings in <linux/textsearch.h>:
  ../include/linux/textsearch.h:65: warning: Incorrect use of kernel-doc format:
	* get_next_block - fetch next block of data
  ../include/linux/textsearch.h:82: warning: Incorrect use of kernel-doc format:
	* finish - finalize/clean a series of get_next_block() calls

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/kernel-api.rst |   13 +++++++
 include/linux/textsearch.h            |    4 +-
 lib/textsearch.c                      |   40 +++++++++++++-----------
 3 files changed, 38 insertions(+), 19 deletions(-)

--- linux-next-20180416.orig/Documentation/core-api/kernel-api.rst
+++ linux-next-20180416/Documentation/core-api/kernel-api.rst
@@ -136,6 +136,19 @@ Sorting
 .. kernel-doc:: lib/list_sort.c
    :export:
 
+Text Searching
+--------------
+
+.. kernel-doc:: lib/textsearch.c
+   :doc: ts_intro
+
+.. kernel-doc:: lib/textsearch.c
+   :export:
+
+.. kernel-doc:: include/linux/textsearch.h
+   :functions: textsearch_find textsearch_next \
+               textsearch_get_pattern textsearch_get_pattern_len
+
 UUID/GUID
 ---------
 
--- linux-next-20180416.orig/lib/textsearch.c
+++ linux-next-20180416/lib/textsearch.c
@@ -10,7 +10,10 @@
  * 		Pablo Neira Ayuso <pablo@netfilter.org>
  *
  * ==========================================================================
- *
+ */
+
+/**
+ * DOC: ts_intro
  * INTRODUCTION
  *
  *   The textsearch infrastructure provides text searching facilities for
@@ -19,7 +22,9 @@
  *
  * ARCHITECTURE
  *
- *      User
+ * .. code-block:: none
+ *
+ *     User
  *     +----------------+
  *     |        finish()|<--------------(6)-----------------+
  *     |get_next_block()|<--------------(5)---------------+ |
@@ -33,21 +38,21 @@
  *     |             (3)|----->| find()/next() |-----------+          |
  *     |             (7)|----->| destroy()     |----------------------+
  *     +----------------+      +---------------+
- *  
- *   (1) User configures a search by calling _prepare() specifying the
- *       search parameters such as the pattern and algorithm name.
+ *
+ *   (1) User configures a search by calling textsearch_prepare() specifying
+ *       the search parameters such as the pattern and algorithm name.
  *   (2) Core requests the algorithm to allocate and initialize a search
  *       configuration according to the specified parameters.
- *   (3) User starts the search(es) by calling _find() or _next() to
- *       fetch subsequent occurrences. A state variable is provided
- *       to the algorithm to store persistent variables.
+ *   (3) User starts the search(es) by calling textsearch_find() or
+ *       textsearch_next() to fetch subsequent occurrences. A state variable
+ *       is provided to the algorithm to store persistent variables.
  *   (4) Core eventually resets the search offset and forwards the find()
  *       request to the algorithm.
  *   (5) Algorithm calls get_next_block() provided by the user continuously
  *       to fetch the data to be searched in block by block.
  *   (6) Algorithm invokes finish() after the last call to get_next_block
  *       to clean up any leftovers from get_next_block. (Optional)
- *   (7) User destroys the configuration by calling _destroy().
+ *   (7) User destroys the configuration by calling textsearch_destroy().
  *   (8) Core notifies the algorithm to destroy algorithm specific
  *       allocations. (Optional)
  *
@@ -62,9 +67,10 @@
  *   amount of times and even in parallel as long as a separate struct
  *   ts_state variable is provided to every instance.
  *
- *   The actual search is performed by either calling textsearch_find_-
- *   continuous() for linear data or by providing an own get_next_block()
- *   implementation and calling textsearch_find(). Both functions return
+ *   The actual search is performed by either calling
+ *   textsearch_find_continuous() for linear data or by providing
+ *   an own get_next_block() implementation and
+ *   calling textsearch_find(). Both functions return
  *   the position of the first occurrence of the pattern or UINT_MAX if
  *   no match was found. Subsequent occurrences can be found by calling
  *   textsearch_next() regardless of the linearity of the data.
@@ -72,7 +78,7 @@
  *   Once you're done using a configuration it must be given back via
  *   textsearch_destroy.
  *
- * EXAMPLE
+ * EXAMPLE::
  *
  *   int pos;
  *   struct ts_config *conf;
@@ -87,13 +93,13 @@
  *       goto errout;
  *   }
  *
- *   pos = textsearch_find_continuous(conf, &state, example, strlen(example));
+ *   pos = textsearch_find_continuous(conf, \&state, example, strlen(example));
  *   if (pos != UINT_MAX)
- *       panic("Oh my god, dancing chickens at %d\n", pos);
+ *       panic("Oh my god, dancing chickens at \%d\n", pos);
  *
  *   textsearch_destroy(conf);
- * ==========================================================================
  */
+/* ========================================================================== */
 
 #include <linux/module.h>
 #include <linux/types.h>
@@ -225,7 +231,7 @@ static unsigned int get_linear_data(unsi
  *
  * Returns the position of first occurrence of the pattern or
  * %UINT_MAX if no occurrence was found.
- */ 
+ */
 unsigned int textsearch_find_continuous(struct ts_config *conf,
 					struct ts_state *state,
 					const void *data, unsigned int len)
--- linux-next-20180416.orig/include/linux/textsearch.h
+++ linux-next-20180416/include/linux/textsearch.h
@@ -62,7 +62,7 @@ struct ts_config
 	int 			flags;
 
 	/**
-	 * get_next_block - fetch next block of data
+	 * @get_next_block: fetch next block of data
 	 * @consumed: number of bytes consumed by the caller
 	 * @dst: destination buffer
 	 * @conf: search configuration
@@ -79,7 +79,7 @@ struct ts_config
 						  struct ts_state *state);
 
 	/**
-	 * finish - finalize/clean a series of get_next_block() calls
+	 * @finish: finalize/clean a series of get_next_block() calls
 	 * @conf: search configuration
 	 * @state: search state
 	 *

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754441AbeCHQzd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:55:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:16925 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbeCHQzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:55:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="181046655"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Matthew Wilcox <mawilcox@microsoft.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH] radix tree test suite: fix mapshift build target
Date: Thu,  8 Mar 2018 09:55:24 -0700
Message-Id: <20180308165524.17427-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit

  commit c6ce3e2fe3da ("radix tree test suite: Add config option for map
  shift")

Introduced a phony makefile target called 'mapshift' that ends up
generating the file generated/map-shift.h.  This phony target was then
added as a dependency of the top level 'targets' build target, which is
what is run when you go to tools/testing/radix-tree and just type 'make'.

Unfortunately, this phony target doesn't actually work as a dependency, so
you end up getting:

$ make
make: *** No rule to make target 'generated/map-shift.h', needed by 'main.o'.  Stop.
make: *** Waiting for unfinished jobs....

Fix this by making the file generated/map-shift.h our real makefile target,
and add this a dependency of the top level build target.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tools/testing/radix-tree/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index fa7ee369b3c9..db66f8a0d4be 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -17,7 +17,7 @@ ifeq ($(BUILD), 32)
 	LDFLAGS += -m32
 endif
 
-targets: mapshift $(TARGETS)
+targets: generated/map-shift.h $(TARGETS)
 
 main:	$(OFILES)
 
@@ -42,9 +42,7 @@ radix-tree.c: ../../../lib/radix-tree.c
 idr.c: ../../../lib/idr.c
 	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
 
-.PHONY: mapshift
-
-mapshift:
+generated/map-shift.h:
 	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
 		echo "#define RADIX_TREE_MAP_SHIFT $(SHIFT)" >		\
 				generated/map-shift.h;			\
-- 
2.14.3

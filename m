Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeDHHUm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:20:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41151 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbeDHHUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 03:20:41 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Michael Henders <hendersm@shaw.ca>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] resource: Fix integer overflow at reallocation
Date: Sun,  8 Apr 2018 09:20:26 +0200
Message-Id: <20180408072026.27365-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a bug report indicating a kernel panic at booting on an
x86-32 system, and it turned out to be the invalid resource assigned
after PCI resource reallocation.  __find_resource() first aligns the
resource start address and resets the end address with start+size-1
accordingly, then checks whether it's contained.  Here the end address
may overflow the integer, although resource_contains() still returns
true because the function validates only start and end address.  So
this ends up with returning an invalid resource (start > end).

There was already an attempt to cover such a problem in the commit
47ea91b4052d ("Resource: fix wrong resource window calculation"), but
this case is an overseen one.

This patch adds the validity check in resource_contains() to see
whether the given resource has a valid range for avoiding the integer
overflow problem.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1086739
Fixes: 23c570a67448 ("resource: ability to resize an allocated resource")
Reported-and-tested-by: Michael Henders <hendersm@shaw.ca>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Andrew, could you pick this? It's still in a wild west...
Thanks!

v1->v2: check in resource_contains() instead of in __find_resource()

 include/linux/ioport.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..466d7be046eb 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -212,6 +212,9 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 		return false;
 	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
 		return false;
+	/* sanity check whether it's a valid resource range */
+	if (r2->end < r2->start)
+		return false;
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
-- 
2.16.3

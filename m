Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754257AbeDBHQa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 03:16:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:56334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754114AbeDBHQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 03:16:29 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Michael Henders <hendersm@shaw.ca>,
        Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH] resource: Fix integer overflow at reallocation
Date: Mon,  2 Apr 2018 09:16:16 +0200
Message-Id: <20180402071616.27177-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a bug report indicating a kernel panic at booting on an
x86-32 system, and it turned out to be the invalid resource assigned
after reallocation.  __find_resource() first aligns the resource start
address and resets the end address with start+size-1 accordingly, then
checks whether it's contained.  Here the end address may overflow the
integer, although resource_contains() still returns true because the
function validates only start and end address.  So this ends up with
returning an invalid resource (start > end).

There was already an attempt to cover such a problem in the commit
47ea91b4052d ("Resource: fix wrong resource window calculation"), but
this case is an overseen one.

This patch adds the validity check of the newly calculated resource
for avoiding the integer overflow problem.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1086739
Fixes: 23c570a67448 ("resource: ability to resize an allocated resource")
Reported-and-tested-by: Michael Henders <hendersm@shaw.ca>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Bjorn, I send this to you since the bug hits during PCI init, although
the culprit is in generic resource management.

 kernel/resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index e270b5048988..2af6c03858b9 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -651,7 +651,8 @@ static int __find_resource(struct resource *root, struct resource *old,
 			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
 					size, constraint->align);
 			alloc.end = alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (alloc.start <= alloc.end &&
+			    resource_contains(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
-- 
2.16.2

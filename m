Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeEEERl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 00:17:41 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56356 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEEERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 00:17:39 -0400
X-Google-Smtp-Source: AB8JxZp+2eN2eUrReKJ4GOucPAQnY/cX/bnvfjvOuoi70nQhC52xWrU1lo4Qp6k6KKIZSPdVGWhSow==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, David Herrmann <dh.herrmann@googlemail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org (open list:UHID USERSPACE HID IO DRIVER:),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] HID: uhid: fix a missing-check bug
Date: Fri,  4 May 2018 23:17:29 -0500
Message-Id: <1525493850-6952-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In uhid_event_from_user(), if it is in_compat_syscall(), the 'type' of the
event is first fetched from the 'buffer' in userspace and checked. If the
'type' is UHID_CREATE, it is a messed up request with compat pointer, which
could be more than 256 bytes, so it is better allocated from the heap, as
mentioned in the comment. Its fields are then prepared one by one instead
of using a whole copy. For all other cases, the event object is copied
directly from user space. In other words, based on the 'type', the memory
size and structure of the event object vary.

Given that the 'buffer' resides in userspace, a malicious userspace process
can race to change the 'type' between the two copies, which will cause
inconsistency issues, potentially security issues. Plus, various operations
such as uhid_dev_destroy() and uhid_dev_input() are performed based on
'type' in function uhid_char_write(). If 'type' is modified by user, there
could be some issues such as uninitialized uses.

To fix this problem, we need to recheck the type after the second fetch to
make sure it is not UHID_CREATE.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/hid/uhid.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3c55073..0220385 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -447,11 +447,17 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
 			event->u.create.country = compat->country;
 
 			kfree(compat);
-			return 0;
+		} else {
+			if (copy_from_user(event, buffer,
+					min(len, sizeof(*event))))
+				return -EFAULT;
+			if (event->type == UHID_CREATE)
+				return -EINVAL;
 		}
-		/* All others can be copied directly */
+		return 0;
 	}
 
+	/* Others can be copied directly */
 	if (copy_from_user(event, buffer, min(len, sizeof(*event))))
 		return -EFAULT;
 
-- 
2.7.4

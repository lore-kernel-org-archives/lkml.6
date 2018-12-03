Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A211820672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A211820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLCQoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:44:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42244 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLCQox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:44:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 6E9C1260CCA
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] kref/kobject: Improve documentation
Date:   Mon,  3 Dec 2018 13:44:35 -0300
Message-Id: <20181203164435.31530-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kref and kobject documentation may be
insufficient to understand these common pitfalls regarding
object lifetime and object releasing.

Add a bit more documentation and improve the warnings
seen by the user, pointing to the right piece of documentation.

Also, it's important to understand that making fun of people
publicly is not at all helpful, doesn't provide any value,
and it's not a healthy way of encouraging developers to do better.

"Mocking mercilessly" will, if anything, make developers feel bad
and go away. This kind of behavior should not be encouraged or justified.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/kobject.txt | 10 +++++++---
 drivers/base/core.c       |  3 +--
 include/linux/kref.h      |  5 +----
 lib/kobject.c             |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/kobject.txt b/Documentation/kobject.txt
index fc9485d79061..ff4c25098119 100644
--- a/Documentation/kobject.txt
+++ b/Documentation/kobject.txt
@@ -279,10 +279,14 @@ such a method has a form like::
 One important point cannot be overstated: every kobject must have a
 release() method, and the kobject must persist (in a consistent state)
 until that method is called. If these constraints are not met, the code is
-flawed.  Note that the kernel will warn you if you forget to provide a
+flawed. Note that the kernel will warn you if you forget to provide a
 release() method.  Do not try to get rid of this warning by providing an
-"empty" release function; you will be mocked mercilessly by the kobject
-maintainer if you attempt this.
+"empty" release function.
+
+If all your cleanup function needs to do is call kfree(), then you must
+create a wrapper function which uses container_of() to upcast to the correct
+type (as shown in the example above) and then calls kfree() on the overall
+structure.
 
 Note, the name of the kobject is available in the release function, but it
 must NOT be changed within this callback.  Otherwise there will be a memory
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f3e6ca4170b4..1a6a161be762 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -918,8 +918,7 @@ static void device_release(struct kobject *kobj)
 	else if (dev->class && dev->class->dev_release)
 		dev->class->dev_release(dev);
 	else
-		WARN(1, KERN_ERR "Device '%s' does not have a release() "
-			"function, it is broken and must be fixed.\n",
+		WARN(1, KERN_ERR "Device '%s' does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.\n",
 			dev_name(dev));
 	kfree(p);
 }
diff --git a/include/linux/kref.h b/include/linux/kref.h
index 29220724bf1c..cb00a0268061 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -53,10 +53,7 @@ static inline void kref_get(struct kref *kref)
  * @release: pointer to the function that will clean up the object when the
  *	     last reference to the object is released.
  *	     This pointer is required, and it is not acceptable to pass kfree
- *	     in as this function.  If the caller does pass kfree to this
- *	     function, you will be publicly mocked mercilessly by the kref
- *	     maintainer, and anyone else who happens to notice it.  You have
- *	     been warned.
+ *	     in as this function.
  *
  * Decrement the refcount, and if 0, call release().
  * Return 1 if the object was removed, otherwise return 0.  Beware, if this
diff --git a/lib/kobject.c b/lib/kobject.c
index 97d86dc17c42..b72e00fd7d09 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -639,7 +639,7 @@ static void kobject_cleanup(struct kobject *kobj)
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
 	if (t && !t->release)
-		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed.\n",
+		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.\n",
 			 kobject_name(kobj), kobj);
 
 	/* send "remove" if the caller did not do it but sent "add" */
-- 
2.20.0.rc1


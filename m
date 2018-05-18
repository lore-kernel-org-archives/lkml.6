Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeERHu1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:50:27 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33519 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeERHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:50:24 -0400
X-Google-Smtp-Source: AB8JxZpYNRGQKPPTd4FsCgOxTjxc8Zcrr54MRY7JTZoU/e3JgsbxUrPGvC7wpW5/av/q0LCixwla2g==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 09/10] closures: closure_wait_event()
Date: Fri, 18 May 2018 03:49:16 -0400
Message-Id: <20180518074918.13816-19-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/closure.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index 1072bf2c13..ef22d18f7c 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -375,4 +375,26 @@ static inline void closure_call(struct closure *cl, closure_fn fn,
 	continue_at_nobarrier(cl, fn, wq);
 }
 
+#define __closure_wait_event(waitlist, _cond)				\
+do {									\
+	struct closure cl;						\
+									\
+	closure_init_stack(&cl);					\
+									\
+	while (1) {							\
+		closure_wait(waitlist, &cl);				\
+		if (_cond)						\
+			break;						\
+		closure_sync(&cl);					\
+	}								\
+	closure_wake_up(waitlist);					\
+	closure_sync(&cl);						\
+} while (0)
+
+#define closure_wait_event(waitlist, _cond)				\
+do {									\
+	if (!(_cond))							\
+		__closure_wait_event(waitlist, _cond);			\
+} while (0)
+
 #endif /* _LINUX_CLOSURE_H */
-- 
2.17.0

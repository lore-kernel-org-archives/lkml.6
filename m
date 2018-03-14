Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeCNTZc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:25:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeCNTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:25:30 -0400
Date: Wed, 14 Mar 2018 12:25:14 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-163cf842f5837334bc69aaf09ad38e11f4573914@git.kernel.org>
Cc: mingo@kernel.org, longman@redhat.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org, longman@redhat.com, arnd@arndb.de,
        mingo@kernel.org
In-Reply-To: <20180313131857.158876-1-arnd@arndb.de>
References: <20180313131857.158876-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Avoid another unused variable
 warning
Git-Commit-ID: 163cf842f5837334bc69aaf09ad38e11f4573914
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  163cf842f5837334bc69aaf09ad38e11f4573914
Gitweb:     https://git.kernel.org/tip/163cf842f5837334bc69aaf09ad38e11f4573914
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Tue, 13 Mar 2018 14:18:46 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 20:20:01 +0100

debugobjects: Avoid another unused variable warning

debug_objects_maxchecked is only updated in __debug_check_no_obj_freed(),
and only read in debug_objects_maxchecked, unfortunately both of these are
optional and depend on different Kconfig symbols.

When both CONFIG_DEBUG_OBJECTS_FREE and CONFIG_DEBUG_FS are disabled this
warning is emitted:

  lib/debugobjects.c:56:14: error: 'debug_objects_maxchecked' defined but not used [-Werror=unused-variable]

Rather than trying to add more complex #ifdef protections, mark the
variable as __maybe_unused so it can be silently dropped when usused.

Fixes: bd9dcd046509 ("debugobjects: Export max loops counter")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20180313131857.158876-1-arnd@arndb.de

---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 105ecfc47d8c..994be4805cec 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -53,7 +53,7 @@ static int			obj_nr_tofree;
 static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
-static int			debug_objects_maxchecked __read_mostly;
+static int __maybe_unused	debug_objects_maxchecked __read_mostly;
 static int			debug_objects_fixups __read_mostly;
 static int			debug_objects_warnings __read_mostly;
 static int			debug_objects_enabled __read_mostly

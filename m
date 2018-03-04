Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeCDHQh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 02:16:37 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46524 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeCDHQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 02:16:36 -0500
X-Google-Smtp-Source: AG47ELta3QfY9tetzIo3o5DLo/4uc9EkF525FFFObJsIji8WFI+x6oUK63Q//vLyO4LCXzqT/X0cVg==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory-failure: fix section mismatch
Date: Sat,  3 Mar 2018 23:16:11 -0800
Message-Id: <20180304071613.16899-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.14.1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang complains when a variable is declared extern twice, but with two
different sections. num_poisoned_pages is marked extern and __read_mostly
in include/linux/swapops.h, but only extern in include/linux/mm.h. Some
c source files must include both, and thus see the conflicting
declarations.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..bd4bd59f02c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2582,7 +2582,7 @@ extern int get_hwpoison_page(struct page *page);
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
-extern atomic_long_t num_poisoned_pages;
+extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(struct page *page, int flags);
 
 
-- 
2.14.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeDFUO7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:14:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42484 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeDFUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:14:58 -0400
X-Google-Smtp-Source: AIpwx4/YzZDzRYYlvwKwuGRd89xo2A3xC0vecf7MGqLoYEYY4DwYHu73oHSYo96LNok9tooEMYv6uA==
From: Mathieu Malaterre <malat@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mathieu Malaterre <malat@debian.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>, Tejun Heo <tj@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] backing: silence compiler warning using __printf
Date: Fri,  6 Apr 2018 22:14:51 +0200
Message-Id: <20180406201453.32683-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__printf marker was added in commit d2cc4dde9206 ("bdi_register: add
__printf verification, fix arg mismatch") for function `bdi_register`
since it is useful to verify format and arguments. Apply equivalent gcc
attribute to `bdi_register_va`.

Remove warning triggered with W=1:

  mm/backing-dev.c:881:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/backing-dev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 3e4ce54d84ab..0e9c0f71f726 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -28,6 +28,7 @@ void bdi_put(struct backing_dev_info *bdi);
 
 __printf(2, 3)
 int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...);
+__printf(2, 0)
 int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
 		    va_list args);
 int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
-- 
2.11.0

Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B68FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1C420862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1C420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbeG0S7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:59:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389347AbeG0Sy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDA9181663CE;
        Fri, 27 Jul 2018 17:32:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 546851C5B9;
        Fri, 27 Jul 2018 17:32:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/38] vfs: Introduce logging functions [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:02 +0100
Message-ID: <153271272284.9458.1302779298307992140.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:32:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:32:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a set of logging functions through which informational messages,
warnings and error messages incurred by the mount procedure can be logged
and, in a future patch, passed to userspace instead by way of the
filesystem configuration context file descriptor.

There are four functions:

 (1) infof(const char *fmt, ...);

     Logs an informational message.

 (2) warnf(const char *fmt, ...);

     Logs a warning message.

 (3) errorf(const char *fmt, ...);

     Logs an error message.

 (4) invalf(const char *fmt, ...);

     As errof(), but returns -EINVAL so can be used on a return statement.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fs_context.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 0ff4969f9d5a..a88b54752f86 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -98,4 +98,46 @@ struct fs_context_operations {
 	int (*get_tree)(struct fs_context *fc);
 };
 
+#define logfc(FC, FMT, ...) pr_notice(FMT, ## __VA_ARGS__)
+
+/**
+ * infof - Store supplementary informational message
+ * @fc: The context in which to log the informational message
+ * @fmt: The format string
+ *
+ * Store the supplementary informational message for the process if the process
+ * has enabled the facility.
+ */
+#define infof(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+
+/**
+ * warnf - Store supplementary warning message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary warning message for the process if the process has
+ * enabled the facility.
+ */
+#define warnf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+
+/**
+ * errorf - Store supplementary error message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary error message for the process if the process has
+ * enabled the facility.
+ */
+#define errorf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+
+/**
+ * invalf - Store supplementary invalid argument error message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary error message for the process if the process has
+ * enabled the facility and return -EINVAL.
+ */
+#define invalf(fc, fmt, ...) ({	errorf(fc, fmt, ## __VA_ARGS__); -EINVAL; })
+
 #endif /* _LINUX_FS_CONTEXT_H */


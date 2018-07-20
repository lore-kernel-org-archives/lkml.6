Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A23ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C83A2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C83A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeGTNOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeGTNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:43 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64E4FBC1;
        Fri, 20 Jul 2018 12:26:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 01/31] compiler, clang: suppress warning for unused static inline functions
Date:   Fri, 20 Jul 2018 14:13:31 +0200
Message-Id: <20180720121340.208690374@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rientjes <rientjes@google.com>

commit abb2ea7dfd82451d85ce669b811310c05ab5ca46 upstream.

GCC explicitly does not warn for unused static inline functions for
-Wunused-function.  The manual states:

	Warn whenever a static function is declared but not defined or
	a non-inline static function is unused.

Clang does warn for static inline functions that are unused.

It turns out that suppressing the warnings avoids potentially complex
#ifdef directives, which also reduces LOC.

Suppress the warning for clang.

Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-clang.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -15,3 +15,10 @@
  * with any version that can compile the kernel
  */
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
+
+/*
+ * GCC does not warn about unused static inline functions for
+ * -Wunused-function.  This turns out to avoid the need for complex #ifdef
+ * directives.  Suppress the warning in clang as well.
+ */
+#define inline inline __attribute__((unused))



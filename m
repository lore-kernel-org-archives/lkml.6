Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D043C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87662087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="asz0W2ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87662087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeLDLJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbeLDLJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9342146D;
        Tue,  4 Dec 2018 11:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921756;
        bh=m8scQTFefAP0BQztGhnrlrLv3gms0WmwiULgb4WQ4s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asz0W2ly+JxxdH+HU4upFFhiV1moCLO7O5OQ6RKzusHal6SV2q1ZaY+3mlZ5b5I/V
         nSQJjBzw1JbwF9XquNx7neAI9SNTXOQDc9mUF/nalz7LpkVBDySlzbMJrg8O3NP9hc
         81iJ928mBr0v2sHcfd/YwmJEfFLUeSw8v3iRI+Bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tejun Heo <tj@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 48/50] workqueue: avoid clang warning
Date:   Tue,  4 Dec 2018 11:50:43 +0100
Message-Id: <20181204103716.894717649@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

(commit a45463cbf3f9dcdae683033c256f50bded513d6a upstream)

Building with clang shows lots of warning like:

drivers/amba/bus.c:447:8: warning: implicit conversion from 'long long' to 'int' changes value from 4294967248 to -48
      [-Wconstant-conversion]
static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/workqueue.h:187:26: note: expanded from macro 'DECLARE_DELAYED_WORK'
        struct delayed_work n = __DELAYED_WORK_INITIALIZER(n, f, 0)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/workqueue.h:177:10: note: expanded from macro '__DELAYED_WORK_INITIALIZER'
        .work = __WORK_INITIALIZER((n).work, (f)),                      \
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/workqueue.h:170:10: note: expanded from macro '__WORK_INITIALIZER'
        .data = WORK_DATA_STATIC_INIT(),                                \
                ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/workqueue.h:111:39: note: expanded from macro 'WORK_DATA_STATIC_INIT'
        ATOMIC_LONG_INIT(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC)
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
include/asm-generic/atomic-long.h:32:41: note: expanded from macro 'ATOMIC_LONG_INIT'
 #define ATOMIC_LONG_INIT(i)     ATOMIC_INIT(i)
                                ~~~~~~~~~~~~^~
arch/arm/include/asm/atomic.h:21:27: note: expanded from macro 'ATOMIC_INIT'
 #define ATOMIC_INIT(i)  { (i) }
                        ~  ^

This makes the type cast explicit, which shuts up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/workqueue.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -106,9 +106,9 @@ struct work_struct {
 #endif
 };
 
-#define WORK_DATA_INIT()	ATOMIC_LONG_INIT(WORK_STRUCT_NO_POOL)
+#define WORK_DATA_INIT()	ATOMIC_LONG_INIT((unsigned long)WORK_STRUCT_NO_POOL)
 #define WORK_DATA_STATIC_INIT()	\
-	ATOMIC_LONG_INIT(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC)
+	ATOMIC_LONG_INIT((unsigned long)(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC))
 
 struct delayed_work {
 	struct work_struct work;



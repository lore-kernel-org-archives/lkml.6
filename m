Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7CE20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAwtn4Ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7CE20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbeGWWuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:50:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35330 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGWWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:50:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so1303979pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=sBBg/ZlROUcB8xJRxMUeMIJc2BV5pntlFlG0jWSuGRA=;
        b=CAwtn4UeeerJlWCys98JVfUY9vn0ho+foi9tHCIQBY/MhQLkORWf1tY+0bfVz1Uhd7
         qJPpnq17wt7on4yOpPQQYa3ce4Gru8pprDz5S4Dx7/wkdJpi0E7jyh5mS4v/89UZURn4
         7tWSfoIxzTc//JDmpYzgWILtVAAxwU5xi249GGRtFnW08qQRCkxo/+qfndHxIP5UIi6a
         viSxEZB2lLFlp20Z3lAERyo/REMQIcI6leRtBmFtz+kY/qA+Z6ID2csX5wUgcFg+flKd
         YgEple8INQ/8Hsgbz0NTUUC5tgeC0ZHUN9JzYgvxqtCUZSCVf0b7nMrcUVveNRzbIEEs
         C0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=sBBg/ZlROUcB8xJRxMUeMIJc2BV5pntlFlG0jWSuGRA=;
        b=oUTs1Nnwoezx1Vdocu7E4fuyhd7LR9fM+KXYhx3ZG8JmLZClN1pkrJFEQokK6Hovyf
         bvASPc0kMDFbtG2l7HWUdxKuFhTHhj98f4yqozdZyDOzcRDCjDVGkDHH2eHaiK39y70y
         VHYEfp9olI6BvnMOc/AsO4XAgC98O5luq7KpngyxDQOcFoPHDlEOtfIc9LqnVg+O1usE
         8kcSaoPrOOvIjDOTOJ1ckQbVoCwErTS78cn2sKm6ICegW9L+OxreOAKAxKEvOh5j0vxd
         kYSJI8dC0m2WkKnupMCSo8/fF9rTscW1k1vh9HQy0O9RK8T+zO/ebqVmTG30skPt8pyQ
         a8hg==
X-Gm-Message-State: AOUpUlF4fQ6RRmfRwl166qX4mct8TkGQy4WDAqf8bWgYJy+JOvbibfaf
        Dz2PQds5ykD8XIxENDYRYe3f9wNg
X-Google-Smtp-Source: AAOMgpfJ3F9omtcqgt8ffkGykVOtjS6KaQ2EoRTM/6BOXfAW6abfMAFZ8Iuf0gBEPkBvc4SQpaRi/g==
X-Received: by 2002:a65:4541:: with SMTP id x1-v6mr13481767pgr.26.1532382445967;
        Mon, 23 Jul 2018 14:47:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m26-v6sm18778250pfi.102.2018.07.23.14.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:47:25 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] android: binder_alloc: Include asm/cacheflush.h after linux/ include files
Date:   Mon, 23 Jul 2018 14:47:23 -0700
Message-Id: <1532382443-14183-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If asm/cacheflush.h is included first, the following build warnings are
seen with sparc32 builds.

In file included from ./arch/sparc/include/asm/cacheflush.h:11:0,
	from drivers/android/binder_alloc.c:20:
./arch/sparc/include/asm/cacheflush_32.h:40:37: warning:
	'struct page' declared inside parameter list

Moving the asm/ include after linux/ includes fixes the problem.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2628806c64a2..2c258dcf9d72 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -17,7 +17,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <asm/cacheflush.h>
 #include <linux/list.h>
 #include <linux/sched/mm.h>
 #include <linux/module.h>
@@ -28,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/list_lru.h>
+#include <asm/cacheflush.h>
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
-- 
2.7.4


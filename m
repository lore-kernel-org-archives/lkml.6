Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EC9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6A420892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6A420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbeG3Oan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:30:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbeG3Oam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:30:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DC21AE4D;
        Mon, 30 Jul 2018 12:55:49 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 49058A0BE8; Mon, 30 Jul 2018 14:55:49 +0200 (CEST)
Message-Id: <6720ebfe08ea06ddc81aa3f576b5cca8a2495fd6.1532954671.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532954671.git.mkubecek@suse.cz>
References: <cover.1532954671.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH ethtool v2 01/23] move UAPI header copies to a separate
 directory
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:55:49 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming netlink series is going to add more local copies of kernel
UAPI header files and some of them are going to include others. Keeping
them in the main directory under modified name would require modifying
those includes as well which would be impractical.

Create a subdirectory uapi and move the UAPI headers there to allow
including them in the usual way.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Makefile.am                                  | 6 +++---
 internal.h                                   | 4 ++--
 ethtool-copy.h => uapi/linux/ethtool.h       | 0
 net_tstamp-copy.h => uapi/linux/net_tstamp.h | 0
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename ethtool-copy.h => uapi/linux/ethtool.h (100%)
 rename net_tstamp-copy.h => uapi/linux/net_tstamp.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 14f79b68a9ee..e7da37a85499 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,12 +1,12 @@
-AM_CFLAGS = -Wall
+AM_CFLAGS = -I./uapi -Wall
 LDADD = -lm
 
 man_MANS = ethtool.8
 EXTRA_DIST = LICENSE ethtool.8 ethtool.spec.in aclocal.m4 ChangeLog autogen.sh
 
 sbin_PROGRAMS = ethtool
-ethtool_SOURCES = ethtool.c ethtool-copy.h internal.h net_tstamp-copy.h \
-		  rxclass.c
+ethtool_SOURCES = ethtool.c uapi/linux/ethtool.h internal.h \
+		  uapi/linux/net_tstamp.h rxclass.c
 if ETHTOOL_ENABLE_PRETTY_DUMP
 ethtool_SOURCES += \
 		  amd8111e.c de2104x.c e100.c e1000.c et131x.c igb.c	\
diff --git a/internal.h b/internal.h
index b239dc7acbd8..0b04a9794b6b 100644
--- a/internal.h
+++ b/internal.h
@@ -42,8 +42,8 @@ typedef int32_t s32;
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #endif
 
-#include "ethtool-copy.h"
-#include "net_tstamp-copy.h"
+#include <linux/ethtool.h>
+#include <linux/net_tstamp.h>
 
 #if __BYTE_ORDER == __BIG_ENDIAN
 static inline u16 cpu_to_be16(u16 value)
diff --git a/ethtool-copy.h b/uapi/linux/ethtool.h
similarity index 100%
rename from ethtool-copy.h
rename to uapi/linux/ethtool.h
diff --git a/net_tstamp-copy.h b/uapi/linux/net_tstamp.h
similarity index 100%
rename from net_tstamp-copy.h
rename to uapi/linux/net_tstamp.h
-- 
2.18.0


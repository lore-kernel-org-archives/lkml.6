Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE701C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B120684
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3B120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbeIUPdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:33:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:50943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389560AbeIUPdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:33:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 02:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="265507948"
Received: from xuting-mobl.ccr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.29.10])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2018 02:45:34 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH] selftests/gpio: fix compiling errors
Date:   Fri, 21 Sep 2018 18:00:21 +0800
Message-Id: <1537524021-3371-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lizhijian@haswell-OptiPlex-9020:/home/lizj/linux/tools/testing/selftests$ make
[...snip...]
make ARCH=x86 CROSS_COMPILE= -C ../../../gpio
make[2]: Entering directory '/home/lizj/linux/tools/gpio'
[...snip...]
make[3]: Leaving directory '/home/lizj/linux/tools/gpio'
  LINK     /home/lizj/linux/tools/testing/selftests/gpiogpio-event-mon
make[2]: Leaving directory '/home/lizj/linux/tools/gpio'
gcc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ gpio-mockup-chardev.c ../../../gpio/gpio-utils.o  -lmount -I/usr/include/libmount -o gpio-mockup-chardev
gcc: error: ../../../gpio/gpio-utils.o: No such file or directory
<builtin>: recipe for target 'gpio-mockup-chardev' failed
make[1]: *** [gpio-mockup-chardev] Error 1
make[1]: Leaving directory
'/home/lizj/linux/tools/testing/selftests/gpio'
Makefile:85: recipe for target 'all' failed
make: *** [all] Error 2

in this patch
- correct target name to $OUTPUTgpio-utils.o
- pass OUTPUT to tools/gpio/Makefile
- support cleanup ../gpiogpio-hammer.o

CC: Bamvor Jian Zhang <bamv2005@gmail.com>
CC: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-gpio@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/gpio/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 4665cdb..7f9354a 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -7,7 +7,7 @@ EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
 EXTRA_DIRS := ../gpioinclude/
 EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
 EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
-EXTRA_OBJS += ../gpiolsgpio.o
+EXTRA_OBJS += ../gpiolsgpio.o ../gpiogpio-hammer.o
 
 include ../lib.mk
 
@@ -22,7 +22,7 @@ CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
 LDLIBS += -lmount -I/usr/include/libmount
 
 $(BINARIES):| khdr
-$(BINARIES): ../../../gpio/gpio-utils.o
+$(BINARIES): ../gpiogpio-utils.o
 
-../../../gpio/gpio-utils.o:
-	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
+../gpiogpio-utils.o:
+	make OUTPUT=$(OUTPUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
-- 
2.7.4


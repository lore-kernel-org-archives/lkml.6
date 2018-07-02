Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682B5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3A2258D9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3A2258D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbeGBDy2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:54:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:43408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbeGBDyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:54:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 20:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,297,1526367600"; 
   d="scan'208";a="63693736"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.29.56])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2018 20:54:05 -0700
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH 3/3] selftests/gpio: unset OUTPUT for build tools/gpio
Date:   Mon,  2 Jul 2018 11:53:54 +0800
Message-Id: <1530503634-32241-4-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530503634-32241-3-git-send-email-lizhijian@cn.fujitsu.com>
References: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1530503634-32241-2-git-send-email-lizhijian@cn.fujitsu.com>
 <1530503634-32241-3-git-send-email-lizhijian@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when we execute 'make' to build selftests, the TOP Makefile build gpio like:
selftests$ make ARCH= CROSS_COMPILE= OUTPUT=/home/lizj/linux/tools/testing/selftests/gpio -C gpio
...
make[2]: Leaving directory '/home/lizj/linux/tools/gpio'
gcc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/gpio-mockup-chardev.c ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h  -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/uuid -lmount -o gpio-mockup-chardev
gcc: error: ../../../gpio/gpio-utils.o: No such file or directory
<builtin>: recipe for target 'gpio-mockup-chardev' failed
make[1]: *** [gpio-mockup-chardev] Error 1
make[1]: Leaving directory
'/home/lizj/linux/tools/testing/selftests/gpio'
Makefile:84: recipe for target 'all' failed
make: *** [all] Error 2

CC: Bamvor Jian Zhang <bamv2005@gmail.com>
CC: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-gpio@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/gpio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb475..e64a11c 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -24,7 +24,7 @@ LDLIBS += -lmount -I/usr/include/libmount
 $(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
 
 ../../../gpio/gpio-utils.o:
-	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
+	make OUTPUT= ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
 
 ../../../../usr/include/linux/gpio.h:
 	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-- 
2.7.4


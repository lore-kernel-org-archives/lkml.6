Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798DBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE92087A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwGDDimF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeIGTRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:17:13 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39963 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIGTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:17:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so27605178oig.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MTJMlsL/qn3+Dab4i8dJ2bnn9KxJOVfBWvsWQ3iChLM=;
        b=LwGDDimF6XRqHckkC2nHruCIBfW8R0074mLtWo+j4z7KEJV/Yi/JzZ/IkjNg+aQMzs
         Wrr8mfpu6mT4oyNNOsPwvr/tboAI0SnNdzPNldoF1zg0Gqkg271N4HGcmUozFFjtVA/O
         KIbeGEyTdxATnhHNaufH/r0KoQoQ4V10IeAlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MTJMlsL/qn3+Dab4i8dJ2bnn9KxJOVfBWvsWQ3iChLM=;
        b=DilGnikmVXl6ee6kultp9kwMalCm5Hhoci5UgTZtVjMI01ACfaJ8hVkgPWQVPWQ6Xe
         XoRB9PBRPgMWZmbPfhWnon+xkE1R3e8unhLBqT/G7rbRcMI1wQECpKPeydOYJO97Uh78
         Sb5eNOzRa0tYq3nMRjXS89twWnq57tnzrmr3RlouYuHYNS0GYiHxa5OXIGFtPkShXpjv
         9yv4gv/c7X/CdAqTcH8EsMuhK9Hf4bJ1uQYI4/5LyjfJ6TFSNxvv7lRp1sVZIen4XLfF
         /yU90EcIeVz/uIx+/RK4nSBpDWhbGsdw/IGFhjcCzBMp6uCJT7Lw67UueopwFX85S+3H
         jHKQ==
X-Gm-Message-State: APzg51B31UMe2Z5u8AyqitRKIh/V9QKiU2bLbs4e7PzknWkuGkB1a1WV
        i/L7PJkfETYlV/eyAVc8eAGblA==
X-Google-Smtp-Source: ANB0VdY4Sj/e/UqGIW8DgBOHr8CgUcozfSZU/AGlcKdOYIMMmUSI/6Pd5Q7hqR0yg07fNIGo6zBpJw==
X-Received: by 2002:aca:ac54:: with SMTP id v81-v6mr8010762oie.1.1536330960021;
        Fri, 07 Sep 2018 07:36:00 -0700 (PDT)
Received: from aura.cortijodelrio.net ([187.161.144.121])
        by smtp.googlemail.com with ESMTPSA id i132-v6sm10306360oif.20.2018.09.07.07.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 07:35:58 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc:     linus.walleij@linaro.org, Fathi Boudra <fathi.boudra@linaro.org>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] selftests: gpio: restructure Makefile
Date:   Fri,  7 Sep 2018 09:34:54 -0500
Message-Id: <1536330895-8391-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fathi Boudra <fathi.boudra@linaro.org>

This patch cleans up the Makefile by restructuring a couple of
things, namely:
1) change explicit paths in targets for variables
2) substitute a variable (BINARIES) for another, part of the
   selftests build system (TEST_PROGS_EXTENDED)
3) proper cleaning up of the EXTRA objects

The resulting Makefile is much more readable and manageable.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/gpio/Makefile | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 4665cdb..a4a01ec8 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,28 +1,26 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
+LDLIBS += -lmount -I/usr/include/libmount
+
 TEST_PROGS := gpio-mockup.sh
-TEST_FILES := gpio-mockup-sysfs.sh $(BINARIES)
-BINARIES := gpio-mockup-chardev
-EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
-EXTRA_DIRS := ../gpioinclude/
-EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
-EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
-EXTRA_OBJS += ../gpiolsgpio.o
+TEST_FILES := gpio-mockup-sysfs.sh
+TEST_PROGS_EXTENDED := gpio-mockup-chardev
+
+GPIODIR := ../../../gpio
+GPIOOBJ := gpio-utils.o
 
 include ../lib.mk
 
-all: $(BINARIES)
+all: $(TEST_PROGS_EXTENDED)
 
 override define CLEAN
-	$(RM) $(BINARIES) $(EXTRA_PROGS) $(EXTRA_OBJS)
-	$(RM) -r $(EXTRA_DIRS)
+	$(RM) $(TEST_PROGS_EXTENDED)
+	$(MAKE) -C $(GPIODIR) clean
 endef
 
-CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
-LDLIBS += -lmount -I/usr/include/libmount
-
-$(BINARIES):| khdr
-$(BINARIES): ../../../gpio/gpio-utils.o
+$(TEST_PROGS_EXTENDED):| khdr
+$(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
 
-../../../gpio/gpio-utils.o:
-	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
+$(GPIODIR)/$(GPIOOBJ):
+	$(MAKE) -C $(GPIODIR)
-- 
2.7.4


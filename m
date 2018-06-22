Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482F523EB0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/2RjIxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482F523EB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeFVIJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:09:59 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38688 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeFVIJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:09:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so2634904pgf.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iTLLhdNlaIGY0bI+lB6w+m6AewzVL5yDimWaS8xtwqU=;
        b=j/2RjIxS3v5mOm83rmN7PDBXzKjbQEmp7vzJq4UD2LP6z6VUwRSys/YWlsskSjS6iE
         6czE75yFjifAtG9wUd7R6YIz+Mt2Y+zTNS2NECk7sOl4UfPdw6KFr6HYV8HfXH8VUUqq
         BVh64Ns9hPu9CwPRAcCTtVwZOYF/i/jepT+4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iTLLhdNlaIGY0bI+lB6w+m6AewzVL5yDimWaS8xtwqU=;
        b=gXyKqNyW3cU0JlJh81tlh/GyYSNGHkBjIPYEXZGvhJoT2DwitWUwpjzUAo2fqja711
         frTif3wrTeQi+WtDHMTaD8X8l5dLruKXwo0ZfaMAt4qO2iqZnM7pq5Ratv++JulOKWUp
         ZLfceFfSEAfuyfrqiVLMIcAGQQyMNCCcc4nL342ADOHqnqelZa9Xn8leI/a+1+vIY/Sy
         N9EGa3pB5uLUvAhkZUPHwQ3uN93crNN/tCW7uQL2EveJJDC4Gzy1Vq1wwRV+ShZbEaH3
         2h5+gSykhweC+lIh6mSnIWLYAiyUsxTSKilt5LsvooA4RNKHq815aQ2YHeHe+KOFdlYI
         5WWQ==
X-Gm-Message-State: APt69E36u95tD0IqrsRO6533BsZJsvypAgRSzssAFBojUPYXRyiDJy2S
        3GB4m2oiPV96PtXKRDx1OpyjYA==
X-Google-Smtp-Source: ADUXVKKhoOE35wNDhaf/mwBAlZgDPHWJ1GTIXHbiYJUdfQQVHDFVr3OBjnhLpxqhYIdLmmG5WUUP+Q==
X-Received: by 2002:a62:ca99:: with SMTP id y25-v6mr623976pfk.187.1529654993821;
        Fri, 22 Jun 2018 01:09:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.09.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:09:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] hwspinlock: Add one new API to support getting a specific hwlock by the name
Date:   Fri, 22 Jun 2018 16:08:58 +0800
Message-Id: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware spinlock binding already supplied the 'hwlock-names' property
to match and get a specific hwlock, but did not supply one API for users
to get a specific hwlock by the hwlock name. So this patch introduces one
API to support this requirement.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |   29 +++++++++++++++++++++++++++++
 include/linux/hwspinlock.h           |    7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index d16e6a3..bea3586 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -367,6 +367,35 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
 }
 EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id);
 
+/**
+ * of_hwspin_lock_get_id_byname() - get lock id for an specified hwlock name
+ * @np: device node from which to request the specific hwlock
+ * @name: hwlock name
+ *
+ * This function provides a means for DT users of the hwspinlock module to
+ * get the global lock id of a specific hwspinlock using the specified name of
+ * the hwspinlock device, so that it can be requested using the normal
+ * hwspin_lock_request_specific() API.
+ *
+ * Returns the global lock id number on success, -EPROBE_DEFER if the hwspinlock
+ * device is not yet registered, -EINVAL on invalid args specifier value or an
+ * appropriate error as returned from the OF parsing of the DT client node.
+ */
+int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
+{
+	int index;
+
+	if (!name)
+		return -EINVAL;
+
+	index = of_property_match_string(np, "hwlock-names", name);
+	if (index < 0)
+		return index;
+
+	return of_hwspin_lock_get_id(np, index);
+}
+EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id_byname);
+
 static int hwspin_lock_register_single(struct hwspinlock *hwlock, int id)
 {
 	struct hwspinlock *tmp;
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 57537e6..2b6f389 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -66,6 +66,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 							unsigned long *);
 int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
 void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
+int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
 
 #else /* !CONFIG_HWSPINLOCK */
 
@@ -125,6 +126,12 @@ static inline int hwspin_lock_get_id(struct hwspinlock *hwlock)
 	return 0;
 }
 
+static inline
+int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_HWSPINLOCK */
 
 /**
-- 
1.7.9.5


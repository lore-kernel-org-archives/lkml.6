Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B63C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0582082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0582082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeH3XJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:09:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33554 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbeH3XJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:09:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so17426828oip.0;
        Thu, 30 Aug 2018 12:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gT6Td7yY5tXHBprHnqiX0q1IaJ6j1fqehgRBLMkuZ2g=;
        b=N1Gzo9X7auVZ58M84Rar/dWKNQDFUj26T+a9PnrGmpQOEvFBcOqYL4/9l0Xvxyrdeh
         c9m/QIFDAYK8mAo360Swdg+ZVHBTjP0Tc/wBQ/hzk4j7KCNoSKyy6mKC/XTMnIC9ZcJd
         kjc54O9otaHr6hGLjyW+9XIFBE/ioIQHwLmooj+B6ppgqeoB6aym1BHutGRlKv10rT0t
         6s2uR8t3FealiNfEQaVZu7yF7qG/yFhZuuuHnZjjvW/odnxQhryxcQP5XWza4vCBxV+f
         xwo3yNzTu456GanTVJHP3Vaeh0pYWbJaij1njbnaKcbY27ZqLtehpp3+wk55BgZ0vs4+
         LPvw==
X-Gm-Message-State: APzg51CmI+2i7fOTe5GlQu3Bh8GCIdz0VCxJzsKM4yJwru8SVECeBMmk
        oBevbyHf5HjTCPpc+riG9w==
X-Google-Smtp-Source: ANB0VdZES4DB4DgpymEnV39+Drnrum9Rblb9QX0scJTCouLc16rgGjjb3cjCjiTmQvFnWpCI0WNDFg==
X-Received: by 2002:aca:f58f:: with SMTP id t137-v6mr3767451oih.244.1535655927378;
        Thu, 30 Aug 2018 12:05:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 22-v6sm4200423oix.58.2018.08.30.12.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:05:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 3/3] of: make default address and size cells sizes private
Date:   Thu, 30 Aug 2018 14:05:23 -0500
Message-Id: <20180830190523.31474-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830190523.31474-1-robh@kernel.org>
References: <20180830190523.31474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only some old OpenFirmware implementations rely on default sizes. Any
FDT and modern implementation should have explicit properties. Make the
OF_ROOT_NODE_*_CELLS_DEFAULT defines private so we don't get any outside
users.

This also gets us one step closer to removing the asm/prom.h dependency on
Sparc.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/include/asm/prom.h | 3 ---
 drivers/of/of_private.h       | 8 ++++++++
 include/linux/of.h            | 6 ------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index d955c8df62d6..1902db27ff4b 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -24,9 +24,6 @@
 #include <linux/atomic.h>
 #include <linux/irqdomain.h>
 
-#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
-#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
-
 #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
 #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcmp((s1), (s2))
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 216175d11d3d..5d1567025358 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -27,6 +27,14 @@ struct alias_prop {
 	char stem[0];
 };
 
+#if defined(CONFIG_SPARC)
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 2
+#else
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
+#endif
+
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
+
 extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
diff --git a/include/linux/of.h b/include/linux/of.h
index 506beca9588d..49d85f670c75 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -247,12 +247,6 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 #include <asm/prom.h>
 #endif
 
-/* Default #address and #size cells.  Allow arch asm/prom.h to override */
-#if !defined(OF_ROOT_NODE_ADDR_CELLS_DEFAULT)
-#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
-#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
-#endif
-
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
-- 
2.17.1


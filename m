Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E85ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCE420856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCE420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=xiaomi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJZAFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:05:44 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.124]:39797 "EHLO
        outboundhk.mxmail.xiaomi.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbeJZAFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:05:44 -0400
X-AuditID: 0a3808cf-a91ff70000013720-83-5bd1c25a4a18
Received: from xiaomi.com (cnbox2.mioffice.cn [10.237.8.142])
        by outboundhk.mxmail.xiaomi.com (xiaomi.com) with SMTP id 2B.FE.14112.A52C1DB5; Thu, 25 Oct 2018 21:17:14 +0800 (HKT)
Received: from cpu.mioffice.cn (10.237.91.193) by cnbox2.mioffice.cn
 (10.237.8.142) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Thu, 25 Oct
 2018 21:17:14 +0800
From:   Peng Wang <wangpeng15@xiaomi.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Peng Wang <wangpeng15@xiaomi.com>
Subject: [PATCH] pstore: Remove duplicate invoking of persistent_ram_zap()
Date:   Thu, 25 Oct 2018 21:16:45 +0800
Message-ID: <20181025131645.8489-1-wangpeng15@xiaomi.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.237.91.193]
X-ClientProxiedBy: CNCAS1.mioffice.cn (10.237.8.131) To cnbox2.mioffice.cn
 (10.237.8.142)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXC9ZajTzfq0MVog+03jS0u75rD5sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfG3VuHmAs+clcsfriNuYHxJGcXIyeHhICJxK+Fc1m7GLk4hAS2
        Mko8bu1hgnBWMEqcWXGACaSKTUBdont7FzuILSKgJPH9WjcjiM0soCpxbtcWMFtYwEti9r+T
        rCA2C1B8z/ojQDYHB6+ApcTDK2EQy+QlGnZtBhvDKyAocXLmExaIMfISzVtnM0PYEhIHX7wA
        s4WAVm243s4GMkZCQFHi1/9YiDHREg9+z2CbwCgwC8mkWUgmzUIyaQEj8ypGyYz8vPRsIC4u
        SMw10svNzE9Ly0xO1UvO28QICkMLjvM7GD+eTD3EKMDBqMTDq7D5QrQQa2JZcWXuIUYJDmYl
        EV7nuIvRQrwpiZVVqUX58UWlOanFhxilOViUxHkNGg9ECwmkJ5akZqemFqQWwWSZODilGhjn
        zhK4wG8kkRLYzbn04HzW2PMvcv//t9H/IKl+sOPsviDf0o9x2bxfHFSv9Kndj3E95H0i20F0
        1YQ3lTuW9AuJTdezTP65Qn4L67K9TL0c+x5oTEhcIGU/8zXzM6Z7Jg2yQXNW1S7/pJt7f5/g
        zuS3lb/1xJdGTI0493PS9Rq1vOUv70x6/aZTiaU4I9FQi7moOBEAjiDb1D8CAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initialing przs with invalid data in buffer(no PERSISTENT_RAM_SIG),
function call path is like this:

ramoops_init_prz ->
|
|-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
|
|--> persistent_ram_zap

As we can see, persistent_ram_zap() is called twice.
We can avoid this by removing it in ramoops_init_prz(),
and only call it in persistent_ram_post_init().

Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
---
 fs/pstore/ram.c      | 2 --
 fs/pstore/ram_core.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index f4fd2e7..d2a3932 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -639,8 +639,6 @@ static int ramoops_init_prz(const char *name,
 		return err;
 	}
 
-	persistent_ram_zap(*prz);
-
 	*paddr += sz;
 
 	return 0;
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 0792595..3ab4f34 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -504,15 +504,14 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 			pr_debug("found existing buffer, size %zu, start %zu\n",
 				 buffer_size(prz), buffer_start(prz));
 			persistent_ram_save_old(prz);
-			return 0;
 		}
 	} else {
 		pr_debug("no valid data in buffer (sig = 0x%08x)\n",
 			 prz->buffer->sig);
+		prz->buffer->sig = sig;
 	}
 
 	/* Rewind missing or invalid memory area. */
-	prz->buffer->sig = sig;
 	persistent_ram_zap(prz);
 
 	return 0;
-- 
1.9.1


Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F09C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0C22168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0C22168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeI0XhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:37:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25027 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbeI0XhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:37:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42LhMf01K7z9ttCB;
        Thu, 27 Sep 2018 19:17:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2xjEdP39HZD7; Thu, 27 Sep 2018 19:17:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42LhMd6Td7z9ttBq;
        Thu, 27 Sep 2018 19:17:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B16D8B8AF;
        Thu, 27 Sep 2018 19:17:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id B6m6WGaEJdLB; Thu, 27 Sep 2018 19:17:50 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33BF98B8AE;
        Thu, 27 Sep 2018 19:17:50 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 00F7D6F1BA; Thu, 27 Sep 2018 17:17:49 +0000 (UTC)
Message-Id: <1d23a5607dca206e429c086ed622d75b92b8fd96.1538068291.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] kdb: use correct pointer when 'btc' calls 'btt'
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, stable@vger.kernel.org
Date:   Thu, 27 Sep 2018 17:17:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a powerpc 8xx, 'btc' fails as follows:

Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
kdb> btc
btc: cpu status: Currently on cpu 0
Available cpus: 0
kdb_getarea: Bad address 0x0

when booting the kernel with 'debug_boot_weak_hash', it fails as well

Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
kdb> btc
btc: cpu status: Currently on cpu 0
Available cpus: 0
kdb_getarea: Bad address 0xba99ad80

On other platforms, Oopses have been observed too, see
https://github.com/linuxppc/linux/issues/139

This is due to btc calling 'btt' with %p pointer as an argument.

This patch replaces %p by %px to get the real pointer value as
expected by 'btt'

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: <stable@vger.kernel.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Added fixes: and Daniel's reviewed-by: in commit's log. No code change.

 kernel/debug/kdb/kdb_bt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 6ad4a9fcbd6f..7921ae4fca8d 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
 				kdb_printf("no process for cpu %ld\n", cpu);
 				return 0;
 			}
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			return 0;
 		}
 		kdb_printf("btc: cpu status: ");
 		kdb_parse("cpu\n");
 		for_each_online_cpu(cpu) {
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			touch_nmi_watchdog();
 		}
-- 
2.13.3


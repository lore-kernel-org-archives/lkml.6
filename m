Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EF3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D655820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="S1oSX2t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLQVlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:41:21 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:41963 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeLQVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=dASoWlKAB4Z0mtWdMhUVGsbuu0AK3BGco/fP6hKaDgA=; b=S1oSX2t046BG
        nO2K1fuFeu09WMuISwPEhjGhSqabdMG7w7LmYZl0n9THx5XYzQqLYqsrSqGL/rIrkyjoz+M+u+KES
        pVtnFNv436cai9h03NrpE3WpyTwX32x4ORVrMdu3LNgJknqIUvJaQT6u39NcSVFuChpTLETzjcrUD
        opbWH7JgSqabWFPXJcHLlOB3OapV+J5XmS5eygS0vZU/JGMis+C/dsDi2725a8Nxpv3CWu0ljjsP6
        Vqchyzhy2Zj5y4y/3Hb924knHNtc6UkBRE6VhC5JyKIGupXng39C/DfYigKUqdAL6KMMRgIudADwW
        zn58S0RiP9r4hCc1iGfX1A==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gZ0dV-0004xR-LW; Mon, 17 Dec 2018 22:41:14 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id E581EC0715;
        Mon, 17 Dec 2018 22:41:09 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Thomas Graf <tgraf@suug.ch>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/rhashtable: Fix work initialization in rhashtable_init()
Date:   Mon, 17 Dec 2018 13:40:58 -0800
Message-Id: <20181217214058.76811-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ik9emMvjwURLqASsQ16WHJ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTY7kP7SE5PspddmLm4Y2shdcMNtQ3gDCyokLOwakJbBX38Y
 o1+fC8lNE3FIrOQRy1SvEsGv7Tp864VSJvLsYVmtidMlhCno/QsYaTlhyywkGXizzUgqLGlt2aAS
 UkukayGrK6jerlezqXsbb1/G9Ow2MqcszHrwQv68X6fDjfnYLhPCniqB4jBFkrphu+nLxlzlTi6V
 lk18rRfINf43In1MJcCoQBBlcIULC9kr1JEApTYkoOkaT87cJBAel70YOH5+9RCr2FVE5l8DWP9U
 QPDf3VAnSZlBxACg67tWDDh3WMpOFwbgZzA7SHJpgzfyrZMpuUU9pQmhp2NdRojjVXAB3i4EXXSu
 eZzMCpX2tfOqKM5soQ0R2jS4GxDcxPFGC78HYSrGsYbAoc1JMz5iQaFuHVCLGjjM692BQ8BEoOya
 OSxkiwuppjVR5L7kHRvOzDqsw0lGtGlBJTXVSv8aSbhqmUBHhUbVqXdX34PqS17izGcgoMWRyDQO
 gOfu0/aOm8sRAddxxZD/HX3rnKNSTysT2+mjZSBX08/Qa05JAIPdanoSKlHMxVnkurBPHtW+f1JZ
 BGKGpZFwJprvIwY1weIqaFcQuCVc+9fBj6baGOFZdZbcunqWjyLlj3mnRpbIWoTppHaiCRmC8Flc
 E3Ubu+PkB5hQ6nsDvccjqgmDvD9Wh+DehejWX+/lopjXORtmb8OahhUT+n0xsGm+GPoI3DkK+p7R
 cSyEW4r8ak1PtqvzG5oX8/ihFquJk/iHbbOxN6QwNFwKBhAh7NeKYzwwwYGpn4ylMlayyqEnMaij
 HZ0REET81Egg6+S0FjTV1E4esMNmGz36eUCK1+RLviVqtw6egP9SGhXsEORSpfo47NJdIKsEX5Gv
 uAP89tsR3+KZzJU3ClTXlSfQV8rvfnHgqk4UJwcvz6VMYEhUT3FsSRfv2zyjhcQtzzInhCSGs+cu
 lFbYY0bPeyKmEE09EuSN8TbpHX+vFtCJx//m0zCjZt/DB6pi1gT5ZDvoeHIWe2ba/oxCKTjFyzPG
 oGmT2XEH3eKONkBpZikjoWkT2E8Ba2BDVTEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_insert_dup() function from lib/test_rhashtable.c passes a
pointer to a stack object to rhltable_init(). Avoid that the following
is reported with object debugging enabled while running the selftest
from lib/test_rhashtable.c:

ODEBUG: object (ptrval) is on stack (ptrval), but NOT annotated.
WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:368 __debug_object_init+0x312/0x480
Modules linked in:
EIP: __debug_object_init+0x312/0x480
Call Trace:
 ? debug_object_init+0x1a/0x20
 ? __init_work+0x16/0x30
 ? rhashtable_init+0x1e1/0x460
 ? sched_clock_cpu+0x57/0xe0
 ? rhltable_init+0xb/0x20
 ? test_insert_dup+0x32/0x20f
 ? trace_hardirqs_on+0x38/0xf0
 ? ida_dump+0x10/0x10
 ? jhash+0x130/0x130
 ? my_hashfn+0x30/0x30
 ? test_rht_init+0x6aa/0xab4
 ? ida_dump+0x10/0x10
 ? test_rhltable+0xc5c/0xc5c
 ? do_one_initcall+0x67/0x28e
 ? trace_hardirqs_off+0x22/0xe0
 ? restore_all_kernel+0xf/0x70
 ? trace_hardirqs_on_thunk+0xc/0x10
 ? restore_all_kernel+0xf/0x70
 ? kernel_init_freeable+0x142/0x213
 ? rest_init+0x230/0x230
 ? kernel_init+0x10/0x110
 ? schedule_tail_wrapper+0x9/0xc
 ? ret_from_fork+0x19/0x24

Cc: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 lib/rhashtable.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 30526afa8343..6c22534c48e4 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/log2.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -1072,7 +1073,10 @@ int rhashtable_init(struct rhashtable *ht,
 
 	RCU_INIT_POINTER(ht->tbl, tbl);
 
-	INIT_WORK(&ht->run_work, rht_deferred_worker);
+	if (object_is_on_stack(ht))
+		INIT_WORK_ONSTACK(&ht->run_work, rht_deferred_worker);
+	else
+		INIT_WORK(&ht->run_work, rht_deferred_worker);
 
 	return 0;
 }
-- 
2.20.0.405.gbc1bbc6f85-goog


Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBA0C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DBF222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899444;
	bh=kXQD3DfraQBzzX/Bmef6cEVI67KTLbByVg52fU9mEk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aKptcuaxmAx8iPeDqYyOfdGXxrGCFIiB8F0nNiaYT6Qps8wt4WgrU69a6ZCcQrG6f
	 Q8Be5eYBdfHprb6DdHk3/kPRrMItcTHtR/mjy6KXW64SoZlBMI9ISpRf1owCr5Rz8M
	 5Onm6dsOKZdzNyTSTyc2nYE1gb87IUtD1atk/AJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbfBKOvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733277AbfBKOvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAADF20700;
        Mon, 11 Feb 2019 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896667;
        bh=kXQD3DfraQBzzX/Bmef6cEVI67KTLbByVg52fU9mEk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbceQG2YZK5N6peFMQz2uTs8BXmmxBcJ84mCma1bsHN8Ms/v8+0laDLhILoRXNhPB
         0v0wRJ+XSZ6Ta/NCh9cVePkin0BGKvKXBXIiNRXIQho8DectFJDtWbgIxFKz/uuV69
         4ArY3CmETya08wRWR8E+dyIVOmrOjHjKfhYPJvgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 261/313] lib/test_rhashtable: Make test_insert_dup() allocate its hash table dynamically
Date:   Mon, 11 Feb 2019 15:19:01 +0100
Message-Id: <20190211141910.743884281@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit fc42a689c4c097859e5bd37b5ea11b60dc426df6 ]

The test_insert_dup() function from lib/test_rhashtable.c passes a
pointer to a stack object to rhltable_init(). Allocate the hash table
dynamically to avoid that the following is reported with object
debugging enabled:

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
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_rhashtable.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -541,38 +541,45 @@ static unsigned int __init print_ht(stru
 static int __init test_insert_dup(struct test_obj_rhl *rhl_test_objects,
 				  int cnt, bool slow)
 {
-	struct rhltable rhlt;
+	struct rhltable *rhlt;
 	unsigned int i, ret;
 	const char *key;
 	int err = 0;
 
-	err = rhltable_init(&rhlt, &test_rht_params_dup);
-	if (WARN_ON(err))
+	rhlt = kmalloc(sizeof(*rhlt), GFP_KERNEL);
+	if (WARN_ON(!rhlt))
+		return -EINVAL;
+
+	err = rhltable_init(rhlt, &test_rht_params_dup);
+	if (WARN_ON(err)) {
+		kfree(rhlt);
 		return err;
+	}
 
 	for (i = 0; i < cnt; i++) {
 		rhl_test_objects[i].value.tid = i;
-		key = rht_obj(&rhlt.ht, &rhl_test_objects[i].list_node.rhead);
+		key = rht_obj(&rhlt->ht, &rhl_test_objects[i].list_node.rhead);
 		key += test_rht_params_dup.key_offset;
 
 		if (slow) {
-			err = PTR_ERR(rhashtable_insert_slow(&rhlt.ht, key,
+			err = PTR_ERR(rhashtable_insert_slow(&rhlt->ht, key,
 							     &rhl_test_objects[i].list_node.rhead));
 			if (err == -EAGAIN)
 				err = 0;
 		} else
-			err = rhltable_insert(&rhlt,
+			err = rhltable_insert(rhlt,
 					      &rhl_test_objects[i].list_node,
 					      test_rht_params_dup);
 		if (WARN(err, "error %d on element %d/%d (%s)\n", err, i, cnt, slow? "slow" : "fast"))
 			goto skip_print;
 	}
 
-	ret = print_ht(&rhlt);
+	ret = print_ht(rhlt);
 	WARN(ret != cnt, "missing rhltable elements (%d != %d, %s)\n", ret, cnt, slow? "slow" : "fast");
 
 skip_print:
-	rhltable_destroy(&rhlt);
+	rhltable_destroy(rhlt);
+	kfree(rhlt);
 
 	return 0;
 }



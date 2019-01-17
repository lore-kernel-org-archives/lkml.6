Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE49C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47E020657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="IdBzQK0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfAQAX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:23:29 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:50227 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfAQAX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=MG1PesDNCcP9WUNoB3XUnwo9vPkNIWosbohvqo7unII=; b=IdBzQK0oZ0Vz
        3ZIsjMrM0Up9l2uTD5ab4STvlLc2pPISXFvkJ7xosq+yzCdoHpl0vTL28ObbsxZfslPB6pPa0E0Oz
        SSe3Ylx9v1xhHnu2HshLkzELF50U1WvIPXCCLbgO41cYuLxpp5qdWOhWzbZO3LlTgs3Lmb138tS9b
        5zZISv+Qf6lMRJhKvn/mXpi8U5nITgTjuX02jcPhWg4vn1zFJ2kktuGH3kZUP6fppmeuD9OAnjSSb
        q6Y7RPZRYbozEA+Aypp2/ZdgFC/Q4Y01NTe4cMdy7nnYqeomByab1UUfWXpXnNHi1F3qA9umRxFJD
        yI3sAgxCXLH6oud2eT6h/w==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gjvSt-000DYQ-2E; Thu, 17 Jan 2019 01:23:23 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0CA72C060B;
        Thu, 17 Jan 2019 01:23:17 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     David Miller <davem@davemloft.net>
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2] lib/test_rhashtable: Make test_insert_dup() allocate its hash table dynamically
Date:   Wed, 16 Jan 2019 16:23:07 -0800
Message-Id: <20190117002307.84019-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ns3TRJcUMmYlve6S/jKRUR602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTacR+7WyMgzHjz+T9oPWai2IJR/LLbceaqS8MKPufzxmLzw
 3dG7A6WkH7JGigdteN57+5HzsJAARNaiXTEXf82VAjw9nUyHRh+vaTE+a8V78gnvcbqWawZgc1Ck
 ONz2E71TYi2bf0F0JzgUQ/o6tR7CgJ80+L1CwdwW3n1LPAFa7+c6TEzHGFGmPNVo8HWtwIUMRa71
 NgiudR/0r17HQUbqWmuNA8WTybi1JN85FSnfKQ92CA+JoVmy/OGFlzvQk2JpuRcJDn/ll9Yr9I5t
 rl5d0K0KOfrBIMcEB73MgNpF9Fka3AWSQBObYIhoDqsjjxMlPZ+d+6dQltnW35dYHDi4YsOSYzzr
 WOkGpzUJhy0xLBRKoVbdmzfZG7WP8P7/emcDFPZI3xOxBaPpD+a4iBFJkhqbiTdTlYcOHnVgVGtC
 G4wbZOs8jS5huW0TMlFixpjfwluHZS9DYzoq+lLuZqz8HQrtppYmxMktfUX7kfB+UdezYqxGMqsK
 jARq8PBC4qgv85DraLmOS/N5Opm+L5a1zbBZVuMc79ykmmxiW8WEzyq4rwkgkXM91sC1MKuZHV/D
 eo2F/515C8kJ0QodJwfrmFGs5lmow6gOzU/CbOds0gEiRQv+PVjjwa+Z5RFCOMQJtWRGqCvIhbNV
 l01bgKOHgneYl2CbmQ1c/RYOiDQqnsek4JKEGdNjmItUUxCuS3NEyy9E5IFa5Qh4o4so9wQ0kdAM
 qg0DLLtI4ISLQfl+9Z9I8+Y87gZoUqewOX3d3X2gZZAS9m5ZAKg1qGreZOdFtgZkcRkCnoMzps1w
 8ZlyWgb2oVDYt/IeCLPO3mLidU+jm0SKZ0CwXP/HCeeGwZf+f/QX5pdvrJ/s/sSAvlYTJFFfEoXm
 0/FPF8PR0w363lmEgMHJYWXh7/hIhbS7hEDvBzMe9IjlCpB8LIXyj4QxEvOMw9vaP5nn5vlj4r0C
 SMNQvy23SZXSfMZ7RzHGH1l2JbF2tT1ILdAA9jrRN4HII8EZ39zyR7b8Z8A45X4Y27zuyf/9FwsQ
 jCZ/G16ONVA9Jhk3JCTF6b0HP4JPC6GFIgN3RaA57lDnI7raX4AxUwRGPwvHeHAXpTjxoV7Drw72
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Changes compared to v1: instead of modifying rhashtable_init(), modify its
   caller.

 lib/test_rhashtable.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 6a8ac7626797..ee5f591f145e 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -541,38 +541,45 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
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
+		key = rht_obj(rhlt.ht, &rhl_test_objects[i].list_node.rhead);
 		key += test_rht_params_dup.key_offset;
 
 		if (slow) {
-			err = PTR_ERR(rhashtable_insert_slow(&rhlt.ht, key,
+			err = PTR_ERR(rhashtable_insert_slow(rhlt.ht, key,
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
-- 
2.20.1.97.g81188d93c3-goog


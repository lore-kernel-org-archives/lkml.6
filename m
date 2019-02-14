Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F330C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C616218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="vPP7IV1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfBNXBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:01:40 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:55455 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfBNXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=GruJ5rIW238Tw4iHFOyOp/vaaQmRSWayVUNRZzg8zg0=; b=vPP7IV1Tk1LR
        h5udxkcmPJdsXHkCHv1aYaLC9tHYksP1zH9S6jw+ns+uEQjOPO2Q3PY57K5QTUbf0MwsRReXM8PrU
        ANoftE4XzXvhrypYTRVgFfWIzJpHvK/FR+THgBjdtKRXsmczhkFwdW59dmoRo+nE33UxyiSQW8AU1
        /IDRI+Y96QrAOLEDuEGDzsFRz7/7zbOGDjMvBwxfmR94YLCSkuPTEam089zJ87CzsZBtHW5u1Fr8i
        NUyYQffpVnahmtGl9EU4r1HY12Ykl2AeWG0enLd6QoIw3rVehhCBFogCl9d9eX8jkAYEqVBvEgIba
        I6bOJSjlFsEF2sTGDWdvLA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0N-0000Z1-DM; Fri, 15 Feb 2019 00:01:20 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 7E749C05BA;
        Fri, 15 Feb 2019 00:01:16 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 04/23] locking/lockdep: Avoid that add_chain_cache() adds an invalid chain to the cache
Date:   Thu, 14 Feb 2019 15:00:39 -0800
Message-Id: <20190214230058.196511-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5qrHfKDKjwqcCZSyAf1rfv5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN597jTTJ1L6O6fbQ8Zo+FVAy6ido1BuolQ9HBm0o5M3yA5y+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNVA0hlu/NpOnaXNvrIp4mRGgQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0WH0EA9CFU+XZZAji6JOThIf/KzeGONRrJtECsN9MBOyr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHJAvCeCpJ5f0G2AUcL3y76VCY2FY5Z5budCTxaZ9l
 YAEhu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that add_chain_cache() returns 0 and does not modify the
chain hash if nr_chain_hlocks == MAX_LOCKDEP_CHAIN_HLOCKS before this
function is called.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b00c6edd6a28..404086b23fc7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2206,16 +2206,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 			chain_hlocks[chain->base + j] = lock_id;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
-	}
-
-	if (nr_chain_hlocks < MAX_LOCKDEP_CHAIN_HLOCKS)
 		nr_chain_hlocks += chain->depth;
-
-#ifdef CONFIG_DEBUG_LOCKDEP
-	/*
-	 * Important for check_no_collision().
-	 */
-	if (unlikely(nr_chain_hlocks > MAX_LOCKDEP_CHAIN_HLOCKS)) {
+	} else {
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
@@ -2223,7 +2215,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 		dump_stack();
 		return 0;
 	}
-#endif
 
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
-- 
2.21.0.rc0.258.g878e2cd30e-goog


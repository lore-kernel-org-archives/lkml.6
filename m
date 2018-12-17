Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B19C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450F920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="ubXnAeT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbeLQVbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:31:16 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:59805 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbeLQVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=vesQG+/IGiBEvc8RWxD3eR9VheVByxKqBDzk9F5mmTo=; b=ubXnAeT5QBE1
        T3yXO0AAZ2pT3iP0KFmgZB2m2yXa+N8i0rvs6p8wLVzM7jEPUrYgIihC5B0WoCa6CJB054iGVGHpp
        qwDh8x7A+iFo7fXWy12T+178k/wa5m9oLJn/+TJMuktMF0d3ecbK9geYvBK37umlGdwirtCZIapY8
        UDd32uUDMDfmS7PMm9crPDkJZ7ZDnrCYmrfkgvvohFBUxLcQNPLQmdSgeQ+o3C2WZ4Tee7/UQIJRo
        Qqqw26irC3aBuc4mVMnlESK9vnmfAAHn1y2/GQlLLzksQt1Smp9yEd5xfnuxBkkRA2zQCn0mIy5To
        u+ImZOR9LqH/BOaQYvpIfg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gZ0Te-0001P5-6V; Mon, 17 Dec 2018 22:31:02 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 2359EC0614;
        Mon, 17 Dec 2018 22:31:00 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v5 12/15] locking/lockdep: Verify whether lock objects are small enough to be used as class keys
Date:   Mon, 17 Dec 2018 13:29:59 -0800
Message-Id: <20181217213002.73776-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
In-Reply-To: <20181217213002.73776-1-bvanassche@acm.org>
References: <20181217213002.73776-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5q10iNySknTUpaWKJ8zpBv5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoEfo+YhwhwGcRWZBQH
 h9nQSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8jRjgifve2wm5/91NPphLv3vW/
 1YF70tAGvOxQzZ2LG274mqeOl+ESE4ty+lrbKeGqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3Dxxd53/ojvX/99o+1Ko4zT9VmM3YrDQTaFxaLqeST8VwUpIAiDKO1d3jsySf+J0s
 zc1uD9pAwuLhqtxw5exj8Aw7fqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d411660572e1..1eb03a29f2c2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -743,6 +743,17 @@ static bool assign_lock_key(struct lockdep_map *lock)
 {
 	unsigned long can_addr, addr = (unsigned long)lock;
 
+#ifdef __KERNEL__
+	/*
+	 * lockdep_free_key_range() assumes that struct lock_class_key
+	 * objects do not overlap. Since we use the address of lock
+	 * objects as class key for static objects, check whether the
+	 * size of lock_class_key objects does not exceed the size of
+	 * the smallest lock object.
+	 */
+	BUILD_BUG_ON(sizeof(struct lock_class_key) > sizeof(raw_spinlock_t));
+#endif
+
 	if (__is_kernel_percpu_address(addr, &can_addr))
 		lock->key = (void *)can_addr;
 	else if (__is_module_percpu_address(addr, &can_addr))
-- 
2.20.0.405.gbc1bbc6f85-goog


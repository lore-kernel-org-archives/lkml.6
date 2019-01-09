Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E2D20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="cYhQD7xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfAIVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:03:02 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:47023 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfAIVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=Aj0DSg7oyZB/nawi6IbSxC1ngsHilykD4n2bEaOHFBY=; b=cYhQD7xb4PqT
        ARONN2wJ/0wIQeEXbzeWV4NgcSERWVcVPRC+0gFQF6lXVQcjniW1SPztGYhFz09MPsmvSS14I6Ndv
        wmJi8qH8hUbk0WXnwSMzfXNgO3kOn2iDJqKD8Z6kY/vUxq2+ccfLpD/RGnKmOlOo7nyTTMxZXPl2m
        XzdmtcH0pdYKXyhiU8kQWLvawq4nXQ43+RUk43AV1PqImeJ0USUKFjM5eS/YUWEUmCEWrcCLdqfNx
        Vwpm3sZyRTEJV2SnzepKmY4c0c9i+48DGZlsQAmiNjxit3nwFr77DXVJ6ryMfz3IKHp+Zf1rjmejL
        EK2GxLNenbiRK1SDNlVYww==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzw-0009JM-PL; Wed, 09 Jan 2019 22:02:49 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id D9E4DC15F1;
        Wed,  9 Jan 2019 22:02:43 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 13/16] locking/lockdep: Verify whether lock objects are small enough to be used as class keys
Date:   Wed,  9 Jan 2019 13:02:01 -0800
Message-Id: <20190109210204.192109-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190109210204.192109-1-bvanassche@acm.org>
References: <20190109210204.192109-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5pPMaWZ3Hoa89DttdlDtMKR602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORp3rQvKLWLpXvWkyd7N
 qfKjSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8FNKZFrpMP+RrTJ6+mm5EZGGBa
 vtAnZ9INbsHebPuL2ELHuxJVA4uGoJgPNgEmp82qltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3Dxxx4+h2ZIjEF3TrpPDTDxrS2Sakih/elSC4wlrawkC4rpIAiDKO1d3jsySf+J0s
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
index acf61dbb8b30..72cff86829e6 100644
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
2.20.1.97.g81188d93c3-goog


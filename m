Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D9BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD220850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="C3UMBZV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FD220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLDA3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:29:21 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:56641 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeLDA3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=cg5zgzx/V5+lCb+X9DhkeWkgIReX1qzBSvaKWXJvia8=; b=C3UMBZV6qeZt
        qV+fF4yFC8ADI/v4jT6gyQeUcME/zgYwwmNbkyvhBKwtcTGngLY90CBSxaGflMLtXyzcEI8qjcxfN
        RgjFtyBMsis5tUPAw/vVXqOVsFFK7KsUAB9vUnpAAPOJx1/7PQc0nFIR0+nkHpB/gv2Ja+3Y9Qrbg
        +EDANWa919yoBtjrDuRGb+cMSgOlCZCfSWOQvG19r1nJYOwm6+VbQ9ks/w1vJfGHmjzGbcppNXNzI
        CL4JiN2IX32hQLiuo7Z1kQ2LUvGQF2jNU3iYL7vtzMnK3QFpqA1MD7wJ2uzWwcAun2jD39wzI4m3Q
        J8ot/sd7vpf9yH4mVNR9Mg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gTyaF-00085R-4u; Tue, 04 Dec 2018 01:29:04 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 30FA5C073F;
        Tue,  4 Dec 2018 01:28:57 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 06/24] liblockdep: Add dummy print_irqtrace_events() implementation
Date:   Mon,  3 Dec 2018 16:28:15 -0800
Message-Id: <20181204002833.55452-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204002833.55452-1-bvanassche@acm.org>
References: <20181204002833.55452-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jt/PrGzO/BgeX7KfxPOVYB602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoTzDmVyeT77VVz2sI0
 XFEoSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8FNKZFrpMP+RrTJ6+mm5EZv1QA
 MG9uIMDMLiZXx21su+VQjL+CeRXYyJUjOvWGx/aqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxxyRsd8grl1y6raDzaUpsYepit/nNz0QO23jgLswQoYD5IAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that linking against liblockdep fails due to no
print_irqtrace_events() definition being available.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/lockdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/lockdep/lockdep.c b/tools/lib/lockdep/lockdep.c
index 6002fcf2f9bc..348a9d0fb766 100644
--- a/tools/lib/lockdep/lockdep.c
+++ b/tools/lib/lockdep/lockdep.c
@@ -15,6 +15,11 @@ u32 prandom_u32(void)
 	abort();
 }
 
+void print_irqtrace_events(struct task_struct *curr)
+{
+	abort();
+}
+
 static struct new_utsname *init_utsname(void)
 {
 	static struct new_utsname n = (struct new_utsname) {
-- 
2.20.0.rc1.387.gf8505762e3-goog


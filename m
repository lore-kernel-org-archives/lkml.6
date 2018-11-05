Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2FEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433712081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="Emv4UEIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433712081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbeKFGBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:01:47 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:57785 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeKFGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=RD2vcmFun9wbrSBmzYE6t7VoGVnmihXl8VI3n0/JpvA=; b=Emv4UEIeF4h3
        Q5J7MazeHsLHnM5pL6160Gl36MBl/xAQiEH3AHqlGWofF4HsuVMtcLrX++eLW7GY7Ueiyo/gn0PML
        I7XiuVuYvMeY3yh9QbytEsaDkjcfgeshOdNP+HGYYbZncONEWYalWnsoeHMOeWC0yQHEozZA9R3x+
        DUTGnPW6/MKaFxLLpALaHDPYeDtZ4hnK+XjYkljRBk4KT0E1aMhsDFXKoSC/0aIe76StUlGLPFToU
        iqSCNu5VwU7v4kR4OHMkRumWJu4ju1lQgZwSHhCbRP51So6omaM/Qca6PO9oyt9FZnhPrHmZF2oSp
        H8oYQg3zDzQMXux0Yxy2Yw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gJlfQ-000CHX-KX; Mon, 05 Nov 2018 21:40:13 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0C788C04F3;
        Mon,  5 Nov 2018 21:40:06 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH] slab.h: Avoid using & for logical and of booleans
Date:   Mon,  5 Nov 2018 12:40:00 -0800
Message-Id: <20181105204000.129023-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5lTCTdVD94pio8tBJjAf87V602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTZ91MSsbRoBuXBr2oQDGAUehEFvLVrJyXP5BOaMZBSzFJiv
 pNPNIKoEhh6LeY+MdguUMp0jQm2ikuRL99CPU0cH5jwljf5ERXCi8vTHbnoYHdKxJIAIPZ39RZo0
 sWZ+2C5AvesSY8iBa4pNI7art7DySmjme/DKNkqa2/pUnVGEoWAk8LmqWByQuE4NgLCNvMr4R10V
 wR3R/9TuC9SMAVeuJp5l8H1X6lF60Ciyb0uI79B8+tF7FnzM+fVo7eEM38pVr8eP+Wmp/y/AB2Ky
 sgGDWRBWbnI5rC0LgUcmljwBRC8/3bImoUNQxaBiRh+ELzQiGbZ9EFjhW1f0xZKR7ke7h2lTU+tO
 zPZGTRGiEElHIfesKAQhnERWY+Zbyb/oallxn2a3k66wqHQRkdHrnUf0XuDVW1RAVP/E7/UYy9T8
 rkAMvHmBTTipZKIPq3iOj9tSKKqNUqeXR0rRzsN1a4pGQL1kekvvDc/yYbCCC8p9CUWioSPTx/yi
 OJKFnIIso8zn0j1QBmC0JIZXgnugZTuCZyCgxZHINA6A5+7T9o6by3MDjiILWse2C7xyo18DbRKd
 6+6AB9mEpRX5vy67WwDjehIqUczFWeS6sE8e1b5/UkBg4yvMn5MBAdwJubari/j0NbttK1RyTzg9
 21y9+zCxEJ+kDHjc6reKBJd0yzB99I2j7RB6MV2m6BuXEXvtqpYHmFDqewO9xyOqCYO8P1aHTwaH
 Q1Qo4eQXu+BLLP1GOzxnZ5UDYNafOy0Jr+QbiT1CJ/k2Jo+Zn4s9cWJWa0GqPkin+M+n/jXu6/99
 KOMlrjA0XAoGECHs14pjPDDBgal9xZYz2MK6AE8POx8Vj5IoY1GdsqIZIi3O22gnDTgfrN4123HW
 l+CueMsnaS1LDvgU005YMQtTGkqF9DfSXeTqNQl0N82pGAaFlBh9ydCic1KxHB/etGG+jKYi/tvO
 WyEnBy/PpUxgSFRPcWxJF+/bZGcrdi6P9WA8qPaxL9ILtEIqJpgLAx9UBkVVtWWC7u0df68W0InH
 /+bTMKNm38MHe3iJ5ql2Fx06AJIYSscySZesPRxtLbAe07w72Y8M1+Qa8Q/Annoe3C1wCMjQ1GK/
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch suppresses the following sparse warning:

./include/linux/slab.h:332:43: warning: dubious: x & !y

Fixes: 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable caches")
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Christoph Lameter <cl@linux.com>
Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374e7156..97d0599ddb7b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
 	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
 	 */
-	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
+	return type_dma + is_reclaimable * !is_dma * KMALLOC_RECLAIM;
 }
 
 /*
-- 
2.19.1.930.g4563a0d9d0-goog


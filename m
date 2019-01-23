Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51FD2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VCwEHtpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfAWUda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:33:30 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:44740 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfAWUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:33:29 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id BFB4124E08FE;
        Wed, 23 Jan 2019 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548275609; bh=/YPzUCBU7GMseM6oGutvXPyXevw5WaEZWn2TeW3rLb0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VCwEHtpuLINV899uuD3C4uvwIg3nf3I66r7K0NjIWgk3/IIsqDYzJjrhU6Rqoo7Zh
         QPegu7LIcLeeQPWfeHoJUNic3qZxpPlMmIaibbNObQE2S/tYvtx/01U42BEBOkJKlh
         HUJmlEeR4SDC/TuNN1RJwppUYEQiIyhWIIqv95LpyHqFT+VVmpvffsyzTA8+L0NCwX
         uNHAUx4T/Iq6k29s4iYvIdtfo5LwBtRIi0pWzDt8WNw5y8l7FFX4DHWYY3oLcCAMgj
         hZ64fDEo+IfbFBe8NDaGsjxVSjTnSFCJhUMfokS/5JYqcLV0kZD4aXXv0UVYdA/pPG
         T1W+VLqargwgw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A765EA0066;
        Wed, 23 Jan 2019 20:33:27 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 12:33:27 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:28 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:25 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/3] bitops.h: set_mask_bits() to return old value
Date:   Wed, 23 Jan 2019 12:33:04 -0800
Message-ID: <1548275584-18096-4-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548275584-18096-1-git-send-email-vgupta@synopsys.com>
References: <1548275584-18096-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

| > Also, set_mask_bits is used in fs quite a bit and we can possibly come up
| > with a generic llsc based implementation (w/o the cmpxchg loop)
|
| May I also suggest changing the return value of set_mask_bits() to old.
|
| You can compute the new value given old, but you cannot compute the old
| value given new, therefore old is the better return value. Also, no
| current user seems to use the return value, so changing it is without
| risk.

Link: http://lkml.kernel.org/g/20150807110955.GH16853@twins.programming.kicks-ass.net
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/linux/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 705f7c442691..602af23b98c7 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -246,7 +246,7 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
 		new__ = (old__ & ~mask__) | bits__;		\
 	} while (cmpxchg(ptr, old__, new__) != old__);		\
 								\
-	new__;							\
+	old__;							\
 })
 #endif
 
-- 
2.7.4


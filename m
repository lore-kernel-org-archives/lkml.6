Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A42AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F442084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="arThAiTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfAKA0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:26:53 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:46924 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAKA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:26:51 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 99A9E10C06EF;
        Thu, 10 Jan 2019 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547166411; bh=MTd8hhL8+Yrd4J5zf9O3w4pCpQ1E6m+yK5NdRUgT2As=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=arThAiTak6xtjdEQqT6DCcRORRxKOtPKlTZOKV/ZQLPMuplgeRxm5smd9cNlASzX6
         WDjzrQiDGNcYPSXlgN9OrHbfPrCEr9W0qGCRLpKziLfoOP/Vd/z9oRiYFMxP2PCVRN
         gugo+ZaJnTuhaJcpjCD9DmLCjdPzWf7/WO+qK75/V17XO5DTYREMHipU/BfRqD0UO+
         +a140xT9WNax6dENNdLpzceFqSXE1jnIjX1c3yf3RUgFSUjgYpy2KFJazxEWclrz5e
         EBwuQesuig/h/PxG9jewFe1dQpWDSobr/TZkQPUVlZ4G2nDUBiQQmtb5BawiqzBhFu
         /nmVMgepWt7Hg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 63E3B39F7;
        Thu, 10 Jan 2019 16:26:50 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 16:26:50 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:48 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:50 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/3] bitops.h: set_mask_bits() to return old value
Date:   Thu, 10 Jan 2019 16:26:27 -0800
Message-ID: <1547166387-19785-4-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
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
Cc: Will Deacon <will.deacon@arm.com>
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


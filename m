Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E3CC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C98221479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBBAHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:07:54 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:40512 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfBBAHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:07:54 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id A37DE4C006C;
        Sat,  2 Feb 2019 00:07:53 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:07:50 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH v2 3/4] net: core: use a dynamic_call for dst_input
To:     <namit@vmware.com>, <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Message-ID: <26040f5c-daad-46ec-a364-8aac09a84773@solarflare.com>
Date:   Sat, 2 Feb 2019 00:07:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24400.005
X-TM-AS-Result: No-2.198300-4.000000-10
X-TMASE-MatchedRID: gtvpwGSUn6YlO3FWVopgW8br3d9/yP1kwFk84lhmgzwAhmnHHeGnvUUW
        SNUeoUM2IV4u8YKdeKsn1aTwtcqsuJ4JPQewVPBv4pdq9sdj8LUWTveLitVUgZzYFsVjIMcywpY
        6xWoyv5frsPFY2b8LGb4tP830vR4ASSOWVJeuO1A5f9Xw/xqKXXJnzNw42kCxxEHRux+uk8jfhP
        1xgyx3DMRTYTJr7OZneLUgbyQE990+qa76zCY0G2QfTnA53TVxJx+BaShdFwYnmtzAzh0pU/qdw
        nLTua3czdTlvYJJucQDWaiyrWEvX5BEcrkRxYJ4UjKnO1KVKKwSkbDwum07zqq0MV8nSMBvABfN
        1nnR24U=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.198300-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24400.005
X-MDID: 1549066073-mRxzB0pVCXaD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically there will be a small number of callees, such as ip_local_deliver
 or ip_forward, which will cover most packets.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 include/net/dst.h | 5 ++++-
 net/core/dst.c    | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 6cf0870414c7..5dd838b9a7d2 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -16,6 +16,7 @@
 #include <linux/bug.h>
 #include <linux/jiffies.h>
 #include <linux/refcount.h>
+#include <linux/dynamic_call.h>
 #include <net/neighbour.h>
 #include <asm/processor.h>
 
@@ -444,10 +445,12 @@ static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *s
 	return skb_dst(skb)->output(net, sk, skb);
 }
 
+DEFINE_DYNAMIC_CALL_1(int, dst_input, struct sk_buff *);
+
 /* Input packet from network to transport.  */
 static inline int dst_input(struct sk_buff *skb)
 {
-	return skb_dst(skb)->input(skb);
+	return dynamic_dst_input(skb_dst(skb)->input, skb);
 }
 
 static inline struct dst_entry *dst_check(struct dst_entry *dst, u32 cookie)
diff --git a/net/core/dst.c b/net/core/dst.c
index 81ccf20e2826..a00a75bab84e 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -342,3 +342,5 @@ void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst)
 	free_percpu(md_dst);
 }
 EXPORT_SYMBOL_GPL(metadata_dst_free_percpu);
+
+DYNAMIC_CALL_1(int, dst_input, struct sk_buff *);


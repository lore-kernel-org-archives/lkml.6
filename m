Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25C720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25C720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeLLRuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:50:09 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:50420 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727880AbeLLRuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:50:08 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id A5A4578006E;
        Wed, 12 Dec 2018 17:50:06 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 09:50:03 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH 1/2] static_call: fix out-of-line static call
 implementation
To:     Nadav Amit <namit@vmware.com>, Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <cf6e9449-f3f6-e0fc-8096-eaba6b5a3b97@solarflare.com>
Message-ID: <51f7404c-9be7-fed5-7815-cefaab2d3c62@solarflare.com>
Date:   Wed, 12 Dec 2018 17:50:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <cf6e9449-f3f6-e0fc-8096-eaba6b5a3b97@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24280.005
X-TM-AS-Result: No-0.030800-4.000000-10
X-TMASE-MatchedRID: wSnU1g9RkP0B/868Hoi7sxes/RxhysDb7f6JAS2hKPidCqKtxM6bh57O
        325kkkmtTuVVQiM3Qc28xfjW6NxdqGk5Fql3Faa7i/b+LxU2p47ljSRvSGpq3EUNHQAoZf5cY6D
        RAC+UVNzi8zVgXoAltkWL4rBlm20vjaPj0W1qn0SujVRFkkVsm6vMe5vj/nSa1u9/O4Nmu2aUlv
        W0bIEckphiaAu9Wc8y++2OoV5KCD47/3vKX+sU9iRzxHal78GdtaLrlsGhV35I9NsuqKLpJpBEc
        rkRxYJ4UjKnO1KVKKwSkbDwum07zqq0MV8nSMBvkLxsYTGf9c0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.030800-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24280.005
X-MDID: 1544637007-Ltkx4ErK2NE2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually call __static_call_update() from static_call_update(), and fix the
 former so it can actually compile.  Also make it update key.func.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 include/linux/static_call.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 6daff586c97d..38d6c1e4c85d 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -153,16 +153,18 @@ struct static_call_key {
 
 #define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)
 
-#define __static_call_update(key, func)					\
+#define __static_call_update(key, _func)				\
 ({									\
 	cpus_read_lock();						\
-	arch_static_call_transform(NULL, key->tramp, func);		\
+	arch_static_call_transform(NULL, key.tramp, _func);		\
+	WRITE_ONCE(key.func, _func);					\
 	cpus_read_unlock();						\
 })
 
 #define static_call_update(key, func)					\
 ({									\
 	BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));	\
+	__static_call_update(key, func);				\
 })
 
 #define EXPORT_STATIC_CALL(key)						\


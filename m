Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECEFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2DE21A49
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DOaXH4tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBKMco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:32:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40725 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfBKMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:32:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so11852446qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B2ouR+Ang/LItZ96PM06UJ1jkDO7ifCmte1uKNl4m9I=;
        b=DOaXH4tV21cFMhS2mNjs93TTzRjlPcp6GZc1CMQpstAl5juxcg/1cjuESUfksfEHgn
         G4S9Bt5bOsfRdiABthYNSGVPYfsN/boEz1HhcDHYnY5PvIyvfvouH7XxSO4z+xUzVQmd
         J7RGbKOKuwCfRAHs72OaP/kGWwixvPuOPl+10olToEi8hLtH3Trjj83pEdhDJ2X7XJfd
         loq8Js20flsGzcr+x0tlRpyIK+4HzBmLNtOrb/heJ3tAl2FUJvXSXNAmiqqiIana0YHw
         wr8QAn+4etl5LYRdb57khbJhfYReZ9//WzlWCh9vR68Joz3Wsrhf+d262NcEd/EQOUaL
         NLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B2ouR+Ang/LItZ96PM06UJ1jkDO7ifCmte1uKNl4m9I=;
        b=FdXwFJbIJxRLZSAPc+KnzuduKPncCqYIBnYF+CjfvgYBlo88el6+Vwu20I42Res1uC
         pzInzbqZTlTiMKoAm3z1713hptpNbDNXBDANNpEg+Q6CjoTuH3CsOkZ4n4sLc4pO1Nlh
         nGzDu55y7nS1VpXCXtrlOv19JS1g464QKHFF0dl7Zh5L8v89EuGQCs9pJn4VIwXdWgyq
         GZWTW3RqLnJQ+UOgB8XY48iM/QF8mXLJAHWFyXpwnM/JE9HCkYtc556vw3CCiiHVXLAg
         rxQkC8SBKuXAMyXUTcyy0iYhlxd/0vLVG7Bbmg+25y3rPwgrJY6TAiw70XRWTVTB7uD2
         exQQ==
X-Gm-Message-State: AHQUAuZ7buvjmDQEJSdvCqgDRgCbRqgcECleasn21x9yajpU2UUulvGd
        YDUYIOY3x/0UXNx5KhuWaIEoXQ==
X-Google-Smtp-Source: AHgI3IbvcpJ8B5DrC2p58gNY0AExMmGTOFsI9dp4XE+ccMuoyiaUgF3QtJJ0xmiuI3Bf9otjzRsTsg==
X-Received: by 2002:a0c:8425:: with SMTP id l34mr26545005qva.101.1549888362886;
        Mon, 11 Feb 2019 04:32:42 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i33sm6236445qti.74.2019.02.11.04.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:32:42 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     labbott@fedoraproject.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] slub: remove an unused addr argument
Date:   Mon, 11 Feb 2019 07:32:14 -0500
Message-Id: <20190211123214.35592-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"addr" function argument is not used in alloc_consistency_checks() at
all, so remove it.

Fixes: becfda68abca ("slub: convert SLAB_DEBUG_FREE to SLAB_CONSISTENCY_CHECKS")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 075ebc529788..4a61959e1887 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1077,8 +1077,7 @@ static void setup_object_debug(struct kmem_cache *s, struct page *page,
 }
 
 static inline int alloc_consistency_checks(struct kmem_cache *s,
-					struct page *page,
-					void *object, unsigned long addr)
+					struct page *page, void *object)
 {
 	if (!check_slab(s, page))
 		return 0;
@@ -1099,7 +1098,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 					void *object, unsigned long addr)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!alloc_consistency_checks(s, page, object, addr))
+		if (!alloc_consistency_checks(s, page, object))
 			goto bad;
 	}
 
-- 
2.17.2 (Apple Git-113)


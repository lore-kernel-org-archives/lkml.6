Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2607EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C344C21719
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHAoqoyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C344C21719
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeGCROy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:14:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40484 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeGCROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:14:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id x5-v6so1268805pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EY0pAuha58wEzP2lN+zXL6zHEbrYwfQVouteJOskiYU=;
        b=kHAoqoyNx2BeIpgvfPOcAuyZD/2zcRg0UDjgF02FIbKEKnRVdqUnW77fIx4Vb4pB64
         WrJbRBmBKZmERtuTCdDn1hV3iHpFnvRLbqIvSn5wHLwSUGzT3nKPPqc+cZtbuRUByx88
         PQztCfgWNeGmOFq5tkPFdpMBy8QClmyTJxgqhvqyu09MHIOdaDF97Hn9jFFkoAAWhWHY
         oC1LO/wUjyMmwoGKo9zsZKNIKURn8ov3nINwtFs1AEadN1y+qa8fJIx7FniGOggZawN5
         NS3Sa+gcsQe1ofwqcraS5jC3lq2CTP+JlzSECR8eZVa4RMfusM9DFkzIp8tbdVwd9DiX
         7QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EY0pAuha58wEzP2lN+zXL6zHEbrYwfQVouteJOskiYU=;
        b=h4/kDDUBw3jenKfNVFI1byOovbOKyXlAvaL7n6Fsxhpe1V8HjXFTgd6NunOEfkDnAJ
         7pw44qO+MUSIGPIl02UsTadBQenX5rYdErp920q6G5FckX9PLt74AhxiAdA8btH/JPDu
         6XSgEljr6N3E0SjqCTAxSR/Q0drRMDVuE84xAXOUND+kifwP5s+VTKwXPklbPNt4hD2g
         g2GDCz7oaIlODG17IIkUWO6uT3RRUNKpEejKvQWESpiV9mc3iV7Gf0XfDuPaVnpsLmMM
         3Hn/qUnYGCfrnh22ebOh74Cm//YG06qP/vkbjgQcDpd4qjVThHl0/TlrmKqVmAdJzENm
         IR7w==
X-Gm-Message-State: APt69E2YtpAGFZ2rDILil/iDoNxUyK6xKefok/xsGEwhJGPnMH3FMDI9
        HvMtZ5iULtl/ijt/tPuR1Zs6QF47+pQ=
X-Google-Smtp-Source: AAOMgpeXyCVL/n9Sy74r4zMzE4Hok5zuBcW28vpvhyAaMIwrMZ4DblGzBXGla6xRFGzIDRfUk4AvGQ==
X-Received: by 2002:a62:d10b:: with SMTP id z11-v6mr2651760pfg.255.1530638091967;
        Tue, 03 Jul 2018 10:14:51 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id e186-v6sm3655485pfc.13.2018.07.03.10.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 10:14:50 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] block, mm: remove unnecessary __GFP_HIGH flag
Date:   Tue,  3 Jul 2018 10:14:46 -0700
Message-Id: <20180703171446.220105-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag GFP_ATOMIC already contains __GFP_HIGH. There is no need to
explicitly or __GFP_HIGH again. So, just remove unnecessary __GFP_HIGH.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index f23311e4b201..01580f88fcb3 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -278,7 +278,7 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
 	atomic_set(&ioc->nr_tasks, 1);
 	atomic_set(&ioc->active_ref, 1);
 	spin_lock_init(&ioc->lock);
-	INIT_RADIX_TREE(&ioc->icq_tree, GFP_ATOMIC | __GFP_HIGH);
+	INIT_RADIX_TREE(&ioc->icq_tree, GFP_ATOMIC);
 	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
 
-- 
2.18.0.399.gad0ab374a1-goog


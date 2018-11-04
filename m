Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E91C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4616E2082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 21:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfDEvO8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4616E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeKEGod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 01:44:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36921 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbeKEGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 01:44:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so3414436pll.4;
        Sun, 04 Nov 2018 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=rHvza5VKJTWWZ+uoSrApwD6oMnYK7DMRclyH9B4ZXv8=;
        b=RfDEvO8Q8aGltrD54DxFb4Z38OHjG1Ikh/vT55ran2p9uDqVf36hszo3+4ywUi+blA
         ZuTqcCV+ExZFgqXLDmPwS7JKYh4vwI4m6PxJ2od8U2wbCCebmeHj86H+4IJYvoXgKZL0
         B8a6YKq4TAY8oVmD9Z/RRCgp31/UQQgV3Xd1MLb0YFWbMeDXNu7iMzNiUSco8xGvIWOH
         5k7tQ7lfRsXlyVGMaSL+NUmYZ7N0OHynPCLRpKJbQvQtHZwg0ZLL3Kr3v//rx4kBf6IF
         h25ueNeToQMBNkpuQZkn+mg6SUqAghTTCJCivIhlUZRGgSdh2qNqifV32G2z/3G655go
         RQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=rHvza5VKJTWWZ+uoSrApwD6oMnYK7DMRclyH9B4ZXv8=;
        b=lsGKCifECx94hgy4PcvTK7AWB9IikkE1VyRev9/lqc0WPJ9jBat6RQe+N5LZXa3i/K
         GZHIWJaGB82ijk+MDJ68fU2RuoKTLvqacttVkSZZJiv/FVB7O4o0w0L0GuxC62UpJtx3
         ad4uLKumx60YnxkBrvzQpBzvNHCXtDgGZWGaq6qus8FNhBaW7NdMqGQs3cjy121JgY7B
         dqUYPR4kMw5J0Q7j6qORImcZwIKiVjf/AOEhfi7Lt9EcD9p/RcUf7mlp7QUT6Nxi6Z4i
         POUg+6GEd6H/scfFhL10cz3DCBNAFZQYESG4UJnhQ8h5Cd0YsUZiEx+q054bSc63ncF7
         uSMQ==
X-Gm-Message-State: AGRZ1gK6kpSHf4ClNl6zGO5G6nlIqku6vFTVhtOk3mwLJL2bfilU+hOY
        U42qkA6a7TXYTyxl6Jdjzx0=
X-Google-Smtp-Source: AJdET5fI2ue2bXO51r3eLY2fJxhWWv+IQq5uXhvp5M/qccCAWucdHmc+Bbr2ZUYqiUWInxpuHXJsyQ==
X-Received: by 2002:a17:902:d708:: with SMTP id w8-v6mr11866531ply.72.1541366889838;
        Sun, 04 Nov 2018 13:28:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e8-v6sm11801720pfi.61.2018.11.04.13.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 13:28:08 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] s390: numa: Export __node_distance
Date:   Sun,  4 Nov 2018 13:28:06 -0800
Message-Id: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__node_distance is used by nvme, resulting in:

ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!

when trying to build nvme as module.

Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I thought I had seen that patch already, but I don't find it anywhere.
Maybe that was for another architecture. My apologies for the noise if it
is already queued.

 arch/s390/numa/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index ae0d9e889534..d31bde0870d8 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -53,6 +53,7 @@ int __node_distance(int a, int b)
 {
 	return mode->distance ? mode->distance(a, b) : 0;
 }
+EXPORT_SYMBOL(__node_distance);
 
 int numa_debug_enabled;
 
-- 
2.7.4


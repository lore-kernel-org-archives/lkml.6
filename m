Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2B8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138A620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc/Y463V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfAQC6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:58:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38919 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfAQC6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:58:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so3742217pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 18:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=90CAwvAW+8yAT7s5ufvgTTWTn7ZZm+MK/ndwsWAACI0=;
        b=Oc/Y463VjhEFUgwME4zD/8QV0pKvXIr80MX1YGxDPWOzRXYd5Kt7zE0N+kqeP3poM5
         DM2ijqA2jDzYtl145iHOCPNrB19xiwtyonuNc70cNfYr8VTr9Q4xwvsVVpOQG4/IZjrw
         b5eUhXQqZOvOmwdtJXIQj+9epKiTrg+jDW7ZHzN91t4KONjcWEXjN63CMOLIMhsCTfLh
         mpkHCCdm7nV+K4Wy146rzi+1i0H2EMyJAS7Lmfwuk2+jhz3PMXg8J3+jgf/4j5UQ77Ki
         FgfwLP8+0LV6iVZRt8Zf+DKHoq8C8c6OdZnx7q3IkvKpOJbwyaWTEU7eNq3FSvvW301H
         EztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=90CAwvAW+8yAT7s5ufvgTTWTn7ZZm+MK/ndwsWAACI0=;
        b=Xt8sTJY7tbQnm05fUUoFtsG1yPk0CLIjhhX/dFqdhlpFemdwLIX4S9LB3bO4t1iAKN
         pVDqEOKRtfw0GXhtOppidREB4DWI11mFfSArDGaVoZJu0ni6J9SgVQEO0HTjgMPXKp83
         9hZ6ecH73hx22ohgCeY+Jul7M2Nvz6b0oYO4gwJh8M3zyDaoTvd/yh0wmBU/F2+fMeOr
         /uUg9JCsq3KlUHV7TY5TanWCVeI2rFejQrX6PoN9jCM05m66Sz3qy6a3H9iBonAA1QnW
         vAU9MwqM/0QbzhdS/s9xrlkCmRLpvMHVMRHqUktJrJXGprwEQ0sOe2HGiR+qyUrVyKZq
         9h6A==
X-Gm-Message-State: AJcUukdj5hEyBwkDnFt/Yr6feIpCqZsxzH7DHMzHqhXmFfW3b1E91cH0
        ufBZD9f2KbJC1/B19DLD9gk=
X-Google-Smtp-Source: ALg8bN5V1tO193K2c2v3h1KQdlAc5nWOtvwpDZ2iIlsd08wnbHoCOTS9VKsuT/EomhBesftGJ4ZBGA==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr12102567pgl.282.1547693903610;
        Wed, 16 Jan 2019 18:58:23 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id x26sm241459pfn.50.2019.01.16.18.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 18:58:22 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Dou Liyang <douliyangs@gmail.com>
Subject: [PATCH] genirq/irqdesc: Fix a bug in alloc_descs()
Date:   Thu, 17 Jan 2019 11:00:09 +0800
Message-Id: <1547694009-16261-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c410abbbacb9b378365b ("genirq/affinity: Add is_managed to struct
irq_affinity_desc") introduce a bug in the for-loop in alloc_descs() by
accident. So fix it.

Fixes: c410abbbacb9b378365b ("genirq/affinity: Add is_managed to struct irq_affinity_desc")
Cc: Dou Liyang <douliyangs@gmail.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index ee062b7..ef8ad36 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -457,7 +457,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 
 	/* Validate affinity mask(s) */
 	if (affinity) {
-		for (i = 0; i < cnt; i++, i++) {
+		for (i = 0; i < cnt; i++) {
 			if (cpumask_empty(&affinity[i].mask))
 				return -EINVAL;
 		}
-- 
2.7.0


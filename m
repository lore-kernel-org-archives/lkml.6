Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634BDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF6120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfAQXqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:46:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbfAQXqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:46:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0HNjvRN948900
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 17 Jan 2019 15:45:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0HNjugh948895;
        Thu, 17 Jan 2019 15:45:56 -0800
Date:   Thu, 17 Jan 2019 15:45:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Huacai Chen <tipbot@zytor.com>
Message-ID: <tip-12fee4cd5be2c4a73cc13d7ad76eb2d2feda8a71@git.kernel.org>
Cc:     hpa@zytor.com, chenhc@lemote.com, zhangfx@lemote.com,
        douliyangs@gmail.com, tglx@linutronix.de, wuzhangjin@gmail.com,
        chenhuacai@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: chenhuacai@gmail.com, wuzhangjin@gmail.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          chenhc@lemote.com, hpa@zytor.com, zhangfx@lemote.com,
          douliyangs@gmail.com
In-Reply-To: <1547694009-16261-1-git-send-email-chenhc@lemote.com>
References: <1547694009-16261-1-git-send-email-chenhc@lemote.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq/irqdesc: Fix double increment in
 alloc_descs()
Git-Commit-ID: 12fee4cd5be2c4a73cc13d7ad76eb2d2feda8a71
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  12fee4cd5be2c4a73cc13d7ad76eb2d2feda8a71
Gitweb:     https://git.kernel.org/tip/12fee4cd5be2c4a73cc13d7ad76eb2d2feda8a71
Author:     Huacai Chen <chenhc@lemote.com>
AuthorDate: Thu, 17 Jan 2019 11:00:09 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 18 Jan 2019 00:43:09 +0100

genirq/irqdesc: Fix double increment in alloc_descs()

The recent rework of alloc_descs() introduced a double increment of the
loop counter. As a consequence only every second affinity mask is
validated.

Remove it.

[ tglx: Massaged changelog ]

Fixes: c410abbbacb9 ("genirq/affinity: Add is_managed to struct irq_affinity_desc")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Cc: Dou Liyang <douliyangs@gmail.com>
Link: https://lkml.kernel.org/r/1547694009-16261-1-git-send-email-chenhc@lemote.com

---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index ee062b7939d3..ef8ad36cadcf 100644
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

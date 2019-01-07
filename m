Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BC92070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HCcLlEvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAGMQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:16:13 -0500
Received: from m12-12.163.com ([220.181.12.12]:38265 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfAGMQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=jH9CrNlPsBPLHLYuKV
        j6SGrxbNmxvMkMnuI07USSvJc=; b=HCcLlEvhIoO2mLJ++VnN0SytI7GGSi/r0/
        ooKcREvSjLoIkKLJgRyUOg0CXZ1Pp5T/uDbY5EvehbASXyjFXF9CJTiSqNWc93HY
        IG3Xb4MKUun8QOgZhWaat07Ta+dhL5iMbN2RFsLsJHCyzm0GbZqjL0bMe3kT/+5e
        Dkf0bBkLc=
Received: from localhost.localdomain (unknown [110.185.70.228])
        by smtp8 (Coremail) with SMTP id DMCowAAHV7H7QjNccZCsIw--.48418S2;
        Mon, 07 Jan 2019 20:15:56 +0800 (CST)
From:   wangbo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     paulus@ozlabs.org, kvm-ppc@vger.kernel.org, wang.bo116@zte.com.cn
Subject: [PATCH] KVM: PPC: Book3S: Replace kmalloc_node+memset with kzalloc_node
Date:   Mon,  7 Jan 2019 20:15:52 +0800
Message-Id: <1546863352-23593-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowAAHV7H7QjNccZCsIw--.48418S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWDtr15ZF17uw4xXr1fZwb_yoWfJrb_Zw
        4xZr47W348Ar4fWr1DXr47XFZ5Jw47Ary09r1jva17Aws0yrWrJ392vF1Dur97WrWxZrZY
        kFWqgwnFv3W0kjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0F4iUUUUUU==
X-Originating-IP: [110.185.70.228]
X-CM-SenderInfo: xzgmy4re6rljoofrz/1tbiEBw1GVWBjOsOBAAAsZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc_node and memset with kzalloc_node

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 arch/powerpc/kvm/book3s_hv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5a066fc..27112b7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5342,13 +5342,11 @@ static int kvm_init_subcore_bitmap(void)
 			continue;
 
 		sibling_subcore_state =
-			kmalloc_node(sizeof(struct sibling_subcore_state),
+			kzalloc_node(sizeof(struct sibling_subcore_state),
 							GFP_KERNEL, node);
 		if (!sibling_subcore_state)
 			return -ENOMEM;
 
-		memset(sibling_subcore_state, 0,
-				sizeof(struct sibling_subcore_state));
 
 		for (j = 0; j < threads_per_core; j++) {
 			int cpu = first_cpu + j;
-- 
2.7.4



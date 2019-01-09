Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F2AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3DE206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfAIJIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:08:10 -0500
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6]:37211 "HELO
        zg8tmtu5ljy1ljeznc42.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1728138AbfAIJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:08:10 -0500
Received: from localhost (unknown [114.255.3.133])
        by email1 (Coremail) with SMTP id AQBjCgDX3fnFuTVcpkUhCg--.7191S2;
        Wed, 09 Jan 2019 17:07:23 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] mm/slub.c: re-randomize random_seq if necessary
Date:   Wed,  9 Jan 2019 17:06:27 +0800
Message-Id: <20190109090628.1695-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgDX3fnFuTVcpkUhCg--.7191S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW3JF4rtrykXrWxXrWrXwb_yoW3tFX_ua
        y0yFy5Ar48GF4qkFyUZr4rJFWfC397uFnruasFvay7Ja4DtrnIyryUW3ykuFWxuFyv9FW5
        GFW7G397Aa4vgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMmh5UUUUU==
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calculate_sizes() could be called in several places
like (red_zone/poison/order/store_user)_store() while
random_seq remains unchanged.

If random_seq is not NULL in calculate_sizes(), re-randomize it.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 mm/slub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1e3d0ec4e200..2a9d18019545 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3583,6 +3583,15 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (oo_objects(s->oo) > oo_objects(s->max))
 		s->max = s->oo;
 
+#ifdef CONFIG_SLAB_FREELIST_RANDOM
+	if (unlikely(s->random_seq)) {
+		kfree(s->random_seq);
+		s->random_seq = NULL;
+		if (init_cache_random_seq(s))
+			return 0;
+	}
+#endif
+
 	return !!oo_objects(s->oo);
 }
 
-- 
2.19.1


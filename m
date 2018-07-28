Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE61C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03FC20841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03FC20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeG1MEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 08:04:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728213AbeG1MEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 08:04:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF975B0AF748F;
        Sat, 28 Jul 2018 18:38:32 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Sat, 28 Jul 2018
 18:38:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] act_bpf: Use kmemdup instead of duplicating it in tcf_bpf_init_from_ops
Date:   Sat, 28 Jul 2018 18:38:06 +0800
Message-ID: <20180728103806.19592-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace calls to kmalloc followed by a memcpy with a direct call to
kmemdup.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/sched/act_bpf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 06f743d..6203eb0 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -196,12 +196,10 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
 	if (bpf_size != nla_len(tb[TCA_ACT_BPF_OPS]))
 		return -EINVAL;
 
-	bpf_ops = kzalloc(bpf_size, GFP_KERNEL);
+	bpf_ops = kmemdup(nla_data(tb[TCA_ACT_BPF_OPS]), bpf_size, GFP_KERNEL);
 	if (bpf_ops == NULL)
 		return -ENOMEM;
 
-	memcpy(bpf_ops, nla_data(tb[TCA_ACT_BPF_OPS]), bpf_size);
-
 	fprog_tmp.len = bpf_num_ops;
 	fprog_tmp.filter = bpf_ops;
 
-- 
2.7.0



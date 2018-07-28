Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5767C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9437020873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9437020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeG1MBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 08:01:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55377 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728449AbeG1MBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 08:01:54 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC21EA62C749B;
        Sat, 28 Jul 2018 18:35:43 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Sat, 28 Jul 2018
 18:35:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] cls_bpf: Use kmemdup instead of duplicating it in cls_bpf_prog_from_ops
Date:   Sat, 28 Jul 2018 18:35:15 +0800
Message-ID: <20180728103515.8576-1-yuehaibing@huawei.com>
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
 net/sched/cls_bpf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 66e0ac9..fa6fe2f 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -349,12 +349,10 @@ static int cls_bpf_prog_from_ops(struct nlattr **tb, struct cls_bpf_prog *prog)
 	if (bpf_size != nla_len(tb[TCA_BPF_OPS]))
 		return -EINVAL;
 
-	bpf_ops = kzalloc(bpf_size, GFP_KERNEL);
+	bpf_ops = kmemdup(nla_data(tb[TCA_BPF_OPS]), bpf_size, GFP_KERNEL);
 	if (bpf_ops == NULL)
 		return -ENOMEM;
 
-	memcpy(bpf_ops, nla_data(tb[TCA_BPF_OPS]), bpf_size);
-
 	fprog_tmp.len = bpf_num_ops;
 	fprog_tmp.filter = bpf_ops;
 
-- 
2.7.0



Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699BECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E520779
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6E520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbeGXEAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:00:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725199AbeGXEAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:00:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8999C89D43A29;
        Tue, 24 Jul 2018 10:56:14 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 10:55:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <quentin.monnet@netronome.com>, <jakub.kicinski@netronome.com>,
        <bhole_prashant_q7@lab.ntt.co.jp>, <osk@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] bpf: btf: fix inconsistent IS_ERR and PTR_ERR
Date:   Tue, 24 Jul 2018 10:55:24 +0800
Message-ID: <20180724025524.22012-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in get_btf,
the proper pointer to be passed as argument is '*btf'

This issue was detected with the help of Coccinelle.

Fixes: 2d3feca8c44f ("bpf: btf: print map dump and lookup with btf info")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 tools/bpf/bpftool/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9c81918..0ee3ba4 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -230,7 +230,7 @@ static int get_btf(struct bpf_map_info *map_info, struct btf **btf)
 
 	*btf = btf__new((__u8 *)btf_info.btf, btf_info.btf_size, NULL);
 	if (IS_ERR(*btf)) {
-		err = PTR_ERR(btf);
+		err = PTR_ERR(*btf);
 		*btf = NULL;
 	}
 
-- 
2.7.0



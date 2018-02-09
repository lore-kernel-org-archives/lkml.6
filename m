Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeBIKmd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:42:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:63976 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIKma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:42:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180209104228epoutp04609b501dfd2fcb0ccb3a460b6d73db03~RokDd57YX2514825148epoutp04R
X-AuditID: b6c32a4a-de3ff70000001125-8a-5a7d7b13d844
From: Nitesh Shetty <nj.shetty@samsung>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joshi.k@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v2] blk: optimization for classic polling
Date: Fri,  9 Feb 2018 16:12:16 -0500
Message-Id: <1518210736-2255-1-git-send-email-user@ubuntu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Re: [PATCH] blk: optimization for classic polling>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmhq5wdW2UwZ1j+har7/azWRz9/5bN
        Yu8tbYvLu+awWWz7PZ/ZgdXj8tlSj74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mo4/XMqS8FX
        toppVyewNDBeYO1i5OSQEDCRmP1jPVsXIxeHkMBuRokjP5exQzifGCWmrrnICuF8Y5Q4d+MI
        C0zL1sPNUFV7GSWOX7nOAuF8ZZRYdu8aI0gVm4C6ROuMO2AdIgIsEiu/fwcrYhboY5RoXPES
        rEhYwFKi5d9qZhCbRUBV4sCR5WBX8QpYSdz60cEMsU5O4ua5TjCbU8BBYvmTxWDXSgj8ZJV4
        t+YzO0SRi8Sn85/ZIGxhiVfHt0DFpSRe9rcB2RxAmzUl1u/SBzElBGwl3m0WB6lgFuCT6P39
        hAkizCvR0SYE0agssWb9AqiBkhLXvjdC2R4SW7atZIQod5Q49YEJJCwkMJlR4v9V8wmMMrMQ
        Vi1gZFzFKJlaUJybnlpsWmCUl1quV5yYW1yal66XnJ+7iREcs1peOxiXnfM5xCjAwajEw/si
        riZKiDWxrLgy9xCjBAezkghvWWxtlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFex0CXKCGB9MSS
        1OzU1ILUIpgsEwenVAPjQs4Xm6f2zn+WovbHOdzF/8eiU3uj/i5+K2F1yCwug3WzUtXN4FD+
        5SKurHZiaUy6utFsQfdC+Y7p7Q5O7/3W/ydoyqwo1xBW/X57vqbfviVazf/zp3/vqoznuDXp
        SqZob2bZ4znBUUU7X8rtPBq0um9Cx/byk7vY/nfmCehfvL8oTaDqd4YSS3FGoqEWc1FxIgCK
        p3Oe1QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTleoujbK4MBFS4vVd/vZLI7+f8tm
        sfeWtsXlXXPYLLb9ns/swOpx+WypR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGWc/jmVpeAr
        W8W0qxNYGhgvsHYxcnJICJhIbD3czN7FyMUhJLCbUeLFjGZGiISkxLK/R5ghbGGJlf+eQxV9
        ZpSY/3IWC0iCTUBdonXGHTBbRIBFYuX37ywgRcwCkxgltu1fwAaSEBawlGj5txpsEouAqsSB
        I8vBVvMKWEnc+tEBtUFO4ua5TjCbU8BBYvmTxWC9QgL2Eu/PbWaZwMi3gJFhFaNkakFxbnpu
        sWGBUV5quV5xYm5xaV66XnJ+7iZGcDBpae1gPHEi/hCjAAejEg/vi7iaKCHWxLLiytxDjBIc
        zEoivGWxtVFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUa
        GHl8GvkaryZI1/CXTqkIay1vzkjQ3Z/GVMzXdyNz5ZRDzdnv3udPlZfrb2JXvp03ddaLp+9u
        MHX8bTrb8P9fOfvjSWt2Ntoc7rx5dm1f/MRnoUYdm76mpEmXqtxje5B8fXH18gtZ8jxGJk/+
        Wan0SG3zYNt8U5xNxHdFqeW/q7a9tv9435xpU2Ipzkg01GIuKk4EALaq5SoiAgAA
X-CMS-MailID: 20180209104227epcas5p26e19e332c00996a777a2c3b73a347405
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180209104227epcas5p26e19e332c00996a777a2c3b73a347405
CMS-TYPE: 105P
X-CMS-RootMailID: 20180209104227epcas5p26e19e332c00996a777a2c3b73a347405
X-RootMTR: 20180209104227epcas5p26e19e332c00996a777a2c3b73a347405
References: <Re: [PATCH] blk: optimization for classic polling>
        <CGME20180209104227epcas5p26e19e332c00996a777a2c3b73a347405@epcas5p2.samsung.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

This removes the dependency on interrupts to wake up task. Set task
state as TASK_RUNNING, if need_resched() returns true,
while polling for IO completion.
Earlier, polling task used to sleep, relying on interrupt to wake it up.
This made some IO take very long when interrupt-coalescing is enabled in
NVMe.

Changes v1->v2:
	-setting task state once in blk_poll, instead of multiple callers.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..40285fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		cpu_relax();
 	}
 
+	set_current_state(TASK_RUNNING);
 	return false;
 }
 
-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934110AbeBMPr5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:47:57 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31028 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933594AbeBMPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:47:55 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180213154753epoutp037e51bfc09e5d0c37eec2d1f7f69925a7~S7T2jBFTR2594625946epoutp03g
X-AuditID: b6c32a37-44bff70000001029-85-5a8308a8c8df
From: Nitesh Shetty <nj.shetty@samsung.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, axboe@fb.com, linux-nvme@lists.infradead.org,
        nj.shetty@samsung.com, joshi.k@samsung.com
Subject: [PATCH v3] blk: optimization for classic polling
Date: Tue, 13 Feb 2018 21:18:12 +0530
Message-id: <1518536892-2051-1-git-send-email-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCmvu4KjuYogwsnhSz+7znGZrH6bj+b
        xdH/b9ks9t7Stri8aw6bxfxlT9kttv2ez+zA7jGx+R27x+WzpR6bl9R79G1ZxejxeZNcAGsU
        l01Kak5mWWqRvl0CV8bL59eZC/6yV0xe9IulgfEMWxcjJ4eEgInE5okdzF2MXBxCAjsYJTbO
        uccG4XxnlFgzcRYzTNXEx5ehqjYwSjzfvRSqqp1J4t2fi+xdjBwcbALaEqf/c4A0iAjYSsw9
        do0FJMwskC/xdZEYSFhYwFJiT/d9FhCbRUBVov/hRzCbV8BFou9gIyPELjmJm+c6wfZyCrhK
        /HnbCbZXQqCDTeLn2tNQZ7tIfNrwkx3CFpZ4dXwL2AkSAtISl47aQtR3M0rcaF0NNXQKo8SM
        ufoQtr3ExT1/mUBsZgE+iXdfe1ghenklOtqEIEo8JPa8fcMEYTtKbHp1kRXi3RmMEm0zNjBN
        YJRawMiwilEstaA4Nz212LDAWK84Mbe4NC9dLzk/dxMjOBq1zHcwbjjnc4hRgINRiYeX421T
        lBBrYllxZe4hRgkOZiUR3oT7QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8AQEuUUIC6Yklqdmp
        qQWpRTBZJg5OqQZGx5eNr8JlZrRxyCaxCuVLPt6gH5j39pPyhfScYzu9jkx7c8xlZ+CML1fv
        ZfWH3Tqx4wbzgYh6/URL7yqXy6H3zQxzQhJY1tyNUT/S98X+h338JYHrB9VZEoOj1A+HL3Lc
        MLH39RSF3llvZkRcnMGxKiraMXUnh/4BCYHjnrFHco6cz2Avf6GsxFKckWioxVxUnAgAOxo+
        usICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42I5/e+xoO4KjuYog2NHmC3+7znGZrH6bj+b
        xdH/b9ks9t7Stri8aw6bxfxlT9kttv2ez+zA7jGx+R27x+WzpR6bl9R79G1ZxejxeZNcAGsU
        l01Kak5mWWqRvl0CV8bL59eZC/6yV0xe9IulgfEMWxcjJ4eEgInExMeXmbsYuTiEBNYxSpw5
        dpcVwulkkrj36TZQFQcHm4C2xOn/HCANIgK2EnOPXWMBsZkF8iW6fnxgArGFBSwl9nTfB4uz
        CKhK9D/8CGbzCrhI9B1sZIRYJidx81wnM4jNKeAq8ecthC0EVHNifRPrBEaeBYwMqxglUwuK
        c9Nzi40KDPNSy/WKE3OLS/PS9ZLzczcxAsNn22Gtvh2M95fEH2IU4GBU4uHd8KopSog1say4
        MvcQowQHs5IIb8J9oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe23nHIoUE0hNLUrNTUwtSi2Cy
        TBycUg2MC48eFjr2n4sjYJOXm/e8VTyy5zamX1Cd76Dy6+LjH1OM72Ut3tD9YefXP5Zzftaz
        bJFc9eL5l2mfzm6qXxmc4/HbKmJ55Gvu1TuSfIOP7fr9boHX1S8PF6+LLlX74nvX5Yi66vrv
        XBWxRtP1mXa/mleR2l3DJHRAnUM1RCj4dsrnypcaF041GymxFGckGmoxFxUnAgA1+pH6GwIA
        AA==
X-CMS-MailID: 20180213154752epcas1p35e3c13d150d2108a06342781ec5e64d7
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180213154752epcas1p35e3c13d150d2108a06342781ec5e64d7
X-RootMTR: 20180213154752epcas1p35e3c13d150d2108a06342781ec5e64d7
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
        <CGME20180213154752epcas1p35e3c13d150d2108a06342781ec5e64d7@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the dependency on interrupts to wake up task. Set task
state as TASK_RUNNING, if need_resched() returns true,
while polling for IO completion.
Earlier, polling task used to sleep, relying on interrupt to wake it up.
This made some IO take very long when interrupt-coalescing is enabled in
NVMe.

Reference:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html

Changes since v2->v3:
	-using __set_current_state() instead of set_current_state()

Changes since v1->v2:
	-setting task state once in blk_poll, instead of multiple
callers.
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..3574927 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		cpu_relax();
 	}
 
+	__set_current_state(TASK_RUNNING);
 	return false;
 }
 
-- 
2.7.4

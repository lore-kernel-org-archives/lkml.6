Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E22C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E5B2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AdVcfegA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeLSIq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:46:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:53326 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSIq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:46:58 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181219084655epoutp043a30d3aea6be03e4a49804a36488be72~xr5g1vJcY3147531475epoutp04M
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:46:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181219084655epoutp043a30d3aea6be03e4a49804a36488be72~xr5g1vJcY3147531475epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545209215;
        bh=wYiFjrom9bAzCbre3iHSP4R14P4ylsUybpVJ/7F8Bj4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AdVcfegAtp6Q9dXi6k2NZrHwsUjtPKtCHgkeWA+n02DPO5z0/NCwNDaEavF9j/gwx
         yCJwQmWzSpKrn/HArxKfhQGY8cy8ulnhYoKFAxctXv7MbXlNPxBJhivIBbpzuDvdNK
         SKX0JYaMMpeBSgXwfa6yBzlepFMZv03htndSGxrQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.194]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20181219084653epcas5p124c46b2a6023287348d692ac9ef82753~xr5fCds5X1734317343epcas5p1T;
        Wed, 19 Dec 2018 08:46:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.CB.04399.D750A1C5; Wed, 19 Dec 2018 17:46:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20181219084316epcas5p33d6f70181b105a697073570221851097~xr2VKo32h2798127981epcas5p3c;
        Wed, 19 Dec 2018 08:43:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181219084316epsmtrp2a243bf23c88d1dbe3b9047f13d4575f5~xr2VJXU3d1671716717epsmtrp2F;
        Wed, 19 Dec 2018 08:43:16 +0000 (GMT)
X-AuditID: b6c32a4a-b7bff7000000112f-58-5c1a057d3beb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.53.03694.4A40A1C5; Wed, 19 Dec 2018 17:43:16 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181219084315epsmtip15b8ffdf9e16fc2920f1e034857c6b116~xr2T9Vlci2392623926epsmtip1G;
        Wed, 19 Dec 2018 08:43:15 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org
Cc:     a.sahrawat@samsung.com, pankaj.m@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/1] task_stack: make code generic for getting end of stack.
Date:   Wed, 19 Dec 2018 14:05:02 +0530
Message-Id: <1545208502-7941-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7bCmum4tq1SMwYr30hYXd6daXN41h83i
        /K61rBaH57exWNx7s5XJ4tDJuYwObB6bVnWyefRtWcXo8XmTXABzVI5NRmpiSmqRQmpecn5K
        Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBaJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BoVGBXnFibnFpXrpecn6ulaGBgZEpUGVCTkbj0zuMBR/YK051P2Br
        YLzN1sXIySEhYCJxr+sQSxcjF4eQwG5GiS1z97NBOJ8YJdZ/Pc4K4XxjlJh7fiIrTMv3a1+Z
        IRJ7GSUuvH7ACOF8YZR4tHQ5WBWbgJ7Eql17WEBsEQFDiXN3boAtYRZoYpT4ubuFCSQhLOAj
        sb//NzOIzSKgKnHtwS2wBl4BN4k9vx9DrZOTOHlsMtgdEgJvWSV2tF9mgUi4SHy7cwWqSFji
        1fEt7BC2lMTnd3vZIBraGSWuz7zGAuFMYZTofL8Sqspe4sGNo0A2B9BNmhLrd+lDhGUlpp5a
        B3YdswCfRO/vJ0wQcV6JHfNgbFWJlpsboBZLS3z++BFoPjuQ7SHx1x8kKiQQK7Hu5jL2CYyy
        sxDmL2BkXMUomVpQnJueWmxaYJSXWo4cVZsYwQlKy2sH47JzPocYBTgYlXh4HyhJxgixJpYV
        V+YeYpTgYFYS4b0UDRTiTUmsrEotyo8vKs1JLT7EaAoMwInMUqLJ+cDkmVcSb2hqZGZmYGlg
        amxhZqgkzjtXdm60kEB6YklqdmpqQWoRTB8TB6dUA+PBuBfJdns+eAppx3RkdOjuY/CJf/JH
        RyHrX1ygrrTSVdYru9Rt8914+u8nbD22gKld3StnWYctC++jZeULm9yWqQrvvGM9Z37Obbfb
        tXzs2uKySafKim88tNcJX/xTfYH1obmHOqY/2/px+dy57rVzss/JKcyIMYtzeOpn8UrraeqV
        Q/df7ldiKc5INNRiLipOBADfr0lXZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsWy7bCSnO4SFqkYg8O/VCwu7k61uLxrDpvF
        +V1rWS0Oz29jsbj3ZiuTxaGTcxkd2Dw2repk8+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6M
        xqd3GAs+sFec6n7A1sB4m62LkZNDQsBE4vu1r8xdjFwcQgK7GSXWt6+FSkhL/Pz3ngXCFpZY
        +e85O0TRJ0aJeZ1trCAJNgE9iVW79oAViQgYSzxue8kCUsQs0MYo8eLmZXaQhLCAj8T+/t/M
        IDaLgKrEtQe3wBp4Bdwk9vx+zAqxQU7i5LHJrBMYeRYwMqxilEwtKM5Nzy02LDDKSy3XK07M
        LS7NS9dLzs/dxAgOFC2tHYwnTsQfYhTgYFTi4e1QkIwRYk0sK67MPcQowcGsJMJ7KRooxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgbE/1I2rw3Tie41b
        i19Ku5yeqvV5xzGLdyW3xFo1F71VXSuY/XHzcl9PR6Y/2zf+ZXf48Oasil9qfvIHzUn3gy4u
        Ml/PUtByZ6dgYpeTcOYFH8uPMl0/CuZt4mVns6iyjf4k+slr55ZXQm+8J7l5zowTvD/9bdCP
        t8+2GztL566cva104uSMv5xKLMUZiYZazEXFiQCsxTLHEAIAAA==
X-CMS-MailID: 20181219084316epcas5p33d6f70181b105a697073570221851097
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181219084316epcas5p33d6f70181b105a697073570221851097
References: <CGME20181219084316epcas5p33d6f70181b105a697073570221851097@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently code provides end of stack by considering stack grows
downwards. Make it useful for architectures where stack grows upward.

Although CONFIG_THREAD_INFO_IN_TASK is selected only for
architectures where stack grows downward.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 include/linux/sched/task_stack.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 6a84192..4f099d3 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -25,7 +25,11 @@ static inline void *task_stack_page(const struct task_struct *task)
 
 static inline unsigned long *end_of_stack(const struct task_struct *task)
 {
+#ifdef CONFIG_STACK_GROWSUP
+	return (unsigned long *)((unsigned long)task->stack + THREAD_SIZE) - 1;
+#else
 	return task->stack;
+#endif
 }
 
 #elif !defined(__HAVE_THREAD_FUNCTIONS)
-- 
1.9.1


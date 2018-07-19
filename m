Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AF220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeGSIjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:39:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44885 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730628AbeGSIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:39:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E2182CF8BF3F5;
        Thu, 19 Jul 2018 15:57:28 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 15:57:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 bpf-next] bpfilter: Fix mismatch in function argument types
Date:   Thu, 19 Jul 2018 15:56:59 +0800
Message-ID: <20180719075659.9800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warning:
net/ipv4/bpfilter/sockopt.c:28:5: error: symbol 'bpfilter_ip_set_sockopt' redeclared with different type
net/ipv4/bpfilter/sockopt.c:34:5: error: symbol 'bpfilter_ip_get_sockopt' redeclared with different type

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/bpfilter.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index 687b176..f02cee0 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -5,10 +5,10 @@
 #include <uapi/linux/bpfilter.h>
 
 struct sock;
-int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char *optval,
+int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
 			    unsigned int optlen);
-int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char *optval,
-			    int *optlen);
+int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
+			    int __user *optlen);
 extern int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
 				       char __user *optval,
 				       unsigned int optlen, bool is_set);
-- 
2.7.0



Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1470C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C3121785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C3121785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeHMFHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:07:41 -0400
Received: from exmail.andestech.com ([59.124.169.137]:47627 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeHMFHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:07:40 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7D2PuS8015231;
        Mon, 13 Aug 2018 10:25:56 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 13 Aug 2018
 10:27:13 +0800
From:   Zong Li <zong@andestech.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <dsahern@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH] net: Change the layout of structure trace_event_raw_fib_table_lookup
Date:   Mon, 13 Aug 2018 10:26:52 +0800
Message-ID: <1534127212-13186-1-git-send-email-zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7D2PuS8015231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unalignment access about the structure
'trace_event_raw_fib_table_lookup'.

In include/trace/events/fib.h, there is a memory operation which casting
the 'src' data member to a pointer, and then store a value to this
pointer point to.

p32 = (__be32 *) __entry->src;
*p32 = flp->saddr;

The offset of 'src' in structure trace_event_raw_fib_table_lookup is not
four bytes alignment. On some architectures, they don't permit the
unalignment access, it need to pay the price to handle this situation in
exception handler.

Adjust the layout of structure to avoid this case.

Signed-off-by: Zong Li <zong@andestech.com>
---
 include/trace/events/fib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
index 9763cddd0594..6271bab63bfb 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -22,6 +22,7 @@ TRACE_EVENT(fib_table_lookup,
 		__field(	int,	err		)
 		__field(	int,	oif		)
 		__field(	int,	iif		)
+		__field(	u8,	proto		)
 		__field(	__u8,	tos		)
 		__field(	__u8,	scope		)
 		__field(	__u8,	flags		)
@@ -31,7 +32,6 @@ TRACE_EVENT(fib_table_lookup,
 		__array(	__u8,	saddr,	4	)
 		__field(	u16,	sport		)
 		__field(	u16,	dport		)
-		__field(	u8,	proto		)
 		__dynamic_array(char,  name,   IFNAMSIZ )
 	),
 
-- 
2.16.1


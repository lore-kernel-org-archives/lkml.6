Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737F4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1E2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfBLLmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:42:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35706 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbfBLLmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:42:12 -0500
X-UUID: e282b5ff1914481abc10a8993419a65d-20190212
X-UUID: e282b5ff1914481abc10a8993419a65d-20190212
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 136087710; Tue, 12 Feb 2019 19:42:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 19:42:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 19:42:00 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     CC Hwang <cc.hwang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andress Kuo <andress.kuo@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH 1/1] tracing: Fix event_trace_printk loss on printk_format.
Date:   Tue, 12 Feb 2019 19:41:57 +0800
Message-ID: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 06594692839B4E64C47D721B1963D00E961641334FFE7C874C63EAD4120692B22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andress Kuo <andress.kuo@mediatek.com>

If fmt on event_trace_printk is not a constant, It means that something not
guaranteed, so the compiler optimizes the fmt out, and then the
__trace_printk_fmt section is not filled. if __trace_printk_fmt is not
filled, the kernel will not allocate the special buffers needed for the
event_trace_printk() and then not shown in the file output
sys/kernel/debug/tracing/print_formats.

Adding a "__used" to the variable in the __trace_printk_fmt section on
event_trace_printk() will keep it around, even though it is set to NULL.
This will keep the string from being printed in the
sys/kernel/debug/tracing/printk_formats section.

We can also refer to commit 3debb0a9ddb1 ("tracing: Fix trace_printk()
to print when not using bprintk()")that it had similar issue on path of
trace_printk().

Signed-off-by: Andress Kuo <andress.kuo@mediatek.com>
Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 include/linux/trace_events.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731..26bd7c4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -551,7 +551,7 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 	__trace_printk_check_format(fmt, ##args);			\
 	tracing_record_cmdline(current);				\
 	if (__builtin_constant_p(fmt)) {				\
-		static const char *trace_printk_fmt			\
+		static const char *trace_printk_fmt __used		\
 		  __attribute__((section("__trace_printk_fmt"))) =	\
 			__builtin_constant_p(fmt) ? fmt : NULL;		\
 									\
-- 
1.7.9.5


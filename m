Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F59420862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F59420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeKKOKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:10:49 -0500
Received: from asrmicro.com ([210.13.118.86]:36042 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbeKKOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:10:48 -0500
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2018 09:10:47 EST
Received: from localhost (10.38.17.127) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 11 Nov 2018 12:07:37
 +0800
From:   Zhizhou Zhang <zhizhouzhang@asrmicro.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <mpatocka@redhat.com>, <alex.popov@linux.com>,
        <labbott@redhat.com>, <panand@redhat.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhizhouzh@gmail.com>,
        <zhizhouzhang@asrmicro.com>
Subject: [PATCH] arm64: disable KASAN for save_trace()
Date:   Sun, 11 Nov 2018 20:07:16 +0800
Message-ID: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.38.17.127]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_trace() which is called from walk_stackframe() always try to
read/write caller's stack. This results KASAN stack-out-of-bounds
warning. So mute it.

Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
---
 arch/arm64/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4989f7e..e93ca67 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -107,7 +107,7 @@ struct stack_trace_data {
 	unsigned int skip;
 };
 
-static int save_trace(struct stackframe *frame, void *d)
+static int __no_sanitize_address save_trace(struct stackframe *frame, void *d)
 {
 	struct stack_trace_data *data = d;
 	struct stack_trace *trace = data->trace;
-- 
2.7.4


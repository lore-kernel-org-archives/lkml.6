Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeDYXnB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 19:43:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753349AbeDYXm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 19:42:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C13C60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: rostedt@goodmis.org, abderrahmane.benbachir@polymtl.ca
Cc: linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH] trace: initcall: Ordered comparison of function pointers
Date: Wed, 25 Apr 2018 16:42:35 -0700
Message-Id: <1524699755-29388-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using initcall_t in the __field macro generates the follwing warning
with clang version 6.0:

include/trace/events/initcall.h:34:3: warning: ordered comparison of
function pointers ('initcall_t' (aka 'int (*)(void)') and 'initcall_t')

__field macro expands to __field_ext macro which does is_signed_type
check on the type argument. Since initcall_t is defined as a function
pointer, using it as the type in the __field macro, leads to an ordered
comparison of function pointer warning, inside the check. Using
__field_struct macro avoids the issue.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 include/trace/events/initcall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/initcall.h b/include/trace/events/initcall.h
index 8d6cf10..46f5f7c 100644
--- a/include/trace/events/initcall.h
+++ b/include/trace/events/initcall.h
@@ -31,7 +31,7 @@
 	TP_ARGS(func),
 
 	TP_STRUCT__entry(
-		__field(initcall_t, func)
+		__field_struct(initcall_t, func)
 	),
 
 	TP_fast_assign(
@@ -48,7 +48,7 @@
 	TP_ARGS(func, ret),
 
 	TP_STRUCT__entry(
-		__field(initcall_t,	func)
+		__field_struct(initcall_t,	func)
 		__field(int,		ret)
 	),
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

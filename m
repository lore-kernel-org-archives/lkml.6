Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD015C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7293D214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486553;
	bh=jPPqHKTkWMm6kPJrQ9UQRYW/ovQTEgMMb0xPZqp1sBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=EK/gz9rLCyFieQ1oaTXB9XDL4IO1ilWaQ3WeL0/4f18pLbIUo+bFCmkmZmFKShXLa
	 Gf8mDz3dHFt638VNNObUeMd+PiQM76ygTO1jbfvSc5pXxt9/jX8pY/J2Pv5mszw+7T
	 5ThrcJ3GYY2YxdBMtme2voM8lZIpCboAVREAS1Xo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7293D214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbeLKAC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:02:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbeLKACR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:02:17 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121EA214DB;
        Tue, 11 Dec 2018 00:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486536;
        bh=jPPqHKTkWMm6kPJrQ9UQRYW/ovQTEgMMb0xPZqp1sBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SPu8kj17Vl+VHtr1sRhQqyOfa+80kATeT30I/cYkZcugHjgoxShFrU+o5fejh9XUu
         IDAHsUCCqdyZ+b6YYUueRF4bYe/E3MSzz2xL26UOKycg3Mw0gvONiYsP9fFhsbKmGw
         1XQD4zd1Q5s6SFaQovCTWLF5WeRbp2dqISrB34oM=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to destroy var_refs
Date:   Mon, 10 Dec 2018 18:01:34 -0600
Message-Id: <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Since every var ref for a trigger has an entry in the var_ref[] array,
use that to destroy the var_refs, instead of piecemeal via the field
expressions.

This allows us to avoid having to keep and treat differently separate
lists for the action-related references, which future patches will
remove.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d07bb2d75e18..da4800c3f745 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2312,6 +2312,15 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
+static void __destroy_hist_field(struct hist_field *hist_field)
+{
+	kfree(hist_field->var.name);
+	kfree(hist_field->name);
+	kfree(hist_field->type);
+
+	kfree(hist_field);
+}
+
 static void destroy_hist_field(struct hist_field *hist_field,
 			       unsigned int level)
 {
@@ -2323,14 +2332,13 @@ static void destroy_hist_field(struct hist_field *hist_field,
 	if (!hist_field)
 		return;
 
+	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
+		return; /* var refs will be destroyed separately */
+
 	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
 		destroy_hist_field(hist_field->operands[i], level + 1);
 
-	kfree(hist_field->var.name);
-	kfree(hist_field->name);
-	kfree(hist_field->type);
-
-	kfree(hist_field);
+	__destroy_hist_field(hist_field);
 }
 
 static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
@@ -2457,6 +2465,12 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 			hist_data->fields[i] = NULL;
 		}
 	}
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		WARN_ON(!(hist_data->var_refs[i]->flags & HIST_FIELD_FL_VAR_REF));
+		__destroy_hist_field(hist_data->var_refs[i]);
+		hist_data->var_refs[i] = NULL;
+	}
 }
 
 static int init_var_ref(struct hist_field *ref_field,
-- 
2.14.1


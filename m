Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4B3214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486648;
	bh=OsA0utCZfyYV9YNN6vd8kJm4nnE+IBKjN6Og11Sj9lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=i+NCbRkdkKEB3JwnjhkWbX29LfC9x8jtLZhmiB40WmXeCtodPgTAVvh1+2hIZpeXZ
	 QeL9EsKk3s6PbmoDLJciEWM0crNxCiGjMiohswLOsLagIWZ1qaqNQJYslU+TeEH8I5
	 XAhtE3cgb0bM0TJqRtPrerU62I+sSV5BGVo/3n4w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4B3214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeLKAEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbeLKABs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:01:48 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F9B214E0;
        Tue, 11 Dec 2018 00:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486507;
        bh=OsA0utCZfyYV9YNN6vd8kJm4nnE+IBKjN6Og11Sj9lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dFzgaj+Z9RMZ2TTxwWzKuZRg2uhxdtlk10zakmCPbP6YAcMlUpEmX+7yr4+T58p7+
         nBt4fLeml3EDMc57mt+OdE03vxg2wU+GMCP0AmUG5H0E571hFaJEunSxfZtbpwFrt5
         zNAbaj3c+pyd3+TmpFCh6aLKGcU3+7ANi1z8q+TQ=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 02/22] tracing: Make hist trigger Documentation better reflect actions/handlers
Date:   Mon, 10 Dec 2018 18:01:16 -0600
Message-Id: <13400eb0079506b8e4be24c833d301071eb6fecb.1544483272.git.tom.zanussi@linux.intel.com>
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

The action/handler code refactoring didn't change the action/handler
syntax, but did generalize it - the Documentation should reflect that.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 7dda76503127..63e522107e59 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -25,7 +25,7 @@ Documentation written by Tom Zanussi
 
         hist:keys=<field1[,field2,...]>[:values=<field1[,field2,...]>]
           [:sort=<field1[,field2,...]>][:size=#entries][:pause][:continue]
-          [:clear][:name=histname1] [if <filter>]
+          [:clear][:name=histname1][:<handler>.<action>] [if <filter>]
 
   When a matching event is hit, an entry is added to a hash table
   using the key(s) and value(s) named.  Keys and values correspond to
@@ -1831,21 +1831,51 @@ and looks and behaves just like any other event::
 Like any other event, once a histogram is enabled for the event, the
 output can be displayed by reading the event's 'hist' file.
 
-2.2.3 Hist trigger 'actions'
-----------------------------
+2.2.3 Hist trigger 'handlers' and 'actions'
+-------------------------------------------
 
-A hist trigger 'action' is a function that's executed whenever a
-histogram entry is added or updated.
+A hist trigger 'action' is a function that's executed (in most cases
+conditionally) whenever a histogram entry is added or updated.
 
-The default 'action' if no special function is explicitly specified is
-as it always has been, to simply update the set of values associated
-with an entry.  Some applications, however, may want to perform
-additional actions at that point, such as generate another event, or
-compare and save a maximum.
+When a histogram entry is added or updated, a hist trigger 'handler'
+is what decides whether the corresponding action is actually invoked
+or not.
 
-The following additional actions are available.  To specify an action
-for a given event, simply specify the action between colons in the
-hist trigger specification.
+Hist trigger handlers and actions are paired together in the general
+form:
+
+  <handler>.<action>
+
+To specify a handler.action pair for a given event, simply specify
+that handler.action pair between colons in the hist trigger
+specification.
+
+In theory, any handler can be combined with any action, but in
+practice, not every handler.action combination is currently supported;
+if a given handler.action combination isn't supported, the hist
+trigger will fail with -EINVAL;
+
+The default 'handler.action' if none is explicity specified is as it
+always has been, to simply update the set of values associated with an
+entry.  Some applications, however, may want to perform additional
+actions at that point, such as generate another event, or compare and
+save a maximum.
+
+The supported handlers and actions are listed below, and each is
+described in more detail in the following paragraphs, in the context
+of descriptions of some common and useful handler.action combinations.
+
+The available handlers are:
+
+  - onmatch(matching.event)    - invoke action on any addition or update
+  - onmax(var)                 - invoke action if var exceeds current max
+
+The available actions are:
+
+  - <synthetic_event_name>(param list)         - generate synthetic event
+  - save(field,...)                            - save current event fields
+
+The following commonly-used handler.action pairs are available:
 
   - onmatch(matching.event).<synthetic_event_name>(param list)
 
-- 
2.14.1


Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763FEC04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429092251C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq5Ir6NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429092251C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeKOGXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbeKOGXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:23:02 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5632251F;
        Wed, 14 Nov 2018 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542226701;
        bh=OsA0utCZfyYV9YNN6vd8kJm4nnE+IBKjN6Og11Sj9lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bq5Ir6NFdSxymViRPvVBIt4BTb8sUyXH8r2fbJBB7dn9HR2LO2yxFL0IqWlkfyRif
         RYvBzP2LEz+Kr8RFBHnMD+TQ3pRoooklW2t8XBZi9LwfylXVc1qQO21Fzcxf/0j5oK
         Tns9kKAyYgtxGVF8y9z6PQXx6DQaDlNYrmt6Wcr4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v7 02/16] tracing: Make hist trigger Documentation better reflect actions/handlers
Date:   Wed, 14 Nov 2018 14:17:59 -0600
Message-Id: <6129e663df62054577dc33a318182e6865c4f83a.1542221863.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1542221862.git.tom.zanussi@linux.intel.com>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1542221862.git.tom.zanussi@linux.intel.com>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
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


Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03359C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D20218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151382;
	bh=5WC7GSKRjy0uI/1uUerwSs1j+1qP5CaOJVcrwTnYro8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ctwOqfWcuyvD0Zi5gPza0M9hKiu9lfxujTT/MgdDq2qBh2gBCcelyzns3w3IUtfoP
	 9OuaOl178oqu05/Ouwqv+45RWz5QBXUH0r455DBB06nOE6HrQmn1Eo3g4vgMnjQZfh
	 4IFvTM1RwdRMZySO8+08opK0G3oTdZrvb/q5qfY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeLRQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeLRQlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D61F421873;
        Tue, 18 Dec 2018 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151300;
        bh=5WC7GSKRjy0uI/1uUerwSs1j+1qP5CaOJVcrwTnYro8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGSi182JahpsNTSMKHeIbrsCwTm1Z1KcW/cMBYg0iVv25mW63P3E3xTk6rCgv9ESi
         9wnk2HNEzS1459JYxR8xft3+h/ZJRp2L0oDFI7Xkh3QAfwDQkaD53G4/rjdIKrMKk3
         ndrMkeFwhHxYNy3DMuhkc9bwsAGYNXiylc4m7VM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 28/44] tracing: Fix memory leak in set_trigger_filter()
Date:   Tue, 18 Dec 2018 17:39:40 +0100
Message-Id: <20181218163930.774006911@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 3cec638b3d793b7cacdec5b8072364b41caeb0e1 upstream.

When create_event_filter() fails in set_trigger_filter(), the filter may
still be allocated and needs to be freed. The caller expects the
data->filter to be updated with the new filter, even if the new filter
failed (we could add an error message by setting set_str parameter of
create_event_filter(), but that's another update).

But because the error would just exit, filter was left hanging and
nothing could free it.

Found by kmemleak detector.

Cc: stable@vger.kernel.org
Fixes: bac5fb97a173a ("tracing: Add and use generic set_trigger_filter() implementation")
Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_trigger.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -732,8 +732,10 @@ int set_trigger_filter(char *filter_str,
 
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret = create_event_filter(file->event_call, filter_str, false, &filter);
-	if (ret)
-		goto out;
+	/*
+	 * If create_event_filter() fails, filter still needs to be freed.
+	 * Which the calling code will do with data->filter.
+	 */
  assign:
 	tmp = rcu_access_pointer(data->filter);
 



Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87880C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587A2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129295;
	bh=YOb5rZBylGBwXR+HyqlQPhV6lVox6okbCGNVzXpnPXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqkYHN0pqYmrSA7UhyzVwE7kApnFIq+jGc1CUKTTRp0fV5i0eXAkm3sbitGFQcOBm
	 6x1GR0Griya5A0odcYMTyDGj6Ar2mXDFPSYBP+xUiWodSWiK2236jjwBplyCvPb5wV
	 Hv01w5cOSK47i305Z03zOoa/VSDQJbWI9Twlr7nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfBYVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbfBYVOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1E821734;
        Mon, 25 Feb 2019 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129287;
        bh=YOb5rZBylGBwXR+HyqlQPhV6lVox6okbCGNVzXpnPXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alDdWmqV7Yj4DCw7QPnvC7RjM+cpAskJJRhYP7r/BoiWIlleZK7CDr8D8t1pLHNP7
         6bH+FCgVTN0YwowcjqYEaOoD53S7rZyFVyEdfVy1Swqgz9AwQi8xLJTDFhiecOMibK
         2wFhkkDdgoWlE1FEDc5nwzNPQSY5mxcDUnF9wQoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 45/63] tracing: Use cpumask_available() to check if cpumask variable may be used
Date:   Mon, 25 Feb 2019 22:11:45 +0100
Message-Id: <20190225195039.264955438@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 4dbbe2d8e95c351157f292ece067f985c30c7b53 upstream.

This fixes the following clang warning:

kernel/trace/trace.c:3231:12: warning: address of array 'iter->started'
  will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (iter->started)

Link: http://lkml.kernel.org/r/20170421234110.117075-1-mka@chromium.org

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3022,13 +3022,14 @@ static void test_cpu_buff_start(struct t
 	if (!(iter->iter_flags & TRACE_FILE_ANNOTATE))
 		return;
 
-	if (iter->started && cpumask_test_cpu(iter->cpu, iter->started))
+	if (cpumask_available(iter->started) &&
+	    cpumask_test_cpu(iter->cpu, iter->started))
 		return;
 
 	if (per_cpu_ptr(iter->trace_buffer->data, iter->cpu)->skipped_entries)
 		return;
 
-	if (iter->started)
+	if (cpumask_available(iter->started))
 		cpumask_set_cpu(iter->cpu, iter->started);
 
 	/* Don't print started cpu buffer for the first entry of the trace */



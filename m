Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86526C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EBA217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297654;
	bh=wyV8vFVxxCXgRwEBpx/fLBQo/DA8MJuTNrqmWhcpMM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cjXEo/9xyT/6xZ9hc88oUYIE8T52ZjrIl/4yRUhtxVxW0REmz3uQUV4Acj1M1zY7G
	 bYpZap5udiXB3I2Cuyw69ZCGeqtrprsI96I5UZOD/hYEmQYd42zN0o695+yb8VeVwu
	 EJOLy/bqqcFRNhWChINTqvww+mc6ToeaKYxqcgyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeLTJUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730866AbeLTJUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE4C2177E;
        Thu, 20 Dec 2018 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297650;
        bh=wyV8vFVxxCXgRwEBpx/fLBQo/DA8MJuTNrqmWhcpMM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sefAKYO37XHmgaGF61gI1OYPZ2S+asVLjlVlpxmItBwTgKsaNC+0BMXim5j/fRg+Q
         upSjqVM50/XBNWJRuzZWmPzTg4I03/T+UzNe6YQCaQYoglPFcMUv+QhW/1e1uH2uIM
         0Ysf4HTxi3rDCouGR33eRKAnHWH8GemztzZW09ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 3.18 09/31] tracing: Fix memory leak in set_trigger_filter()
Date:   Thu, 20 Dec 2018 10:18:21 +0100
Message-Id: <20181220085742.962722801@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -727,8 +727,10 @@ static int set_trigger_filter(char *filt
 
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
 



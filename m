Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28554C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBADB21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501000;
	bh=T6PtAuttmc5ch7k6SZUkwFLrO6ELqtxo+vxE0BT+x6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mOWzqB1YaHpiZTwogEJolUNzBG6DYUSGSC58WwD3Md1OfVAayRmcZr3QOqoNr/zKg
	 8TjQ3EO4FxYfnsEGJ8g6YwNkkVEdGWSdziCDR23bnfQ5MjJj1iw19qwxLB+3ynGTnH
	 3qsP+eL9rZjROaW86puamobvwAvI0dShwo1bS60k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfBRNt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbfBRNtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7484B20842;
        Mon, 18 Feb 2019 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497764;
        bh=T6PtAuttmc5ch7k6SZUkwFLrO6ELqtxo+vxE0BT+x6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2e0MFqey6+K5Kh7XZQr/rXUTpU2N1fziLq26HzZUE3cHTGzo05CPM1M9WCKnpw5y
         Cq80KL+wqXuVRKc1xDsq20Lo2XrKBZJEr7L4rqXFTZaPGTod//HA+DdYQh6HpUwKLl
         1cDAvAdhYj/2eCVYMJGvl/wrkKX77mkPTZCZDxXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.20 77/92] tracing: probeevent: Correctly update remaining space in dynamic area
Date:   Mon, 18 Feb 2019 14:43:20 +0100
Message-Id: <20190218133502.114106103@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Ziegler <andreas.ziegler@fau.de>

commit f6675872db57305fa957021efc788f9983ed3b67 upstream.

Commit 9178412ddf5a ("tracing: probeevent: Return consumed
bytes of dynamic area") improved the string fetching
mechanism by returning the number of required bytes after
copying the argument to the dynamic area. However, this
return value is now only used to increment the pointer
inside the dynamic area but misses updating the 'maxlen'
variable which indicates the remaining space in the dynamic
area.

This means that fetch_store_string() always reads the *total*
size of the dynamic area from the data_loc pointer instead of
the *remaining* size (and passes it along to
strncpy_from_{user,unsafe}) even if we're already about to
copy data into the middle of the dynamic area.

Link: http://lkml.kernel.org/r/20190206190013.16405-1-andreas.ziegler@fau.de

Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_probe_tmpl.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -180,10 +180,12 @@ store_trace_args(void *data, struct trac
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, regs, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic))
+		if (unlikely(ret < 0 && arg->dynamic)) {
 			*dl = make_data_loc(0, dyndata - base);
-		else
+		} else {
 			dyndata += ret;
+			maxlen -= ret;
+		}
 	}
 }
 



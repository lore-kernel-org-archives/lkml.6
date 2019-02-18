Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021AA21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498248;
	bh=7QRKOcgaVbGY4rx8eSAyG7eoLBarA0l0qO1GkxivUdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n+I+mhWpP5Wlx6fBNewF7S+rjw5zwvpiQtycZmEC7wP00h8yMNpf9d/XlCnh+RueW
	 uI8b34HrHugvvHeVAoJOSgIarx3GF1T3O8csZSSTpNGfNFI9hjJtuHIq1BuZq7LUwb
	 6dc30I9Qn7+t5Ll7LcFIuKotvufih+ultK4WS3IM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfBRN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733040AbfBRN5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:57:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0512077B;
        Mon, 18 Feb 2019 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498241;
        bh=7QRKOcgaVbGY4rx8eSAyG7eoLBarA0l0qO1GkxivUdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzBtmC/cwcVyPnXXC/H3gf3KL48uv7w5uphEfBhNkh7Vm9gGTpqhpCEGJPca+0AS/
         rGwkadPuFe4mchvDSTe7csS3Lc5y5k0EqsjFcHLZJ692Vn3qTTveFmb3BH20OIAWAm
         0/LWffKdUGoHQsW0zBw7lbaKnhg1ey2VkXVicRwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 52/62] tracing/uprobes: Fix output for multiple string arguments
Date:   Mon, 18 Feb 2019 14:43:58 +0100
Message-Id: <20190218133510.245339321@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Ziegler <andreas.ziegler@fau.de>

commit 0722069a5374b904ec1a67f91249f90e1cfae259 upstream.

When printing multiple uprobe arguments as strings the output for the
earlier arguments would also include all later string arguments.

This is best explained in an example:

Consider adding a uprobe to a function receiving two strings as
parameters which is at offset 0xa0 in strlib.so and we want to print
both parameters when the uprobe is hit (on x86_64):

$ echo 'p:func /lib/strlib.so:0xa0 +0(%di):string +0(%si):string' > \
    /sys/kernel/debug/tracing/uprobe_events

When the function is called as func("foo", "bar") and we hit the probe,
the trace file shows a line like the following:

  [...] func: (0x7f7e683706a0) arg1="foobar" arg2="bar"

Note the extra "bar" printed as part of arg1. This behaviour stacks up
for additional string arguments.

The strings are stored in a dynamically growing part of the uprobe
buffer by fetch_store_string() after copying them from userspace via
strncpy_from_user(). The return value of strncpy_from_user() is then
directly used as the required size for the string. However, this does
not take the terminating null byte into account as the documentation
for strncpy_from_user() cleary states that it "[...] returns the
length of the string (not including the trailing NUL)" even though the
null byte will be copied to the destination.

Therefore, subsequent calls to fetch_store_string() will overwrite
the terminating null byte of the most recently fetched string with
the first character of the current string, leading to the
"accumulation" of strings in earlier arguments in the output.

Fix this by incrementing the return value of strncpy_from_user() by
one if we did not hit the maximum buffer size.

Link: http://lkml.kernel.org/r/20190116141629.5752-1-andreas.ziegler@fau.de

Cc: Ingo Molnar <mingo@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 5baaa59ef09e ("tracing/probes: Implement 'memory' fetch method for uprobes")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_uprobe.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -153,7 +153,14 @@ static void FETCH_FUNC_NAME(memory, stri
 
 	ret = strncpy_from_user(dst, src, maxlen);
 	if (ret == maxlen)
-		dst[--ret] = '\0';
+		dst[ret - 1] = '\0';
+	else if (ret >= 0)
+		/*
+		 * Include the terminating null byte. In this case it
+		 * was copied by strncpy_from_user but not accounted
+		 * for in ret.
+		 */
+		ret++;
 
 	if (ret < 0) {	/* Failed to fetch string */
 		((u8 *)get_rloc_data(dest))[0] = '\0';



Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551EFC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A25A222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083633;
	bh=W2WXx0Qxecm5OPDrzvUfsAIxjLVnHo+CsilQjj/CLBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z0uF8BL2FJ7VOWwPNn/zWnCviFtihCqBUJ2XED5WBj85LHyHhiiRMTrmsvzIYqzWG
	 CIIGjKajhcXBP/mA5mwEwMxL81qwZB4qFoAASpCPZ3MVNBUdlp+akdwX74/Wfc7GbD
	 0Jvvik3P8luNSFwqRGeX6rH79cz/rvEp9a7rsPko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436492AbfBMSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406609AbfBMSrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:47:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F053B20811;
        Wed, 13 Feb 2019 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083628;
        bh=W2WXx0Qxecm5OPDrzvUfsAIxjLVnHo+CsilQjj/CLBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UxrZoPahuWMx6AqU7swMERmKXVNC1XDXtzN6ky8rZaLXsQ/BQzKU5PVa8l1yLpeMi
         0s1FJBoJmJP+i3DiBLI/dYjKzNPBN556QFeTk/bI2KVURqDQ7H4w14CbtNPKW8sNGp
         2Qapi+x2jvGoJIEDX0uIVYoF3dJHHUQn3D72CDEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.20 21/50] tracing/uprobes: Fix output for multiple string arguments
Date:   Wed, 13 Feb 2019 19:38:26 +0100
Message-Id: <20190213183657.472808374@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_uprobe.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -127,6 +127,13 @@ fetch_store_string(unsigned long addr, v
 	if (ret >= 0) {
 		if (ret == maxlen)
 			dst[ret - 1] = '\0';
+		else
+			/*
+			 * Include the terminating null byte. In this case it
+			 * was copied by strncpy_from_user but not accounted
+			 * for in ret.
+			 */
+			ret++;
 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
 	}
 



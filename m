Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B1E2089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5ZToGuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B1E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbeKIHs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbeKIHrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:46 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1832147D;
        Thu,  8 Nov 2018 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715014;
        bh=uTZxy5UB+jKBLZEXBZ839Fip607Q5PHDAF4YOYKAwkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5ZToGuErN/n/lXxjX+JSbT1E78scw89kMGfJ2gKFA2Rhp0L7b5zmWKxTVbCBcCyH
         mc1zn1aeUJ3DVb7a9sy1WRUVe64/rgnMBM88lh6Vlf0AfrHHfRDk/krdrsmLxW1ecY
         bbWDLhyYH9malujmWhrjucxvga1oSKw/yv66EFOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.18 25/34] tracing: Fix synthetic event to allow semicolon at end
Date:   Thu,  8 Nov 2018 13:52:54 -0800
Message-Id: <20181108215140.453613960@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit a360d9e4016c1fcf41553b37ad496870dc5723d0 upstream.

Fix synthetic event to allow independent semicolon at end.

The synthetic_events interface accepts a semicolon after the
last word if there is no space.

 # echo "myevent u64 var;" >> synthetic_events

But if there is a space, it returns an error.

 # echo "myevent u64 var ;" > synthetic_events
 sh: write error: Invalid argument

This behavior is difficult for users to understand. Let's
allow the last independent semicolon too.

Link: http://lkml.kernel.org/r/153986835420.18251.2191216690677025744.stgit@devbox

Cc: Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: commit 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_hist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1097,7 +1097,7 @@ static int create_synth_event(int argc,
 		i += consumed - 1;
 	}
 
-	if (i < argc) {
+	if (i < argc && strcmp(argv[i], ";") != 0) {
 		ret = -EINVAL;
 		goto err;
 	}



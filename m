Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB96C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71729217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71729217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbeHDLHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:07:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHDLHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:07:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5D1A89C;
        Sat,  4 Aug 2018 09:07:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 008/124] tracing: Quiet gcc warning about maybe unused link variable
Date:   Sat,  4 Aug 2018 10:59:57 +0200
Message-Id: <20180804082702.756841527@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 2519c1bbe38d7acacc9aacba303ca6f97482ed53 upstream.

Commit 57ea2a34adf4 ("tracing/kprobes: Fix trace_probe flags on
enable_trace_kprobe() failure") added an if statement that depends on another
if statement that gcc doesn't see will initialize the "link" variable and
gives the warning:

 "warning: 'link' may be used uninitialized in this function"

It is really a false positive, but to quiet the warning, and also to make
sure that it never actually is used uninitialized, initialize the "link"
variable to NULL and add an if (!WARN_ON_ONCE(!link)) where the compiler
thinks it could be used uninitialized.

Cc: stable@vger.kernel.org
Fixes: 57ea2a34adf4 ("tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_kprobe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -349,7 +349,7 @@ static struct trace_kprobe *find_trace_k
 static int
 enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 {
-	struct event_file_link *link;
+	struct event_file_link *link = NULL;
 	int ret = 0;
 
 	if (file) {
@@ -375,7 +375,9 @@ enable_trace_kprobe(struct trace_kprobe
 
 	if (ret) {
 		if (file) {
-			list_del_rcu(&link->list);
+			/* Notice the if is true on not WARN() */
+			if (!WARN_ON_ONCE(!link))
+				list_del_rcu(&link->list);
 			kfree(link);
 			tk->tp.flags &= ~TP_FLAG_TRACE;
 		} else {



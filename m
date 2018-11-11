Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102CA20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102CA20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbeKLFzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51894 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730984AbeKLFza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000oM-4Z; Sun, 11 Nov 2018 19:59:14 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001W1-7M; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.762417190@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 114/366] branch-check: fix long->int truncation when
 profiling branches
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 2026d35741f2c3ece73c11eb7e4a15d7c2df9ebe upstream.

The function __builtin_expect returns long type (see the gcc
documentation), and so do macros likely and unlikely. Unfortunatelly, when
CONFIG_PROFILE_ANNOTATED_BRANCHES is selected, the macros likely and
unlikely expand to __branch_check__ and __branch_check__ truncates the
long type to int. This unintended truncation may cause bugs in various
kernel code (we found a bug in dm-writecache because of it), so it's
better to fix __branch_check__ to return long.

Link: http://lkml.kernel.org/r/alpine.LRH.2.02.1805300818140.24812@file01.intranet.prod.int.rdu2.redhat.com

Cc: Ingo Molnar <mingo@redhat.com>
Fixes: 1f0d69a9fc815 ("tracing: profile likely and unlikely annotations")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -105,7 +105,7 @@ void ftrace_likely_update(struct ftrace_
 #define unlikely_notrace(x)	__builtin_expect(!!(x), 0)
 
 #define __branch_check__(x, expect) ({					\
-			int ______r;					\
+			long ______r;					\
 			static struct ftrace_branch_data		\
 				__attribute__((__aligned__(4)))		\
 				__attribute__((section("_ftrace_annotated_branch"))) \


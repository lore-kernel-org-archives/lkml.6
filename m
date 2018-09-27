Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D72FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEFC216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd/H3pZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEFC216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeI0WRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeI0WRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:17:52 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D10021571;
        Thu, 27 Sep 2018 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538063937;
        bh=r6nZliiHZmFeIbL0Ct6kZozfeyDGfPW2Vgv9pFrkKNU=;
        h=From:To:Cc:Subject:Date:From;
        b=hd/H3pZl0o5JQ9GbdfCcPgN9vGBaCHlroJ1OFvs5sXhsLzZ2EJxDajMUBrHRWC+xL
         uotT4zrYEKVXpGIQS8SycQl9QdUzFVRCXGx11EqNxp25v11lUwUH9rgEmvzcateaXg
         CKQ3M2canP0JbFwnjG2QZ1orb1xCvMrsnC7Bq5QQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/5] tracing: Unifying dynamic event interface
Date:   Fri, 28 Sep 2018 00:58:33 +0900
Message-Id: <153806391326.18458.3927382953014694981.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an RFC series of unifying dynamic event interface on ftrace.
Currently ftrace has 3 dynamic event interfaces, kprobes, uprobes
and synthetic. This series unifies kprobes and uprobes event
interface on "dynamic_events". This enables us to add new dynamic
events easily on same interface, e.g. function events.
The older interfaces are left on the tracefs for backward
compatibility at this moment.

dynamic_events syntax has no different from kprobe_events and
uprobe_events. You can use same syntax for dynamic_events interface.

I think we can integrate synthetic events to this dynamic_events
interface but it will requires new syntax. e.g.

echo "s:<event-name> <args>" >> dynamic_events

If it is OK, I'll add it in next version.

BTW, since this dynamic_events interface derived from *probe_events,
it inherits "all clear when truncate file open" behavior. But if you
think this is too aggressive, I can drop it. (even in that case,
kprobe_events/uprobe_events behavior is not changed)

I also introduced a widely used way to erase entries in other
interfaces of ftrace, that is '!'. So you can now use '!event-name'
or '!group/event' to erase an entry in dynamic_events.
(Wait... it has to be '!p:event' as others do??)

Any thought?

Thank you,

---

Masami Hiramatsu (5):
      tracing/uprobes: Add busy check when cleanup all uprobes
      tracing: Add a unified dynamic event framework
      tracing/kprobes: Use dyn_event framework for kprobe events
      tracing/uprobes: Use dyn_event framework for uprobe events
      tracing: Add generic event-name based remove event method


 Documentation/trace/kprobetrace.rst  |    3 +
 Documentation/trace/uprobetracer.rst |    4 +
 kernel/trace/Kconfig                 |    4 +
 kernel/trace/Makefile                |    1 
 kernel/trace/trace.c                 |    4 +
 kernel/trace/trace_dynevent.c        |  183 +++++++++++++++++++++++++++++++++
 kernel/trace/trace_dynevent.h        |   89 ++++++++++++++++
 kernel/trace/trace_kprobe.c          |  191 +++++++++++++++++++++++-----------
 kernel/trace/trace_uprobe.c          |  175 +++++++++++++++++++++++--------
 9 files changed, 547 insertions(+), 107 deletions(-)
 create mode 100644 kernel/trace/trace_dynevent.c
 create mode 100644 kernel/trace/trace_dynevent.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

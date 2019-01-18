Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7F6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940B2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547786662;
	bh=u1mhR/kF2G4BVk4xJ1ovltaIC8VQrNlI1zR7FMHg7zA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=b2xczAt9CYrkCkO9Hz/AYTeN3kiD3km/+2q2A601kNQudX3usAWuMdR/ffUc9VCwX
	 ftlq3IkLwRvN1agz4zs/a0CKwnOIa246A4xz1Ne/oBVfVleaV7TaFmWm06E/u3lGfC
	 g6Zj/b9EDdDJTxTF6lucyY1bJPm8uU8r14+CuX98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfAREoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfAREoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:44:21 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872292086D;
        Fri, 18 Jan 2019 04:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547786660;
        bh=u1mhR/kF2G4BVk4xJ1ovltaIC8VQrNlI1zR7FMHg7zA=;
        h=From:To:Cc:Subject:Date:From;
        b=oaHSsUBQI+F2VTi5pAQQo+vjgqZzdHR4OGPBmur1Gj5ZiWAvgbem754w1VvXlia5d
         0OqTTvW8CZGgVe/15Ypif/b1EZMjcrHeswJTcXHrsw2yoT14mnnC2G7DYJIVhTHsp3
         i4F9/piDOvwllMEfyyR6pU4iec6s+MHPPcuEsr30=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] tracing: probeevent: Fix probe argument parser and handler
Date:   Fri, 18 Jan 2019 13:43:56 +0900
Message-Id: <154778663676.19927.12774448308165809570.stgit@devbox>
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

Here is the 2nd version of series to fix several bugs in probe event
argument parser and handler routines.

In this version I just added Fixes tags so that it makes clear which
release should be fixed.

Recently I got 2 issues reported by Andreas, see
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899098.html

One issue is already fixed by Andreas (Thanks!) but $comm handling
issue still exists on uprobe event. [1/3] fixes it.
And I found other issues around that, [2/3] is just a trivial cleanup,
[3/3] fixes $comm type issue which occurs not only uprobe events but
also on kprobe events. Anyway, after this series applied, $comm must
be "string" type and not be an array.

Thank you,

---

Masami Hiramatsu (3):
      tracing: uprobes: Re-enable $comm support for uprobe events
      tracing: probeevent: Do not accumulate on ret variable
      tracing: probeevent: Fix to make the type of $comm string


 kernel/trace/trace_probe.c      |   13 +++++++------
 kernel/trace/trace_probe_tmpl.h |    2 +-
 kernel/trace/trace_uprobe.c     |   15 +++++++++++++--
 3 files changed, 21 insertions(+), 9 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A4120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547732904;
	bh=kTpgDt3fp6U+mlA9bVqgQq8o3QqTVInxjovlB3pRauA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ryk3LEtnbQtxwKS39HE/JH6dEwk/NgPJwvt6P+GwHy/hLgpqIsLZxJFoS4j5Nc4Y+
	 s/7XeMj+Fld4A+qv4udpIt90MuwTyebNlSOKz6Ffu+malgsxQSzte4w3d9/FlSqizi
	 Jax0wzJp+/mmYK71DAdT4iyR2Ys99kbW4lW0QmDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfAQNsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfAQNsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:48:22 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6390120851;
        Thu, 17 Jan 2019 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547732902;
        bh=kTpgDt3fp6U+mlA9bVqgQq8o3QqTVInxjovlB3pRauA=;
        h=From:To:Cc:Subject:Date:From;
        b=tkNVwi+yqAq8T92JwFYMRiyNgDBB0SSpuyUENtNL+wbGVOfh4IC+tlNJe+jh445bt
         3GqGYHYlMwBwV+9jyUVfzqC28Mis1k8C4TQUYZxYDb0X229qEBcx/b1laN0Qmb2lv7
         Yz9AZpgFdb6WWXy40YsIjY9kdTPIIAJ4QBBNJpu4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing: probeevent: Fix probe argument parser and handler
Date:   Thu, 17 Jan 2019 22:47:58 +0900
Message-Id: <154773287750.2285.5509629487576876823.stgit@devbox>
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

This series fixes several bugs in probe event argument parser
and handler routines.

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

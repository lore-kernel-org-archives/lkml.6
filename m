Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A80C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686362086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686362086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeK2Hma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:42:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeK2Hma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:42:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FB2B89AF1;
        Wed, 28 Nov 2018 20:39:36 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A6919483;
        Wed, 28 Nov 2018 20:39:32 +0000 (UTC)
Date:   Wed, 28 Nov 2018 15:39:31 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
Message-ID: <20181128203931.ym2rkya7a6agzzy3@redhat.com>
References: <20181122002801.501220343@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122002801.501220343@goodmis.org>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 28 Nov 2018 20:39:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 07:28:01PM -0500, Steven Rostedt wrote:
>
> [ ... snip ... ]
>
> Feel free to test this! I'll be pushing this to linux-next and let it
> sit there a week or so before pushing it to Linus.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/urgent

Hi Steve,

With your ftrace/urgent branch linked above, if I try a quick
function_graph test like the following:

  SYSFS=/sys/kernel/debug/tracing

  echo 0 > "$SYSFS/tracing_on"
  echo cmdline_proc_show > "$SYSFS/set_graph_function"
  echo function_graph > "$SYSFS/current_tracer"
  echo 1 > "$SYSFS/tracing_on"

I see a bunch of scheduler interrupt functions in the trace/trace_pipe
without even invoking cmdline_proc_show().

This tests works as expected with Linux 4.20-rc3 though:

  % cat /sys/kernel/debug/tracing/trace_pipe
   2)               |  cmdline_proc_show() {
   2)   0.320 us    |    seq_puts();
   2)   0.030 us    |    seq_putc();
   2)   1.352 us    |  }

Operator error, or did the patchset break something?

Regards,

-- Joe

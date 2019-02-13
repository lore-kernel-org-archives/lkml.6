Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48714C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8F5222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550081886;
	bh=eE5qF9SMQX/ohKMggwa320P87EODUz9gUPcUuxAscZU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rN1hQHiamLSUZBPAY4SbomOgYVakdQYjhzc9oIMleaJQhD/JX2Hu3p1tlthIb+jqS
	 ykNqGVr7IKtzfoW773KDln++MSdOfQbJLTk4q6Cxl1kFVAAPJsrAvZ/YKykcsExWty
	 AAK8r6bnL+dIbxtdsKL1wWQTOdijXZyYuryebm1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393664AbfBMSSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfBMSSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:18:04 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121DD21934;
        Wed, 13 Feb 2019 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550081882;
        bh=eE5qF9SMQX/ohKMggwa320P87EODUz9gUPcUuxAscZU=;
        h=From:To:Cc:Subject:Date:From;
        b=V62d8U45tTrPQ0UIZvaRMYcyB5gDdQeUCsTMUrIgYu549MgRT2PLkivW3Nhn9oGWC
         OfDxIWa1gXVCuXU+0S39mWwnSyoyDbcCTodrvU/fMgtYEAXYe7pUW8C0yye+6BQSGU
         mBCqZSx1nnQBnwVn5g3rwnJuGMGb+L+q5db0FcQI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 0/5] tracing: common error_log for ftrace
Date:   Wed, 13 Feb 2019 12:17:51 -0600
Message-Id: <cover.1550074795.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Last April, I posted an RFC patchset [1] implementing a common
error_log interface as suggested by Masami [2].  We were supposed to
discuss it at Plumbers but that never happened, and Steve recently
asked about patches for a follow-on discussion [3], so here they are.

I incorporated comments from the previous discussion, the most
important of which are:

 - Incorporated Steve's suggestion of using static strings as in the
   existing trace event filter code, along with err_info indexing into
   the string arrays and a position for the error caret.

 - Converted all the hist trigger errors and the existing trace event
   filter parse errors to use the new interface.

 - Converted a few kprobe_event errors to the new interface as
   examples, but these will require more work - I didn't spend much
   time figuring out how to get the full kprobe command into the error
   info, for instance.

 - Got rid of the custom single-page ring buffer and used standard
   lists instead.

For now, this is implemented on top of the latest 'hist trigger
snapshot and onchange additions' patchset [4].

Below is an example session of a few failed commands and the
corresponding error_log contents:

  # echo > /sys/kernel/debug/tracing/error_log

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument

  # cat /sys/kernel/debug/tracing/error_log
  hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                      ^

  # echo 'hist:key=comm:p=prio:onchange($q).snapshot()' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
  -su: echo: write error: Invalid argument

  # cat /sys/kernel/debug/tracing/error_log
  hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                      ^
  hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^

  # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  # echo 'hist:keys=pid' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: File exists

  # echo 'comm="cyclictest"' > /sys/kernel/debug/tracing/events/sched/sched_wakeup/filter
  -su: echo: write error: Invalid argument

  # cat /sys/kernel/debug/tracing/error_log
  hist:sched:sched_wakeup: error: Variable already defined
    Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                      ^
  hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^
  hist:sched:sched_wakeup: error: Hist trigger already exists
    Command: keys=pid
             ^
  event filter parse error: error: Invalid operator
    Command: comm="cyclictest"
                  ^

  # echo "((sig >= 10 && sig < 15) || dsig == 17) && comm != bash" > /sys/kernel/debug/tracing/events/signal/signal_generate/filter
  -su: echo: write error: Invalid argument

  # cat /sys/kernel/debug/tracing/error_log
  hist:sched:sched_wakeup: error: Variable already defined
  Command: keys=pid:ts0=common_timestamp.usecs if comm=="cyclictest"
                    ^
  hist:sched:sched_waking: error: Couldn't find onmax or onchange variable
    Command: key=comm:p=prio:onchange($q).snapshot()
                                       ^
  hist:sched:sched_wakeup: error: Hist trigger already exists
    Command: keys=pid
             ^
  event filter parse error: error: Invalid operator
    Command: comm="cyclictest"
                  ^
  event filter parse error: error: Field not found
    Command: ((sig >= 10 && sig < 15) || dsig == 17) && comm != bash
                                              ^  


Thanks,

Tom


[1] https://lore.kernel.org/lkml/cover.1523545519.git.tom.zanussi@linux.intel.com/
[2] https://lore.kernel.org/lkml/20180406105309.b50ea1a21d2cbd9b0e39dbfd@kernel.org/
[3] https://lore.kernel.org/lkml/e885d1fd02e76f121d6cc2bb28e58b523e2434a7.camel@linux.intel.com/
[4] https://lore.kernel.org/lkml/cover.1549403369.git.tom.zanussi@linux.intel.com/

The following changes since commit 779474478eacb64a1e686a37cf663d8210d88f84:

  tracing: Add hist trigger action 'expected fail' test case (2019-02-05 14:53:54 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/error_log_v2

Tom Zanussi (5):
  tracing: Add tracing error log
  tracing: Save the last hist command's associated event name
  tracing: Use tracing error_log with hist triggers
  tracing: Use tracing error_log with kprobe events (incomplete)
  tracing: Use tracing error_log with trace event filters

 kernel/trace/trace.c               | 217 ++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h               |   4 +
 kernel/trace/trace_events_filter.c |   7 +-
 kernel/trace/trace_events_hist.c   | 221 ++++++++++++++++++++-----------------
 kernel/trace/trace_probe.c         |  24 +++-
 5 files changed, 368 insertions(+), 105 deletions(-)

-- 
2.14.1


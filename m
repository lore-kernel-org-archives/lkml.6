Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BD2222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550101386;
	bh=hnEuHjZQ6t5ez1rqkYS8TbSZaPth8MjACWbz6ivvOrU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q6nQzFSDZAuy8hIF9itN81Is1MSTSLsKSaaJtfwD+JuzKzkXWOSnTSVtO3pIOghEq
	 ItDIFMcBAiTec3jwLzdmWuQIjFWrEpi4UrLRYFzjm6WkXIrXML+d+3YOTMWb+f3MjJ
	 dv++tyhXNlqj+mLYhfRdAbUYj+8NfB2X50aZHPNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392790AbfBMXnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfBMXnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:43:03 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDFA222C9;
        Wed, 13 Feb 2019 23:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550101382;
        bh=hnEuHjZQ6t5ez1rqkYS8TbSZaPth8MjACWbz6ivvOrU=;
        h=From:To:Cc:Subject:Date:From;
        b=yKu7qHOO20TSiN2iaL0uwFeo+hcNlvNtdwvEejYv4xpY/7CcugjR0Xd897G/k5Tmk
         atrLiFbUuTgybqf9bAX7HiZ/htxi+Ej/0XDqadAgXqyUldM/E/ZY5C4URjH3aT7flA
         1YmoSVTY9XFU4++pi145mpT9vk0QakNeIoJGt2DU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v15 00/15] tracing: Hist trigger snapshot and onchange additions
Date:   Wed, 13 Feb 2019 17:42:40 -0600
Message-Id: <cover.1550100284.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This is v15 of the hist trigger snapshot and onchange additions
patchset.

This version addresses several comments from Steve Rostedt (thanks,
Steve!) in the snapshot and snapshot command patches.  Everything else
remains the same.

Thanks,

Tom


v14->v15 changes:

  - Fixed return-with-mutex-held errors in tracing_snapshot_cond_enable()
    and simplified the error return handling.
  - Simplified error return handling in update_max_tr().
  - Simplified the -EBUSY cond_snapshot checks in tracing_set_tracer()
    and tracing_snapshot_write().
  - Removed ifdef around cond_snapshot struct in trace.h.
  - Introduced tracing_snapshot_instance_cond(), defined
    tracing_snapshot_instance() in terms of that, and changed the more
    numerous calls to that simpler function instead.
  - Removed the unnecessary size param in track_data_alloc() and use
    TASK_COMM_LEN directly instead.

v13->v14 changes:

  - Added CONFIG_TRACER_SNAPSHOT ifdefs as appropriate to partition
    out snapshot code.
  - Changed tracing_snapshot_cond_enable() to return -ENODEV to the
    user if CONFIG_TRACER_SNAPSHOT isn't on.
  - Made sure only the trigger that enabled the snapshot can disable
    it in track_data_destroy().

v12->v13 changes:

  - Added -EBUSY checks to tracing_snapshot_cond_enable()
    tracing_snapshot_cond(), tracing_set_tracer() and
    tracing_snapshot_write().
  - Introduced snapshot_context for passing key/elt pair to
    tracing_snapshot_cond().
  - Removed key and cond_snapshot from action_data and cur_elt from
    track_data.
  - Added updated flag to track_data and test for it in
    hist_trigger_print_key().
  - Removed cond_snapshot_update_track_data() and simplified
    cond_snapshot_update().
  - Removed get/save_track_val_fn_t and corresponding
    get_val/save_val() members from action_data.
  - Moved code from get/save_val functions to save_data instead.

v11->v12 changes:

  - Removed parens from the param list specification in the trace()
    command description
  - Changed the Documentation for synthetic event generation to
    emphasize the trace() form over the function-call form.

v10->v11 changes:

  - Updated to use str_has_prefix() for static strings

v9->v10 changes:

  - Updated to use strncmp_prefix() for static strings

v8->v9 changes:

  - Moved v8 patches 17-22 to a separate series
  - Moved track_data.var_ref_idx removal into 'tracing: Generalize
    hist trigger onmax and save action'
  - Merged 'tracing: Add hist trigger handler.action documentation'
    into 'tracing: Refactor hist trigger action code'
  - Updated patches to change all strlen() to sizeof() for string
    constants
  - Moved test cases to the end of the series

v7->v8 changes:

  - Removed /dev/null redirection from test cases
  - Replaced event disable with tracing_on disable instead
  - New patch to remove hist_field.var_idx and track_data.var_ref_idx
  - New patch to use var_refs[] array for reference checking
  - New patch to remove open-coding of var_ref count manipulation
  - New patch to use var_refs[] array to destroy var_refs
  - New patch to remove synth_var_refs[] now that var_refs[] is used
  - New patch to add comments to variable-related fields
  - Added various new comments in the patches to clarify other things
  - Replaced the convoluted logic mentioned by Namhyung in
    update_track_val with wrappers and simpler check/save logic as
    suggested
  - Rebased to latest ftrace/core including Masami's dynamic event
    framework changes

v6->v7 changes:

  - Removed unnecessary HANDLER_ONMAX checks from onmax_print()/create()
  - Moved handler assignment to acion_parse()
  - Changed goto in ATION_TRACE case in action_create() to return
  - Changed EINVAL to EEXIST in action_create() ACTION_SAVE case
  - Made the return logic in create_actions() more consistent
  - Merged 'tracing: Move hist trigger key printing into a separate
    function' into 'tracing: Add hist trigger snapshot() action'
  - Updated the new snapshot, onchange, and trace test cases to match
    4.20 kselftest changes.
  - Added new xfail test case that make sure certain unsupported
    handler/action combinations fail as expected.
  - While updating the test cases, realized that the other testcases
    in the inter-event subdir needed SPDX license updates, so added
    them.

v5->v6 changes:

  - Added new Documentation patch explaining handler.action
  - Added new README patch explaining handler.action
  - Added separate snapshot() Documentation
  - Added new snapshot() test case
  - Updated README with snapshote()
  - Added separate onchange() Documentation
  - Added separate onchange() test case
  - Updated README with onchange()
  - Added separate trace() test case
  - Updated README with trace() and <synthetic_event>() syntax

v4->v5 changes:

  - added 'trace' keyword test case
  - added 'onchange' handler test case

v3->v4 changes:

  - added 'trace' keyword for generating synthetic events
  - fix elt_data leak
  - changed cond_update to cond_update_fn_t

v2->v3 changes:

  - fixed problem where trace actions were only being allowed for
    onmatch handlers - now trace actions can be used with any handler.
  - fixed problem where no action was being assigned to onmatch
    handlers if save or snapshot actions were specified.

v1->v2 changes:

  - added missing tracing_cond_snapshot_data() definition for when
    CONFIG_TRACER_SNAPSHOT not defined
  - removed an unnecessary WARN_ON() in track_data_snapshot_print()


Original text:

This patchset adds some useful new functions to the hist
trigger code: a snapshot action and an onchange handler.

In order to make it easier to add these and in the process make the
code more generic, I separated the code into explicit 'handlers' and
'actions', handlers being things like 'onmax' and 'onchange', and
'actions' being things like 'take a snapshot' or 'save some fields'.

The first few patches do that basic refactoring, which make it easier
to add the subsequent changes that arbitrarily combine actions and
handlers.

The fourth patch adds a 'conditional snapshot' capability that via a
new tracing_snaphot_cond() function extends the existing snapshot
code.  It allows the caller to associate some user data with the
snapshot that can be checked and saved in an update() callback whose
return value determines whether the snapshot should be taken or not.

The remaining patches finally add the new snapshot action and onchange
handler functionality - please see those patches for details and some
examples.

Thanks,

Tom


The following changes since commit 50c35ae1267d64eee975b8125e151e600071d4dc:

  tracing: Use strncpy instead of memcpy for string keys in hist triggers (2019-02-04 08:45:50 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v15

Tom Zanussi (15):
  tracing: Refactor hist trigger action code
  tracing: Make hist trigger Documentation better reflect
    actions/handlers
  tracing: Split up onmatch action data
  tracing: Generalize hist trigger onmax and save action
  tracing: Add conditional snapshot
  tracing: Add hist trigger snapshot() action
  tracing: Add hist trigger snapshot() action Documentation
  tracing: Add hist trigger onchange() handler
  tracing: Add hist trigger onchange() handler Documentation
  tracing: Add alternative synthetic event trace action syntax
  tracing: Add SPDX license GPL-2.0 license identifier to inter-event
    testcases
  tracing: Add hist trigger snapshot() action test case
  tracing: Add hist trigger onchange() handler test case
  tracing: Add alternative synthetic event trace action test case
  tracing: Add hist trigger action 'expected fail' test case

 Documentation/trace/histogram.rst                  |  316 +++++-
 kernel/trace/trace.c                               |  208 +++-
 kernel/trace/trace.h                               |   56 +-
 kernel/trace/trace_events_hist.c                   | 1048 ++++++++++++++------
 kernel/trace/trace_sched_wakeup.c                  |    2 +-
 .../inter-event/trigger-action-hist-xfail.tc       |   30 +
 .../inter-event/trigger-extended-error-support.tc  |    1 +
 .../inter-event/trigger-field-variable-support.tc  |    1 +
 .../trigger-inter-event-combined-hist.tc           |    1 +
 .../inter-event/trigger-multi-actions-accept.tc    |    1 +
 .../inter-event/trigger-onchange-action-hist.tc    |   28 +
 .../inter-event/trigger-onmatch-action-hist.tc     |    1 +
 .../trigger-onmatch-onmax-action-hist.tc           |    1 +
 .../inter-event/trigger-onmax-action-hist.tc       |    1 +
 .../inter-event/trigger-snapshot-action-hist.tc    |   43 +
 .../trigger-synthetic-event-createremove.tc        |    1 +
 .../inter-event/trigger-trace-action-hist.tc       |   42 +
 17 files changed, 1459 insertions(+), 322 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc

-- 
2.14.1


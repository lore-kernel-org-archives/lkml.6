Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F69EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573E4214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486506;
	bh=G84pp9d7ppQk/Yn4lo29ML+o9JGOM8phqqMXJVA9F+8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N8O1VTFt4h0C1gAym5kbL+qKLzoCXyPG1YxbvdCzcdRyqS5X6K03lQPIhkhoeS0Cr
	 sUCqF9Mdv1yobqPFw84/Ra6L6MPLowLr//7uWnNbcGIXlbtbj7P+DNE4QSuMKGDN6m
	 Scvpo6No5eDEGB8lH0GuEWzMNZbZmYDl7146a/h4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573E4214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeLKABp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbeLKABo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:01:44 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB85F214D9;
        Tue, 11 Dec 2018 00:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486503;
        bh=G84pp9d7ppQk/Yn4lo29ML+o9JGOM8phqqMXJVA9F+8=;
        h=From:To:Cc:Subject:Date:From;
        b=IxcoPDOwlV3oqxx9eFVmqdH4f58X0w/a3mTwM0UxkWqM+7so/thsk/mjTUmBoxMjW
         z7y89pB3uTdfGhwirdU4dEk/tl6PNUmPjKw+Z2wDClYcgpkWD983WZZroVvk3v0yQ5
         sWJCoyV5gcirQv+1Dsmwi19CGnL6bRCAjohM8sz8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 00/22] tracing: Hist trigger snapshot and onchange additions
Date:   Mon, 10 Dec 2018 18:01:14 -0600
Message-Id: <cover.1544483272.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This is v8 of the hist trigger snapshot and onchange additions
patchset.  It makes testcase changes suggested by Masami, and does a
bit of refactoring and cleanup as suggested by Namhyung.  It also adds
a bunch of comments mainly to the variable and variable reference code
to I hope clear up questions regarding indexing that Namhyung had.

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


The following changes since commit 5d6ddf6acce68d1290112cb08b12fd78b201e7d5:

  arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack (2018-12-08 22:21:31 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v8

Tom Zanussi (22):
  tracing: Refactor hist trigger action code
  tracing: Make hist trigger Documentation better reflect
    actions/handlers
  tracing: Add hist trigger handler.action documentation to README
  tracing: Split up onmatch action data
  tracing: Generalize hist trigger onmax and save action
  tracing: Add conditional snapshot
  tracing: Add hist trigger snapshot() action
  tracing: Add hist trigger snapshot() action Documentation
  tracing: Add hist trigger snapshot() action test case
  tracing: Add hist trigger onchange() handler
  tracing: Add hist trigger onchange() handler Documentation
  tracing: Add hist trigger onchange() handler test case
  tracing: Add alternative synthetic event trace action syntax
  tracing: Add alternative synthetic event trace action test case
  tracing: Add hist trigger action 'expected fail' test case
  tracing: Add SPDX license GPL-2.0 license identifier to inter-event
    testcases
  tracing: Remove unnecessary hist trigger struct fields
  tracing: Use var_refs[] for hist trigger reference checking
  tracing: Remove open-coding of hist trigger var_ref management
  tracing: Use hist trigger's var_ref array to destroy var_refs
  tracing: Remove hist trigger synth_var_refs
  tracing: Add hist trigger comments for variable-related fields

 Documentation/trace/histogram.rst                  |  285 ++++-
 kernel/trace/trace.c                               |  177 ++-
 kernel/trace/trace.h                               |   56 +-
 kernel/trace/trace_events_hist.c                   | 1303 ++++++++++++++------
 kernel/trace/trace_events_trigger.c                |    2 +-
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
 18 files changed, 1584 insertions(+), 392 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc

-- 
2.14.1


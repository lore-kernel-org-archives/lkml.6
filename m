Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF7FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3638920881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xMuh9Jsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3638920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeIKAGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeIKAGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:06:22 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604B82086A;
        Mon, 10 Sep 2018 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536606650;
        bh=WaK+QZN/x0f3Uv0otA5Di4SLb6idC7E0caYr7368GWU=;
        h=From:To:Cc:Subject:Date:From;
        b=xMuh9JslSqdEBc4O7F12ujEut2DbUzw9EyDkxv3Dj3I3TnRq3jIptrSCQldFo+Ku1
         EdCVmWaIhodTp8pB7Y/9Hzj4vSIPgD0DXwun74y9r0cofhDMNZnWsDqEf1ISr435/A
         fG74VXx8zCpGnXyWZWRC9ZR+dMuRDiheMwnzAZqE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v4 0/8] tracing: Hist trigger snapshot and onchange additions
Date:   Mon, 10 Sep 2018 14:10:38 -0500
Message-Id: <cover.1536605847.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This is v4 of the hist trigger snapshot and onchange additions
patchset.  It adds fixes to a couple problems noticed by Namhyung Kim,
as well as one minor syntax addition ('trace' keyword for generating
synthetic events) also suggested by him.

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


The following changes since commit 9161a864ff88e800de50494da095af19832e9583:

  tracing/kprobes: Fix to check notrace function with correct range (2018-08-21 09:41:12 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v4

Tom Zanussi (8):
  tracing: Refactor hist trigger action code
  tracing: Split up onmatch action data
  tracing: Generalize hist trigger onmax and save action
  tracing: Add conditional snapshot
  tracing: Move hist trigger key printing into a separate function
  tracing: Add snapshot action
  tracing: Add hist trigger onchange() handler
  trace: Add alternative synthetic event trace action syntax

 Documentation/trace/histogram.txt   |  226 ++++++++
 kernel/trace/trace.c                |  162 +++++-
 kernel/trace/trace.h                |   56 +-
 kernel/trace/trace_events_hist.c    | 1062 ++++++++++++++++++++++++++---------
 kernel/trace/trace_events_trigger.c |    2 +-
 kernel/trace/trace_sched_wakeup.c   |    2 +-
 6 files changed, 1224 insertions(+), 286 deletions(-)

-- 
2.14.1


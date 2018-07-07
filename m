Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF44C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8001620C48
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwYxexIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8001620C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeGGPAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753567AbeGGPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:00:11 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63FD208FA;
        Sat,  7 Jul 2018 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530975610;
        bh=A/RMFfJnSTpW6QCsDoLOzZePZK9edO6D5BwPPBjN0sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EwYxexIM/BrOjBv9CDpmPh2YvYXUYIJj0Y01hHlUHs6LZZq/Q//kBoFkuDgUXHD1u
         7ISxYXIG71PdT6HHhrielEriq6rmBhFqK+xBQzipcRCv8UNGA+LqlXiNRZYz2zYfY4
         f7T/sbZpgkMtj9i+YMwawH+A33VDefGSJJV0oktg=
Date:   Sun, 8 Jul 2018 00:00:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 0/7] tracing: Hist trigger snapshot and onchange
 additions
Message-Id: <20180708000006.5b93884b8123392ab2446809@kernel.org>
In-Reply-To: <cover.1530561352.git.tom.zanussi@linux.intel.com>
References: <cover.1530561352.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon,  2 Jul 2018 15:22:19 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> This is v2 of the hist trigger snapshot and onchange additions
> patchset.  It adds a couple fixes to problems flagged by the kbuild
> test robot, but is otherwise the same as v1.
> 
> Changes since v1:
> 
>   - added missing tracing_cond_snapshot_data() definition for when
>     CONFIG_TRACER_SNAPSHOT not defined
>   - removed an unnecessary WARN_ON() in track_data_snapshot_print()
> 
> 
> Original text:
> 
> This patchset adds some useful new functions to the hist
> trigger code: a snapshot action and an onchange handler.
> 
> In order to make it easier to add these and in the process make the
> code more generic, I separated the code into explicit 'handlers' and
> 'actions', handlers being things like 'onmax' and 'onchange', and
> 'actions' being things like 'take a snapshot' or 'save some fields'.

Sounds great!

By the way, it seems that nowadays the syntax of trigger is
very complicated. For example, we can set some 'actions' without
handlers, but this introduce new 'handlers' on it.

Could you consider not just extending it, but refactor it from
the viewpoint of consistent and extensible syntax?

e.g. if we support

<actions> if <condition>

syntax, why we can not do 

<actions> onchange(<var>)

? :)

Thank you,

> 
> The first few patches do that basic refactoring, which make it easier
> to add the subsequent changes that arbitrarily combine actions and
> handlers.
> 
> The fourth patch adds a 'conditional snapshot' capability that via a
> new tracing_snaphot_cond() function extends the existing snapshot
> code.  It allows the caller to associate some user data with the
> snapshot that can be checked and saved in an update() callback whose
> return value determines whether the snapshot should be taken or not.
> 
> The remaining patches finally add the new snapshot action and onchange
> handler functionality - please see those patches for details and some
> examples.
> 
> Thanks,
> 
> Tom
> 
> The following changes since commit 591a033dc17ff6f684b6b6d1d7426e22d178194f:
> 
>   tracing: Use match_string() instead of open coding it in trace_set_options() (2018-06-05 16:19:39 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-snapshot-onchange-v2
> 
> Tom Zanussi (7):
>   tracing: Refactor hist trigger action code
>   tracing: Split up onmatch action data
>   tracing: Generalize hist trigger onmax and save action
>   tracing: Add conditional snapshot
>   tracing: Move hist trigger key printing into a separate function
>   tracing: Add snapshot action
>   tracing: Add hist trigger onchange() handler
> 
>  Documentation/trace/histogram.txt   | 206 ++++++++
>  kernel/trace/trace.c                | 162 +++++-
>  kernel/trace/trace.h                |  58 ++-
>  kernel/trace/trace_events_hist.c    | 982 ++++++++++++++++++++++++++----------
>  kernel/trace/trace_events_trigger.c |   2 +-
>  kernel/trace/trace_sched_wakeup.c   |   2 +-
>  6 files changed, 1140 insertions(+), 272 deletions(-)
> 
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

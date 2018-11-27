Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B71C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B71C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeK1FKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:10:33 -0500
Received: from ms.lwn.net ([45.79.88.28]:42482 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725752AbeK1FKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:10:33 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 70DC72D5;
        Tue, 27 Nov 2018 18:11:49 +0000 (UTC)
Date:   Tue, 27 Nov 2018 11:11:48 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] Documentation/admin-guide: introduce
 perf-security.rst file
Message-ID: <20181127111148.75746f02@lwn.net>
In-Reply-To: <b1a4fa08-482d-0fcc-c798-efb9a9894a47@linux.intel.com>
References: <feac7efa-df6f-cca1-e321-28d220bf0411@linux.intel.com>
        <b1a4fa08-482d-0fcc-c798-efb9a9894a47@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 11:15:37 +0300
Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> +To perform security checks, the Linux implementation splits processes into two
> +categories [6]_ : a) privileged processes (whose effective user ID is 0, referred
> +to as superuser or root), and b) unprivileged processes (whose effective UID is
> +nonzero). Privileged processes bypass all kernel security permission checks so
> +perf_events performance monitoring is fully available to privileged processes
> +without access, scope and resource restrictions.
> +
> +Unprivileged processes are subject to a full security permission check based on
> +the process's credentials [5]_ (usually: effective UID, effective GID, and
> +supplementary group list).
> +
> +Linux divides the privileges traditionally associated with superuser into
> +distinct units, known as capabilities [6]_ , which can be independently enabled
> +and disabled on per-thread basis for processes and files of unprivileged users.
> +
> +Unprivileged processes with enabled CAP_SYS_ADMIN capability are treated as
> +privileged processes with respect to perf_events performance monitoring and
> +bypass *scope* permissions checks in the kernel.
> +
> +Unprivileged processes using perf_events system call API is also subject for
> +PTRACE_MODE_READ_REALCREDS ptrace access mode check [7]_ , whose outcome
> +determines whether monitoring is permitted. So unprivileged processes provided
> +with CAP_SYS_PTRACE capability are effectively permitted to pass the check.

It's good to have more information here.  I could certainly quibble
further with things - a process with CAP_SYS_ADMIN is not "unprivileged"!
- but I don't want to stand in the way of this any further.  I *would*
still like to see an ack from the perf world, though.

With regard to Kees's comment on merging the two patches; I would probably
add the new document to index.rst in the same patch, but it doesn't matter
that much.  Not worth redoing the patch just for that.

jon

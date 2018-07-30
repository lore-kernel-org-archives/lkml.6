Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E4FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5A820893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5A820893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeG3RmI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:42:08 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41710 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeG3RmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:42:08 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so10305397ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mRu0HBSAwS/9FJazXj1uydj8bDGIih5P0P2k2UBhde8=;
        b=EsC6v9bEPDP0S8r2KwTT/N143lAaCSTuNCCPw4gPcz6RF07F30Qv3Jwhw+bR2T80kx
         /NpL2plxjbDvy9grHjGhXfudjY2HMhnlewe9bLNm/osjIMoklOl9xoljnMVvs1u1Znvc
         3bBg49+g1bOQ6vNrbjB5+cddOgsGFoiMWZUBqljk2GfMea0Hinw25X9T1yXT1KiSJuwv
         OhUdD/iO2UMOyiavCfeuTWABc0geCSuNih5/zz3PMlX/o3UbUtl+mLttm6/euxA8kxKL
         WGpgNQYEBkuPgDq14bM/egNWuBueKjXDJkjMmHcQaqdCDfQy8z8WyQG9KFzeZ1XgqP2s
         DERw==
X-Gm-Message-State: AOUpUlHViPoZTuLCnAMvcRD72ZC1avuYAZG/S9WpvxKDHgkS9x7HL4dS
        MTudbbZMh4lFk7JzTxVyrsGahQETKk36ENe8oiA=
X-Google-Smtp-Source: AAOMgpdsljbeN/F/LTPuulET6GSazpRPWqPXYZqUgVO04HYsuw46LLd7Kekp+22f9SND4zQ0p59Izoph4qj9vnzhO7s=
X-Received: by 2002:a6b:b751:: with SMTP id h78-v6mr15142732iof.164.1532966789304;
 Mon, 30 Jul 2018 09:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <153294598465.32740.17737878083872427008.stgit@devbox>
In-Reply-To: <153294598465.32740.17737878083872427008.stgit@devbox>
From:   Francis Deslauriers <francis.deslauriers@efficios.com>
Date:   Mon, 30 Jul 2018 12:06:17 -0400
Message-ID: <CADcCL0hWtn=r-AjpKgB_JKeL1aTbeZPpoKeVXH8Z_FnJYyaTbA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] tracing: kprobes: Prohibit probing on notrace functions
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, shuah@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,
I just tested the patch-set and it still prevents the crash I was witnessing.
You can add my tested-by.
Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>

Thank you for pushing this forward!
Francis
Le lun. 30 juill. 2018, à 06 h 20, Masami Hiramatsu
<mhiramat@kernel.org> a écrit :
>
> Hi,
>
> This is the 5th version of the series to prohibit kprobe
> on notrace functions.
>
> This fixes a build error when CONFIG_FUNCTION_TRACER=y but
> DYNAMIC_FTRACE=n. Finally I decided to recover the approach
> in the 1st version, made it depends on CONFIG_KPROBES_ON_FTRACE=y.
> It is the simplest and enough to prohibiting kernel crash.
>
> So, in summary, if CONFIG_KPROBES_ON_FTRACE=y (which depends
> on CONFIG_DYNAMIC_FTRACE=y, so ftrace_location_range must be
> there) && CONFIG_KPROBE_EVENTS_ON_NOTRACE=n (default),
> kprobe events can not be defined on notrace function.
> Otherwides (means CONFIG_KPROBES_ON_FTRACE=n or
> CONFIG_KPROBE_EVENTS_ON_NOTRACE=y), we can put kprobe events
> on notrace functions.
>
> Francis, I dropped your tested-by because I got many kbuild
> errors and fixed it. If you can, could you test it again?
>
> Thank you,
>
> ---
>
> Francis Deslauriers (1):
>       selftest/ftrace: Move kprobe selftest function to separate compile unit
>
> Masami Hiramatsu (2):
>       tracing: kprobes: Prohibit probing on notrace function
>       selftests/ftrace: Fix kprobe string testcase to not probe notrace function
>
>
>  kernel/trace/Kconfig                               |   20 +++++++
>  kernel/trace/Makefile                              |    5 ++
>  kernel/trace/trace_kprobe.c                        |   59 +++++++++++++-------
>  kernel/trace/trace_kprobe_selftest.c               |   10 +++
>  kernel/trace/trace_kprobe_selftest.h               |    7 ++
>  .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++------
>  .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 -
>  7 files changed, 94 insertions(+), 39 deletions(-)
>  create mode 100644 kernel/trace/trace_kprobe_selftest.c
>  create mode 100644 kernel/trace/trace_kprobe_selftest.h
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>



--
Francis Deslauriers
Software developer
EfficiOS inc.

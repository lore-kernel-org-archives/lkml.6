Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2270raaZZEPKL/T9x5ckGuC4ZDdmG8HrKXGkR5Lbd5ggVNkKrlI2PR9lxjC/HB3nLxf4PteP
ARC-Seal: i=1; a=rsa-sha256; t=1519299812; cv=none;
        d=google.com; s=arc-20160816;
        b=wqjSYoE18ETgarf+95H0PDA0GnZTzEl/gB5DaOA5NQF7EeXjNy0Ilb87PC/A0cMH9u
         OQD73FfoDGeiTaLx1Rdeww1TbpU8fH16+iKnPagv5eLj4r4Oc+VcpTXC6bJKFajf4ftk
         PuT3wAvMhzY0uVUip01nDEiFceoYWNrqsLA+msARSW74u/6T3J0QlthaPBvtlwFS+txY
         WrmbuBK0PqNmaSOTcw55P4lJKjTn7coDphH+eLLJAxbrUAghyg2yM02bfZfEWp+zVcqm
         oWZAZk4xTEDLWzACHVA14nSdr4x1Qhuo0S7pU0xgzvEJLKNqDSc5m+OvmSBepi8200F2
         p6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=0sE7uuQh1GSmValkCU0CSGhLOUnNUNVF8qCbNyHUcuc=;
        b=ArDgqGnpak/ZeN6qd1uOEFz2CPxEy77fL8BvNUga3IIDa7683unsPuOChBQHe3L3SN
         PXy8LPO9MWcRgKvLkmZ5kpjo6PWLXE68GLEvZxTrvGm8//fZyrvFCxSTZX7gBbvkEzdZ
         36FHwlE+WNyAy6eMdclriulWteGQBimUXr3qC63U5NmT0/O2dCfWk6k9lQXQHDFOxMh/
         FdgLPKKyksnzgZRtZVbXVA91oQ7L9xhaFedMkDkDSoG6oWAFsY7n8h6BX38gs28CZ07v
         v3YNUPfLcmwgHdl0MCqZ4M5wPMTiAaHWr0gFk7BMk2Dhl1bNi98SdtA8YsCnAY8DvOnQ
         B8RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeBVLnc (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 06:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753515AbeBVLnb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 06:43:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D72021796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 22 Feb 2018 20:43:27 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2 15/17] selftests: ftrace: Add a testcase for symbol
 type
Message-Id: <20180222204327.269b207ff8c3c4da377f7598@kernel.org>
In-Reply-To: <151922528927.6217.272823645130675841.stgit@devbox>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
        <151922528927.6217.272823645130675841.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593023203354951392?=
X-GMAIL-MSGID: =?utf-8?q?1593101320887232795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 00:01:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase for symbol type with kprobe event.
> This tests good/bad syntax combinations and also
> the traced data.
> If the kernel doesn't support symbol type, it skips
> the test as UNSUPPORTED.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   73 ++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
> new file mode 100644
> index 000000000000..a5820b175df5
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Kprobe event argument symbol type
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +grep -qe "type:.* symbol" README || exit_unsupported # version issue
> +
> +echo 0 > events/enable
> +echo > kprobe_events
> +
> +PROBEFUNC="vfs_read"
> +GOODREG=
> +BADREG=
> +GOODSYM="_sdata"
> +if ! grep -qw ${GOODSYM} /proc/kallsyms ; then
> +  GOODSYM=$PROBEFUNC
> +fi
> +
> +case `uname -m` in
> +x86_64|i[3456]86)
> +  GOODREG=%ax
> +  BADREG=%ex
> +;;
> +aarch64)
> +  GOODREG=%x0
> +  BADREG=%ax
> +;;
> +arm*)
> +  GOODREG=%r0
> +  BADREG=%ax
> +;;
> +*)
> +  echo "Please implement other architecture here"
> +  exit_untested
> +esac
> +
> +test_goodarg() # Good-args
> +{
> +  while [ "$1" ]; do
> +    echo "p ${PROBEFUNC} $1" > kprobe_events
> +    shift 1
> +  done;
> +}
> +
> +test_badarg() # Bad-args
> +{
> +  while [ "$1" ]; do
> +    ! echo "p ${PROBEFUNC} $1" > kprobe_events
> +    shift 1
> +  done;
> +}
> +
> +echo > kprobe_events
> +
> +: "Symbol type"
> +test_goodarg "${GOODREG}:symbol" "@${GOODSYM}:symbol" "@${GOODSYM}+10:symbol" \
> +	 "\$stack0:symbol" "+0(\$stack):symbol"
> +test_badarg "\$comm:symbol"
> +
> +: "Retval with symbol type"
> +echo "r ${PROBEFUNC} \$retval:symbol" > kprobe_events
> +
> +echo > kprobe_events
> +
> +: "Test get symbol"
> +echo 'p:testprobe create_trace_kprobe $stack0:symbol' > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +! echo test >> kprobe_events
> +tail -n 1 trace | grep -q "arg1=trace_run_command"

Hmm, this works only on x86 and other arch which stores return address on
top of stack. I'll find some other good point to test it.

Thanks,

> +
> +echo 0 > events/enable
> +echo > kprobe_events
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

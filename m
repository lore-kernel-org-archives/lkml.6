Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF222C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C19921567
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C19921567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeHYF4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 01:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbeHYF4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 01:56:41 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098B121567;
        Sat, 25 Aug 2018 02:19:27 +0000 (UTC)
Date:   Fri, 24 Aug 2018 22:19:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/32] selftests/ftrace: Add output format testcase
Message-ID: <20180824221926.40cae9f9@vmware.local.home>
In-Reply-To: <153443782973.23257.16320326555688796000.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443782973.23257.16320326555688796000.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:43:49 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase for tracing output format using trace_marker.
> This tests raw, hex and bin format output.

I'd like to deprecate these formats. They are useless ever since we
implemented trace_pipe_raw.

Let's not add this test.

Thanks,

-- Steve

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/00basic/print_format.tc          |   51 ++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc b/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
> new file mode 100644
> index 000000000000..55feb542e83e
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL2.0
> +# description: Change print trace format
> +
> +if [ ! -f trace_marker ]; then
> +  echo "trace_marker is not supported, can not continue testing"
> +  exit_unresolved
> +fi
> +
> +do_reset() {
> +  if [ `cat options/bin` -eq 1 ]; then
> +    grep -v "^#" trace | od -h | cut -f 2- -d " " | xargs echo
> +  fi
> +  echo 0 > options/hex
> +  echo 0 > options/raw
> +  echo 0 > options/bin
> +  cat trace
> +  exit 1
> +}
> +
> +echo > trace
> +echo "abcdefgh" > trace_marker
> +echo 0 > tracing_on
> +
> +: "Get the pid and cpu#"
> +IDS=`grep -v "^#" trace | sed -e 's/[[:space:]]*.*-\([[:digit:]]*\)[[:space:]]*\[\([[:digit:]]*\)\].*/\1 \2/'`
> +
> +read_pid_cpu() {
> +  _PID=$1
> +  _CPU=`printf "%d" $2`
> +}
> +
> +read_pid_cpu $IDS
> +
> +: "Test raw output format"
> +echo 1 > options/raw
> +grep -v "^#" trace | grep "^$_PID $_CPU" || do_reset
> +echo 0 > options/raw
> +
> +: "Test hex output format"
> +echo 1 > options/hex
> +PAT=`printf "%08x %08x" $_PID $_CPU`
> +grep -v "^#" trace | grep "^$PAT" || do_reset
> +echo 0 > options/hex
> +
> +: "Test bin output format"
> +echo 1 > options/bin
> +PAT=`printf "%04x [[:xdigit:]]* [[:xdigit:]]*%02x" $_PID $_CPU`
> +# Make a stream of hexdump
> +grep -v "^#" trace | od -h | cut -f 2- -d " " | xargs echo | grep "$PAT" || do_reset
> +echo 0 > options/bin


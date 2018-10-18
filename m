Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC58ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E77F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E77F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJSEhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbeJSEhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:37:13 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068D22145D;
        Thu, 18 Oct 2018 20:34:28 +0000 (UTC)
Date:   Thu, 18 Oct 2018 16:34:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Tom Zanussi <zanussi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] selftests: ftrace: Add synthetic event syntax
 testcase
Message-ID: <20181018163427.6e0f823d@gandalf.local.home>
In-Reply-To: <153986838264.18251.16627517536956299922.stgit@devbox>
References: <153986829702.18251.1286066460999338772.stgit@devbox>
        <153986838264.18251.16627517536956299922.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Masami,

Thanks! I pulled this into my urgent queue and will be running tests on
it over night.

Shuah, can you ack this patch, as I want to add it to this release,
along with the other changes.

Thanks!

-- Steve


On Thu, 18 Oct 2018 22:13:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase to check the syntax and field types for
> synthetic_events interface.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../inter-event/trigger-synthetic-event-syntax.tc  |   80 ++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
> new file mode 100644
> index 000000000000..88e6c3f43006
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
> @@ -0,0 +1,80 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test synthetic_events syntax parser
> +
> +do_reset() {
> +    reset_trigger
> +    echo > set_event
> +    clear_trace
> +}
> +
> +fail() { #msg
> +    do_reset
> +    echo $1
> +    exit_fail
> +}
> +
> +if [ ! -f set_event ]; then
> +    echo "event tracing is not supported"
> +    exit_unsupported
> +fi
> +
> +if [ ! -f synthetic_events ]; then
> +    echo "synthetic event is not supported"
> +    exit_unsupported
> +fi
> +
> +reset_tracer
> +do_reset
> +
> +echo "Test synthetic_events syntax parser"
> +
> +echo > synthetic_events
> +
> +# synthetic event must have a field
> +! echo "myevent" >> synthetic_events
> +echo "myevent u64 var1" >> synthetic_events
> +
> +# synthetic event must be found in synthetic_events
> +grep "myevent[[:space:]]u64 var1" synthetic_events
> +
> +# it is not possible to add same name event
> +! echo "myevent u64 var2" >> synthetic_events
> +
> +# Non-append open will cleanup all events and add new one
> +echo "myevent u64 var2" > synthetic_events
> +
> +# multiple fields with different spaces
> +echo "myevent u64 var1; u64 var2;" > synthetic_events
> +grep "myevent[[:space:]]u64 var1; u64 var2" synthetic_events
> +echo "myevent u64 var1 ; u64 var2 ;" > synthetic_events
> +grep "myevent[[:space:]]u64 var1; u64 var2" synthetic_events
> +echo "myevent u64 var1 ;u64 var2" > synthetic_events
> +grep "myevent[[:space:]]u64 var1; u64 var2" synthetic_events
> +
> +# test field types
> +echo "myevent u32 var" > synthetic_events
> +echo "myevent u16 var" > synthetic_events
> +echo "myevent u8 var" > synthetic_events
> +echo "myevent s64 var" > synthetic_events
> +echo "myevent s32 var" > synthetic_events
> +echo "myevent s16 var" > synthetic_events
> +echo "myevent s8 var" > synthetic_events
> +
> +echo "myevent char var" > synthetic_events
> +echo "myevent int var" > synthetic_events
> +echo "myevent long var" > synthetic_events
> +echo "myevent pid_t var" > synthetic_events
> +
> +echo "myevent unsigned char var" > synthetic_events
> +echo "myevent unsigned int var" > synthetic_events
> +echo "myevent unsigned long var" > synthetic_events
> +grep "myevent[[:space:]]unsigned long var" synthetic_events
> +
> +# test string type
> +echo "myevent char var[10]" > synthetic_events
> +grep "myevent[[:space:]]char\[10\] var" synthetic_events
> +
> +do_reset
> +
> +exit 0


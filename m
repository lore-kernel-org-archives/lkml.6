Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06808C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50B720645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xKw+QRw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50B720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeH3Ltd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeH3Ltd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:49:33 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D957120645;
        Thu, 30 Aug 2018 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535615322;
        bh=CI3/uqa7zBkLDKvlCjQjp063mDskWGsV7T1nq4KPOJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xKw+QRw39jlBDFK0GgaZuVOJVaTWn6v/cCg1wahW/p7X8tI6c51TZJfe/LLpOWY0Y
         Fy9i7SxgE6v63MWnVSTe9Q4zRv3nJQ0QjOdt3jP58ZG+6AW+E+QcVP7SivNgPgeJZf
         j8YRxb8QS8XgPyq0YGPOirkgTo1zF5aKlZamhnMY=
Date:   Thu, 30 Aug 2018 16:48:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/32] selftests/ftrace: Add output format testcase
Message-Id: <20180830164840.35171b39d82d1893cb2a1405@kernel.org>
In-Reply-To: <20180824221926.40cae9f9@vmware.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443782973.23257.16320326555688796000.stgit@devbox>
        <20180824221926.40cae9f9@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 22:19:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:43:49 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a testcase for tracing output format using trace_marker.
> > This tests raw, hex and bin format output.
> 
> I'd like to deprecate these formats. They are useless ever since we
> implemented trace_pipe_raw.
> 
> Let's not add this test.

OK, I'll drop it.
I think this test code itself can reuse for testing trace_pipe_raw too.
(for next time?)

Thank you,

> 
> Thanks,
> 
> -- Steve
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../ftrace/test.d/00basic/print_format.tc          |   51 ++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc b/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
> > new file mode 100644
> > index 000000000000..55feb542e83e
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
> > @@ -0,0 +1,51 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL2.0
> > +# description: Change print trace format
> > +
> > +if [ ! -f trace_marker ]; then
> > +  echo "trace_marker is not supported, can not continue testing"
> > +  exit_unresolved
> > +fi
> > +
> > +do_reset() {
> > +  if [ `cat options/bin` -eq 1 ]; then
> > +    grep -v "^#" trace | od -h | cut -f 2- -d " " | xargs echo
> > +  fi
> > +  echo 0 > options/hex
> > +  echo 0 > options/raw
> > +  echo 0 > options/bin
> > +  cat trace
> > +  exit 1
> > +}
> > +
> > +echo > trace
> > +echo "abcdefgh" > trace_marker
> > +echo 0 > tracing_on
> > +
> > +: "Get the pid and cpu#"
> > +IDS=`grep -v "^#" trace | sed -e 's/[[:space:]]*.*-\([[:digit:]]*\)[[:space:]]*\[\([[:digit:]]*\)\].*/\1 \2/'`
> > +
> > +read_pid_cpu() {
> > +  _PID=$1
> > +  _CPU=`printf "%d" $2`
> > +}
> > +
> > +read_pid_cpu $IDS
> > +
> > +: "Test raw output format"
> > +echo 1 > options/raw
> > +grep -v "^#" trace | grep "^$_PID $_CPU" || do_reset
> > +echo 0 > options/raw
> > +
> > +: "Test hex output format"
> > +echo 1 > options/hex
> > +PAT=`printf "%08x %08x" $_PID $_CPU`
> > +grep -v "^#" trace | grep "^$PAT" || do_reset
> > +echo 0 > options/hex
> > +
> > +: "Test bin output format"
> > +echo 1 > options/bin
> > +PAT=`printf "%04x [[:xdigit:]]* [[:xdigit:]]*%02x" $_PID $_CPU`
> > +# Make a stream of hexdump
> > +grep -v "^#" trace | od -h | cut -f 2- -d " " | xargs echo | grep "$PAT" || do_reset
> > +echo 0 > options/bin
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

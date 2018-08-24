Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3DDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707CF2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707CF2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeHYCzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeHYCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:55:22 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87E620A8B;
        Fri, 24 Aug 2018 23:18:37 +0000 (UTC)
Date:   Fri, 24 Aug 2018 19:18:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/32] selftests/ftrace: Add ringbuffer size changing
 testcase
Message-ID: <20180824191836.305ad740@gandalf.local.home>
In-Reply-To: <153443757416.23257.9284862385646039929.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443757416.23257.9284862385646039929.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:39:34 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase for changing ringbuffer size. This tests
> not only ringbuffer size but also tests the imbalance
> per-cpu buffer size change too.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

I'm fine with this, but one day I need to port over some of my other
tests. I have a test that stresses the ring buffer size (basically
checks to see if it can cause an oom). I need to port that to
selftests. But for now...

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

But, one more thing..

> ---
>  .../ftrace/test.d/00basic/ringbuffer_size.tc       |   21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
> new file mode 100644
> index 000000000000..9224f33b3194
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Change the ringbuffer size

Should add:

 # flags: instance

As this works for instances as well.

-- Steve

> +
> +rb_size_test() {
> +ORIG=`cat buffer_size_kb`
> +
> +expr $ORIG / 2 > buffer_size_kb
> +
> +expr $ORIG \* 2 > buffer_size_kb
> +
> +echo $ORIG > buffer_size_kb
> +}
> +
> +rb_size_test
> +
> +: "If per-cpu buffer is supported, imbalance it"
> +if [ -d per_cpu/cpu0 ]; then
> +  cd per_cpu/cpu0
> +  rb_size_test
> +fi


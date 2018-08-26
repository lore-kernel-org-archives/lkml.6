Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C717C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248FA208E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vv/9eSXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248FA208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeHZPDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 11:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeHZPDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 11:03:13 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C68208E8;
        Sun, 26 Aug 2018 11:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535282456;
        bh=yw/3i9GhjgSLvLnw6vW4t6D+dVgpSgn22fTKn2on7Bg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vv/9eSXggaSzSTnOssNFkzoNBiKItcVHbgOaQFALJMcoNnYsWul3C4uybEyBalzlP
         zoJr9dzIWSCO+5/F/WBiRjBfVXOnjZENPS2+ng81mbFBsrDfbELMHeD9iKp5dQIZP6
         +kKisAjzWirpUMD0bXrdSbo04Q0AhJ4McVAUuO+M=
Date:   Sun, 26 Aug 2018 20:20:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 26/32] selftests/ftrace: Add trace_pipe testcase
Message-Id: <20180826202054.897d7ae94b0a024e2b326c47@kernel.org>
In-Reply-To: <20180824192629.42c8e906@gandalf.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443768729.23257.2645114356784631107.stgit@devbox>
        <20180824192629.42c8e906@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 19:26:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 17 Aug 2018 01:41:27 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a simple testcase for trace_pipe which can consume
> > ringbuffer.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |   15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
> > new file mode 100644
> > index 000000000000..a7dd6fda487a
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
> > @@ -0,0 +1,15 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: trace_pipe and trace_marker
> 
> Should add:
> 
>  # flags: instance

Ah, right!

Thanks!

> 
> -- Steve
> 
> > +
> > +[ ! -f trace_marker ] && exit_unsupported
> > +
> > +echo "test input 1" > trace_marker
> > +
> > +: "trace interface never consume the ring buffer"
> > +grep -q "test input 1" trace
> > +grep -q "test input 1" trace
> > +
> > +: "trace interface never consume the ring buffer"
> > +head -n 1 trace_pipe | grep -q "test input 1"
> > +! grep -q "test input 1" trace
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96360C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C261208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OugJEZpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C261208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeHBJMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeHBJMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:12:50 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5249A208DD;
        Thu,  2 Aug 2018 07:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533194581;
        bh=JLtAUmHOaWx1mzZwsQ5hFj9qh8jWsFTsq8xmUA8aGqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OugJEZpWWZcNOqErsuLsr3cFCmwCwA6s9rPXkBp+CM12+Z7ePQcZ3vwwuZAyq9yvc
         4Qb0n86j00/n2Z3F64ysxfm8RMLZHHIcn3AOAXh31Y9Ffpyx+JhpRS3n9Qx6Ju0YNM
         rILFTiQtC/bXVdKVngZ5cVG+ZKhhhiJGLjcXXshs=
Date:   Thu, 2 Aug 2018 16:22:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/25] selftests/ftrace: Improve kprobe on module
 testcase to load/unload module
Message-Id: <20180802162258.e038d6b1114f6c3c9e2dc238@kernel.org>
In-Reply-To: <20180802100240.a27b72abe375c5817d970a0c@kernel.org>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
        <153269370853.3084.10985190108092225790.stgit@devbox>
        <20180802100240.a27b72abe375c5817d970a0c@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 10:02:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 27 Jul 2018 21:15:08 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > @@ -4,11 +4,18 @@
> >  
> >  [ -f kprobe_events ] || exit_unsupported # this is configurable
> >  
> > +rmmod trace-printk ||:
> > +if ! modprobe trace-printk.ko ; then
> > +  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> > +m"
> > +  exit_unresolved;
> > +fi
> > +
> > +MOD=trace_printk
> > +FUNC=trace_printk_irq_work
> 
> Hmm, this caused a problem with CONFIG_KPROBE_EVENTS_ON_NOTRACE=n.
> However, as far as I can see, the trace_printk_irq_work() is not
> marked as notrace...

Ah, I found this was caused by my prevent probe on notrace patch.
I was a bit too greedy to check out-of-range probes in it.
I'll fix that.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

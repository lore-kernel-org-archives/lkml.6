Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA6DC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A8F20882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eho9tWlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A8F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeGZBzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbeGZBzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:55:21 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E37420846;
        Thu, 26 Jul 2018 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532565669;
        bh=YIntXCC2jObea/TJjPOS+yKumScbe0KBFS57HMShnLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eho9tWlgI2lVd17CF6aIe5b3CmQ6xeCADisAZZPMhWcZ0DbLQS04rdbZpggicbdsU
         +jlte7ce9dvrvMZP5QkSZjyPsgVNe6AfNh0/IE1Nnl2fQRHS+Uw5T/iGBWkaK6Nfc4
         eUUiJhSFCA8RMJuy4brmsio7kcy9Q6IYf3rr7aAk=
Date:   Thu, 26 Jul 2018 09:41:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: kprobes: Prohibit probing on notrace
 functions
Message-Id: <20180726094106.1e8db6e2df788de20e696566@kernel.org>
In-Reply-To: <20180713081803.1b78ebbc@gandalf.local.home>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
        <20180713115301.532ab1484e8b0befd90782d0@kernel.org>
        <20180713081803.1b78ebbc@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 08:18:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 13 Jul 2018 11:53:01 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 12 Jul 2018 13:54:12 -0400
> > Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
> > 
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Prohibit kprobe-events probing on notrace function.
> > > Since probing on the notrace function can cause recursive
> > > event call. In most case those are just skipped, but
> > > in some case it falls into infinite recursive call.  
> > 
> > BTW, I'm considering to add an option to allow putting
> > kprobes on notrace function - just for debugging 
> > ftrace by kprobes. That is "developer only" option
> > so generally it should be disabled, but for debugging
> > the ftrace, we still need it. Or should I introduce
> > another kprobes module for debugging it?
> 
> No, I think the former is better (to add an option to allow putting
> kprobes on notrace functions). By default we let people protect
> themselves. But if then provide a switch that lets you do things that
> might let you shoot yourself in the foot.

I'm adding CONFIG_KPROBE_EVENTS_ON_NOTRACE kconfig which allows
kprobes on notrace function. I think we don't need to make it
online switchable, since it is only good for ftrace developers.

Thank you,

> 
> BTW, I'm now leaving on vacation. I'll be back on the 23rd and will be
> looking for patches that I should be pulling in then.
> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>

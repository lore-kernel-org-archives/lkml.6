Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7302089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0syyzqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7302089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJBO1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeJBO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:27:24 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05505206B2;
        Tue,  2 Oct 2018 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538466329;
        bh=xI3+UCa+FjTb418OOVN7z3015McL3RY8qpPsJs7PevM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o0syyzqISeOdfmICm09PpEANermnDo2F66KcYMej8YP6g0FMS+iQ6tHPdQD1KAxdU
         rulbQNC3C0/KV36oDpDI0XK9rv+mZQs7EwszKfSuZPQOcy6XRf6rUZABmQaSGKF7Xe
         b5BeozFr1W/ZSjvo/vaWFJnggAY0zBcCZ0KBpMXU=
Date:   Tue, 2 Oct 2018 16:45:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/5] tracing: Unifying dynamic event interface
Message-Id: <20181002164526.09f93bffa5d543f3a00e1080@kernel.org>
In-Reply-To: <f360d9c67bb9bc3418fad290399b8f27cb61c80f.camel@linux.intel.com>
References: <153806391326.18458.3927382953014694981.stgit@devbox>
        <f360d9c67bb9bc3418fad290399b8f27cb61c80f.camel@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, 01 Oct 2018 08:49:24 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Masami,
> 
> On Fri, 2018-09-28 at 00:58 +0900, Masami Hiramatsu wrote:
> > Hi,
> > 
> > This is an RFC series of unifying dynamic event interface on ftrace.
> > Currently ftrace has 3 dynamic event interfaces, kprobes, uprobes
> > and synthetic. This series unifies kprobes and uprobes event
> > interface on "dynamic_events". This enables us to add new dynamic
> > events easily on same interface, e.g. function events.
> 
> This seems like a nice idea to me and I don't see any problems with the
> patches themselves, so consider it
> 
> Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks!

> 
> > The older interfaces are left on the tracefs for backward
> > compatibility at this moment.
> > 
> > dynamic_events syntax has no different from kprobe_events and
> > uprobe_events. You can use same syntax for dynamic_events interface.
> > 
> > I think we can integrate synthetic events to this dynamic_events
> > interface but it will requires new syntax. e.g.
> > 
> > echo "s:<event-name> <args>" >> dynamic_events
> > 
> 
> So that's just the existing syntax, prefaced by s: , right?

Yes, just for identifying.

> > If it is OK, I'll add it in next version.
> > 
> 
> Makes sense to me.

OK, I'll try :)

> 
> > BTW, since this dynamic_events interface derived from *probe_events,
> > it inherits "all clear when truncate file open" behavior. But if you
> > think this is too aggressive, I can drop it. (even in that case,
> > kprobe_events/uprobe_events behavior is not changed)
> > 
> > I also introduced a widely used way to erase entries in other
> > interfaces of ftrace, that is '!'. So you can now use '!event-name'
> > or '!group/event' to erase an entry in dynamic_events.
> > (Wait... it has to be '!p:event' as others do??)
> > 
> 
> I'd think the full form should always be accepted, but would only be
> necessary in cases requiring disambiguation.

OK, I'll add full form support.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>

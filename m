Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCDEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C340A20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uspwl2m4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C340A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeKBAFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbeKBAFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:05:20 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C912064C;
        Thu,  1 Nov 2018 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541084520;
        bh=KGl9or9EVnZdYg5a/ggsiGlZuUnpSi830BiYPxcIsgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uspwl2m4rTmykYyyIp8m8TSaL6KB1lapXqzI+K1AbqWbq0KgIt8dLniDu8+/nFknf
         dgNyzWYyWtJKeCSXU29ifX3dhh/Mf5XtJnt/VDlTZ+lgYa5OuVQRzjpXepeht6pDML
         mzUo8p8WjY9y/Z7kdYgnULlpxqnmM7TvjBAKEy8w=
Date:   Fri, 2 Nov 2018 00:01:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kretprobe: produce sane stack traces
Message-Id: <20181102000156.21304d571e756352b36d2bf2@kernel.org>
In-Reply-To: <20181101104948.bc7wk453bfryhhk7@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
        <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
        <20181031090317.4e211fdd@vmware.local.home>
        <20181031133912.3j5tryq2vyhkdn4d@yavin>
        <20181101191347.74eadff4a5d1fab2d79d7efe@kernel.org>
        <20181101104948.bc7wk453bfryhhk7@yavin>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 21:49:48 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> On 2018-11-01, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > Anyway, until that merge happens, this patch looks good to avoid
> > > > > this issue for generic solution (e.g. for the arch which doesn't
> > > > > supports retstack).
> > > > 
> > > > I think its time to come up with an algorithm that makes function graph
> > > > work with multiple users, and have kretprobes be able to hook into it
> > > > just like kprobes hooks into function tracer.
> > > > 
> > > > I have some ideas on how to get this done, and will try to have an RFC
> > > > patch set ready by plumbers.
> > > 
> > > Should I continue working on this patchset?
> > 
> > Yes, until we finally introduce Steven's algorithm on all arch (yeah, we still
> > have some archs which don't support graph-tracer but supports kprobes),
> > I think your patch is the best fix for this issue.
> 
> Thanks, I just sent a v3.
> 
> Though, even with Steven's hooking of kprobes I think you'd still need
> to stash away the stack trace somewhere (or am I misunderstanding the
> proposal?).

Wait, I might miss something. kretprobe and func-graph tracer just swap the
return address on the stack but no change on other stuffs on the stack.
In that case, if we can restore the stack, isn't it enough?

And anyway, even if using func-graph tracer, stack unwinding works correctly.
I thought it means we don't need to backup whole the stack, doesn't it?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

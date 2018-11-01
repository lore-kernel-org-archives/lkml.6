Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A06C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7AC20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTnaAUk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7AC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeKATQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbeKATQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:16:11 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CD92081B;
        Thu,  1 Nov 2018 10:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541067231;
        bh=4f9/JYwKkffXHyozI8uwla/glWKAImJE1/DU/Q3rfIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LTnaAUk3XO8PkjGHPnsRZUSCJTOluYMg5zRBoZMYw1dMaa3EillbsV+q/7iczXNAE
         +AJfIf4R/mAJVYk2R+9iyOnyrfiT4CWn6tgmlsf5A9s+6OIErOY3hdYG7SQ+m7xiN5
         3+696RI5SqM8MwqfEc6En91gnrK2f4AmnaypBOrY=
Date:   Thu, 1 Nov 2018 19:13:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-Id: <20181101191347.74eadff4a5d1fab2d79d7efe@kernel.org>
In-Reply-To: <20181031133912.3j5tryq2vyhkdn4d@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
        <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
        <20181031090317.4e211fdd@vmware.local.home>
        <20181031133912.3j5tryq2vyhkdn4d@yavin>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 00:39:12 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> On 2018-10-31, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > Anyway, until that merge happens, this patch looks good to avoid
> > > this issue for generic solution (e.g. for the arch which doesn't
> > > supports retstack).
> > 
> > I think its time to come up with an algorithm that makes function graph
> > work with multiple users, and have kretprobes be able to hook into it
> > just like kprobes hooks into function tracer.
> > 
> > I have some ideas on how to get this done, and will try to have an RFC
> > patch set ready by plumbers.
> 
> Should I continue working on this patchset?

Yes, until we finally introduce Steven's algorithm on all arch (yeah, we still
have some archs which don't support graph-tracer but supports kprobes),
I think your patch is the best fix for this issue.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

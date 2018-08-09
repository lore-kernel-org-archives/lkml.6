Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8A0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6151821838
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGl4KdQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6151821838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbeHIRWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIRWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:22:08 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3FC214FF;
        Thu,  9 Aug 2018 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826611;
        bh=Q/TZ/W+LhvlsPYWjZoFOzlZrbBkYFNWuGQO5wrk2pVs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uGl4KdQZWLC+9TxjjXkXW2yEJjh4QZmDGOrZ4zEkPdPJhKVKE8uuSr85nDfrQYY2R
         +ERtQisQO0ftgNV1tDOof9HswZHVbS0YAfrBXp9Ub87eBuQgP7NBOZLAq/mnWm703/
         BZp39rDnu1lj+QUOxJlacEW1TYEUF2mqj9tc3QzU=
Message-ID: <1533826609.1918.3.camel@kernel.org>
Subject: Re: [PATCH v3 0/7] tracing: Hist trigger snapshot and onchange
 additions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Thu, 09 Aug 2018 09:56:49 -0500
In-Reply-To: <20180809105516.41b68a83@gandalf.local.home>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
         <20180809104711.7962b340@gandalf.local.home>
         <1533826297.1918.2.camel@kernel.org>
         <20180809105516.41b68a83@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 10:55 -0400, Steven Rostedt wrote:
> On Thu, 09 Aug 2018 09:51:37 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Thu, 2018-08-09 at 10:47 -0400, Steven Rostedt wrote:
> > > On Thu,  9 Aug 2018 09:34:10 -0500
> > > Tom Zanussi <zanussi@kernel.org> wrote:
> > >   
> > > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > 
> > > > Hi,
> > > > 
> > > > This is v3 of the hist trigger snapshot and onchange additions
> > > > patchset.  It's rebased on top of the latest ftrace/core and
> > > > adds a
> > > > few fixes to some handler/action problems I noticed while
> > > > testing.  
> > > 
> > > Hi Tom,
> > > 
> > > How ready is this? I'm still dealing with the fallout of the
> > > preempt
> > > irqs tracepoint updates, and trying to get that stable before
> > > pushing
> > > to linux-next. Are you confident that these are solid enough to
> > > pull
> > > in
> > > this late before the merge window opens? Or should I ignore them
> > > until
> > > the merge window closes and push this for the following release?
> > >   
> > 
> > I wasn't really expecting they'd go into this merge window, so no
> > problem ignoring them until the next release..
> > 
> 
> Great, that makes things easier. Can you ping me after the merge
> window
> closes to remind me to take a look at these? Much appreciated if you
> do :-)
> 

Sure, will do!

Tom


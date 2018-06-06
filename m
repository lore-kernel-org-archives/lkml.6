Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GnseITQ6GFs2dAAAmS7hNA
	; Wed, 06 Jun 2018 19:47:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F35CF60861; Wed,  6 Jun 2018 19:47:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGQ9ZMyg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5AE266074D;
	Wed,  6 Jun 2018 19:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AE266074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeFFTrY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeFFTrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:47:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4A22086E;
        Wed,  6 Jun 2018 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528314442;
        bh=qJ48daom3G5gpPm6ofGI43aAX8QjC/dvpotdTg7pqgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGQ9ZMygLK67xqCgABSy4p7E9mMB01JPzfXNx+owCRBkTt+1OthRHvs22P9vTY2wc
         hoV9hPs7HXDJHgRki3gkmea+Bcq2FKuhkQQSh066QIxRZXmeOyas70uQ+hAT6Af2++
         +8LiHQr8vuJ8/0tZ9o6SeTdA1s0/XUvG/aDXQeYQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C9D4B146911; Wed,  6 Jun 2018 16:47:19 -0300 (-03)
Date: Wed, 6 Jun 2018 16:47:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH V4 1/3] kallsyms: Simplify update_iter_mod()
Message-ID: <20180606194719.GK24381@kernel.org>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
 <1528289651-4113-2-git-send-email-adrian.hunter@intel.com>
 <20180606131302.GB12180@hirez.programming.kicks-ass.net>
 <20180606143727.03da2e26@vmware.local.home>
 <20180606185914.GJ24381@kernel.org>
 <20180606151300.27a3d72e@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606151300.27a3d72e@vmware.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 06, 2018 at 03:13:00PM -0400, Steven Rostedt escreveu:
> On Wed, 6 Jun 2018 15:59:14 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Wed, Jun 06, 2018 at 02:37:27PM -0400, Steven Rostedt escreveu:
> > > On Wed, 6 Jun 2018 15:13:02 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > On Wed, Jun 06, 2018 at 03:54:09PM +0300, Adrian Hunter wrote:  
> > > > > The logic in update_iter_mod() is overcomplicated and gets worse every time
> > > > > another get_ksymbol_* function is added.
> > > > > 
> > > > > In preparation for adding another get_ksymbol_* function, simplify logic in
> > > > > update_iter_mod().
> > > > > 
> > > > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > > > Acked-by: Andi Kleen <ak@linux.intel.com>    
> > > > 
> > > > Both Daniel and Steven touched this function last year, let's also Cc
> > > > them.  
> > > 
> > > Thanks for Ccing me. I tested the patch to make sure my changes still
> > > work and they do:
> > > 
> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> > 
> > Since you said you tested the patch, may I replace the Acked-by with the
> > stronger Tested-by?
> 
> Well, I only tested it against the changes I made earlier. I didn't do
> any other testing, which is why I'm reluctant to say "tested by".
> 
> Perhaps it can be:
> 
> Tested-by: (ftrace changes only) Steven Rostedt (VMware) <rostedt@goodmis.org>

I think that brings more useful information to the log, so should be
useful.

- Arnaldo

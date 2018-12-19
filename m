Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8808A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeLSVDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730418AbeLSVDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:03:21 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62BF42070B;
        Wed, 19 Dec 2018 21:03:19 +0000 (UTC)
Date:   Wed, 19 Dec 2018 16:03:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org, vedang.patel@intel.com,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Message-ID: <20181219160317.71c3e3ff@gandalf.local.home>
In-Reply-To: <426609d1a7c8217187f18011add87ca4fdd54f1e.camel@perches.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <1545250591.4161.2.camel@kernel.org>
        <af216c227fa3ec310d8c4271485dd6c7f829174f.camel@perches.com>
        <20181219153447.3684100d@gandalf.local.home>
        <426609d1a7c8217187f18011add87ca4fdd54f1e.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 12:51:59 -0800
Joe Perches <joe@perches.com> wrote:


> > #define strncmp_prefix(str, prefix) \
> > 	strncmp(str, prefix, strlen(prefix))
> > 
> > in include/linux/string.h
> > 
> > And go around and use that throughout the kernel. By doing a quick
> > grep, I already spotted a few bugs.  
> 
> I hope you also convert the existing uses like
> 
> 	strncmp(str1, "str2", 4)
> 
> where the length value is precalculated to the strlen
> of the const string

Yeah sure.

> 
> But there seem to be _a lot_ of those...
> 
> $ git grep -P "\bstrncmp\s*\([^,]+,[^,]+,\s*\d+\s*\)" | wc -l
> 1681
> 

Right.

I'm going to first create the macro and probably just apply it to the
tracing directory. Then when the macro is added to the next merge
window, I'll post a bunch of patches that clean up the rest of the code.

-- Steve

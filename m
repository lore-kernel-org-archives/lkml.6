Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE721019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3MDpd47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAE721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeK3A54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeK3A5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:57:55 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F9220863;
        Thu, 29 Nov 2018 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543499549;
        bh=Py88rtfBV1eLZDFMCpvDn36g5W2AB9LMi+kdBo3gBlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h3MDpd47so+FQfB/7c+X71PXnw9wluPsMqUhuIEa5VK3Cu/bjJbtWF7pBrBdbUUJG
         KL37F2pQmTThLjLqsOq+TNG/xDv+f36K3jC0dgQOshvZoyZxddOd81bVf8lWqP6eVX
         qz6cDlFgYhUXf+n4CrWWaTDZt3S0mRYy/9RjOJ5w=
Date:   Thu, 29 Nov 2018 22:52:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v7 00/16] tracing: Hist trigger snapshot and onchange
 additions
Message-Id: <20181129225225.00ab1709c79f63c8e08b49c7@kernel.org>
In-Reply-To: <1543267288.2529.25.camel@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
        <20181126230928.17883eecfaefd6a29cbbd1c3@kernel.org>
        <1543267288.2529.25.camel@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 15:21:28 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Mon, 2018-11-26 at 23:09 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Wed, 14 Nov 2018 14:17:57 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > Hi,
> > > 
> > > This is v7 of the hist trigger snapshot and onchange additions
> > > patchset.  It does a bit of refactoring to address the suggestions
> > > made by Masami in v6.
> > 
> > Thank you for fixing it. 
> > 
> > > 
> > > It also adds an additional patch to update the trigger/inter-event
> > > testcases with SPDX license blurbs.
> > > 
> > > BTW, I noticed that with the recent kselftest changes, I now get
> > > mangled output when running the selftests, though I can still see
> > > well
> > > enough that the tests passed as expected.  This happens with any of
> > > the ftrace selftests and not just the trigger selftests.  In my
> > > case,
> > > this is using the stock Terminal in Ubuntu 17.10, in case that
> > > helps.
> > 
> > Hmm, it should be fixed by
> > 8096fbcf55c0 ("selftests/ftrace: Use colored output when available")
> > 
> > Could you check your kernel has this commit?
> > 
> 
> Yes, it does have this commit.
> 
> > BTW, what terminal and environment (especially echo command)
> > did you run your tests on? (It seems echo command didn't accept -e
> > option)
> > 
> 
> For that system, I'm using Gnome terminal 3.24.2 and GNU bash, version
> 4.4.12(1)-release (x86_64-pc-linux-gnu) (Ubuntu 17.10).
> 
> If I change 'echo' to '/bin/echo' in e.g. prlog() it works fine, so it
> must be the inbuilt bash echo that's not doing the right thing.  I
> thought it might be the xpg_echo option, but 'shopt -s xpg_echo'
> doesn't have any effect.
> 
> I also tried on a Fedora 28 system (GNOME terminal 3.28.2, GNU bash,
> version 4.4.23(1)-release (x86_64-redhat-linux-gnu), and it worked
> fine.
> 
> Also, tried a Ubuntu 18.04.1 system (GNOME Terminal 3.28.1, GNU bash,
> version 4.4.19(1)-release (x86_64-pc-linux-gnu) and in that case the
> colors worked fine, but still got the '-e -n' and newlines in the
> output:
> 
> -e -n [28] (instance)  event trigger - test histogram modifiers
> -e 	[PASS]
> -e -n [29] (instance)  event trigger - test histogram trigger
> -e 	[PASS]
> 
> Again, substituting '/bin/echo' in prlog() fixed things in this case
> too.   I guess the builtin bash 'echo' can't be relied on..

OK, then we should use /bin/echo for avoiding this issue.

Thank you!



-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8886FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507ED21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550567240;
	bh=sMSKVV8l7NNhyoKncEMpbp0IQtcuBeEA4/nd5VD74Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Co0Bt3aPwe/wvPyMImONTM1hbFHcA3oE3xtbxxpNpYs7HMr02AxwMxWv5B7XjrDxL
	 dLAUMMlIr5KvogOVKaIWB5y7cAays8Uhbab8QocLtBO3j28TKTcWDO/40/jZivV6F3
	 1kCwd+tllx+yzKqTvLsANNl0D2NMyscurbbiiC5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfBSJHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbfBSJHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:07:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9182D2146F;
        Tue, 19 Feb 2019 09:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550567237;
        bh=sMSKVV8l7NNhyoKncEMpbp0IQtcuBeEA4/nd5VD74Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2b7KO5W0zH5AqZL8nn6L0a9837a2FBlP1SWTEkqjGRChBH+Mb6dFjQampblQrScPg
         NUDAPSwqVyy5YnhWuUr/PaVOz8ba2SfmmeCTwWCLGLpfB5uEG5AGd5vSNzuBEC+JCt
         R/jID5QxHZb2PztXj0S4wksttgkosXBUWFctGbEs=
Date:   Tue, 19 Feb 2019 10:07:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 4.20 11/50] signal: Always notice exiting tasks
Message-ID: <20190219090714.GA27102@kroah.com>
References: <20190213183655.747168774@linuxfoundation.org>
 <20190213183656.733725215@linuxfoundation.org>
 <95a41702-ac6a-cd58-2ca5-71d879ee923c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a41702-ac6a-cd58-2ca5-71d879ee923c@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 07:23:41AM +0100, Jiri Slaby wrote:
> On 13. 02. 19, 19:38, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Eric W. Biederman <ebiederm@xmission.com>
> > 
> > commit 35634ffa1751b6efd8cf75010b509dcb0263e29b upstream.
> > 
> > Recently syzkaller was able to create unkillablle processes by
> > creating a timer that is delivered as a thread local signal on SIGHUP,
> > and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop
> > failing to deliver SIGHUP but always trying.
> > 
> > Upon examination it turns out part of the problem is actually most of
> > the solution.  Since 2.5 signal delivery has found all fatal signals,
> > marked the signal group for death, and queued SIGKILL in every threads
> > thread queue relying on signal->group_exit_code to preserve the
> > information of which was the actual fatal signal.
> > 
> > The conversion of all fatal signals to SIGKILL results in the
> > synchronous signal heuristic in next_signal kicking in and preferring
> > SIGHUP to SIGKILL.  Which is especially problematic as all
> > fatal signals have already been transformed into SIGKILL.
> > 
> > Instead of dequeueing signals and depending upon SIGKILL to
> > be the first signal dequeued, first test if the signal group
> > has already been marked for death.  This guarantees that
> > nothing in the signal queue can prevent a process that needs
> > to exit from exiting.
> > 
> > Cc: stable@vger.kernel.org
> > Tested-by: Dmitry Vyukov <dvyukov@google.com>
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Ref: ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4")
> > History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This patch breaks strace self-tests in 4.20.9. In particular,
> "threads-execve":
> https://github.com/strace/strace/blob/master/tests/threads-execve.c
> https://github.com/strace/strace/blob/master/tests/threads-execve.test
> 
> The test received some fix a day ago, but it did not help in this case:
>  https://github.com/strace/strace/commit/2a50278b9
> 
> Only a revert of the above patch helped.
> 
> I don't know if the strace's test is broken (which is quite usual in
> cases like these) or the patch affects some user-visible behaviour --
> e.g. could this be a reason for sh failures in the build farm?
> 
> Any ideas?

Does cf43a757fd49 ("signal: Restore the stop PTRACE_EVENT_EXIT") help
with this?  It's queued up for the next round of stable releases and is
in Linus's tree.

thanks,

greg k-h

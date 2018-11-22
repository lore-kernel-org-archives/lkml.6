Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA28C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0136620864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0136620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405044AbeKVS0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:26:24 -0500
Received: from mail.hallyn.com ([178.63.66.53]:57188 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbeKVS0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:26:23 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id A25CAB47; Thu, 22 Nov 2018 01:48:07 -0600 (CST)
Date:   Thu, 22 Nov 2018 01:48:07 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian@brauner.io>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181122074807.GB15484@mail.hallyn.com>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119223954.GA4992@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119223954.GA4992@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 03:39:54PM -0700, Tycho Andersen wrote:
> On Mon, Nov 19, 2018 at 11:32:39AM +0100, Christian Brauner wrote:
> >
> > +/**
> > + *  sys_procfd_signal - send a signal to a process through a process file
> > + *                      descriptor
> > + *  @fd: the file descriptor of the process
> > + *  @sig: signal to be sent
> > + *  @info: the signal info
> > + *  @flags: future flags to be passed
> > + */
> > +SYSCALL_DEFINE4(procfd_signal, int, fd, int, sig, siginfo_t __user *, info,
> > +		int, flags)
> > +{
> 
> Can I just register an objection here that I think using a syscall
> just for this is silly?
> 
> My understanding is that the concern is that some code might do:
> 
> unknown_fd = recv_fd();
> ioctl(unknown_fd, SOME_IOCTL, NULL); // where SOME_IOCTL == PROC_FD_KILL
> // whoops, unknown_fd was a procfd and we killed a task!

This could just be my own mental model, but for something like "kill a
task", an ioctl just seems wrong.  Syscall seems more natural.

I'd ack either method.

-serge

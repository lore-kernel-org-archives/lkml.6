Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD7520851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD7520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeKTCN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:13:29 -0500
Received: from foss.arm.com ([217.140.101.70]:60108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbeKTCN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:13:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D77680D;
        Mon, 19 Nov 2018 07:49:30 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EB923F575;
        Mon, 19 Nov 2018 07:49:27 -0800 (PST)
Date:   Mon, 19 Nov 2018 15:49:25 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
Message-ID: <20181119154923.GW3505@e103592.cambridge.arm.com>
References: <20181118111751.6142-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118111751.6142-1-christian@brauner.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 12:17:51PM +0100, Christian Brauner wrote:
> With this patch an open() call on /proc/<pid> will give userspace a handle
> to struct pid of the process associated with /proc/<pid>. This allows to
> maintain a stable handle on a process.
> I have been discussing various approaches extensively during technical
> conferences this year culminating in a long argument with Eric at Linux
> Plumbers. The general consensus was that having a handle on a process
> will be something that is very simple and easy to maintain with the
> option of being extensible via a more advanced api if the need arises. I
> believe that this patch is the most simple, dumb, and therefore
> maintainable solution.
> 
> The need for this has arisen in order to reliably kill a process without
> running into issues of the pid being recycled as has been described in the
> rejected patch [1]. To fulfill the need described in that patchset a new

It would certainly be good to fix this.  IIUC, things like pkill(1) are
a gamble today and can probably kill a process that doesn't fulfil the
match criteria due to PID recycling.  (If not, I'd certainly like to
understand how that is prevented.)

> ioctl() PROC_FD_SIGNAL is added. It can be used to send signals to a
> process via a file descriptor:
> 
> int fd = open("/proc/1234", O_DIRECTORY | O_CLOEXEC);
> ioctl(fd, PROC_FD_SIGNAL, SIGKILL);
> close(fd);
> 
> Note, the stable handle will allow us to carefully extend this feature in
> the future.

A concern here would be that an fd-based shadow API may need to be
created, duplicating the whole PID-based API that already exists.

However, so long as the PID is stabilised against recycling, an ordinary
kill() call seems fine as a way to kill the target process, and no new
API or permission model seems to be needed.


It occurs to me that a mechanism for holding a reference on a third
process already exists: ptrace.

Suppose we were to have something like

	ptrace(PTRACE_MONITOR, pid, 0, 0);

that subscribes the caller for the same set of notifications via wait()
as the process' real parent gets, and prevents PID recycling until the
zombie is consumed be everyone who is subscribed.

Multiple PTRACE_MONITOR attachments could be allowed for a given target,
in addition to the real parent and regular ptrace-parent (if any).


There are a couple of wrinkles:

 * ptrace() operates on tasks, not processes, so the precise semantics
of PTRACE_MONITOR attachment would need a bit of thought.

 * Odd mechanisms for discovering PIDs, like the unix(7) SCM_CREDENTIALS
message might need a special variant to get a PTRACE_MONITOR attachment
along with the message.  This variant behaviour would need to be opt-in
for the recipient.


OTOH, extending ptrace may bring problems of its own :/

Cheers
---Dave

Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD55BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9E9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="vB3Lrbdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfBKXZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:25:31 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:61045 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727246AbfBKXZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:25:31 -0500
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 0E108EA4;
        Mon, 11 Feb 2019 15:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549927530;
        bh=3YxHnywSG8hYulqc+8cuD5JEiuhzTO1v9FN3FWTU4FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=vB3LrbdwmGbX6QZXYUVrEg62OcTcAXjxIy3rUJ4o9NKKLNfyN4CFm0b5jADximnFw
         SsFJsAHub1W3/1fBESnLu8dCOa2H9gEBWtNsKE+g4J/NDGgjuCd7cxfx2kmtH7C/E6
         zx134X1VAYm09bJW5xB9MPVSc2hQNeAaSlSsDJXz2j5xLmOtzZZMVX36dfV+/nPCs3
         Qt3izxNubEkpIHJc1sjga8g8hh7vBRmNp2X9g5nH3b6HrFVsaYALkRhEeZBY7F2ks2
         ARzBjqsii9tzF9HfDXGXdI76/ZTqYhvFjwlz7Jp/A/79nOdn2AkKAldqWFCi/uLaUM
         NQgH0M1CE9UMw==
Received: from visor (unknown [172.20.208.17])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 0012AEA2;
        Mon, 11 Feb 2019 15:25:29 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:25:29 -0800
From:   Ivan Delalande <colona@arista.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending
 fatal signal
Message-ID: <20190211232529.GA28428@visor>
References: <20190205025308.GA24455@visor>
 <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
 <20190206031029.GB9368@visor>
 <87pns2q2ug.fsf@xmission.com>
 <20190209001638.GA14025@visor>
 <87ftsvmv4f.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <87ftsvmv4f.fsf@xmission.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 10, 2019 at 11:05:52AM -0600, Eric W. Biederman wrote:
> Ivan Delalande <colona@arista.com> writes:
> > A difference I've noticed with your tree (unrelated to my issue here but
> > that you may want to look at) is when I run my reproducer under
> > strace -f, I'm now getting quite a lot of "Exit of unknown pid 12345
> > ignored" warnings from strace, which I've never seen with mainline.
> > My reproducer simply fork-exec tail processes in a loop, and tries to
> > sigkill them in the parent with a variable delay.
> 
> What was your base tree?

It was just off v5.0-rc5, and I didn't see these warnings on the last
few RCs either. Now I'm seeing them on vanilla v5.0-rc6 as well.

> My best guess is that your SIGKILL is getting there before strace
> realizes the process has been forked.  If we can understand the race
> it is probably worth fixing.
> 
> Any chance you can post your reproducer.

Sure, see the attachment. I think this is the simplest version where
these warnings show up. This one just forks/exec `tail -a` to make it
fail and exit 1 as soon as possible, and progressively increase the
delay between the fork and sigkill to try to hit our original issue,
stopping and restarting only after 10 completions of the child as the
timing varies a fair bit.

Running this program under `strace -f -o /dev/null` prints the warnings
almost instantly on my system.

> It is possible it is my most recent fixes, or it is possible something
> changed from the tree you were testing and the tree you are working
> on.

Thanks,

-- 
Ivan Delalande
Arista Networks

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="forksigkilltest.c"

#define _GNU_SOURCE
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>
#include <stdio.h>

int main(void)
{
	pid_t pid;
	int status;
	size_t i, count;
	unsigned long max = 300000, first;
	struct timespec ts = { .tv_nsec = 1 };
	char* const argv[] = {"/bin/tail", "-a", NULL};

	for (i = 0; i < 42000; ++i) {
		for (count = first = 0, ts.tv_nsec = 1;
		     ts.tv_nsec < max && count < 10;
		     ts.tv_nsec += 1) {
			if ((pid = fork())) {
				if (pid < 0)
					continue;
				nanosleep(&ts, NULL);
				kill(pid, SIGKILL);
				if (waitpid(pid, &status, 0) != pid)
					continue;
				if (WIFSIGNALED(status) &&
				    WTERMSIG(status) == 9) {
					continue;
				} else if (WIFEXITED(status) &&
					   WEXITSTATUS(status) == 1) {
					count++;
					if (!first)
						first = ts.tv_nsec;
				} else
					printf("%lu: %x\n", ts.tv_nsec, status);
			} else {
				close(STDOUT_FILENO);
				close(STDERR_FILENO);
				execve("/bin/tail", argv, NULL);
				_exit(2);
			}
		}
		if (max < ts.tv_nsec)
			max = ts.tv_nsec;
		if (count < 10)
			max += 5000;
		printf("break at %lu (max: %lu) count %lu (first at %lu)\n",
		       ts.tv_nsec, max, count, first);
	}

	return 0;
}

--2fHTh5uZTiUOsy+g--

Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22AC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD2220844
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfBJRGT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:06:19 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:56908 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJRGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:06:19 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gssYb-00070c-E0; Sun, 10 Feb 2019 10:06:17 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gssYR-0007Ef-4z; Sun, 10 Feb 2019 10:06:17 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ivan Delalande <colona@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
References: <20190205025308.GA24455@visor>
        <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
        <20190206031029.GB9368@visor> <87pns2q2ug.fsf@xmission.com>
        <20190209001638.GA14025@visor>
Date:   Sun, 10 Feb 2019 11:05:52 -0600
In-Reply-To: <20190209001638.GA14025@visor> (Ivan Delalande's message of "Fri,
        8 Feb 2019 16:16:38 -0800")
Message-ID: <87ftsvmv4f.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1gssYR-0007Ef-4z;;;mid=<87ftsvmv4f.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19NJYnYnwLROvcJ+QQJmt92auStM1N1DCo=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] exec: don't force_sigsegv processes with a pending fatal signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Delalande <colona@arista.com> writes:

> Hi Eric,
>
> On Thu, Feb 07, 2019 at 11:13:59PM -0600, Eric W. Biederman wrote:
>> I just noticed this.  From  my patch queue that I intend to send to
>> Linus tomorrow. I think this change fixes your issue of getting
>> the SIGSEGV instead of the already pending fatal signal.
>> 
>> So I think this fixes your issue without any other code changes.
>> Ivan can you verify that the patch below is enough?
>
> I was having issues with just this patch applied on top of v5.0-rc5 or
> the latest master: defunct processes accumulating, exiting processes
> that would hang forever, and some kernel functions eating all the CPU
> (setup_sigcontext, common_interrupt, __clear_user, do_signal…).
>
> But using your user-namespace.git/for-linus worked great and I've been
> running my reproducer for a few hours now without issue. I'll probably
> keep it running over the week-end as it has been unreliable at times,
> but it looks promising so far.

Sounds.  Thank you for finding my tree, and thank you for testing.

> A difference I've noticed with your tree (unrelated to my issue here but
> that you may want to look at) is when I run my reproducer under
> strace -f, I'm now getting quite a lot of "Exit of unknown pid 12345
> ignored" warnings from strace, which I've never seen with mainline.
> My reproducer simply fork-exec tail processes in a loop, and tries to
> sigkill them in the parent with a variable delay.

What was your base tree?

My best guess is that your SIGKILL is getting there before strace
realizes the process has been forked.  If we can understand the race
it is probably worth fixing.

Any chance you can post your reproducer.

It is possible it is my most recent fixes, or it is possible something
changed from the tree you were testing and the tree you are working
on.

Eric

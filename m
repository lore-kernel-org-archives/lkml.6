Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9DCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6703D20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBHFON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:14:13 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44628 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBHFOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:14:12 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gryUM-0004CL-RT; Thu, 07 Feb 2019 22:14:10 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gryUL-0003mu-3G; Thu, 07 Feb 2019 22:14:10 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ivan Delalande <colona@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
References: <20190205025308.GA24455@visor>
        <20190205131119.3e388a0a1a69c0a041ed87ef@linux-foundation.org>
        <20190206031029.GB9368@visor>
Date:   Thu, 07 Feb 2019 23:13:59 -0600
In-Reply-To: <20190206031029.GB9368@visor> (Ivan Delalande's message of "Tue,
        5 Feb 2019 19:10:29 -0800")
Message-ID: <87pns2q2ug.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gryUL-0003mu-3G;;;mid=<87pns2q2ug.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/gKch5gprulFjcTtJ4s0vO7tHFCT1bvNo=
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

> On Tue, Feb 05, 2019 at 01:11:19PM -0800, Andrew Morton wrote:
>> On Mon, 4 Feb 2019 18:53:08 -0800 Ivan Delalande <colona@arista.com> wrote:
>> > --- a/fs/exec.c
>> > +++ b/fs/exec.c
>> > @@ -1660,7 +1660,12 @@ int search_binary_handler(struct linux_binprm *bprm)
>> >  		if (retval < 0 && !bprm->mm) {
>> >  			/* we got to flush_old_exec() and failed after it */
>> >  			read_unlock(&binfmt_lock);
>> > -			force_sigsegv(SIGSEGV, current);
>> > +			if (!fatal_signal_pending(current)) {
>> > +				if (print_fatal_signals)
>> > +					pr_info("load_binary() failed: %d\n",
>> > +						retval);
>> 
>> Should we be using print_fatal_signal() here?
>
> I don't think so, the force_sigsegv() already ensures it will be called
> from get_signal() when the signal is handled, and so the process
> information will be printed then.
>
>> > +				force_sigsegv(SIGSEGV, current);
>> > +			}
>> >  			return retval;
>> >  		}
>> >  		if (retval != -ENOEXEC || !bprm->file) {
>


I just noticed this.  From  my patch queue that I intend to send to
Linus tomorrow. I think this change fixes your issue of getting
the SIGSEGV instead of the already pending fatal signal.

So I think this fixes your issue without any other code changes.
Ivan can you verify that the patch below is enough?


diff --git a/kernel/signal.c b/kernel/signal.c
index 9ca8e5278c8e..5424cb0006bc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
                goto relock;
        }
 
+       /* Has this task already been marked for death? */
+       ksig->info.si_signo = signr = SIGKILL;
+       if (signal_group_exit(signal))
+               goto fatal;
+
        for (;;) {
                struct k_sigaction *ka;
 
@@ -2488,6 +2493,7 @@ bool get_signal(struct ksignal *ksig)
                        continue;
                }
 
+       fatal:
                spin_unlock_irq(&sighand->siglock);
 
   

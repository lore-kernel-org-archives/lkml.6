Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A167C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDB02147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDB02147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGLRW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:22:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37361 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeGLRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:22:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdf8J-0006ah-VZ; Thu, 12 Jul 2018 11:12:00 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fdf8J-0000zl-3r; Thu, 12 Jul 2018 11:11:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-11-ebiederm@xmission.com>
        <20180711141456.GA6636@redhat.com> <87h8l5g3qi.fsf@xmission.com>
        <20180712134220.GA15075@redhat.com>
Date:   Thu, 12 Jul 2018 12:11:53 -0500
In-Reply-To: <20180712134220.GA15075@redhat.com> (Oleg Nesterov's message of
        "Thu, 12 Jul 2018 15:42:20 +0200")
Message-ID: <87601k5qg6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fdf8J-0000zl-3r;;;mid=<87601k5qg6.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18SWne0Jm3Irz6jwHDkRo6fABgbFE6uHO8=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 11/11] signal: Ignore all but multi-process signals that come in during fork.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/11, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> >> -	recalc_sigpending();
>> >> -	if (signal_pending(current)) {
>> >> +	if (read_seqcount_retry(&current->signal->multi_process_seq, seq) ||
>> >> +	    fatal_signal_pending(current)) {
>> >>  		retval = -ERESTARTNOINTR;
>> >>  		goto bad_fork_cancel_cgroup;
>> >
>> > So once again, I think this is not right, see the discussion on
>> > bugzilla.
>>
>> I am trying to dig through and understand your concerns.  I am having
>> difficulty understanding your concerns.
>>
>> Do the previous patches look good to you?
>
> Yes, yes, personally I like 1-10 after a quick glance. I'll try to read this
> series carefully later, but I don't think I will find something really
> wrong.

Good.  Then I will consider those acked by both you and Linus.

Oleg do you mind if I add:
Acked-by: Oleg Nesterov <oleg@redhat.com>

To those patches?

>> If I understand you correctly.  Your concern is that since we added the:
>>
>> 	recalc_sigpending();
>>         if (signal_pending(current))
>>         	return -ERESTARTNOINTR;
>>
>> Other (non-signal) code such as the freezer has come to depend upon that
>> test.  Changing the test in the proposed way will allow the new child to
>> escape the freezer, as it is not guaranteed the new child will be
>> frozen.
>
> Yes.


>> It seems reasonable to look at other things that set TIF_SIGPENDING and
>> see if any of them are broken by the fork changes.
>
> Again, please look at do_signal_stop(). If it was the source of signal_pending(),
> copy_process() should fail. Or we should update the new thread to participate in
> group-stop, but then we need to set TIF_SIGPENDING, copy the relevant part of
> current->jobctl, and increment ->group_stop_count at least.

Hmm.  That is an interesting twist.

In general for do_signal_stop is fine as long as we have the
recalc_sigpending at the start of fork.

But yes.  What happens when it isn't a fork but it is a clone.  Signals
that affect the entire thread group (STOP CLONE) are very interesting
from this perspective.

Same issue as with fork, but different scope.

Eric

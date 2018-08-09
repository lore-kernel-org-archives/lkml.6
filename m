Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6590FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E7221EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E7221EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbeHIUJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:09:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45117 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732583AbeHIUJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:09:05 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnoxp-0001Qe-T2; Thu, 09 Aug 2018 11:43:09 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnoxZ-0002BD-SU; Thu, 09 Aug 2018 11:43:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <87wot0yqsx.fsf_-_@xmission.com>
        <20180809065605.32345-6-ebiederm@xmission.com>
        <CA+55aFyuJHWW__t_Pq+AqVhiGOVnbd7wKKdX8AH8YUzfzb0=YA@mail.gmail.com>
Date:   Thu, 09 Aug 2018 12:42:40 -0500
In-Reply-To: <CA+55aFyuJHWW__t_Pq+AqVhiGOVnbd7wKKdX8AH8YUzfzb0=YA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 9 Aug 2018 10:15:43 -0700")
Message-ID: <87600jwi5r.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fnoxZ-0002BD-SU;;;mid=<87600jwi5r.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18eG5FXrfgFVql3gnVlREci6Zo43KZiKFs=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v5 6/6] signal: Don't restart fork when signals come in.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Aug 8, 2018 at 11:57 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The code was being overly pesimistic.
>
> Pessimistic.

>> +       if (type > PIDTYPE_TGID) {
>> +               struct multiprocess_signals *delayed;
>> +               hlist_for_each_entry(delayed, &t->signal->multiprocess, node) {
>> +                       sigset_t *signal = &delayed->signal;
>> +                       /* Can't queue both a stop and a continue signal */
>> +                       if (sig == SIGCONT) {
>> +                               sigset_t flush;
>> +                               siginitset(&flush, SIG_KERNEL_STOP_MASK);
>> +                               sigandnsets(signal, signal, &flush);
>
> This looks odd and unnecessary.
>
> Why isn't this just a
>
>         sigdelsetmask(signal, SIG_KERNEL_STOP_MASK);
>
> since all of the traditional stop bits should be in the low mask.
>
> I see that we apparently have this stupid pattern elsewhere too, and
> it looks like it's because we stupidly say "are the RT signals in the
> non-legacy set", when that definitely cannot be the case for the (very
> much legacy) tty flow control signals.

I just missed the existence of sigdelsetmask when I was putting this
together.

I will fix that and unless someone sees an issue I will queue this up
for linux-next.

Eric

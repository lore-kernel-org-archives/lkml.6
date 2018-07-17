Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CBCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEDE208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEDE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeGQCTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:19:09 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:34699 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeGQCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:19:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ffF6s-0004Qv-3T; Mon, 16 Jul 2018 19:49:02 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ffF6q-0000Yo-NX; Mon, 16 Jul 2018 19:49:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-9-ebiederm@xmission.com>
        <20180716145540.GA20960@redhat.com> <87lgabrzfd.fsf@xmission.com>
        <CA+55aFxNMPgg3Y7m8hCjtaFVERPL6LaXPKcbBmz-6C=8_FMpKg@mail.gmail.com>
        <87pnznkn1u.fsf@xmission.com>
        <CA+55aFy2A=UeDoJNBr9WE=E_h7dfq+_4TzRgF2dPYSbEXRNZzA@mail.gmail.com>
Date:   Mon, 16 Jul 2018 20:48:55 -0500
In-Reply-To: <CA+55aFy2A=UeDoJNBr9WE=E_h7dfq+_4TzRgF2dPYSbEXRNZzA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 16 Jul 2018 12:36:37 -0700")
Message-ID: <87h8kylji0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ffF6q-0000Yo-NX;;;mid=<87h8kylji0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HWfbr2BuURADE/Qts3i8HfzOelH23i/I=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK to forcibly kill tasks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jul 16, 2018 at 12:17 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I should have said it doesn't matter because init does not open ttys and
>> become a member of session groups.  Or at least it never has in my
>> experience.  The only way I know to get that behavior is to boot with
>> init=/bin/bash.
>
> That's hopefully true, yes.
>
> Presumably init does open the console, but hopefull doesn't do setsid.
>
> (We *do* do "setsid()" for the linuxrc running, but that's not done by
> the init thread itself).
>
>> With the force_sig already in do_SAK today my change is not a
>> regression.  As force_sig in a completely different way forces the
>> signal to init.
>
> Ok. A couple of notes in the commit description on this might be good.

Definitely.

>> So I think we want the patch below to clean that up.  Then we don't have
>> to worry about the wrong things sending signals to init by accident, and
>> SEND_SIG_FORCED becomes just SEND_SIG_PRIV that skips the unnecesary
>> allocation of a siginfo struct.
>>
>> Thoughts?
>
> I think the end result is fine, but then I look at that patch of yours
> and it does many other things and that makes me nervous.
>
> Can you separate out the different things it does into separate
> patches to make it easier to read?

I will take a look.

Eric

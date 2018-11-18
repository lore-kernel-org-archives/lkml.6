Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69956C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2856D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNxIJ0ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2856D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeKSCyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:54:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKSCyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U8eIa1z1+dT1TtrG9VGPf0BEtG1aN+76TqLDjy2k6Ok=; b=VNxIJ0obTFAzVkha/Mu5BtC3mS
        b/hzsF7oJpf5IcNhyuS6fFGRVWFzwEJj92CMSMpcWu1HVwgEuMMqXfj0XJ3l2r//2GT8Vwlw4n0ED
        fPbBJvzoxYim87ol7UdccVxS2l76yUQvphxefrq67ha+j6gx7WoUn4HbPoTA4fpoi53KbR0x+Eyl4
        srgP2FKhKLmV0Om23z9RL4QvCNMmHi57Q6ao72JaqRKzGQhM8DBtjPpuPzZG3Zvhkmo4p5yzpZFYk
        4RtlZ07H9XzGz+mmkV9uwBqnht5VK7yUeiAHnYwBupwzxrGS5CklmJqfvmuAILzntbatZuJGj4OGd
        UGYSsmbQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOQ1F-0000tb-W8; Sun, 18 Nov 2018 16:33:58 +0000
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@kernel.org>,
        Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
References: <20181118111751.6142-1-christian@brauner.io>
 <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
Date:   Sun, 18 Nov 2018 08:33:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/18 8:17 AM, Andy Lutomirski wrote:
> On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>>
>> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>> I fully agree that a more comprehensive, less expensive API for
>>> managing processes would be nice.  But I also think that this patch
>>> (using the directory fd and ioctl) is better from a security
>>> perspective than using a new file in /proc.
>>
>> That's an assertion, not an argument. And I'm not opposed to an
>> operation on the directory FD, now that it's clear Linus has banned
>> "write(2)-as-a-command" APIs. I just insist that we implement the API
>> with a system call instead of a less-reliable ioctl due to the
>> inherent namespace collision issues in ioctl command names.
> 
> Linus banned it because of bugs iike the ones in the patch.
> 
>>
>>> I have an old patch to make proc directory fds pollable:
>>>
>>> https://lore.kernel.org/patchwork/patch/345098/
>>>
>>> That patch plus the one in this thread might make a nice addition to
>>> the kernel even if we expect something much better to come along
>>> later.
>>
>> I've always commented on that patch. You never addressed my technical
>> objections. Why are you bringing up this patch again as if that
>> discussion had never happened? To review, that patch has various race
>> conditions
> 
> I don't think I ever saw that review.
> 
>> and even if it were technically correct, it'd be an abuse
>> of directory objects (in what other circumstance do we poll
>> directories?) and not logically generalizable to a model in which we
>> expose process exit status via the exit-monitoring API.
> 
> I agree it's weird.  It might be better to have /proc/PID/exit_status
> and make *that* pollable.
> 

If there is a new exit_status file, it could even be more than
8 bits of exit status:

See https://lore.kernel.org/lkml/alpine.LSU.2.20.1507091257010.9602@nerf40.vanv.qr/T/#u
and http://austingroupbugs.net/view.php?id=594#c1317

-- 
~Randy

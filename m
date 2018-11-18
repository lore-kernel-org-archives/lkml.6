Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C48C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF3620817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF3620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKSEEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:04:15 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55502 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeKSEEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:04:15 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gOR6O-0001mA-1v; Sun, 18 Nov 2018 10:43:20 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gOR6N-0007LV-BZ; Sun, 18 Nov 2018 10:43:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
References: <20181118111751.6142-1-christian@brauner.io>
        <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
        <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
        <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
        <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
        <CAKOZuetuuxW+yFnyaqS5kW6gkVMstLa8D-7SgYtrLBUQB+sgDg@mail.gmail.com>
        <CALCETrXNBNcASRtxTL_aO-KSj4ahPRpXKLUdHaWG3sPjsWx3CQ@mail.gmail.com>
        <CAKOZues3_uh1mnQr=VPCxoWiY0wfiUq0oFXcVuiHF7rPmUXsuw@mail.gmail.com>
Date:   Sun, 18 Nov 2018 11:43:14 -0600
In-Reply-To: <CAKOZues3_uh1mnQr=VPCxoWiY0wfiUq0oFXcVuiHF7rPmUXsuw@mail.gmail.com>
        (Daniel Colascione's message of "Sun, 18 Nov 2018 09:17:31 -0800")
Message-ID: <875zwu46z1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gOR6N-0007LV-BZ;;;mid=<875zwu46z1.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JBW/uB6HpGNYgmgf8rS/fZZSm5h4pRc4=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Colascione <dancol@google.com> writes:

> On Sun, Nov 18, 2018 at 9:13 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> On Sun, Nov 18, 2018 at 8:29 AM Daniel Colascione <dancol@google.com> wrote:
>>>
>>> On Sun, Nov 18, 2018 at 8:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>> > On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>>> >>
>>> >> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>> >> > I fully agree that a more comprehensive, less expensive API for
>>> >> > managing processes would be nice.  But I also think that this patch
>>> >> > (using the directory fd and ioctl) is better from a security
>>> >> > perspective than using a new file in /proc.
>>> >>
>>> >> That's an assertion, not an argument. And I'm not opposed to an
>>> >> operation on the directory FD, now that it's clear Linus has banned
>>> >> "write(2)-as-a-command" APIs. I just insist that we implement the API
>>> >> with a system call instead of a less-reliable ioctl due to the
>>> >> inherent namespace collision issues in ioctl command names.
>>> >
>>> > Linus banned it because of bugs iike the ones in the patch.
>>>
>>> Maybe: he didn't provide a reason. What's your point?
>>
>> My point is that an API that involves a file like /proc/PID/kill is
>> very tricky to get right.  Here are some considerations:
>
> Moot. write(2) for this interface is off the table anyway. The right
> approach here is a system call that accepts a /proc/pid directory file
> descriptor, a signal number, and a signal information field (as in
> sigqueue(2)).

If we did not have the permission check challenges and could perform
the permission checks in open, write(2) would be on the table.
Performing write(2) would only be concrend about data.

Unfortunately we have setresuid and exec which make that infeasible
for the kill operations.

>> Now if we had an ioctlat() API, maybe it would make sense.  But we
>> don't, and I think it would be a bit crazy to add one.
>
> A process is not a driver. Why won't this idea of using an ioctl for
> the kill-process-by-dfd thing just won't die? An ioctl has *zero*
> advantage in this context.

An ioctl has an advantage in implementation complexity.  An ioctl is
very much easier to wire up that a system call.

I don't know if that outweighs ioctls disadvantages in long term
maintainability.

Eric


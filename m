Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA5BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE36208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE36208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeLFNkl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:40:41 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36943 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeLFNkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:40:41 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUttM-0003cR-Rr; Thu, 06 Dec 2018 06:40:36 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gUttL-0006xA-T7; Thu, 06 Dec 2018 06:40:36 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Florian Weimer <fweimer@redhat.com>
Cc:     =?utf-8?Q?J=C3=BCrg?= Billeter <j@bitron.ch>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org
References: <20181206121858.12215-1-christian@brauner.io>
        <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
        <b0e946bcac12358841c9a99017da819b00794d9c.camel@bitron.ch>
        <87pnue6bp2.fsf@oldenburg2.str.redhat.com>
Date:   Thu, 06 Dec 2018 07:40:24 -0600
In-Reply-To: <87pnue6bp2.fsf@oldenburg2.str.redhat.com> (Florian Weimer's
        message of "Thu, 06 Dec 2018 14:12:41 +0100")
Message-ID: <87efaun587.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1gUttL-0006xA-T7;;;mid=<87efaun587.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JWiG7bCObOLUQ1daii82zk4vRUkuzT3I=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fweimer@redhat.com> writes:

> * Jürg Billeter:
>
>> On Thu, 2018-12-06 at 13:30 +0100, Florian Weimer wrote:
>>> * Christian Brauner:
>>> 
>>> > /* zombies */
>>> > Zombies can be signaled just as any other process. No special error will be
>>> > reported since a zombie state is an unreliable state (cf. [3]).
>>> 
>>> I still disagree with this analysis.  If I know that the target process
>>> is still alive, and it is not, this is a persistent error condition
>>> which can be reliably reported.  Given that someone might send SIGKILL
>>> to the process behind my back, detecting this error condition could be
>>> useful.
>>
>> As I understand it, kill() behaves the same way. I think it's good that
>> this new syscall keeps the behavior as close as possible to kill().
>
> No, kill does not behave in this way because the PID can be reused.
> The error condition is not stable there.

I am not quite certain what is being discussed here.

Posix says:
    [ESRCH]
        No process or process group can be found corresponding to that specified by pid.

The linux man page says:
       ESRCH  The process or process group does not exist.  Note that an
              existing process might be a zombie, a process that has terminated
              execution, but has not yet been wait(2)ed for.

What happens with this new system call is exactly the linux behavior.
Success is returned until the specified process or thread group has
been waited for.

The only difference from the behavior of kill is that because the
association between the file descriptor and the pid is not affected by
pid reuse once ESRCH is returned ESRCH will always be returned.

Floriam are you seeing a problem with this behavior or the way Christian
was describing it?

Eric

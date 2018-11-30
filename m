Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05D42146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 05:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05D42146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeK3QWJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:22:09 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44153 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeK3QWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 11:22:09 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gSb7q-0008Hq-OC; Thu, 29 Nov 2018 22:14:02 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gSb7p-0005dP-Ss; Thu, 29 Nov 2018 22:14:02 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, christian@brauner.io,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20181120105124.14733-1-christian@brauner.io>
        <87in0g5aqo.fsf@oldenburg.str.redhat.com>
        <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
        <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
        <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
        <20181129195551.woe2bl3z3yaysqb6@brauner.io>
        <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
        <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 23:13:57 -0600
In-Reply-To: <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 29 Nov 2018 22:02:13 +0100")
Message-ID: <87y39b2lm2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1gSb7p-0005dP-Ss;;;mid=<87y39b2lm2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+mMyLYLK4Aao5mgpRBDubB9Qyld7uZuk0=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, Nov 29, 2018 at 9:14 PM Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Nov 29, 2018, at 11:55 AM, Christian Brauner <christian@brauner.io> wrote:
>> >> On Thu, Nov 29, 2018 at 11:22:58AM -0800, Andy Lutomirski wrote:
>> >>> On Thu, Nov 29, 2018 at 11:17 AM Christian Brauner <christian@brauner.io> wrote:
>> >>>> On November 30, 2018 5:54:18 AM GMT+13:00, Andy Lutomirski <luto@amacapital.net> wrote:
>> >>
>> >> The #1 fix would add a copy_siginfo_from_user64() or similar.
>> >
>> > Thanks very much! That all helped a bunch already! I'll try to go the
>> > copy_siginfo_from_user64() way first and see if I can make this work. If
>> > we do this I would however only want to use it for the new syscall first
>> > and not change all other signal syscalls over to it too. I'd rather keep
>> > this patchset focussed and small and do such conversions caused by the
>> > new approach later. Does that sound reasonable?
>>
>> Absolutely. I don’t think we can change old syscalls — the ABI is set in stone.
>> But for new syscalls, I think the always-64-bit behavior makes sense.
>
> It looks like we already have a 'struct signalfd_siginfo' that is defined in a
> sane architecture-independent way, so I'd suggest we use that.

Unfortunately it isn't maintained very well.  What you can
express with signalfd_siginfo is a subset what you can express with
siginfo.  Many of the linux extensions to siginfo for exception
information add pointers and have integers right after those pointers.
Not all of those linux specific extentions for exceptions are handled
by signalfd_siginfo (it needs new fields).

As originally defined siginfo had the sigval_t union at the end so it
was perfectly fine on both 32bit and 64bit as it only had a single
pointer in the structure and the other fields were 32bits in size.

Although I do feel the pain as x86_64 has to deal with 3 versions
of siginfo.  A 64bit one.  A 32bit one for ia32.  A 32bit one for x32
with a 64bit si_clock_t.

> We may then also want to make sure that any system call that takes a
> siginfo has a replacement that takes a signalfd_siginfo, and that this
> replacement can be used to implement the old version purely in
> user space.

If you are not implementing CRIU and reinserting exceptions to yourself.
At most user space wants the ability to implement sigqueue:

AKA:
sigqueue(pid_t pid, int sig, const union sigval value);

Well sigqueue with it's own si_codes so the following would cover all
the use cases I know of:
int sendnewsig(pid_t pid, int sig, int si_code, const union sigval value);

The si_code could even be set to SI_USER to request that the normal
trusted SI_USER values be filled in.  si_code values of < 0 if not
recognized could reasonably safely be treated as the _rt member of
the siginfo union.  Or perhaps better we error out in such a case.

If we want to be flexible and not have N kinds of system calls that
is the direction I would go.  That is simple, and you don't need any of
the rest.


Alternatively we abandon the mistake of sigqueueinfo and not allow
a signal number in the arguments that differs from the si_signo in the
siginfo and allow passing the entire thing unchanged from sender to
receiver.  That is maximum flexibility.

signalfd_siginfo just sucks in practice.  It is larger that siginfo 104
bytes versus 48.  We must deliver it to userspace as a siginfo so it
must be translated.  Because of the translation signalfd_siginfo adds
no flexiblity in practice, because it can not just be passed through.
Finallay signalfd_siginfo does not have encodings for all of the
siginfo union members, so it fails to be fully general.

Personally if I was to define signalfd_siginfo today I would make it:
struct siginfo_subset {
	__u32 sis_signo;
	__s32 sis_errno;
	__s32 sis_code;
        __u32 sis_pad;
	__u32 sis_pid;
	__u32 sis_uid;
	__u64 sis_data (A pointer or integer data field);
};

That is just 32bytes, and is all that is needed for everything
except for synchronous exceptions.  Oh and that happens to be a proper
subset of a any sane siginfo layout, on both 32bit and 64bit.

This is one of those rare times where POSIX is sane and what linux
has implemented is not.

Eric

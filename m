Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161048AbeBNRUP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:20:15 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:55379 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033287AbeBNRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:20:13 -0500
X-Google-Smtp-Source: AH8x227rrP5u6/keE+YDl7y/FbPv7CZRsW7kVM49PTTwXW53lNtLHt33WKSDVmbQUAnQf85dgmMcI5oyVK8Hlg+T/QM=
MIME-Version: 1.0
In-Reply-To: <20180214152958.cjgwh2k52zji2jxk@cisco>
References: <20180204104946.25559-1-tycho@tycho.ws> <20180204104946.25559-2-tycho@tycho.ws>
 <CAGXu5jLAAKY19a9iC1PmXRyuwdn1Zxr2Cb318zdzkqgYt8vtdg@mail.gmail.com> <20180214152958.cjgwh2k52zji2jxk@cisco>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 Feb 2018 17:19:52 +0000
Message-ID: <CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com>
Subject: Re: [RFC 1/3] seccomp: add a return code to trap to userspace
To: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Sargun Dhillon <sargun@sargun.me>, Paul Moore <pmoore@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 3:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> Hey Kees,
>
> Thanks for taking a look!
>
> On Tue, Feb 13, 2018 at 01:09:20PM -0800, Kees Cook wrote:
>> On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>> > This patch introduces a means for syscalls matched in seccomp to notify
>> > some other task that a particular filter has been triggered.
>> >
>> > The motivation for this is primarily for use with containers. For example,
>> > if a container does an init_module(), we obviously don't want to load this
>> > untrusted code, which may be compiled for the wrong version of the kernel
>> > anyway. Instead, we could parse the module image, figure out which module
>> > the container is trying to load and load it on the host.
>> >
>> > As another example, containers cannot mknod(), since this checks
>> > capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
>> > /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
>> > coding some whitelist in the kernel. Another example is mount(), which has
>> > many security restrictions for good reason, but configuration or runtime
>> > knowledge could potentially be used to relax these restrictions.
>>
>> Related to the eBPF seccomp thread, can the logic for these things be
>> handled entirely by eBPF? My assumption is that you still need to stop
>> the process to do something (i.e. do a mknod, or a mount) before
>> letting it continue. Is there some "wait for notification" system in
>> eBPF?
>
> I replied in the other thread
> (https://patchwork.ozlabs.org/cover/872938/#1856642 for those
> following along at home), but no, at least not that I know of.

eBPF can call functions.  One of those functions could put the caller
to sleep.  In fact, I think I once proposed doing this for the seccomp
logging action as well.

>> I wonder if this communication should be netlink, which gives a more
>> well-structured way to describe what's on the wire? The reason I ask
>> is because if we ever change the seccomp_data structure, we'll now
>> have two places where we need to deal with it (the first being within
>> the BPF itself). My initial idea was to prefix the communication with
>> a size field, then send the structure, and then I had nightmares, and
>> realized this was basically netlink reinvented.
>
> I suggested netlink in LA, and everyone (especially Andy) groaned very
> loudly :). I'm happy to switch it to netlink if you like, although i
> think memcpy() of structs should be safe here, since the return value
> from read or write can indicate the size of things.

I could easily get on board with "netlink" (i.e. NLA) messages sent
over an fd.  I will object strongly to the use of netlink *sockets*.

>
>> An ERRNO filter would block a USER_NOTIF because it's unconditional.
>> TRACE could be either, USER_NOTIF could be either.
>>
>> This means TRACE rules would be bumped by a USER_NOTIF... hmm.
>
> Yes, I didn't exactly know what to do here. ERRNO, TRAP, and KILL all
> seemed more important than USER_NOTIF, but TRACE didn't. I don't have
> a strong opinion about what to do here, because users can adjust their
> filters accordingly. Let me know what you prefer.

If we switched to eBPF functions, this whole issue goes away.

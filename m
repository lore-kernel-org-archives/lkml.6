Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeB0Ate (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:49:34 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:45081 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeB0At0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:49:26 -0500
X-Google-Smtp-Source: AG47ELt9vnxVuxlCU5MteIh/e3EAwAaWGDQjoRWzWxC2gZJSWpBoumcvKlojb2xVzR5/HciwgLnjBrYX6BizjqthI+A=
MIME-Version: 1.0
In-Reply-To: <CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com>
References: <20180204104946.25559-1-tycho@tycho.ws> <20180204104946.25559-2-tycho@tycho.ws>
 <CAGXu5jLAAKY19a9iC1PmXRyuwdn1Zxr2Cb318zdzkqgYt8vtdg@mail.gmail.com>
 <20180214152958.cjgwh2k52zji2jxk@cisco> <CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 26 Feb 2018 16:49:21 -0800
X-Google-Sender-Auth: wgPSZq4vC2fSPk2M7Bb26eObKY8
Message-ID: <CAGXu5jKBmej+fXhEc+Jy7Guy+vXEZkHnc=4LNm1NNEsc1=DFVA@mail.gmail.com>
Subject: Re: [RFC 1/3] seccomp: add a return code to trap to userspace
To: Andy Lutomirski <luto@amacapital.net>
Cc: Tycho Andersen <tycho@tycho.ws>, LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Feb 14, 2018 at 9:19 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Feb 14, 2018 at 3:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>> On Tue, Feb 13, 2018 at 01:09:20PM -0800, Kees Cook wrote:
>>> On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>>> I wonder if this communication should be netlink, which gives a more
>>> well-structured way to describe what's on the wire? The reason I ask
>>> is because if we ever change the seccomp_data structure, we'll now
>>> have two places where we need to deal with it (the first being within
>>> the BPF itself). My initial idea was to prefix the communication with
>>> a size field, then send the structure, and then I had nightmares, and
>>> realized this was basically netlink reinvented.
>>
>> I suggested netlink in LA, and everyone (especially Andy) groaned very
>> loudly :). I'm happy to switch it to netlink if you like, although i
>> think memcpy() of structs should be safe here, since the return value
>> from read or write can indicate the size of things.
>
> I could easily get on board with "netlink" (i.e. NLA) messages sent
> over an fd.  I will object strongly to the use of netlink *sockets*.

Yeah, I was thinking NLA over the fd; not a netlink socket.

>>> An ERRNO filter would block a USER_NOTIF because it's unconditional.
>>> TRACE could be either, USER_NOTIF could be either.
>>>
>>> This means TRACE rules would be bumped by a USER_NOTIF... hmm.
>>
>> Yes, I didn't exactly know what to do here. ERRNO, TRAP, and KILL all
>> seemed more important than USER_NOTIF, but TRACE didn't. I don't have
>> a strong opinion about what to do here, because users can adjust their
>> filters accordingly. Let me know what you prefer.
>
> If we switched to eBPF functions, this whole issue goes away.

Yeah, though we'd still need some kind of "wait for answer" eBPF
function. It feels wrong to re-use maps for that...

-Kees

-- 
Kees Cook
Pixel Security

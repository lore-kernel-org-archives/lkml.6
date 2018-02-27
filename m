Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeB0D14 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:27:56 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:39624 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeB0D1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:27:55 -0500
X-Google-Smtp-Source: AH8x226QJPq5L2CyT2MZR/93GV9qXD35ROJBM/EPzJ+gfuG8Sen8+SbpChn8/OeuR+erFiIe3WzvUQ==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 1/3] seccomp: add a return code to trap to userspace
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D60)
In-Reply-To: <CAGXu5jKBmej+fXhEc+Jy7Guy+vXEZkHnc=4LNm1NNEsc1=DFVA@mail.gmail.com>
Date: Mon, 26 Feb 2018 19:27:51 -0800
Cc: Tycho Andersen <tycho@tycho.ws>, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Sargun Dhillon <sargun@sargun.me>, Paul Moore <pmoore@redhat.com>,
        ast@kernel.org
Message-Id: <6314EDD9-2B0F-454C-9B99-E57694DC7AE1@amacapital.net>
References: <20180204104946.25559-1-tycho@tycho.ws> <20180204104946.25559-2-tycho@tycho.ws> <CAGXu5jLAAKY19a9iC1PmXRyuwdn1Zxr2Cb318zdzkqgYt8vtdg@mail.gmail.com> <20180214152958.cjgwh2k52zji2jxk@cisco> <CALCETrXeZZfVzXh7SwKhyB=+ySDk5fhrrdrXrcABsQ=JpQT7Tg@mail.gmail.com> <CAGXu5jKBmej+fXhEc+Jy7Guy+vXEZkHnc=4LNm1NNEsc1=DFVA@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1R3S1He014050



> On Feb 26, 2018, at 4:49 PM, Kees Cook <keescook@chromium.org> wrote:
> 
>> On Wed, Feb 14, 2018 at 9:19 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Wed, Feb 14, 2018 at 3:29 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>>>> On Tue, Feb 13, 2018 at 01:09:20PM -0800, Kees Cook wrote:
>>>> On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>>>> I wonder if this communication should be netlink, which gives a more
>>>> well-structured way to describe what's on the wire? The reason I ask
>>>> is because if we ever change the seccomp_data structure, we'll now
>>>> have two places where we need to deal with it (the first being within
>>>> the BPF itself). My initial idea was to prefix the communication with
>>>> a size field, then send the structure, and then I had nightmares, and
>>>> realized this was basically netlink reinvented.
>>> 
>>> I suggested netlink in LA, and everyone (especially Andy) groaned very
>>> loudly :). I'm happy to switch it to netlink if you like, although i
>>> think memcpy() of structs should be safe here, since the return value
>>> from read or write can indicate the size of things.
>> 
>> I could easily get on board with "netlink" (i.e. NLA) messages sent
>> over an fd.  I will object strongly to the use of netlink *sockets*.
> 
> Yeah, I was thinking NLA over the fd; not a netlink socket.
> 
>>>> An ERRNO filter would block a USER_NOTIF because it's unconditional.
>>>> TRACE could be either, USER_NOTIF could be either.
>>>> 
>>>> This means TRACE rules would be bumped by a USER_NOTIF... hmm.
>>> 
>>> Yes, I didn't exactly know what to do here. ERRNO, TRAP, and KILL all
>>> seemed more important than USER_NOTIF, but TRACE didn't. I don't have
>>> a strong opinion about what to do here, because users can adjust their
>>> filters accordingly. Let me know what you prefer.
>> 
>> If we switched to eBPF functions, this whole issue goes away.
> 
> Yeah, though we'd still need some kind of "wait for answer" eBPF
> function. It feels wrong to re-use maps for that...
> 

BPF_CALL.

Alexei, can we make it so that each bpf program type can easily limit which BPF_CALL helpers can be use and allow bpf program types to add their own helpers?c

Return-Path: <luto@amacapital.net>
ARC-Seal: i=1; a=rsa-sha256; t=1520557197; cv=none;
        d=google.com; s=arc-20160816;
        b=lkVuRKZQhz+XMmB8D5zUivek5bxVywvBFwTUaImu8J1yV/LGUotp7ui/KsnpZqc5Rm
         sBKsBMaUzwHtwxk/ZSRgE6RFxwH29xlps5UXoOzcrm6IUZJNNN47MMx4Xe3bNFSwFAZF
         YNhyDnAc1juJQzaexN5lvDPvaanwmWICT0PAOjgqCf0amof0QX32pnZ9TuF4PX/3srD2
         h6hlmv1mkJhbBTKH6Kk7/179seo1xjDn9xIzfKHMlv1SpJ4hAkmQc9nHdK7TZvOT7CsO
         adt0MQRozPRcazrufgKp1LkTZrGRCpKdh7lxqaRXxk+qdJ2lLTPE0r602f2SQVOLl6kY
         z6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nWFo+89pSuBF3Rz8efXBMWfRY9FKuoLtyRqGObO56LQ=;
        b=i+27t0c8qh8Il+kduP8f7oWwvcKqzT0fIdYfm8L9ztGi5YGmRyjkThBrmy1Og5U7BT
         ihl9oXrnjWrWroZpY9ikQk7xn93YTXFyTpLLCmqGAyIQA0lv8YHDf/XNMWXG81pTI3gM
         enK3GTGWTgoqYViIiQ0iVBpyh/cEYmD8T/hAyk96QKV9MPRchDDOW/rn717uusX7/VBz
         NWcBLIOorlNbJUBGObPFr1hsCGXjR9h5jiwScrd+/Japwtzl7wJRZx1f0xWs19+G761X
         KEzlzkm94iQoEwlDv0G9Qtge2ZRBQJ/I3oBuuSPTJU5tE+z9ef2Ocr36gR+Lzgc9hgXa
         GjuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=D7YX5pxP;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amacapital-net.20150623.gappssmtp.com header.s=20150623 header.b=D7YX5pxP;
       spf=pass (google.com: domain of luto@amacapital.net designates 209.85.220.65 as permitted sender) smtp.mailfrom=luto@amacapital.net
X-Google-Smtp-Source: AG47ELtDDBS4nanJnVUVFpL/+p/EItVgYsMj4pu/LX3jDE09IDU87B81/uFOf2v675xbjEi8tK/EoyBY3ElodWsI+vY=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 9 Mar 2018 00:59:36 +0000
Message-ID: <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Kees Cook <keescook@chromium.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Djalal Harouni <tixxdz@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
	Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594419784765449430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 12:24 AM, Kees Cook <keescook@chromium.org> wrote:
> How is this not marked [RFC]? :)
>
> On Mon, Mar 5, 2018 at 5:34 PM, Alexei Starovoitov <ast@kernel.org> wrote:
>> As the first step in development of bpfilter project [1] the request_module()
>> code is extended to allow user mode helpers to be invoked. Idea is that
>> user mode helpers are built as part of the kernel build and installed as
>> traditional kernel modules with .ko file extension into distro specified
>> location, such that from a distribution point of view, they are no different
>> than regular kernel modules. Thus, allow request_module() logic to load such
>> user mode helper (umh) modules via:
>>
>>   request_module("foo") ->
>>     call_umh("modprobe foo") ->
>>       sys_finit_module(FD of /lib/modules/.../foo.ko) ->
>>         call_umh(struct file)
>
> Yikes. This means autoloaded artbitrary exec() now, instead of
> autoloading just loading arbitrary modules? That seems extremely bad.
> This just extends all the problems we've had with defining security
> boundaries with modules out to umh too. I would need some major
> convincing that this can be made safe.
>
> It's easy for container to trigger arbitrary module loading, so if it
> can find/use a similar one of the bugs we've seen in the past to
> redirect the module loading we don't just get new module-created
> attack surface added to the kernel, but we again get arbitrary ELF
> running in the root ns (not in the container). And in the insane case
> of a container with CAP_SYS_MODULE, this is a trivial escape without
> even needing to build a special kernel module: the root ns, running
> with all privileges runs an arbitrary ELF.
>
> As it stands, I have to NAK this. At the very least, you need to solve
> the execution environment problems here: the ELF should run with no
> greater privileges than what loaded the module, and very importantly,
> must not be allowed to bypass these checks through autoloading. What
> _triggered_ the autoload must be the environment, not the "modprobe",
> since that's running with full privileges. Basically, we need to fix
> module autoloading first, or at least a significant subset of the
> problems: https://lkml.org/lkml/2017/11/27/754

I disagree.  If we're going to somehow have ELF binaries that pretend
to be modules, then they should run with high privilege and, more
importantly, should run in a context independent of whoever triggered
autoloading.

Also, I don't see how this is any more exploitable than any other
init_module().  If someone has CAP_SYS_MODULE or autoload privileges
and they can trigger init_module() on a file, then they're granting
maximum privilege to the contents of that file.  So who cares if that
file is a kernel module or an ELF binary?

Alexei, can you give an example use case?  I'm sure it's upthread
somewhere, but I'm having trouble finding it.

Also, I just tested this concept a bit.  Depmod invoked explicitly on
an ET_EXEC with a.ko extension gets mad, but depmod -a on a kernel
that has a "module" like that seems to work fine.  Go figure.

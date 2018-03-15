Return-Path: <daniel.vetter@ffwll.ch>
ARC-Seal: i=1; a=rsa-sha256; t=1521109919; cv=none;
        d=google.com; s=arc-20160816;
        b=Fqz7Az9fjHmPQf0d2RsRJdjmT6bJeXHBAV5y0qFImmNFIBFigMwDCgWZQXgqveZfZ8
         v81d212PfpSme0XC/63WgCOjp8WaJMktppEsyIkn82XAtEupAnxTc2/yNTikVgb0d/oR
         hIwrjR7TqY5wKdD0lNXGFJSePHuSirYwMJhbXRt7EwpBgJFP1AJs6sRSMo5hXtUzM80r
         MZgRfpPKlPjfMnmMArVo8SkxAvOcJgUS8TOvNRtX8tbSds37hP4T3kXXqQ+Sd/JPVzpV
         9mSHQj4DxYhwrC6UhQapCPQCEiybRsH0qpmIyVIqdtCAAG/FmdlcMW+kP8kYGNXQlJBi
         rWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wz0OzK1jEYqnCBV/npFXk8gvfSiWqBrxM+rkopH1HPo=;
        b=nS/p7Ip3NVD2EJ4doL/vKcomZD4+lCS6KoIJXyY/D1TcVqoND7EfxaJWhI/u40R+x3
         YGB0pDyYuhbF11F1vz2NVwTqi8/3dgRweWL9JN3kJ6sudtrY6M5pV48IETkaunzMHX3g
         vvEOw84Dovg7p0UNXfinc6/YC5eeVNd4ZTCujG6B3+mxB+/Y3eX4BOY0C16/zrBrIwEc
         YEHM8yZq2yOzRz3HapWzpMucq5xkpRTZmo5BWc2KVywdEBV1YVY279K5J4ec6xtpVxFz
         SHzZ3S5dqcCX6SP5mYNf7OaBSLx6XKSt2cuDxe5xMX/Lvity5FZWfEaU23Mo9zSGggVs
         rMXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=dwGS7QhH;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=dwGS7QhH;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
X-Google-Smtp-Source: AG47ELsYqSRpRIcAcmAgsv+864HO/pLMFd6UAMvNuYi8YT66HO0fM1px2Yma2luUZWF1S4+BUHkxpIIB8MlqiuGkLJg=
MIME-Version: 1.0
Sender: daniel.vetter@ffwll.ch
X-Originating-IP: [2a02:168:56e6:0:e4bc:76a0:8042:669e]
In-Reply-To: <aae95b90-a0c8-4825-17fb-b31eb1aecf80@lge.com>
References: <20171207100849.407-1-daniel.vetter@ffwll.ch> <20171208105419.jdzene5wrsriwm2n@hirez.programming.kicks-ass.net>
 <20171211091928.cpw3srz2rddmruxj@phenom.ffwll.local> <20171218071159.GW26573@phenom.ffwll.local>
 <CA+55aFwD+0hhehWHmh8PW9eDCVtEBTi9KCmCrJXZRUFj77r82Q@mail.gmail.com>
 <20171219095925.GY26573@phenom.ffwll.local> <aae95b90-a0c8-4825-17fb-b31eb1aecf80@lge.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 15 Mar 2018 11:31:57 +0100
X-Google-Sender-Auth: 94iPyLfPXF7nqn9LAxyeQ3t4Qi4
Message-ID: <CAKMK7uHdk1CT9YP00fb0mpBQdg_Di6CKv+z5ZXSS9Q4tbOcwAg@mail.gmail.com>
Subject: Re: [PATCH] kthread: finer-grained lockdep/cross-release completion
To: Byungchul Park <byungchul.park@lge.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Marta Lofstedt <marta.lofstedt@intel.com>, Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
	Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Shaohua Li <shli@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>,
	Oleg Nesterov <oleg@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, kernel-team@lge.com,
	Amir Goldstein <amir73il@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586119401963161178?=
X-GMAIL-MSGID: =?utf-8?q?1594999354904668668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Dec 20, 2017 at 2:14 AM, Byungchul Park <byungchul.park@lge.com> wrote:
> On 12/19/2017 6:59 PM, Daniel Vetter wrote:
>>
>> On Mon, Dec 18, 2017 at 09:42:13AM -0800, Linus Torvalds wrote:
>>>
>>> On Sun, Dec 17, 2017 at 11:11 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>>>
>>>>
>>>> This didn't seem to have made it into -rc4. Anything needed to get it
>>>> going?
>>>
>>>
>>> Do you actually see the problem in -rc4?
>>>
>>> Because we ended up removing the cross-release checking due to other
>>> developers complaining. It seemed to need a lot more work before it
>>> was ready.
>>>
>>> So I suspect the patch is simply not relevant any more (even if it's
>>> not necessarily wrong either).
>>
>>
>> Awww ... I like the cross release stuff, it's catching lots of good bugs
>> for us - writing a gpu memory manager that's supposed to interface with
>> the core one ain't the simplest thing to get right. That's also why we're
>> going around and fixing up fallout (we've worked on the worker annotations
>> for 4.14 too). I guess next release, hopefully.
>>
>> I think between 4.14 and 4.15 attemps cross-release spotted around 5 or so
>> genuine deadlocks in i915 code. And at least right now, with the current
>> set of fixups our CI runs are splat-free. So at least a Kconfig option
>> would be nice, to be able to enable it easily when you want to.
>>
>> Wrt us not noticing: Getting the patches in through normal means takes too
>> long, so we constantly carry arounda  bunch of fixup patches to address
>> serious issues that block CI (no lockdep is no good CI). That's why we
>> won't immediately notice when an issue is resolved some other way.
>
>
> Hello Ingo and Linus,
>
> IMO, taking it off by default is enough. What fs folk actually
> wanted is not to remove whole stuff but make it off by default.
>
> Cross-release logic itself makes sense. Please consider it back
> and apply my patch making it off by default.
>
> I will do what I can do for the classification in layered fs.

Is there any progress on getting cross-release enabled again?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

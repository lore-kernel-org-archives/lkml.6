Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525264691; cv=none;
        d=google.com; s=arc-20160816;
        b=pzpKfHi/VVMhMEl1Hkn8UOaL2Os6T96BWzTC9EDz/+KlDi9xj35X1l3P9t5P7jMIxD
         9lyPjSUvBHBEkK92QMJO/XmkHzgayDo5CqJY+giAJHyCkF+SYDXSQBjYeLDmuORCnwzL
         9Zum9fjNEWixOGmy6ebwKV4qx6PNqoVA9R3p1/ORUo8Gvu9k5+RksRYIqJblth6wvEQ0
         MVWB9sAjwI4wYUpCIMfdua/qORRHv/w/Zp8pXHp0wjweCDVzT7LykA5IG5jX94umWYSU
         BHcqNwslAmfbleXUdxqmYo1CHmAFgftMqK9VnAYgiitq+rcOE3gT5iIVasatfev/r7K0
         VVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=FQI4NR94XhPcp3Ut62cwA1iztnQZp9cF87tP1t65iiw=;
        b=uHD20d699twaBkXEjX4we080KDlOqg0sl0JMSp4EbsL6lyHoZJzG6WpHpHpNgoMYht
         m4T6pl8ku9W0pJ7KVh04JsEag+E2o/mfHVpM2rtXIR6CjKJYVUA7MgJ4ajzWDei5Ns6F
         NjaP3EJgGliVnLV1/Q22D9C2hi7140VS4AGHOqM0C7XyakOHW/kZh50gH+C0y9+GTpxt
         bnGHvmDvgBe+FIt3MINdSJ7ZLzzzAriZ6eoFudVu2RIMcOcuFNlGlkc3EWR/9w+csq6h
         +CufTGSc0yzVprF+rHXF38Ofv7LlNGNukkRMYmnzNiXJ4cmOXRPGR04k2NB0CyhOmQcq
         xktw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jclBDmmZ;
       dkim=pass header.i=@chromium.org header.s=google header.b=EWOaAJ1P;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jclBDmmZ;
       dkim=pass header.i=@chromium.org header.s=google header.b=EWOaAJ1P;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZrWwim3gYHAyMxLYKqz5Xa3vaSFUcMaWQEEm86Q5J7Zg1pJGdL1hdz5CLwrj/27jdC/KQfh412olyWnDxj3C1o=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <alpine.DEB.2.21.1805021041260.1668@nanos.tec.linutronix.de>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
 <1523024546-6150-3-git-send-email-alex.popov@linux.com> <4e668302-8754-3f4e-3372-d0d7ba30cfa3@linux.intel.com>
 <CAGXu5jJ_0e63QSv0YZsQoT_=zN8U-83nwxrQ10h=QjszbHK-aQ@mail.gmail.com> <alpine.DEB.2.21.1805021041260.1668@nanos.tec.linutronix.de>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 05:38:09 -0700
X-Google-Sender-Auth: p7tMQiJHOF4QMeHnhUeoQpxQGo8
Message-ID: <CAGXu5j+4Rj3oOH_iHhfD9sMMa2hRVm_dp9oA6YKhN9omhjdtEg@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>, Richard Sandiford <richard.sandiford@arm.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1599355948783132932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 1:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 30 Apr 2018, Kees Cook wrote:
>
>> On Mon, Apr 23, 2018 at 9:23 PM, Dave Hansen
>> <dave.hansen@linux.intel.com> wrote:
>> > Hi Alexander,
>> >
>> > You can add:
>> >
>> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>> >
>> > for this patch if you like.  I haven't taken a super close look at the
>> > rest, but this is certainly minimally invasive from my point of view for
>> > the entry code.  Thanks, again for reworking it.
>>
>> Thanks Dave!
>>
>> Given this improvement and your review, I'm going to start carrying
>> this for linux-next. Linus, if you're still opposed to this even after
>> the changes here in v11, please let us know. I'd rather hash things
>> out now instead of during a NAK in the 4.18 merge window. :)
>
> Kees, can we please route that x86/entry stuff through tip to avoid
> conflicts as there are other changes in that area on the horizon.

Sure, let me figure out how best to split up the patches, since it
touch x86/entry, gcc-plugins, and lkdtm. Thanks!

-Kees

-- 
Kees Cook
Pixel Security

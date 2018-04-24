Return-Path: <SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx48+YH1+uxYBE42cZBcQI2XqPg7C9GAxcaHiqukkYd3vwifwEeP68dmz9Y4Nor5p+QwL+sUy
ARC-Seal: i=1; a=rsa-sha256; t=1524597970; cv=none;
        d=google.com; s=arc-20160816;
        b=J+EkHSkH8I5do6oHscwGlZPTHTaVWZ7R1H7UvUFbR8moGJ5casefuJew3QBmpfKmFS
         AfWG3uJaVGAN8N0EXUK/WbQivKA1C2yyM1ur0mg6JcYHtrAqpqRb5238HDglQTJN1P1P
         PCLUUXi88iy3foK4Dl5ArNQNEg93Ua6OGBoNyAawUL2gtib5WPKZaG5/taNKbHmVPyBE
         QdO7Bm75k0kTF5P5hdA/mXWQsJzyJHA9X/GFj47ZFMGiN2ol3GM8PFnLn213U1zZ4Svm
         lRxAsPcsjxyXDgso1UZElr+shUmse7UctzRmeSyume5dlIbTaut/Fxy2o2Km8wrHj1L5
         hFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=MD1mfCxa6FayztUI1NofH7D3bxONGU1LCIGccDVwWGI=;
        b=IZWNAwlUMlG3llDJmWq3L9HfKfyrxJWwmRy4XJ7O1F3H29CLG/BaStME0dhRgNjfkm
         OnMXYziZzXsZMKsSjG/D32DlewoOKRiMSYJdvKcrdBZ9/NvkvvQ6RjgGixh9kA6cLUs+
         d5+QSOhdOyuzsBMTZehKlemFgLRBmIxM/lkIPw/kYMQi7KjUw1czRMCUzsBU1hOAj/Vb
         UlkNOzT7kFOFmiIbZA2Gc5vF+xNMlSzuvKazGxvHcn7W8Gx367IbFvJUZ3fILgDjzwkS
         2vdiHBdxv1l5PLfw3QJ/SLBWwf1zogSjHm2GUKPRj88hhNkP6vU4DABft16v4qGZmF+u
         qLFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=kioc=hn=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=KIOc=HN=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C40D21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 15:26:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees
 Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>, Alexei
 Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
Message-ID: <20180424152607.71fbee34@gandalf.local.home>
In-Reply-To: <CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
References: <20180424180812.215900-1-wvw@google.com>
	<20180424145056.7c29ea18@gandalf.local.home>
	<CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
	<20180424151416.397fbbde@gandalf.local.home>
	<CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598656842159800187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 24 Apr 2018 19:20:03 +0000
Wei Wang <wvw@google.com> wrote:

> checkpatch.pl sounds good. One thing to add is we have many off tree
> patches with abuse trace_printk. Also as you mentioned, given this is
> really not for use in production and we have been cleaning this our on our
> side for years, could we consider to enforce this in kernel?

That nasty warning was suppose to be the enforcement. I would expect
nobody would ship a kernel where it produced such a message on boot (or
loading of a module). If they don't notice, then they are not testing
their code.

A lot of kernel developers use trace_printk() and I want to make it as
easy to use as possible. I don't want to add a config to enable it,
because that would be something that could be rather annoying.

Let's add it to checkpatch and see if that can draining the swamp of
abusers.

-- Steve

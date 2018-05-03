Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZqhv2q8amcvy5ZRv432X8fxelDYaXoWzZrTCqxpMxcyIPq1ODoNwbIo6lfhQMsYeXYPLvVJ
ARC-Seal: i=1; a=rsa-sha256; t=1525324147; cv=none;
        d=google.com; s=arc-20160816;
        b=bhNCl8jUEERy25YEgaTBiYI5JOSb9uUSMmFJy6EKqtZGPySW6SetNSFuOF6jHASfh1
         PY/PhufDXqQs/eDXw5G9GCv+UGl3dItGJ2ZXdJX4AxmaF7PQSPV+IyeusEkP3ZorsUtv
         1kSfJs/po1gmu78ztZNvgBDIZ+Jt2IaX8xOTAMEPlKdCrSzqjJJZeJ2WbWwDcd7UCs2C
         rq5/VNOQ28M7cFZ4G1rsTYkfwrpFYAsXf7vIn+hQgKxK/XXkez627HhGxNYqp+gCSog0
         1fCsuFaT4amqsCoWLHzkCJc4ZluhpqBK6Eso+s7V67r2GTo1pWIRgWyIdLml5HdbKPhx
         23EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=fh1jaBbBEX4qg0++UmtgPH5fvZuU0OCHjz4gnzdhiCA=;
        b=A+CYfj9JpOVqYOS26vFKW38qnEN0xtsL8KpxV3hQRPkJVluXk7JChxdMEzmKzQLA6O
         SvpxxSh4tx13UOYuqgMKrzpUPMsGuaY3T4EFki6hodxzMK/gYgmHpCqw697GvEL5UKT4
         VQ34rTIwE19CzPxan6Ik/Z8JhRvkpShIIfPRqdO/Va/pHcEpSQZgVBVTxiMRKJ7sdDRC
         m5r+syYYedJieQePXeM+vDSKr+a/ouDTGQkm1rabLTQHIPdnFq/jGFJdbq1vFJTtSUxW
         C/Anevm2pRzvQtMvezqSypPatckCZWas7H0/z8eAsBqtfTxywGV6VubpAGdiX5kaifp6
         tw6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=PP9sLeJk;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ILDTYcJV;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=PP9sLeJk;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ILDTYcJV;
       spf=neutral (google.com: 66.111.4.25 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:cpnqWhISXhXQxzNbIiydYARIhDsBo7aUhnKkQ7kr5En4Dh_NBx3Jsg>
Date: Thu, 3 May 2018 15:09:02 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 4/4] vsprintf: Add command line option debug_early_boot
Message-ID: <20180503050902.GM3791@eros>
References: <1525301426-23543-1-git-send-email-me@tobin.cc>
 <1525301426-23543-5-git-send-email-me@tobin.cc>
 <CAGXu5jKQbyBAD733Xyy94yMa0rQ=yRV4smXr+YHbeBGMxdChgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKQbyBAD733Xyy94yMa0rQ=yRV4smXr+YHbeBGMxdChgQ@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599394508196651405?=
X-GMAIL-MSGID: =?utf-8?q?1599418293760933098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 09:57:57PM -0700, Kees Cook wrote:
> On Wed, May 2, 2018 at 3:50 PM, Tobin C. Harding <me@tobin.cc> wrote:
> > Currently printing [hashed] pointers requires either a hw RNG or enough
> > entropy to be available.  Early in the boot sequence these conditions
> > may not be met resulting in a dummy string '(____ptrval____)' being
> > printed.  This makes debugging the early boot sequence difficult.  We
> > can relax the requirement to use cryptographically secure hashing during
> > debugging.  This enables debugging while keeping development/production
> > kernel behaviour the same.
> >
> > If new command line option debug_early_boot is enabled use
> > cryptographically insecure hashing and hash pointer value immediately.
> >
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
> >  lib/vsprintf.c                                  | 18 ++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index b8d1379aa039..ab619c4ccbf2 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -748,6 +748,14 @@
> >
> >         debug           [KNL] Enable kernel debugging (events log level).
> >
> > +       debug_early_boot
> > +                       [KNL] Enable debugging early in the boot sequence.  If
> > +                       enabled, we use a weak hash instead of siphash to hash
> > +                       pointers.  Use this option if you need to see pointer
> > +                       values during early boot (i.e you are seeing instances
> > +                       of '(___ptrval___)') - cryptographically insecure,
> > +                       please do not use on production kernels.
> > +
> >         debug_locks_verbose=
> >                         [KNL] verbose self-tests
> >                         Format=<0|1>
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 3697a19c2b25..6c139b442267 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1654,6 +1654,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >         return widen_string(buf, buf - buf_start, end, spec);
> >  }
> >
> > +/* Make pointers available for printing early in the boot sequence. */
> > +static int debug_early_boot;
> 
> Please make this __ro_after_init too.

Good suggestion.  I forgot, we are supposed to be closing security
wholes not opening them :)

thanks,
Tobin.

Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518111910; cv=none;
        d=google.com; s=arc-20160816;
        b=tPv2TLPP9W//AzNSnVupnVDph8n2HDmJ6Gd5ZK2gODrGqjMJ8t9WaforIdq4IrGEoA
         luC/1mgIsMVsTK8tbDwzpoINC0DzhD/+YTV08Zm0AmYE5ny1MWKmNSNkNk1kuobOsOtQ
         2/ovBjI3E7+2v0BCh5E9tRVkqQGI9rzmJcJOwlgiL8S/1sg9jGWJTLpkzYxPuHOnDGZI
         lrie/TAO8sGcS7vHDIdUrP0Z3B/Gys04MpA9RccBMwbkGl1hzAar/5osFPluHBgUy7MT
         D1/3bpuakrwd3gjijBZrC4JJWnqNThOcgb2uTA5ECAzdG8onK0iBHfLEzfDkVcNVB+nd
         uZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9IyyjLDhOoG4d3dtvW73tdeMyVQt3P0NBzLU66QXJh8=;
        b=DkdnYYFQ5bz+CrV7MMRumvi+AuKDmzM7Oy5YRxL6zq8sRGfpeR88zsH136VCXYi9QF
         nyqPta2saIBQc3kAoHKwEa293g/xopUrE28EVb6N5iWIRWtD7zqvbzqlYY5BYDdQJU94
         9H51cNZ7W1O2jdog8cZLeUycvNAftXUExZL8MfIaEPf7ElNYLwb2WLCplBBhYRbZEFVZ
         deeSobTtpH+YFPkcuK30WPmGXSdKvZc5ksLnXGzDT7YHNvcrniexccSCDEh39V6LGBVV
         bcIeiq6Ct5AgF7wAwrrcFLeeCwnwTWa7KH7UjxWI4O1hHmLGXJ/YYJeRUE1oPC/q1BBR
         1aYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YcMTFr9i;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YcMTFr9i;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227jdNAEjoSgNOzVsQZafjueVhi9RUx9VdsRt4wWiXsIm6xyk8o7/OGJshQAZw62XZzy/PTYg/AGp6cBpX5ILrQ=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAK7LNARSd6QOcr05z-V9UGCspib=yMDSjdBLXB5h1CGXCmwKjw@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-6-git-send-email-yamada.masahiro@socionext.com> <CAK7LNARSd6QOcr05z-V9UGCspib=yMDSjdBLXB5h1CGXCmwKjw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 09:45:09 -0800
X-Google-Sender-Auth: WDmsKEw4kEsQ0hRfxFmozj21e4w
Message-ID: <CA+55aFy-gyap4YS3ycgYgMqQJLCjXF9Ua7C-xyvi3J=14Ddqnw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] kconfig: invoke silentoldconfig when compiler is updated
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>,
	Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368907801402?=
X-GMAIL-MSGID: =?utf-8?q?1591855714306271209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 9:19 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Should this be checked?
> Or, is it just "Don't do it" thing?

I think it's probably a "Don't do it".

In fact, maybe we should just make it very explicit that you need to
re-run "make *config" by hand if you have updated your compiler.

So instead of your "run silentoldconfig" if the compiler version has
changed, just literally error out and say "compiler has changed,
re-run configuration".

That way there are no subtle silent failures where you might end up -
by mistake - building just modules with a new compiler and different
options. Because people would be *aware* of the re-configuration.

Anyway, I suspect this is a tiny detail that we don't have to set in
stone right now. Maybe worry about it more when/if it actually becomes
something that people notice?

              Linus

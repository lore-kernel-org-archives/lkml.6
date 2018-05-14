Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqdwZc88Eosgk9pR255r7bgyEU8D2VBnBR3XPIGnCR1vTd+/JDtGOWp/4am0gmS8NLCfB7V
ARC-Seal: i=1; a=rsa-sha256; t=1526314408; cv=none;
        d=google.com; s=arc-20160816;
        b=qRtloa/Cjl2U5SQEIhpihbCVkBax3m0pgr4B2tXODvmAM8jkYBlO6xMb89iwYmqpas
         lB0BZQw5dgzAAuGCuUgIDHnFz5Kvg2lWuwZdn4X54aNoc3fS3wZicObqcUTa0TXy/YK7
         A5chwlUGo6r9yGEFuGpllXoBzzm2jtKyrlb+w7yAvwOAYTRRjpv3DHvlJZmp4nz8Mvts
         oQkx/ITzwNrdi5RbbnY+XzkN6JbNnOvo9GUSrG9XxOG9wk2hTJmgErGiXyRHfJ9RuqF1
         V/Po1JCX/r82KdFQunpo8cvi8Osfkvr3BQqMpiH7uBQtTby8L+jxum6JKf05u09COJWS
         DA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=QNINd99N/Q7idCDvfIWD18xtabzo4U7OLbdzfX3M+9k=;
        b=cjKepbV3lCNBASdyAUCRtbMJT1i/kSgMz+4N7karJyu4l1J4kX1x9pB38d7ODP+BFA
         7y8q1fbydL4HaHpa6RBQfHGzzT7mftc6UFfDPckeLiWo0+BgqRr8lvfYPZpjtvfBraK+
         pnBpfRLJ4U/uMAnM5uCAv7VaI8f0iQxoWxJNHaeN2+suSEztEjIPh/GWg0t8C29tmvOL
         SEyLC+pZjwDVxZ87ChPaHmpUg4hYROjV7RGKdnEfnjXmAsmCj3WILSKpBSNkRHxAGTPZ
         xUFQW+90d/ceWUVqQ9xsuqNSC89fPQcM9GX3gB/aFGw6r+vMAis+ym3sF1mHZmnOZt4P
         2YEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="55783844"
Message-ID: <ddd9eae5cf848df9c25a49001845a3d80e429a6f.camel@linux.intel.com>
Subject: Re: [PATCH v2] device property: Get rid of union aliasing
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-efi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki"
 <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date: Mon, 14 May 2018 19:13:24 +0300
In-Reply-To: <20180514154017.GA6734@wunner.de>
References: <20180508131547.44366-1-andriy.shevchenko@linux.intel.com>
	 <20180514121817.GA27869@wunner.de>
	 <f2109d06a0755dd2d9dc807c1e13dd2c19903905.camel@linux.intel.com>
	 <20180514154017.GA6734@wunner.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599901902158233534?=
X-GMAIL-MSGID: =?utf-8?q?1600456657739412784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-14 at 17:40 +0200, Lukas Wunner wrote:
> On Mon, May 14, 2018 at 03:48:09PM +0300, Andy Shevchenko wrote:
> > On Mon, 2018-05-14 at 14:18 +0200, Lukas Wunner wrote:
> > > On Tue, May 08, 2018 at 04:15:47PM +0300, Andy Shevchenko wrote:
> > > > --- a/drivers/firmware/efi/apple-properties.c
> > > > +++ b/drivers/firmware/efi/apple-properties.c
> > > > @@ -13,6 +13,9 @@
> > > > + * FIXME: The approach is still based on union aliasing and
> > > > should be
> > > > + * replaced by a proper resource provider.
> > > 
> > > Why?  All Apple EFI properties are either boolean or u8 arrays.
> > > You've correctly changed this file to always supply u8 arrays,
> > > so I don't see where union aliasing is happening here?
> > 
> > Okay, for now I can see only Thunderbolt user of these properties
> > (is it
> > correct?) in upstream which uses u8 arrays indeed.
> 
> That is correct, thunderbolt.ko is so far the only user.
> 
> 
> > Though the implementation is quite fragile in this sense, because it
> > doesn't discourage people to use device_property_read_string() in
> > case
> > when it's indeed a string (I saw these kind of properties in the
> > very
> > dump you posted on your GH page).
> 
> Well if that is your concern then you need to prevent functions which
> retrieve properties to use the wrong type.
> 
> E.g. to prevent retrieval of the u8 array as string, you'd have to
> amend drivers/base/property.c:pset_prop_read_string_array() to
> check the type of the property found and return -EINVAL if it's not
> string.

I think it's doable. I will hack a new version later this week.

But it still not a (best) solution for Apple properties. B/c as I told
already I saw in _your_ dump the _string_ properties. Someone might have
got an idea to use them as _strings_.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel F

Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x227uX6K5YoNwS52BZ8KvD0pFSyafWyWSE6N7lqrSHONA8VsEjoPS/GC29JfuzWN5whoOZoW2
ARC-Seal: i=1; a=rsa-sha256; t=1519219181; cv=none;
        d=google.com; s=arc-20160816;
        b=T0tTr997qL+2UNJ+DjMsxIC5KCV25a9PXDAT51X1Xf4Nph7YiOMGyQJ96Wnk4f5QQH
         LKt6HxebP1z44BT2QU8cbpVGdrUXfFhnd6440WJNHqiXka2wNZyuHf3zg0Yl/4EQi7bT
         +UOR1TuEDQZmpLz/KKkVHXchFSIRryGNU+yQzEK8LEZmqPvQoDwwU5cQag9RsMw7NpHg
         hGEPnva1W9JOwUSQs7erNHMhQ/xuvYGg5Vbf/93jT9wE+bGEmnT+C0XBiG54vlIrLKPL
         0HFExpsRIpMK4S9W1pXJCW6OyiGi6NZ4FG7QIZnZNQYcKQoivOz+4W3ZZfBbaYub3u7/
         6e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=1QIJA7q66t+4tjcjUld3Gmb9x4YZsT0y3swzGtbL38g=;
        b=c9kDa+58KDcI77JgneMGqKgjI1yNDru+sv8z1Ux78MZyYD5blSbMPbjNYpEXNujraV
         KMtpDtb5eek43jIHsPVi4OyCbdGnSehkUOBMp5/bffcZL7nr88ACeVFpOmIaOnCTNSJO
         4/nRHTMA8cHoJYDiOPBO0HwUGmhD0xKx3bd4HS9ddtpd9zHAwgiqVnu852sxF4GLEJzh
         FtgzBRF3x/e2coRWDMuUJh03urHwjdZ77KmgodabK7aKGAzKJSBYAxHwN2Kdyx9dNr1M
         zSDwDUqYCzdvkzuYiUkBklrY9CAihLfrt3P3XiMNcR4PBpnfF6LpMIm+kPza2h93aj3G
         p4pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29582482"
Message-ID: <1519219174.10722.21.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joe Perches <joe@perches.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,  Mark Salyzyn
 <salyzyn@android.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding
 <thierry.reding@gmail.com>
Date: Wed, 21 Feb 2018 15:19:34 +0200
In-Reply-To: <1519170907.4326.17.camel@perches.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
	 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
	 <1519170907.4326.17.camel@perches.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1593016771614501508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-20 at 15:55 -0800, Joe Perches wrote:
> On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> > There are users which print time and date represented by content of
> > struct rtc_time in human readable format.
> > 
> > Instead of open coding that each time introduce %ptR[dt][rv]
> > specifier.
> > 
> > Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
> 
> Not sure this is a great option.
> Not just the name, the need to select it.

kbuildbot and some people complained about + text size.
https://lists.01.org/pipermail/kbuild-all/2017-June/034950.html

I would really like to compile it always.

> > +	int year = tm->tm_year + (r ? 0 : 1900);
> > +	int mon = tm->tm_mon + (r ? 0 : 1);
> 
> What happens with negative values?

Same as before.

> Perhaps these temporaries should be unsigned int.

No, the type of them is int, so, I'll keep it int.

> > +	if (unlikely(v && (unsigned int)tm->tm_min > 59))
> 
> leap seconds are allowed in the struct

Alexandre answered already, but I would add that this is part of
existing ABI, so, I wouldn't go to change this.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

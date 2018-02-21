Return-Path: <alexandre.belloni@free-electrons.com>
X-Google-Smtp-Source: AH8x2263PVW0us/L4Xwvda3m39hBy0Dc7JaYHQvr9ODA3nCUv3XFqRUnJPMZsobX8OoCC+yUoKks
ARC-Seal: i=1; a=rsa-sha256; t=1519204608; cv=none;
        d=google.com; s=arc-20160816;
        b=Oc5EW+/+3RdpM8FkqNOGDlIj1OAC8zMe8qqB2FiRMadkpWT5PM/BCaFNLOqlFfdj69
         g1BeoqHTPR5rvnwKQfOAFm7hs378KN93jzI7MAHs9w3ziCwz6BzikO0OBI/JJqcEzS4G
         +SmTIAIDcqtD1rU6UZmF8kN2qyknwbc1ww19cINtMUN8IIMfe0c/p3aRwhtDMLYLr2ZB
         soxxLEmQlsAROtHC/qCblQvhgUbXRV8TKNWbdqIdo5BJzcAJ9HuTMEbaI3U/N1y8z5pj
         yCft1JjjaFNM70guPNp6GoJkEa/YSmU8VkYlgLaFIJk41eP1Zjh3Vm6+zi5LDWD1JlsY
         ljFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=CvHnXeeAmU59yzK8aKUQ19h4a/1Dgg4x9Cwg+njGi+I=;
        b=yxD79+0FpHxfHkRN4cE/qCO7+jVOU2FQdK/kKlxNLB99/D1TmpfmgJtXVogJ+RNpv8
         Q/XLh+djB6ccswp4cP4zTp5qU1PQezm5TCelEnN/Ps5pkAhrLPvdJg2bzzAnQC637vxK
         QDE6CrxaTQYXHSKS9M8qncyRZbXyAAS1zKyuIzIWzSvDmjdezipnmylcCuaiBCRM8eRL
         mOl9zEeNP/2OB/PZBaUBdMF8FJkWJJBlvtX8yd4ILTWcbufiFrvneEFdvC0vlCTSvO81
         SlaWzGXCSeomEeWDCxm4x+NSRBO8vAanvEz2qtO8U6eWkWjVRHXoOgp7uCpVLNxK96qB
         xcmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@free-electrons.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@free-electrons.com
Date: Wed, 21 Feb 2018 10:16:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joe Perches <joe@perches.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Mark Salyzyn <salyzyn@android.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
Message-ID: <20180221091637.GK18058@piout.net>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
 <1519170907.4326.17.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519170907.4326.17.camel@perches.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1593001492102429875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20/02/2018 at 15:55:07 -0800, Joe Perches wrote:
> On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> > +static noinline_for_stack
> > +char *time_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
> > +{
> 
> Maybe use unsigned int temporaries here too for hour, min, sec
> 
> > +	if (unlikely(v && (unsigned int)tm->tm_hour > 24))
> > +		buf = string(buf, end, "**", default_str_spec);
> > +	else
> > +		buf = number(buf, end, tm->tm_hour, default_dec02_spec);
> > +
> > +	if (buf < end)
> > +		*buf = ':';
> > +	buf++;
> > +
> > +	if (unlikely(v && (unsigned int)tm->tm_min > 59))
> 
> leap seconds are allowed in the struct
> 

No, they are not:
https://elixir.bootlin.com/linux/v4.15.4/source/drivers/rtc/rtc-lib.c#L108


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

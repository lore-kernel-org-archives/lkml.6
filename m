Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AB8JxZq77CzpIZLtw+EhFYli5Lh8fC/beJSYsrPOWUtt5VclHIeoenacoNz5E69LCNdiyu4WUkYy
ARC-Seal: i=1; a=rsa-sha256; t=1524592831; cv=none;
        d=google.com; s=arc-20160816;
        b=j4rdO46CS4bmTV/5c3jr+afIFW0nhjI5ort22M0QuCHJVcqnZi7U6EqWL58t9PH3WK
         mEblCCGwc9lma+vVit00QlNOZm1aAbPhnod7M8/9YKMwQ/TeCx02HcuBhi5vz8+c1BZv
         W1BEPRbygXXWmeNEGAsrL829JjzhqVh2Hpq7Pe7qVfF0SnIHsxpiAyd8zcHB+3M418cq
         PmzcJVGYlmhwluzkMBs8lUkmtrTD9eb0xLYtF4RzkLepm3nCnyIifoGAfMAE1eLF0Bce
         c+5eBNUjCxFKwIUhGj7AW5DXy6D9r50o1rGTFvFBhMruwX/88vESIuASBhqEUjAMkYJD
         F+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=HnsmpAg983H0wvOfHIMYLaXBtBT5z7zeInJTX6eA0KA=;
        b=yPDkjr2Tl0zC6lcA7GyyXvJHK5FggD6Hfzy8nWEbWbQU+drBPwEaIdfLf8/17g7ji3
         sW5/T6qVQ1Da8MKMz+lYNKrqp0cYZV0HiNmxr0+yhGXp6H7MS357tXm+2VnRYZqb4Nec
         gEuDKzdI4Soqxo6igrq9TG7dSnN6s+ArjCRT+LBIKUDT3GX2Np9yoI2QhSeJ2vXEqbaO
         E4p8HsSETcg6cLx+SLcHNmzIQ8OZ5GQ4Tajhug2zIVIGSiAcS9mvnnZZs9ymCvr6yxfj
         xJLO5m6SGMTqtDCNccwlVZUidadUmC2FBhugIcgCoqZ0Y3vnk/w98PxB+lArjcjxumir
         BlNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Tue, 24 Apr 2018 13:59:37 -0400
From: Rich Felker <dalias@libc.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/11] platform: device tree support for early platform
 drivers
Message-ID: <20180424175937.GD3094@brightrain.aerifal.cx>
References: <20180424173051.15099-1-brgl@bgdev.pl>
 <20180424175544.uq7f5x63a5il36sh@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424175544.uq7f5x63a5il36sh@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649607100825317?=
X-GMAIL-MSGID: =?utf-8?q?1598651452555507850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 06:55:45PM +0100, Mark Rutland wrote:
> Hi bartosz,
> 
> On Tue, Apr 24, 2018 at 07:30:40PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Device tree based systems often use OF_DECLARE() macros for devices
> > that need to be initialized early in the boot process such as clocks,
> > timers etc. However platform devices are more desirable.
> > 
> > This series aims at introducing support for early platform drivers for
> > OF-based systems.
> > 
> > The idea is to have a special compatible fallback string: "earlydev"
> > that similarily to "syscon" would be added to device nodes that need
> > early probing. We then need to call of_early_platform_populate() early
> > in the boot process to actually probe the registered devices.
> > 
> > I am aware that this new compatible does not strictly correspond with
> > the "hardware description only" rule of DT, but we already have many
> > functionalities that break this rule: syscon, gpio hogs etc.
> 
> I don't think we need the "earlydev" string at all, and can still keep
> the rest of this infrastrcuture if it is helpful.
> 
> So while I'm certainly oppposed to the "earlydev" string, I think that
> the infrastrcuture could be useful.

Yes. I think this agrees with my objection -- I'm not opposed to the
infrastructure in the kernel, but to semantically-wrong and
backwards-incompatible changes to the device tree contract.

> > The first user of this new functionality will be the DaVinci platform
> > for which we want to probe the pll, psc and timer drivers early in the
> > boot sequence but keep them implemented as platform drivers.
> 
> Can we have early_paltform_driver() take a reference to the driver's
> of_match_table, and put that in a special section?
> 
> Then instead of looking for "earlydev", we look for any compatible
> string in that section. No magic string required in the DT, and we can
> always mess around with probe ordering in future.

Yes, this is pretty much exactly the change I had in mind.

Rich

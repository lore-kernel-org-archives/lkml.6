Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrvKuY4Tmw+QTX4tQ/zAMvGbkvTsxbP+O7e0Duy+0xwZiHzvO47hUbAhCDc6gBu0WKKgYe6
ARC-Seal: i=1; a=rsa-sha256; t=1526302093; cv=none;
        d=google.com; s=arc-20160816;
        b=xi/61u8aDurUszFVI5G7aw39cRgPAHcq+U/9dIsaUV8eZibqsuhIO2T8Yg4hhAolkz
         J9QVOEbbg09i05EcHMHWYCTpBx7HeQlA9MexHdVRnCzFhx6OKTVAQVy1FpWT/KAB5Rno
         v7NQbJ+c62Truq7L6TUiQKf6VFQfXWolJ0cdOK73cYs11qrT4O6+uY5RVztXl+Rg0vjP
         UJD+mO9dI7SF66BjbrBUAOkQYDCp9ftTpeGmMlgOyBf50PllM42f32rJMbzlgLQN0gN8
         A4+jT3Y4lS2E6faEBZs6FzxjgzJGajA68v/QRirQRFGh/488sacS3xEzkGqhWLgdFj4p
         erIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=O7KjCUOJdX55x3ohWccSCtkuaCMHKTNcJkwQwlq7pVE=;
        b=NPU2x6+S4QtlrPU61/SVTeN4vXlkW8yd0r/sG90YDNRqdSqNkDEhjy65juxCAINwQR
         8KYu67cmwCukXuh1wD1Dn/6tsW/PqN83/EcN8ol+4gnzpSZx5xdCBUPQeNsF9dk5or2t
         gTR4z0gOOH1Yy/ePpg2SMsmsQxuTz0yoMnaodSufACO8lB0fwI+gz1Of8pSd8JArWMCs
         QP7dqOKl+sHehbhmZ2aXudQmdAfT1NHDdEpK4S7yvxet1BAy1sR8JNltBavkbXXfwo7H
         b15FYRZuQeyFIboZl0U3DIszkfHNPEvaz0lr34EpPfH4gYqgjHduNizcPHojAUTc4i59
         Z/Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="41635000"
Message-ID: <f2109d06a0755dd2d9dc807c1e13dd2c19903905.camel@linux.intel.com>
Subject: Re: [PATCH v2] device property: Get rid of union aliasing
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-efi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki"
 <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date: Mon, 14 May 2018 15:48:09 +0300
In-Reply-To: <20180514121817.GA27869@wunner.de>
References: <20180508131547.44366-1-andriy.shevchenko@linux.intel.com>
	 <20180514121817.GA27869@wunner.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599901902158233534?=
X-GMAIL-MSGID: =?utf-8?q?1600443744229834588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-14 at 14:18 +0200, Lukas Wunner wrote:
> On Tue, May 08, 2018 at 04:15:47PM +0300, Andy Shevchenko wrote:
> > --- a/drivers/firmware/efi/apple-properties.c
> > +++ b/drivers/firmware/efi/apple-properties.c
> > @@ -13,6 +13,9 @@
> >   *
> >   * You should have received a copy of the GNU General Public
> > License
> >   * along with this program; if not, see <http://www.gnu.org/license
> > s/>.
> > + *
> > + * FIXME: The approach is still based on union aliasing and should
> > be
> > + * replaced by a proper resource provider.
> 
> Why?  All Apple EFI properties are either boolean or u8 arrays.
> You've correctly changed this file to always supply u8 arrays,
> so I don't see where union aliasing is happening here?

Okay, for now I can see only Thunderbolt user of these properties (is it
correct?) in upstream which uses u8 arrays indeed.

Though the implementation is quite fragile in this sense, because it
doesn't discourage people to use device_property_read_string() in case
when it's indeed a string (I saw these kind of properties in the very
dump you posted on your GH page).

So, I can agree that is "not happening _right_now_", but I can't agree
on the implementation robustness.

I can change a wording of the commit message and the FIXME, but _leave_
FIXME in place b/c of above.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

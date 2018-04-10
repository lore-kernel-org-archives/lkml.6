Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523365615; cv=none;
        d=google.com; s=arc-20160816;
        b=Tz7vY0szil31N8ODseXVfc8zXJFTirEjet5FW0LcmAQ0UutnDotm7Hyrs5vtKkt5/e
         EJTANltM66TCrtRs2KtOeZQ8FaZi7Fli2mPyOfUYlKNIlIDJMwdcG+E38b57FcTLMqJc
         DXEQhT2pyZElYDHLLr72lL0n10JsVDDFc+rg++wQC5b3t6jge7XCsqY/RwYADE1OLqDW
         eOWjiVTMK4bdl6AavJKy+wrId3D5ipd+CWBLT/Hy7HOJ9U2GD+423GUU+pP4MsICiEFK
         htgmy0e2oY6S+yP2monI+DZKMFBAL+GXKVUGiPpSVxk7mefF8WkbjQtyrd8unIHb/9Ek
         De1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=IMSEI2zjT3dOhRbTH9pAp/LGRoWu+ZXWp1AOd6o4Mas=;
        b=CezYZZAg2erdEALj1/T4tsrDfI9f6JaSxzYI4ipeBJBkQ0yIFTSZ+LxyxFPWrnv2hY
         QzCfHRvWP3qCUIoEhGt4nIvjI7qCzBZxxl4b59g72UZ85E4gjnPX8em3WjFmQKHyMb55
         JYIOzaq47SABG8dv5+inbxXeBsRUvShInw7L+saCiH0DgJXSVL4vqqoG/t63H1c4GYIO
         wAz6TVNQlSFE86px14uDag9vfEIVuoFzT/80+yLlO/4cq27lXW2hAlrqYNrC0Se53Sox
         M74uoSg49O/knhfGDSxTkespUfipP+OLPZ6rMne73eNJTa+n/+5aWjEY6qVCUgNIE5rw
         CCjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+MdmCKJsDYB5KozE/c2AIiJoEV26rNxNvgaV7FjL48YOodn+bbddvqL2+uLxY6UunY5+o8zQ==
Date: Tue, 10 Apr 2018 08:06:52 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: add unit converter
Message-ID: <20180410130652.d3kk3vo6p4524mid@rob-hp-laptop>
References: <20180403153635.8228-1-peda@axentia.se>
 <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
 <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739875121160497?=
X-GMAIL-MSGID: =?utf-8?q?1597364623048680501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 08:09:08PM +0200, Peter Rosin wrote:
> On 2018-04-03 19:41, Andrew F. Davis wrote:
> > On 04/03/2018 10:36 AM, Peter Rosin wrote:
> >> Hi!
> >>
> >> This driver implements support for voltage dividers and current
> >> sense circuits. It's pretty generic and should be easily adaptable
> >> to other linear scaling purposes...
> >>
> > 
> > I really like this idea, defining channel scaling / channel type
> > conversion in DT will be very useful. So much so that I would recommend
> > this not be a use specific driver but instead moved into the IIO core.
> > 
> > This would allow defining these channel conversions in the device node
> > itself, so as to not need a separate node just for the converter (the
> > conversion is not a device and probably should not have it's own node
> > anyway). It would also help with enabling this support for buffered
> > readers/writers and not just devices only supporting _raw reads/writes.
> 
> In my case, the voltage dividers and the current sense circuit are very
> much real, and I can point my finger at them on the board. Sure, they
> are not ICs, but to not call them devices is wrong IMHO, and the ADC
> which is involved have very little to do with the voltage dividers and
> the fact that it is involved in sensing current. This is not an argument
> for not moving the functionally to the core though, but that has some
> problems AFAICT. Because you need some kind of clever and generic
> binding to make the core do its thing, and it might not be easy to come
> up with something that fits all devices? And if we do put this in the
> core, that opens the door for more complex unit converters later on
> (non-linear etc), further complicating the generic bindings.

I agree. We've learned the hard way that even things like the LED diode 
itself need to be described and not just the controller.

Rob

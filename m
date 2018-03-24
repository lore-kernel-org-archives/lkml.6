Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELsqyuG+Jw65zspKrvGaJu3zxks9q5panTTh+0BVrxlUNUkVA/ct+Yuvin+8wimxM4VEfpuF
ARC-Seal: i=1; a=rsa-sha256; t=1521899287; cv=none;
        d=google.com; s=arc-20160816;
        b=xtNpNcjVQcpIbUfhEuqdaYOS0oHI8UCYci/Y3UxMsp0NrO9YcY9HQvF1ybFIT2xCHa
         skDTqPiKcyiTQqy4HN5ayER7okUFUUlca+RIvVvW4GQiGAetLwGzH+dLUIRn3O5j6K8K
         IpAcOA0x35D0GQmKJSJQj6c9jkcqBY43PGICxWeNar5CUfGMOeB9n9nC7sjeZVo0C+kp
         QET0iPMC+Aiiz+JDqGfCi/iBIkkux4gd+eFciv/3tWzpwC2cRJGpa7BRB22a9WBy433R
         ErRs8CM9WKTpooUOn4YryhXdJBQf7tQgsxhfzmI7Z86/aNieUwtiH4VKdov8/d1/tHjO
         +Yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=w+aXvYlDyfiyICqK3Uehp0VRYtheNIXyxhI3wme72VM=;
        b=v+IiOvHhSKlETeQvuns9JWcvcwB4777/2PslZb9cPsr++uVKTFSDgRiVRcHibkgtmQ
         KCcr2x7KjsWX7D4AL9ou2LuZo21RpVbf673JFUDpDykW4XuQVLGw79NkXqrai158uX+n
         f26HHqbTfdmUKOUElQWjkF4N6oCRoiuThS5sl7fd5nQwBAzH1zmYcIUBi/RIaTGHZyCA
         CH3CntI+bYnu3jTNJqSp/Ry1E5R88krvPhQ7yy5lL218k73/NN56dmULCqCMKNzsDWAQ
         rMfNSooOzIai2ShzPJawwrazkXjPyc8Z3rlhoKwKL/tq38WgG6vEjtR8bLPdv1upjzHq
         bG5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADEB21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:48:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "David
 S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: add unit converter
Message-ID: <20180324134801.0e6254ee@archlinux>
In-Reply-To: <0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
	<20180323141401.000031cc@huawei.com>
	<0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386339632135527?=
X-GMAIL-MSGID: =?utf-8?q?1595827067726796905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018 14:59:41 +0100
Peter Rosin <peda@axentia.se> wrote:

> On 2018-03-23 14:14, Jonathan Cameron wrote:
> > On Mon, 19 Mar 2018 18:02:43 +0100
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> Hi!
> >>
> >> This moves the iio-mux driver to a new category, since I think
> >> it will be the single driver in that category forever, and now
> >> I'm adding a new driver that is somewhat similar in nature...
> >>
> >> But that rename is not very interesting, it's just reshuffling.
> >> It's the new driver that I need. Specifically, I need to allow
> >> linear scaling and modification of the type of an io-channel.
> >> I don't know exactly how that is accomplished in the best way,
> >> but this is what I came up with.
> >>
> >> The use cases are an ADC hooked up to measure a "big" voltage by
> >> looking at the midpoint of a voltage divider, and an ADC used
> >> to measure the current by looking at the voltage over a resistor.
> >>
> >> Comments?  
> > It is pretty much how I would have implemented it as well.
> > 
> > Will probably do a detailed review over the weekend.
> > Not convinced entirely on the 'wrapper' naming though.
> > Will think about it...  
> 
> Yeah, let's put 'Wrapper' in the crapper. Not married to it.
> 
> Miscellaneous?
> 
> So, not super-happy about that either. And maybe leave the mux
> where it is? It's just that I have the feeling that the iio-mux
> is never going to get any friends in its category, and the mux
> and the unit-converter are kind of related in that they operate
> on other channels. But maybe that's only logical it you know how
> they are implemented...
Perhaps Analog Front ends?
We could move the amplifier driver into the same directory as well,
though right now that driver is not passing the channels through
(it's often used without there being an IIO ADC behind it I think...)

Jonathan


> 
> Cheers,
> Peter
> 
> > 
> > Jonathan
> >   
> >>
> >> Cheers,
> >> Peter
> >>
> >> Peter Rosin (3):
> >>   iio: rename the multiplexer category to wrapper
> >>   dt-bindings: iio: wrapper: add io-channel-unit-converter
> >>   iio: wrapper: unit-converter: new driver
> >>
> >>  .../{multiplexer => wrapper}/io-channel-mux.txt    |   0
> >>  .../iio/wrapper/io-channel-unit-converter.txt      |  84 +++++++
> >>  MAINTAINERS                                        |  11 +-
> >>  drivers/iio/Kconfig                                |   2 +-
> >>  drivers/iio/Makefile                               |   2 +-
> >>  drivers/iio/multiplexer/Makefile                   |   6 -
> >>  drivers/iio/{multiplexer => wrapper}/Kconfig       |  13 +-
> >>  drivers/iio/wrapper/Makefile                       |   7 +
> >>  drivers/iio/{multiplexer => wrapper}/iio-mux.c     |   0
> >>  drivers/iio/wrapper/iio-unit-converter.c           | 268 +++++++++++++++++++++
> >>  10 files changed, 381 insertions(+), 12 deletions(-)
> >>  rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
> >>  delete mode 100644 drivers/iio/multiplexer/Makefile
> >>  rename drivers/iio/{multiplexer => wrapper}/Kconfig (53%)
> >>  create mode 100644 drivers/iio/wrapper/Makefile
> >>  rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)
> >>  create mode 100644 drivers/iio/wrapper/iio-unit-converter.c
> >>  
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

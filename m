Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x227UF5gZhsS/HLyEcGdWNOQrVZU9tPImvccO89m7RVfbSVKrODSZK52s3rDDW9JM7a8uXalM
ARC-Seal: i=1; a=rsa-sha256; t=1519668543; cv=none;
        d=google.com; s=arc-20160816;
        b=qAXj6XhC5cCT+f7Gs7t2Tscc0CjI4VNDfj0nXEKXxAwwrKT5F+eLkaGy6BUWOuB3qO
         dRs1VRHF1FebQgq1rnhpEEJefyCuHVS5i2TdrIvZLXhYUqklkVhjKgaV1xf9GyiVmKd5
         iWnesPBVhD+glsfJnytuH4opTgRbHTwo5UDUDgnbhgmFyc5ZCSjGEqXdYVSBGBJNqPlI
         kido1MExLiufCbkBKHlJZc39oyr60N2adnlPVOUV1VAcPlXRpmb3QC5Zs49e/Zv33zBv
         5vDWrffpsCIbI4K2XuKLsWphUQOe4MluUokdjkHibVvEO4oT8FH9Qu3w3tlFzw8w2t31
         iyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=gQ+bSdzrHsgZ0tPvjjsHpc9TV5ndIQvweVeCeN75T3Y=;
        b=N3QMVh2yCC4bkJDTxBzAkVfbR5PXetg2PNCRF7KPqOAmhpJfHZKaVA8lQ78tp7p9pG
         j59vEW8zo11MvwNHPqOBWrlskjy8FUuoRhumnpQONQtSnQqVfS39jkPc6tspjHLyZ6eB
         w9HRAjSGTR/9DV/9qlkCQLb1pbraPProSNsNM5FpZDaISnhbPFtT4H+Qf+HSZPqQQOlS
         1tTYfZcFc91LtWVoFxKLAfnELf2cN3rQM3+BbJ0Li0zlVxJpTBHOCLEBoI4EmbTVxdXw
         OW8rlqc6GWPouoODe62J9Uvlhrv1/xvBNXJZfRXpfBAMMhwr24/mzNg3LC2+ftSw3eQT
         KFIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9319C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 26 Feb 2018 12:09:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>, kishon@ti.com,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180226180901.GB25159@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-3-niklas.cassel@axis.com>
 <20180226172618.GA26815@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226172618.GA26815@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591836133225578402?=
X-GMAIL-MSGID: =?utf-8?q?1593487962559392232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 05:26:18PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 08, 2018 at 01:33:45PM +0100, Niklas Cassel wrote:
> > A 64-bit BAR uses the succeeding BAR for the upper bits,
> > so we cannot simply call pci_ioremap_bar() on every single BAR.
> > 
> > Ignore BARs that does not have a valid resource length.
> > 
> > pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> > pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> > pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR1
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR3
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR5
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> > Lorenzo/Bjorn: pci_resource_len() seems to fix my problem,
> > but is it the correct function to use here?
> > If BAR[x] is a 64-bit BAR, I'm assuming that pci_resource_len() on BAR[x+1]
> > will always return 0 (since BAR[x+1] cannot have any prefetchable/type bits
> > when BAR[x] is 64-bit).
> > 
> >  drivers/misc/pci_endpoint_test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 320276f42653..3af31bfdcfdd 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -534,6 +534,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> >  	}
> >  
> >  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> > +		if (pci_resource_len(pdev, bar) == 0)
> > +			continue;
> 
> Should not it be handled by checking the resource flags as you loop
> through the bar counter and incrementing the bar counter (+1) if
> IORESOURCE_MEM_64 is detected ?

I agree, pci_resource_len() is the wrong thing here.  The length
(actually the entire resource[x]) *should* be zero if the slot
corresponds to the upper bits of a 64-bit BAR, but I think it would be
more natural to do this:

  if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
    base = pci_ioremap_bar(pdev, bar);

You *could* check for IORESOURCE_MEM_64 and increment "bar" if you
find it, but I don't think that's really idiomatic, and it builds in a
little bit of unnecessary knowledge about how the PCI core maps BAR
registers to the resource[] array.

> >  		base = pci_ioremap_bar(pdev, bar);
> >  		if (!base) {
> >  			dev_err(dev, "failed to read BAR%d\n", bar);
> > -- 
> > 2.14.2
> > 

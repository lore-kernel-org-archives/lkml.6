Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524123836; cv=none;
        d=google.com; s=arc-20160816;
        b=M9ZSEk8GXnYVad7HMZgix0umsZGt72X6c7fVI1jP21oTkCbI9sJvRqyMEmq/X1sFt2
         pbsQFOa/UtYdCzhhGHwkaI6sA+SXxz+yaQb9GOyTEGL5FqFhrtk7sPFf4OebrQi1Gi1q
         MqMFXiBBRO1T9iZXjF8lgDMQiRKtjb9iDMjvbbvMRGg7augMC+ti6k97AIVLToLSj0eC
         PDLLq052aXXSL5JVoHIGpwg3ms4D+zYa70vzb27FHMOzbGLesCJaFdE+Tojdkq/6R6/z
         OPrwUOnxOiumiAvH2IaEfgg93oFFgKszE2ut9cwSq5+pzO8y1vooT48Z+Ux9567/5Mh1
         ZKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=QJV0Nj96oC/7oV4ow1zqHO75VfxDidejcs7C8HNfu4E=;
        b=KObQJ7KBxbUv5xpWIKDVcH8SNaTd/nzedMYsL6r0u3178c4VMY2iHDumI/I3kpRSWE
         0Mm+vDNxmbvvdB0OrrkiYBnze7TWXUZ509nGa/XX7tUdkODzHHn8+uX02sLvzGYdaOL0
         KYFo4jExeS0iI3ttDCqEpRhLqZzwRRfKZxZaWtIK7D5UYZKY7rrOXZwBDtxN27ywJWLi
         Ap++PAc43yHWPhXYYsQcoNn8YWd+907M8YPCR4+1eWFUJ2x+4bYlrzmtflZT6QVeBIp4
         M7lisEoI238XxjD/h87WACvEQ8fwDWc7Guvy54Ie1R3Yh10gZleFGADG0UOkxSW8g8NP
         4b1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=skRvSRvv;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=skRvSRvv;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx4+YEXKa/sHSElISOyw0VXA57lvYOnHC3V5za0WbT/cFGh1SMkfdOBWE1VkEcwEY4qYXOos5lw==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Thu, 19 Apr 2018 09:43:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Johan Hovold <johan@kernel.org>, Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Kishon Vijay Abraham I <kishon@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB: musb: dsps: phy fix and DT-topology support
Message-ID: <20180419074353.GK9198@localhost>
References: <20180413151505.32663-1-johan@kernel.org>
 <CAFBinCBYvi2RXEujcc-mKHq0iROeEThGaCe7ca_S-nWbkC3ttw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBYvi2RXEujcc-mKHq0iROeEThGaCe7ca_S-nWbkC3ttw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597644614233253974?=
X-GMAIL-MSGID: =?utf-8?q?1598159676152667980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 09:18:30PM +0200, Martin Blumenstingl wrote:
> Hi Johan,
> 
> On Fri, Apr 13, 2018 at 5:15 PM, Johan Hovold <johan@kernel.org> wrote:
> > I've been carrying a patch out-of-tree since my work on improving the
> > USB device-tree support which is needed to be able to describe USB
> > topologies for musb based controllers.
> >
> > This patch, which associates the platform controller device with the
> > glue device device-tree node, did not play well with the recent changes
> > which added generic phy support to USB core however.
> I'm the one who added this
> 
> > Like the recent dwc2 regression fixed by Arnd after the device-tree
> > #phy-cell changes, the generic phy code in USB core can now also fail
> > indefinitly with -EPROBE_DEFER when the controller uses a legacy USB
> > phy.
> >
> > The second patch addresses this for musb, which handles its own (legacy
> > and generic) phys, but something more may possibly now be needed for
> > other platforms with legacy phys.
> I'm not sure if I understand the problem yet - could you please
> explain with your words what "legacy PHYs" are and how the "conflict"
> with the PHY handling in USB core?
> 
> I am aware of two PHY subsystems:
> - drivers/phy
> -- also called "generic PHY framework"
> -- uses a "phys" property

Right, and these are sometimes referred to as generic PHYs, as opposed
to...

> - drivers/usb/phy
> -- also called "USB PHY framework"
> -- AFAIK this should not be used for new drivers

...the legacy ones.

> -- uses an "usb-phy" property

This is unfortunately not always the case however; some legacy USB phys
are also referred to using a "phys" property...

> the new PHY handling in USB core only parses the "phys" property and
> thus should not conflict with "usb-phy" (the legacy property)

> however, I probably missed something so I'd appreciate an explanation
> how things can break

...and that is the problem. Specifically, since last fall when a number
of legacy-phy nodes had a #phy-cells property added to them (to silence
DTC warnings), the generic PHY subsubsystem can now return -EPROBE_DEFER
indefinitely when looking up a phy as it finds a matching device-tree
node, but for which there will never be a generic phy registered (since
it's handled by a legacy-phy driver).

I referred to Arnd's workaround for "usb-nop-xceiv" devices

	b7563e2796f8 ("phy: work around 'phys' references to
	usb-nop-xceiv devices")

which has some more background on this.

So if we have any other host controllers out there using
"phys"-properties with legacy phys other than "usb-nop-xceiv", then
these will now fail to register (with -EPROBE_DEFER) unless
hcd->skip_phy_initialization is set (or we blacklist them as well in the
generic phy code).

I'm not aware of any further examples, but we're sure to find out soon
enough if there are.

Perhaps we should blacklist also "ti,am335x-usb-phy" in the generic phy
code even if hcd->skip_phy_initialization is still needed for musb for
the time being anyway.

Johan

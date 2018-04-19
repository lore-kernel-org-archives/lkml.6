Return-Path: <martin.blumenstingl@googlemail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524174885; cv=none;
        d=google.com; s=arc-20160816;
        b=S8PeEmGB3MOiTMGmLqJbX9U4TwD6AtSS+/Pu5qHoZyYbInKegrNGL8fpUsiCCJqWFy
         UA/SH3sg7ZhNcQ1ul/J0RyZOGq3sESMVRB+NsyiiQcOzFz0dZPaaiw7AlaDPEZrM5l+f
         v/MzwPJsvJfGrYHCmIDFvGYaFcVa+Vf25d5A3nmgiFW4MMDkQBXJpOOz6ThmUsoVXUTP
         grDdYiCAUHz1YFe7PJ9cjYxPnaPSyg2TlcPOHD/UW3/1C0kFS9wcTHe6qphHzxHL5e/z
         jljGabTrwvinftByaVOX8oc2LEtU2CM4DsQWi6yGU/lMWAMcCI6gVwa+jXTEdvnpJjgw
         TcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LVVS4nqvFsky5W9JMiawxXlysB1Ls57jne/mRXGOg3M=;
        b=RQHx0eBfCBXDIqR0ihoBb6sg/KQW35T6eU321Fj9tsKgOb6XwO8UuQvQPJlrE4/l+T
         p5yRqSmVISiPeJobbsh1dr8VL87+tHbGY0mdg6ds2YdMvzGIJo9JlfjD67YbkmMeD974
         0ktptETv908Dov1ggEQzMTfX8gQoxG7UFhmp30nnFgKb2z0zErcsE8Fgvj0eqpFpIJR3
         UlAmpjxX1z46twC392LBwEq+jGGDEcUdEL2W08iacpCKa0mkq4ifvuEDQKq87muODAiA
         CM71GVIexiwS1NywjueU1/7Rs/0E0lFXBaxkE2uH21uaNJJwoMBzlVvxZ9n1iPCPNgnT
         Ne+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@googlemail.com header.s=20161025 header.b=Ih1s3Cb1;
       spf=pass (google.com: domain of martin.blumenstingl@googlemail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=martin.blumenstingl@googlemail.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=googlemail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlemail.com header.s=20161025 header.b=Ih1s3Cb1;
       spf=pass (google.com: domain of martin.blumenstingl@googlemail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=martin.blumenstingl@googlemail.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=googlemail.com
X-Google-Smtp-Source: AIpwx4+ltTVCTLKL7VLuqx+ACqN4/1Ssi1cCKBt7CA5WPhkrqhFtZUTC69JToz30nc8xl+NSp16kjIROwVOQhmCrG8M=
MIME-Version: 1.0
In-Reply-To: <20180419074353.GK9198@localhost>
References: <20180413151505.32663-1-johan@kernel.org> <CAFBinCBYvi2RXEujcc-mKHq0iROeEThGaCe7ca_S-nWbkC3ttw@mail.gmail.com>
 <20180419074353.GK9198@localhost>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 19 Apr 2018 23:54:24 +0200
Message-ID: <CAFBinCANBwtaqKuRMWb4GRAv6OCP4yLr-93h6qHkZ858--Bo_A@mail.gmail.com>
Subject: Re: [PATCH 0/3] USB: musb: dsps: phy fix and DT-topology support
To: Johan Hovold <johan@kernel.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>, Arnd Bergmann <arnd@arndb.de>,
	Kishon Vijay Abraham I <kishon@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597644614233253974?=
X-GMAIL-MSGID: =?utf-8?q?1598213204947320777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Johan,

On Thu, Apr 19, 2018 at 9:43 AM, Johan Hovold <johan@kernel.org> wrote:
> On Wed, Apr 18, 2018 at 09:18:30PM +0200, Martin Blumenstingl wrote:
>> Hi Johan,
>>
>> On Fri, Apr 13, 2018 at 5:15 PM, Johan Hovold <johan@kernel.org> wrote:
>> > I've been carrying a patch out-of-tree since my work on improving the
>> > USB device-tree support which is needed to be able to describe USB
>> > topologies for musb based controllers.
>> >
>> > This patch, which associates the platform controller device with the
>> > glue device device-tree node, did not play well with the recent changes
>> > which added generic phy support to USB core however.
>> I'm the one who added this
>>
>> > Like the recent dwc2 regression fixed by Arnd after the device-tree
>> > #phy-cell changes, the generic phy code in USB core can now also fail
>> > indefinitly with -EPROBE_DEFER when the controller uses a legacy USB
>> > phy.
>> >
>> > The second patch addresses this for musb, which handles its own (legacy
>> > and generic) phys, but something more may possibly now be needed for
>> > other platforms with legacy phys.
>> I'm not sure if I understand the problem yet - could you please
>> explain with your words what "legacy PHYs" are and how the "conflict"
>> with the PHY handling in USB core?
>>
>> I am aware of two PHY subsystems:
>> - drivers/phy
>> -- also called "generic PHY framework"
>> -- uses a "phys" property
>
> Right, and these are sometimes referred to as generic PHYs, as opposed
> to...
>
>> - drivers/usb/phy
>> -- also called "USB PHY framework"
>> -- AFAIK this should not be used for new drivers
>
> ...the legacy ones.
>
>> -- uses an "usb-phy" property
>
> This is unfortunately not always the case however; some legacy USB phys
> are also referred to using a "phys" property...
oh, I was not aware of that. this explains the issue you're seeing...
thank you for the explanation!

>> the new PHY handling in USB core only parses the "phys" property and
>> thus should not conflict with "usb-phy" (the legacy property)
>
>> however, I probably missed something so I'd appreciate an explanation
>> how things can break
>
> ...and that is the problem. Specifically, since last fall when a number
> of legacy-phy nodes had a #phy-cells property added to them (to silence
> DTC warnings), the generic PHY subsubsystem can now return -EPROBE_DEFER
> indefinitely when looking up a phy as it finds a matching device-tree
> node, but for which there will never be a generic phy registered (since
> it's handled by a legacy-phy driver).
>
> I referred to Arnd's workaround for "usb-nop-xceiv" devices
>
>         b7563e2796f8 ("phy: work around 'phys' references to
>         usb-nop-xceiv devices")
>
> which has some more background on this.
thank you for this pointer too

> So if we have any other host controllers out there using
> "phys"-properties with legacy phys other than "usb-nop-xceiv", then
> these will now fail to register (with -EPROBE_DEFER) unless
> hcd->skip_phy_initialization is set (or we blacklist them as well in the
> generic phy code).
>
> I'm not aware of any further examples, but we're sure to find out soon
> enough if there are.
>
> Perhaps we should blacklist also "ti,am335x-usb-phy" in the generic phy
> code even if hcd->skip_phy_initialization is still needed for musb for
> the time being anyway.
>
> Johan


Regards
Martin

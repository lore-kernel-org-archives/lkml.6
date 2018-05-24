Return-Path: <stern+5b0af0d8@rowland.harvard.edu>
X-Google-Smtp-Source: ADUXVKJwxMDjqqRiLHKVxgbuEBVwBpAPg/hdNMhKboYc3LjbJ7xxLs7o6y39iTQiuU2+Kt5lNb6Q
ARC-Seal: i=1; a=rsa-sha256; t=1527172195; cv=none;
        d=google.com; s=arc-20160816;
        b=HRdsG+iSdqGBkHvzinqHMTe0zICGfqLoWE1GB82rSddsjc0TWAjD87DkGbtYLdc6e3
         fPr4Fyh0RAVYxgcj+irMZ88BEu7tKUsh5oD7gwF3NrcPBSwCCP/L9Dm+MtVRwXwqgTEK
         CV5VpxrM8TETWl0hJQ9oSrWkbRfKfnA02DpdFlm0Ji0uhdS2l0ghb/selg6Kz3zPlaUJ
         al34/go6QbgZxrpCojK1JNFjmiMuiA5BFZFw7ZxMNgXNg7k+QhtkRUUeNhVwVLMc7trC
         VgrjmKG6S1oy4mArcxVEk5rS/UvLG6VBc0dHOLWIl+VoOopyQR2WSS5sL0aGMp+dTD9b
         cWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=cbuRQIUmgT6n+PQLJFxypK9qEkte/wPVUjr35ge5Mjo=;
        b=wKb7z/GRFGADRmiuFxGi87CccBLOIdL99R+llFO8TjeOvHW6vEr1a3jYRoWKz4QSa5
         EvKpaNr/wd8kjeUlIunAIRZOU5nYHQxousWl7jBZKApTNUPKbYgokNACCuqnGrih9t+G
         mt3IgyFrsJcq3jMlscEQRpxTAaqoKM3dwjwXzMLFAEYvKf8fHpNUGlphRfvK8Eurqnhv
         S8aEtpH6yV2nLLJv8LxWkzrJQUopDf0m0nvoE1cXe7HX3xqghU+Piy7i5KTPZKnz5qRx
         1ebsoyyzp+KKEuIrJLTMgL9gXSrACj+yIJc7YnuYE6B2Lu/33C/Esm865CQa3DspGrRe
         W7VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5b0af0d8@rowland.harvard.edu) smtp.mailfrom=stern+5b0af0d8@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5b0af0d8@rowland.harvard.edu) smtp.mailfrom=stern+5b0af0d8@rowland.harvard.edu
Date: Thu, 24 May 2018 10:29:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Nicolas Boichat <drinkcat@chromium.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
     <linux-usb@vger.kernel.org>,
    Mathias Nyman <mathias.nyman@linux.intel.com>,
    Felipe Balbi <felipe.balbi@linux.intel.com>,
    Eugene Korenevsky <ekorenevsky@gmail.com>, Peter Chen <peter.chen@nxp.com>,
    Daniel Drake <drake@endlessm.com>, Joe Perches <joe@perches.com>,
    Johan Hovold <johan@kernel.org>,
    Richard Leitner <richard.leitner@skidata.com>,
    lkml <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] usb: hub: Per-port setting to use old enumeration scheme
In-Reply-To: <CANMq1KD8SpPQ7UTy2wN0J84dsA86Skmbb5q0OjkG+-BZShiv-A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1805241018420.1871-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601219430844559036?=
X-GMAIL-MSGID: =?utf-8?q?1601356112116072259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 24 May 2018, Nicolas Boichat wrote:

> On Thu, May 24, 2018 at 12:39 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, May 23, 2018 at 10:03:55AM -0400, Alan Stern wrote:
> >> On Wed, 23 May 2018, Nicolas Boichat wrote:
> >>
> >> > The "old" enumeration scheme is considerably faster (it takes
> >> > ~294ms instead of ~439ms to get the descriptor).
> >> >
> >> > It is currently only possible to use the old scheme globally
> >> > (/sys/module/usbcore/parameters/old_scheme_first), which is not
> >> > desirable as the new scheme was introduced to increase compatibility
> >> > with more devices.
> >> >
> >> > However, in our case, we care about time-to-active for a specific
> >> > USB device (which we make the firmware for), on a specific port
> >> > (that is pogo-pin based: not a standard USB port). This new
> >> > sysfs option makes it possible to use the old scheme on a single
> >> > port only.
> >> >
> >> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >> > ---
> >> >
> >> > There are other "quirks" that we could add to reduce further
> >> > enumeration time (e.g. reduce USB debounce time, reduce TRSTRCY
> >> > to 10ms instead of 50ms as used currently), but the logic is quite
> >> > similar, so it'd be good to have this reviewed first.
> >>
> >> I'm not opposed to the idea in principle, although I don't like your
> >> implementation because it breaks the original old_scheme_first
> >> parameter.
> 
> I don't think it breaks the original parameter? I mean,
> /sys/module/usbcore/parameters/old_scheme_first is still a global
> default, while bit 0 of /sys/bus/usb/devices/x/y/z/quirks becomes a
> port-specific override.

Oops, sorry, my mistake.  My email client wrapped the last line of
use_new_scheme(), and as a result I missed the fact that
old_scheme_first was getting or'ed into the expression.

> >> How do you arrange to set the new quirk before the device is
> >> discovered?
> >
> > Yeah, this last question is what I had when looking at this.  Or does it
> > not matter at first boot and only matters for wake-up?
> 
> It does not matter on boot, we have plenty of time to enumerate the
> device. We use USB (auto-)suspend and remote wake, so no
> re-enumeration there either. It only matters on unplug/replug where
> the device needs to be re-enumerated.
> 
> Somewhere in an init script, we would do this (we know in advance that
> usb1 port2 is the bus/port where we have our pogo-pin USB interface,
> so we can hard-code the path):
> echo 1 > /sys/bus/usb/devices/usb1/1-0:1.0/usb1-port2/quirks
> 
> We could try to add ACPI support (just like connect_type), but we
> don't strictly need it for our application.

Okay, that makes sense.  So this change looks okay to me.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

Return-Path: <stern+5b0af0d8@rowland.harvard.edu>
X-Google-Smtp-Source: ADUXVKKNDnAg88DHF7o6uAX31iQNKi7dVse6QLrSiRaGZtg94P4xY9RVCB8hGqJ4ajat7j+Xq8Pm
ARC-Seal: i=1; a=rsa-sha256; t=1527084236; cv=none;
        d=google.com; s=arc-20160816;
        b=J8dRDovtt50ayIW/H11Wvf24d5AixiGnWWCHKsc4s6aLDeoIePg7Oobui4Ewhnw0Nf
         LrdsKZpldXqnSxLIvxGlw+F3CX5QNylxvufy6IsjSvydwbYpLkffNWKlMUw7a3XRowHG
         V2cAOzXqAjZvTYVaGIGaDPd4SFIEwq9UfQhp10VUQA2le/18BpNZ7wGVAlSK0v1Tpgur
         6pPcsgwwuBddR2FmWlqdyvcGQHTJOY9jwHKIlE9pwy8x/skRHyrmsQpiKRN++R0bG5Jl
         9Je1yBI2JGY70IkdgdKYVSDvSjnfKw3Q4b/hONchhGzo5zGxPxLukcPkVZNXpX2ndUnH
         IgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=xEo8XdlxQ8ZKFiRU75HEJJofIrjMEDJstBvxAukuDV4=;
        b=SNwwPmY+nQ/07t5tBy7tOLA22zgte5o5ibDXthp7V9JahwJrpblYzoCIyBkLEMZaJJ
         u4F+joffSTnhyaRG3752L2f5ebFD/Sz8rpCMqMoQ+LGlLCLON9EeUT/nV3EZ6SnC0M/Q
         79AhxhUhMht0hypuwGDizPfAg+ifEQKyLaVwOr/QPIWhrLkIcX7JeBYZ0VdLfw5m4PmZ
         L2Ekw45MveC2OI0vH+udPc0NWQlXc02l49EWwAVoD/dFTFPwN3ibzBCk3F4f69DmbGjh
         PNwUtoWTMCZ7/7SlLSSQ/uZjgS1ChSzAkeSWL5eL1b77PJOn+qFSd1XvHINVuRMTOVXB
         pCAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5b0af0d8@rowland.harvard.edu) smtp.mailfrom=stern+5b0af0d8@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5b0af0d8@rowland.harvard.edu) smtp.mailfrom=stern+5b0af0d8@rowland.harvard.edu
Date: Wed, 23 May 2018 10:03:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Nicolas Boichat <drinkcat@chromium.org>
cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Mathias Nyman <mathias.nyman@linux.intel.com>,
    Felipe Balbi <felipe.balbi@linux.intel.com>,
    Eugene Korenevsky <ekorenevsky@gmail.com>, Peter Chen <peter.chen@nxp.com>,
    Daniel Drake <drake@endlessm.com>, Joe Perches <joe@perches.com>,
    Johan Hovold <johan@kernel.org>,
    Richard Leitner <richard.leitner@skidata.com>,
     <linux-kernel@vger.kernel.org>,  <groeck@chromium.org>
Subject: Re: [PATCH] usb: hub: Per-port setting to use old enumeration scheme
In-Reply-To: <20180523021656.122455-1-drinkcat@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1805230958590.1481-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601219430844559036?=
X-GMAIL-MSGID: =?utf-8?q?1601263880362754322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 23 May 2018, Nicolas Boichat wrote:

> The "old" enumeration scheme is considerably faster (it takes
> ~294ms instead of ~439ms to get the descriptor).
> 
> It is currently only possible to use the old scheme globally
> (/sys/module/usbcore/parameters/old_scheme_first), which is not
> desirable as the new scheme was introduced to increase compatibility
> with more devices.
> 
> However, in our case, we care about time-to-active for a specific
> USB device (which we make the firmware for), on a specific port
> (that is pogo-pin based: not a standard USB port). This new
> sysfs option makes it possible to use the old scheme on a single
> port only.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> There are other "quirks" that we could add to reduce further
> enumeration time (e.g. reduce USB debounce time, reduce TRSTRCY
> to 10ms instead of 50ms as used currently), but the logic is quite
> similar, so it'd be good to have this reviewed first.

I'm not opposed to the idea in principle, although I don't like your
implementation because it breaks the original old_scheme_first
parameter.

Let's see what some other people think.

Yours is a rather special case, because you know exactly what device
will be attached to a specific port.  Still, I can see that sort of
thing happening in constrained and special-purpose settings.

How do you arrange to set the new quirk before the device is 
discovered?

Alan Stern

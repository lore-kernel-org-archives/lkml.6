Return-Path: <benh@kernel.crashing.org>
X-Google-Smtp-Source: AIpwx48YMjID5OV83OIe4BWB1BGEMS+qT+fZ/+X1uicjs2kc3XMXf1tE4H+k/8k8+Hj6+RXuzbEq
ARC-Seal: i=1; a=rsa-sha256; t=1523365084; cv=none;
        d=google.com; s=arc-20160816;
        b=nLXwtUYP9CctjWlrWzfbkFuLW4uYlyDCxRW8IS/wXGaMZP7mg+NBkQIFXhdHhrkCLG
         hbHoHLns8WBhFANAY3AKWjXR1jJuulDmM4qIYfPuF0MRHnbR3q5NoaYNZmYRMsOjEKJw
         +RZRTBz/cBshDiodezczZ9DMKpwcnNOxyiYy4UQSoDgYdSNI3yr1PD8MYdRY6J1CxMUA
         2ymRPv7EJhiVjtrlcSCyQTMDsPQQD+Tz3g26bzZtpQiIhieBGm7XuB2une3xBJ6RioyX
         g3b4175D0i+S4HUQ33meB3s6Q9okLLdLPPTscDftd/Qd87AOQq/s0Yg1CLqv8Md2dmz2
         A6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=z7wIKaU+Zg6SDy90UF7N9aQ5YDl2HKOTaABPQ2p9x98=;
        b=0S13mMv6xqtoEJEp0iXTXVzCgFug8m90cWJKeOqveRkva3DmFx/lU9mvWkNn62jtcX
         xqohbatDHLWbuSbKuPwDNUq09AOXF9ktqOSzWOXapB3IzDb9kEWrxJkeBmMQiBD4GSQv
         OmpvyRl9igX9FiiCylpLrQpgP0XaIKLoHgDxI/1G1VYE3Q3L9pVa3VNDBXTlDndCVBLh
         UUl5Pa0QsI4fdpb0Lh3q82U6sng5PvCnMuCKp1imm1XvDwJJrGcg9RVJYjOXZXYg31Zw
         jv8md1sqUEl6K43HBdELM4Ir+ZA6g/UE/Dmkc/pz14xILQik09wD3MkkPFKsCInSD0fj
         dTuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of benh@kernel.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=benh@kernel.crashing.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of benh@kernel.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=benh@kernel.crashing.org
Message-ID: <1523365055.11062.95.camel@kernel.crashing.org>
Subject: Re: How to expose various BMC chip controls ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew
 Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel.stanley@au1.ibm.com>,
        Jeremy
 Kerr <jeremy.kerr@au1.ibm.com>
Date: Tue, 10 Apr 2018 22:57:35 +1000
In-Reply-To: <CAK8P3a2rC3jymPDJbpxsYZRYMAcSJy6zXjYrxKPHrGxj63vBtg@mail.gmail.com>
References: <1523351850.11062.80.camel@kernel.crashing.org>
	 <CAK8P3a2rC3jymPDJbpxsYZRYMAcSJy6zXjYrxKPHrGxj63vBtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597350209516531918?=
X-GMAIL-MSGID: =?utf-8?q?1597364067151201071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-10 at 13:29 +0200, Arnd Bergmann wrote:

> > Any better idea ? It's a fairly simple problem, and the above solution
> > would be very little code, but I just don't want us to go down a rabbit
> > hole if some of you have religious objections to some of it :)
> 
> I think the hard part is finding the right balance: traditionally, these
> kinds of systems used ad-hoc interfaces like /dev/mem or random
> kernel interfaces to do both very generic and very non-generic
> thigns.

Right. This is always the question, and for a bunch of things we *have*
used either generic interfaces or specialized drivers. There's an open
ended issue with our mailbox driver since we don't use the mailbox
framework, which we need to resolve, but otherwise, we are keen on
using existing interfaces when one exists.

> The initial reaction you get when posting a patch that adds
> an ad-hoc interface will (should?) always be a question of "can
> this be done using a generic interface?", but that doesn't mean
> that the answer is always "yes", we just need to come up with
> ideas of how that interface would look like and figure out together
> if it's actually worth it or not.

So I listed a few examples, I think Joel and Andrew can come up with a
few mores. These things, mostly because they control host-visible
things rather than BMC-visible things tend to simply not fit in
existing interfaces.

They are also sufficiently platform *and* BMC type specific that they
wouldn't fit into some kind of generic "BMC controls" driver either I
suspect.

Basically, what we need a set of named "knobs" that the BMC userspace
code can tweak based on policies set by a given system vendor and the
interactions between their BMC implementation (including OpenBMC
variant) and their BIOS/Firmware.

> In the cases where an ad-hoc interface is needed, I can see
> two options: we can stick something in drivers/soc that exposes
> it in the least ugly way, completely specific to that particular
> SoC, or we can create a new subsystem from "random BMC
> slave-side interfaces" and have it maintained by you all (leave
> me out of the picture, except if you are looking for ideas).

I don't think there enough commonality in these things to create a "BMC
slave interface" class that is anything other than a bunch of sysfs
files.

That's why I ended up with my personal conclusion/preference of just
having the syscon "driver" for the SoC just expose a table of a dozen
or so such knobs, and use the DT to describe them to abstract a bit the
difference between SoC models/revisions and how they are wired up in a
given platform.

> In any case, I think it makes most sense to discuss new interfaces
> between the people working on the competing BMC implementations,
> mainly to see if some functionality can be abstracted in a common
> way or not.

So we have some ideas of what competing BMC *chip* vendors do since
OpenBMC people communicates with other vendors.

We know a lot less about BMC SW stacks, but those are a rat nest of
closed source & GPL stuff that doesn't get upstream (or even released
sometimes ... ahem ...). Having had access to some vendor code in the
past, I can tell you that you really don't want to look at what's going
on in there ;-)

Now, lets be clear, these is really for a few (we hope maybe a handful
or two as described in my examples) knobs that really don't fit
anywhere else. By their very nature they are very specific to a given
BMC HW implementation.

>  I believe you are already working with the Nuvoton BMC
> people, but I don't know much about the others.

Nuvoton and Aspeed own the market as far as I know these days...

>  Is the
> Emulex/Broadcom/Aspeed "Pilot" BMC series used anywhere
> that you know of? 

I don't know.

> It seems that Renesas and TI are no longer
> active in this space, and that the big server vendors are either
> not running Linux (e.g. HP) on their BMC or they have their
> own software stack on the generic third-party BMCs (e.g. Dell).
> I think Huawei also has their own BMC hardware, but no idea
> what they run on it. Do you know of any others?

Nope. That said, I don't expect much commonality for this specific
problem.

Cheers,
Ben.

>        Arnd

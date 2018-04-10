Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523359795; cv=none;
        d=google.com; s=arc-20160816;
        b=Ulou9sZNRaGmjHnZhZk8/IZxHORbpA6wIEN0GS+0aGjQLWomr0wXI2h7389QuJsdKs
         aOULlZRDQzLxqYZ10bRbYgXex16egsbEu4Vuc4VdSIszUGqM69sfV/0p9O//Fkld67aw
         4xaAEMkfeFWrW33s5o0j/MLhtfaTdliSo+CthfiMvhyAfG0aojNaoqbhtsf7ZSnMLn4Z
         vaM0ZMmjRSQLiqw1tWi8uYyMn/Amz0ewV/3oVS/7PTkdo84Qjb089QBY/KeJPod2NuPA
         Httg81nO+zND656T+o0Afz978qjcnA1A5bwU6K67ttmlqL82wCIbyJXBpmiacPvCYc1R
         KS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ChYwAawOfAy+293pSM/nn03dlSeL66Y4eXNODbjUmTw=;
        b=OjtD7+5eVabypBRDdXRyBQiDABAB5aWOOjqteWdVjoovtywZCVrVQv5MUNyl523VtE
         N2KpAgi9eUnjuL8Za56WIKIep2rwYZQcoLGpBWrvpLj3dqxzzdqeUUsXGxs8wtShWVIa
         5KmLXyqb+6GNKTpc7upfKyBqvVS9U7NlUYxH+PzdmBwynTFnTm6dZy3Saq9P2iDXopyX
         PGEjVDOj+Wsy0h7strGQtzwKURZpy0m1eYIw1muPFGUowGjBxIenZXjrReuiJZjxN8iz
         oRlIdTi7XTFGFadjcQ6hs+rt/g3jOusDETCFF2vMhQ8DS2mzaEspPyZwZ8dfR+zBWDgn
         KI3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f+NQ0Gxd;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f+NQ0Gxd;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx4/cfcXZmgZvzkPfDZe0CIIUmQX/NVG1SAnJ6DYX36dS6fz/yFYtquZB+mvh+5Nx6PaZs3RdWy8X14T+Xuzx+qk=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1523351850.11062.80.camel@kernel.crashing.org>
References: <1523351850.11062.80.camel@kernel.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Apr 2018 13:29:53 +0200
X-Google-Sender-Auth: GDu4WT8TQ5eRraj6staNQlo2cwM
Message-ID: <CAK8P3a2rC3jymPDJbpxsYZRYMAcSJy6zXjYrxKPHrGxj63vBtg@mail.gmail.com>
Subject: Re: How to expose various BMC chip controls ?
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
	Joel Stanley <joel.stanley@au1.ibm.com>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597350209516531918?=
X-GMAIL-MSGID: =?utf-8?q?1597358520833312251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:17 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi Folks !
>
> I would like to discuss something we need to solve for BMC chips before
> we start implementing a solution that you'll reject upstream :-)
>
> So quick recap: the BMC chip is the management controller of your
> server, typically some kind of specialized ARM SoC which controls a
> variety of things ranging from power supply, fans, inventory, flash, to
> having even a built-in GPU connected to the main server processor via
> PCIe etc...
>
> As part of the OpenBMC project, we have been contributing (along with
> others from Google etc...) a bunch of upstream drivers to support the
> BMC chips from Aspeed which are quite popular. There's work in progress
> to also upstream other vendor(s) chip support.
>
> For most things, we can write appropriate drivers.
>
> However, there's a range of things for which there is no good fit for
> dedicated per-function kernel drivers in the BMC:
>
> The BMC chips have a variety of control bits and pieces (registers)
> that affect the host in all sorts of ways. A few semi-random examples:
>
>  - Scratch registers that the host BIOS can read via LPC that contain
> system specific details of interest to the BIOS itself. The
> content/format is specific to a given BIOS <-> BMC userspace pair.
>
>  - Similar ones related to the built-in VGA (the one the host sees on
> PCIe, it doesn't appear as a device on the BMC side). Used to pass some
> wiring information to the VGA BIOS and the Linux driver among others.
>
>  - Bits controlling which parts of the BMC the host can access remotely
> via either LPC or PCIe. (Visibility of the VGA to the host, of the BMC
> PCIe system-controller device, opening of various windows from the host
> into the BMC address space etc...)
>
>  - ... and a few more
>
> Those things tend to be fairly system specific. Meaning that what's
> written in them (or read from them) and when it's written in these
> registers should be under userspace control on the BMC. There isn't
> necessarily many registers that need to be exposed that way, here too,
> which specific ones is rather system specific.
>
> But /dev/mem isn't a solution :-)
>
> So one simple idea I had, you tell me if it can fly, is to have some
> driver for the SoC as a whole (thinking of syscon here...) expose a
> selection of these things via sysfs.
>
> The list being potentially system specific, it would be provided to
> the kernel via the device-tree (binding tbd) where we would effectively
> provide a list of names, register offset, start bit, bitfield size.
>
> Any better idea ? It's a fairly simple problem, and the above solution
> would be very little code, but I just don't want us to go down a rabbit
> hole if some of you have religious objections to some of it :)

I think the hard part is finding the right balance: traditionally, these
kinds of systems used ad-hoc interfaces like /dev/mem or random
kernel interfaces to do both very generic and very non-generic
thigns.

The initial reaction you get when posting a patch that adds
an ad-hoc interface will (should?) always be a question of "can
this be done using a generic interface?", but that doesn't mean
that the answer is always "yes", we just need to come up with
ideas of how that interface would look like and figure out together
if it's actually worth it or not.

In the cases where an ad-hoc interface is needed, I can see
two options: we can stick something in drivers/soc that exposes
it in the least ugly way, completely specific to that particular
SoC, or we can create a new subsystem from "random BMC
slave-side interfaces" and have it maintained by you all (leave
me out of the picture, except if you are looking for ideas).

In any case, I think it makes most sense to discuss new interfaces
between the people working on the competing BMC implementations,
mainly to see if some functionality can be abstracted in a common
way or not. I believe you are already working with the Nuvoton BMC
people, but I don't know much about the others. Is the
Emulex/Broadcom/Aspeed "Pilot" BMC series used anywhere
that you know of? It seems that Renesas and TI are no longer
active in this space, and that the big server vendors are either
not running Linux (e.g. HP) on their BMC or they have their
own software stack on the generic third-party BMCs (e.g. Dell).
I think Huawei also has their own BMC hardware, but no idea
what they run on it. Do you know of any others?

       Arnd

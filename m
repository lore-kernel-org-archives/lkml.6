Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbeE3Wmv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:42:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:45445 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932289AbeE3Wmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:42:47 -0400
Message-ID: <58c1059a91b93a490a7fc8bda2112e67e6513840.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 0/7] i2c: Add FSI-attached I2C master algorithm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 31 May 2018 08:42:04 +1000
In-Reply-To: <CAHp75VerhOMCTPGz5b8wUNL611AdT1iutRm-wrHfzzT+_GbvWA@mail.gmail.com>
References: <1527714464-8642-1-git-send-email-eajames@linux.vnet.ibm.com>
         <CAHp75VerhOMCTPGz5b8wUNL611AdT1iutRm-wrHfzzT+_GbvWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 00:31 +0300, Andy Shevchenko wrote:
> On Thu, May 31, 2018 at 12:07 AM, Eddie James
> <eajames@linux.vnet.ibm.com> wrote:
> > This series adds an algorithm for an I2C master physically located on an FSI
> > slave device. The I2C master has multiple ports, each of which may be connected
> > to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
> > 
> > Due to the multi-port nature of the I2C master, the driver instantiates a new
> > I2C adapter for each port connected to a slave. The connected ports should be
> > defined in the device tree under the I2C master device.
> 
> I'll comment the series later, though you have to address previous
> comments first:
> - understand devm_ purpose and how it works

I think it is perfectly understood and I don't see what your problem
here is. So please be a proper civil human being an express your
concern precisely rather than with aggressive comments.

Now to clarify that specific point, devm purpose is to automatically
clean up the resources used by the device when it is torn down.

However, in this specific case, it makes sense to dispose of the port
structure explicitly because this is a failure in registering an
individual port which doesn't lead to a failure of the entire driver.

Thus not freeing it means the structure would remain allocated
uselessly until the whole driver is torn down.

> - understand list_for_each*() macros

This is a genuine misunderstanding of Eddies, I'm sure he will address
it, your tone however isn't appropriate.

> - discuss with maintainer a design of enumerating ports

I've been at that game for at least a good 2 decades. Maintainers
generally do *not* discuss design until a patch is proposed. I even
still try every now and then, maintainers are like lawyers, they don't
want to tell you what to do in case they still want to reject it after
seeing it later :-) I know I've been one of them for long enough.

If you have specific issues with how this is done, please express them
clearly. It's quite possible that there's some better way to do what
Eddie is doing here, but without *construtive* feedback this is
pointless. 

> - ... (whatever I forgot and others added) ...

I believe he addressed most of your comments. There is one mistake left
(the list_for_each) which will be easily fixed. As for the rest, it's
just ramblings unless you or Wolfram can propose a better alternative
in which case I'm sure Eddie will be happy to implement it.

I'm disappointed here because we have an example of somebody rather new
producing what is overall pretty damn good code, despite a few corner
issues, and being (again) treated like crap.

This isn't the right way to operate, and I believe this has been made
clear many times before.

Cheers,
Ben.

> > Changes since v7
> >  - Fix grammer in Kconfig (a -> an)
> >  - Change I2C registers to use BIT and GENMASK
> >  - Remove custom macros and use FIELD_PREP and FIELD_GET
> >  - Fix a few unecessary initializations and "return rc" that are always zero
> >  - Clean up the read/write fifo functions a bit
> >  - Few other clean-up items
> > 
> > Changes since v6
> >  - Remove spinlock for reset functionality; it's unecessary and doesn't work
> >    with the latest FSI core.
> >  - Use a mutex instead of a semaphore, and don't wait for timeout to get the
> >    lock.
> >  - Use usleeps instead of schedule_timeout; it's not worth the overhead when
> >    the wait should be very short in between sending the command and receiving
> >    the response.
> > 
> > Changes since v5
> >  - Fix reset functionality and do a reset after every transfer failure
> > 
> > Eddie James (7):
> >   dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
> >   i2c: Add FSI-attached I2C master algorithm
> >   i2c: fsi: Add port structures
> >   i2c: fsi: Add abort and hardware reset procedures
> >   i2c: fsi: Add transfer implementation
> >   i2c: fsi: Add I2C master locking
> >   i2c: fsi: Add bus recovery
> > 
> >  Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
> >  drivers/i2c/busses/Kconfig                        |  11 +
> >  drivers/i2c/busses/Makefile                       |   1 +
> >  drivers/i2c/busses/i2c-fsi.c                      | 722 ++++++++++++++++++++++
> >  4 files changed, 774 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
> >  create mode 100644 drivers/i2c/busses/i2c-fsi.c
> > 
> > --
> > 1.8.3.1
> > 
> 
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeFDXin (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:38:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:32866 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbeFDXim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:38:42 -0400
Message-ID: <7daf29f643bb0445fceef85b1a7fff71048f2aa6.camel@kernel.crashing.org>
Subject: Re: [PATCH v9 2/7] i2c: Add FSI-attached I2C master algorithm
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
Date: Tue, 05 Jun 2018 09:38:06 +1000
In-Reply-To: <CAHp75Vd7NvDFmWSzNDz-tgGvMVyXU7Z16LgGCWnHkY-3kE7fwg@mail.gmail.com>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1528138850-18259-3-git-send-email-eajames@linux.vnet.ibm.com>
         <CAHp75Vd7NvDFmWSzNDz-tgGvMVyXU7Z16LgGCWnHkY-3kE7fwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 22:21 +0300, Andy Shevchenko wrote:
> > +#define I2C_INT_ENABLE         0x0000ff80
> > +#define I2C_INT_ERR            0x0000fcc0
> 
> Now it looks like a flags combinations.
> For me as for reader would be better to see quickly a decoded line.
> 
> My proposal is to introduce something like following
> 
> _INT_ALL  GENMASK()
> _INT_ENABLE (_INT_ALL & ~(_FOO | _BAR))
> _INT_ERR ... similar way as above ...
> 
> What do you think?

I don't think this absolutely needs to change but yes, open coding is
error prone. However I would think it more readable to use positive
logic and just list all the bits that are *set* even if it's a bit more
text:

#define I2C_INT_ERR	(I2C_INT_INV_CMD	|\                			
 I2C_INT_PARITY         |\
			 I2C_INT_BE_OVERRUN	|\
			.../...)

#define I2C_INT_ENABLE	(I2C_INT_ERR		|\
			 I2C_INT_DAT_REQ	|\
			 I2C_INT_CMD_COMP)

Note: Eddie, I notice I2C_INT_BUSY is in "ERR" but not in "ENABLE", any
reason for that ?

Cheers,
Ben.

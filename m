Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBHMK5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:10:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:53456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeBHMKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:10:53 -0500
Date: Thu, 8 Feb 2018 13:10:50 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Andrew Cooks <andrew.cooks@opengear.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, platypus-sw@opengear.com,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] gpio-pca953x: fall back to byte-at-a-time for 24-bit io
Message-ID: <20180208131050.7c26717d@endymion>
In-Reply-To: <0f82783e-3f78-34dd-4f80-8e21328f9c91@opengear.com>
References: <1512440242-8983-1-git-send-email-andrew.cooks@opengear.com>
        <CAHp75Vcpdh36yjXCCOQthYKdY3vPi5EDrqFWauyv9WDgjcZPYQ@mail.gmail.com>
        <0f82783e-3f78-34dd-4f80-8e21328f9c91@opengear.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018 14:11:35 +1000, Andrew Cooks wrote:
> On 29/12/17 19:44, Andy Shevchenko wrote:
> > On Tue, Dec 5, 2017 at 4:17 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:  
> >> Using TCA6424A with i2c-piix4 bus driver requires byte-at-a-time IO,
> >> because the i2c-piix4 driver (and probably some SMBus controllers) don't
> >> support I2C_SMBUS_I2C_BLOCK_DATA.  
> > 
> > Why not to fix piix4 for now?  
> 
> The piix4 driver applies to so many chips and has been around for such a long time, that I don't know if this kind of change is safe to make. Do you think it's safe to assume that all the implementations that use this driver can handle the 3byte block writes?
> 
> I've added Jean to the CC list to get the piix4 maintainer's perspective.

This is a hardware limitation, not a driver deficiency. The original
Intel PIIX4 SMBus implementation did not support I2C Block transfers,
only SMBus Block transfers. I2C Block transfer support was added by
Intel to the 82801 (ICH5) only.

I have checked the few AMD datasheets I have here and it doesn't seem
that AMD implemented I2C Block transfers support either.

> >> @@ -249,7 +261,7 @@ static int pca953x_read_regs_24(struct pca953x_chip *chip, int reg, u8 *val)
> >>  {
> >>         int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
> >>
> >> -       return i2c_smbus_read_i2c_block_data(chip->client,
> >> +       return i2c_smbus_read_i2c_block_data_or_emulated(chip->client,
> >>                                              (reg << bank_shift) | REG_ADDR_AI,
> >>                                              NBANK(chip), val);  
> > 
> > Don't we have a counter part for writing?
> > 
> > Perhaps, it might be another option.
> 
> Again, I don't know if it's safe to assume that the i2c controllers can do this and would appreciate comments.
> 
> Thanks for your review!

I would be very cautious with
i2c_smbus_read_i2c_block_data_or_emulated(). There are no official
semantics attached to I2C transfers, each device can have its own
idea of how it should react to a given transfer.
i2c_smbus_read_i2c_block_data_or_emulated() was implemented with
EEPROMs in mind and there is absolutely no guarantee that the
"emulation" will do the right thing. Before calling it, you must check
all the code paths in i2c_smbus_read_i2c_block_data_or_emulated() and
ensure that all will do the right thing for your device.

-- 
Jean Delvare
SUSE L3 Support

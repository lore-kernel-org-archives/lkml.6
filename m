Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDJPv3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:51:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:30084 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeDJPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:51:28 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN2ETuY
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 2/5] gpio: pca953x: add register definitions for pcal6524 and fix address calculation
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75Ve5ecXJmMoO5Yy65VqR-FwnD+wMmhP=bOJ_Oxsgz8R1SQ@mail.gmail.com>
Date: Tue, 10 Apr 2018 17:51:17 +0200
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Message-Id: <97EE9603-0302-46AB-B973-F3CAFE419D07@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com> <69ab73657c5e75db94fab027c9957dbbb73047a7.1522868423.git.hns@goldelico.com> <CAHp75Ve5ecXJmMoO5Yy65VqR-FwnD+wMmhP=bOJ_Oxsgz8R1SQ@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3AFpXWj007814

Hi,

> Am 10.04.2018 um 16:41 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> On Wed, Apr 4, 2018 at 10:00 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> PCAL chips ("L" seems to stand for "latched") have additional
>> registers starting at address 0x40 to control the latches,
>> interrupt mask, pull-up and pull down etc.
>> 
>> The constants are so far defined in a way that they fit for
>> the pcal9555a when shifted by the number of banks, i.e. multiplied
>> by 2.
>> 
>> Now the pcal6524 has 3 banks which means the relative offset
>> must be multiplied by 4 which gives a wrong result if not done
>> carefully, since the base offset is already included in the offset.
>> 
>> For the basic registers shared with all pca93xx/tca64xx chips
>> there is no such offset.
>> 
>> Therefore, we add code to adjust the register number for exended
>> registers in this case.
>> 
>> And we add additional register offset constants (not yet used by
>> the driver code) which are specific to the pcal6524.
> 
>> -#define PCAL953X_IN_LATCH      34
>> -#define PCAL953X_INT_MASK      37
>> -#define PCAL953X_INT_STAT      38
> 
> I prefer either to change first all the rest to be 2 digit hex values
> first, or leave decimal in this patch.

Ok, let's change them all to hex (like in the data sheets).

> 
>> +#define PCAL953X_OUT_STRENGTH  0x20
>> +#define PCAL953X_IN_LATCH      0x22
>> +#define PCAL953X_PULL_EN       0x23
>> +#define PCAL953X_PULL_SEL      0x24
>> +#define PCAL953X_INT_MASK      0x25
>> +#define PCAL953X_INT_STAT      0x26
>> +#define PCAL953X_OUT_CONF      0x27
>> +
>> +#define PCAL6524_INT_EDGE      0x28
>> +#define PCAL6524_INT_CLR       0x2a
>> +#define PCAL6524_IN_STATUS     0x2b
>> +#define PCAL6524_OUT_INDCONF   0x2c
>> +#define PCAL6524_DEBOUNCE      0x2d
> 
>> +       /* adjust register address for pcal6524 */
>> +       if (reg >= PCAL953X_OUT_STRENGTH)
>> +               reg -= PCAL953X_OUT_STRENGTH >> 1;
> 
> I don't like this condition. Can we avoid relying on the register
> offset in regard to some flag / compatible string / etc?

I don't think so.

for TCA6416 and PCAL9555 the real registers are e.g.:
PCA953X_INPUT		0x00 / 0x01
PCA953X_OUTPUT		0x02 / 0x03

i.e. every address constant is shifted left 1 bit in the 16 bit
accessors.

for PCAL9555 some extended registers:

PCAL953X_OUT_STRENGTH	0x40 / 0x41 / 0x42 / 0x43
PCAL953X_IN_LATCH	0x44 / 0x45

i.e. PCAL953X_IN_LATCH is also simply shifted left by 1 bit
because the extended constants are defined that they fit.

for TCA6424 and PCAL6524:
PCA953X_INPUT		0x00 / 0x01 / 0x02
PCA953X_OUTPUT		0x04 / 0x05 / 0x06

every address is shifted left 2 bits in the 24 bit accessors.

for PCAL6524:
PCAL953X_OUT_STRENGTH	0x40 / 0x41 / 0x42 / 0x43 / 0x44 / 0x45
PCAL953X_IN_LATCH	0x48 / 0x49 / 0x4a

simply shifting left by 2 bits gives wrong result which is this
special case. It is not a general chip property but a mix of chip
bit-width and depends on accessing the first or second bank.

So the full condition to apply this address fix is:

if (24 bit access && second bank access)
	do correction.

and it can be simplified to what I suggest, because the 8/16/24 bit
accessors are already separate functions.

I don't think this can't be hard-coded into flags / compatible string.

> 
>> +       /* adjust register address for pcal6524 */
>> +       if (reg >= PCAL953X_OUT_STRENGTH)
>> +               reg -= PCAL953X_OUT_STRENGTH >> 1;
> 
> Ditto.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

BR and thanks,
Nikolaus

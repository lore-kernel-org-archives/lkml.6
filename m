Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeCNMv4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:51:56 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:20098 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeCNMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:51:53 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5xNv8p2jCmr+yn1q
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] drivers: gpio: pca953x: add compatibility for pcal6524 and pcal9555a
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75Ve8Y2AOm36KwuVUhssLR7Q82KS1SzB1tcKw57_LdqkKhQ@mail.gmail.com>
Date: Wed, 14 Mar 2018 13:39:30 +0100
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Message-Id: <0BF8A237-1EB9-465A-9A7C-75163F093F18@goldelico.com>
References: <49f6922ba342cf69bfd2a787d0c2a93b4df2c429.1520664883.git.hns@goldelico.com> <CAHp75Ve8Y2AOm36KwuVUhssLR7Q82KS1SzB1tcKw57_LdqkKhQ@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yong Li <yong.b.li@intel.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2ECq2eA005173

Hi Andy,

> Am 13.03.2018 um 17:56 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> On Sat, Mar 10, 2018 at 1:00 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> The Pyra-Handheld originally used the tca6424 but recently we have
>> replaced it by the pin and package compatible pcal6524. So let's
>> add this to the bindings and the driver.
>> 
>> And while we are at it, the pcal9555a does not have a compatible entry
>> either but is already supported by the device id table.
> 
> 
>> +       { "pcal6524", 24 | PCA953X_TYPE | PCA_INT | PCA_PCAL, },
>>        { "pcal9555a", 16 | PCA953X_TYPE | PCA_INT | PCA_PCAL, },
> 
> So, from your description I can get that PCA_PCAL is redundant for
> 6524. Is it correct?

We might not be using all features of the 6524 and therefore our test
coverage is not 100%. So I would not draw the conclusion that PCA_PCAL
is *not* needed. The data sheet should tell.

> What does L means in the model code?

Good question. The data sheets don't tell. But 6424 and 6524 are not identical
from register set and overall functions, although quite similar.
Only for pin and package.

As far as I understand the 6524 (and all PCAL) have additional interrupt
latch mechanisms and registers so that it is possible to disable each
I/O pin individually as an interrupt while for the 6424 they are always
enabled. Maybe this is the "L" designator.

But we aren't using interrupts yet.

> Perhaps we need to rename PCA_PCAL to be more specific?

My assumption is that it should be there for all PCAL variants,
but I think the original author who introduced this constant should know.

Hm. git blame tells that you have introduced it :) But this seems to
be a false alarm because you have just changed formatting.

It was introduced by

commit 44896beae605b93f2232301befccb7ef42953198
Author: Yong Li <yong.b.li@intel.com>
Date:   Thu Apr 7 12:56:32 2016 +0800

    gpio: pca953x: add PCAL9535 interrupt support for Galileo Gen2
    
    Galileo Gen2 board uses the PCAL9535 as the GPIO expansion,
    it is different from PCA9535 and includes interrupt mask/status registers,
    The current driver does not support the interrupt registers configuration,
    it causes some gpio pins cannot trigger interrupt events,
    this patch fix this issue.
    
    The original patch was submitted by
    Josef Ahmad <josef.ahmad@linux.intel.com>
    http://git.yoctoproject.org/cgit/cgit.cgi/meta-intel-quark/tree/recipes-kernel/linux/files/0015-Quark-GPIO-1-2-quark.patch
    
    Signed-off-by: Yong Li <yong.b.li@intel.com>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> 
> 
>> +       { .compatible = "nxp,pcal6524", .data = OF_953X(24, PCA_INT), },
>> +       { .compatible = "nxp,pcal9555a", .data = OF_953X(16, PCA_INT), },
> 
> Other way around, you missed PCA_PCAL in the second case.

Ah, ok. It wasn't clear how these flag relate to the i2c table because they
are hidden by a macro here. I'd assume that PCA_PCAL is missing for both.

So it might be that we run the pcal6524 in non-PCAL mode because we use DT.
I can do a test as soon as I have access to the hardware. 

BR and thanks,
Nikolaus

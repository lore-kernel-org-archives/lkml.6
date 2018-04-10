Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeDJQGx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:06:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:17233 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeDJQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:06:51 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN2ETuY
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 3/5] [RFC] gpio: pca953x: hack to map LEVEL irqs to EDGE irqs (may loose interrupts/hang)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75VctneZKFrRr5bgq6w1L9JkDzbKW421aDLQU2jf9vZgmFA@mail.gmail.com>
Date: Tue, 10 Apr 2018 18:06:41 +0200
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
Message-Id: <D32076BD-A605-4D62-AC22-33711CE0EB39@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com> <637f00dd7da98cfeffdc6080914a5f67b433da50.1522868423.git.hns@goldelico.com> <CAHp75VctneZKFrRr5bgq6w1L9JkDzbKW421aDLQU2jf9vZgmFA@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3AG6xgG007908

Hi Andy,

> Am 10.04.2018 um 16:38 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> On Wed, Apr 4, 2018 at 10:00 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> 
>> in driver code. Therefore, the pca953x driver rejects the
>> setup of the irq because it can only handle EDGE interrupts
>> so far.
>> 
>> This hack translates level interrupts to edge interrupts
>> for the pca953x chips. This is enough for initial testing,
>> but not a good solution since interrupts may be lost.
>> 
>> If for example the connected chip requests a IRQ_TYPE_LEVEL_LOW
>> this may have the reason that there may be multiple different
>> interrupt sources in the chip - wired-or together to the
>> input of the pca953x. Now if we do edge detecion only,
>> the first interrupt will generate an EDGE_FALLING, but a
>> second one won't ever if the first interrupt wasn't already
>> processed.
>> 
>> IMHO a better solution would be to make the pca953x interrupt
>> handler check if the irq input is still in the active
>> level and run the device specific handler again.
> 
> What I thought about is to enable such exclusively for "L" variants of
> the chips and check latched values.

Yes, something like this, although we have to think about if the same can't
be done for other chips.

The question is who will pick up this topic and when. My job for this chip
was to check if it can basically work and the hack shows that, but others
must make the driver perfect.

So for the moment I keep it in our workplace and remove it from the
patch set.

I am sure that there will be some more kernel developers as soon
as the Pyra handheld hardware is more widely available.

BR,
Nikolaus

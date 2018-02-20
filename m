Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeBTIyN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:54:13 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54482 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeBTIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:53:41 -0500
Date: Tue, 20 Feb 2018 09:53:38 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Cc: Han Xu <han.xu@nxp.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: gpmi: fix edo mode for non fully ONFI
 compliant flashes
Message-ID: <20180220095338.13f04062@xps13>
In-Reply-To: <2e12a84b-b4cb-f0ff-f3c9-173def6b5bd2@ginzinger.com>
References: <2e12a84b-b4cb-f0ff-f3c9-173def6b5bd2@ginzinger.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

On Tue, 20 Feb 2018 09:15:33 +0100, Manfred Schlaegl
<manfred.schlaegl@ginzinger.com> wrote:

> In enable_edo_mode the timing mode feature is set according to previously
> read capabilities of the parameter page ("Timing mode support"). After
> the value was set, it is read back to provide a "double-check".
> If the "double check" fails, the whole function returns with an error,
> which leads to a very slow (non-edo) fallback timing.
> 
> The problem here is, that there seem to be some NAND flashes, which are
> not fully ONFI 1.0 compliant.
> One of these is Winbond W29N04GV. According to datasheet and parameter
> page, the flash supports timing mode 4 (edo), but the timing mode feature
> is simply missing.
> 
> It seems that setting a non-existing feature is simply ignored. The real
> problem occurs, when the feature is read back: W29N04GV always delivers
> zero, which causes the "double-check" to fail. This leads to very slow
> timing and therefore to poor performance.
> 
> To solve this, we simply remove the double-check, which is a paranoia
> check anyways.

I have been in troubles about this already and sent a first patch
to dot the exact same thing, which was (rightly) nacked by Han.

So I moved to another solution which is:
1/ Move the GPMI driver to use the standardized
->setup_data_interface() hook. This way, use the logic already laying
in the core (controller drivers should not care about that anyway).
2/ Handle differently the ONFI/JEDEC parameter page so that we only
keep the parameters we actually use (instead of the whole page)
3/ Add the possibility in vendor code to nack a feature which is
declared supported (I guess it is your case too) by editing the new
structure replacing the parameter page. This way the check won't be
trustable and thus ignored.

You can find the first versions here [1] [2] and I am currently working
on a next version right now. Look at the last patch in Macronix NAND
code, I guess you could do a similar patch for your NAND (you may wait
for the next version for that, it is subject to slightly change).

Cheers,
Miquèl

[1]
http://lists.infradead.org/pipermail/linux-mtd/2018-January/078920.html
[2]
http://lists.infradead.org/pipermail/linux-mtd/2018-February/079048.html

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

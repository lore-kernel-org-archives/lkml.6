Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeEBKj1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:39:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46107 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbeEBKj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:39:26 -0400
Date: Wed, 2 May 2018 12:39:14 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "Bos, Ties \(Nokia - US/Sunnyvale\)" <ties.bos@nokia.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] Fix FSL NAND driver to read all ONFI parameter
 pages
Message-ID: <20180502123914.3755a634@bbrezillon>
In-Reply-To: <VI1PR07MB161575ACAE380B18882E8EE981810@VI1PR07MB1615.eurprd07.prod.outlook.com>
References: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
        <1524788396-32380-2-git-send-email-Jane.Wan@nokia.com>
        <20180428134218.3ae857eb@xps13>
        <VI1PR07MB161575ACAE380B18882E8EE981810@VI1PR07MB1615.eurprd07.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2018 05:01:23 +0000
"Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com> wrote:

> Hi Miquèl and Boris,
> 
> Thank you for your response and feedback.  I've modified the fix based on your comments.  
> Please see the updated patch file at the end of this message (also in attachment).
> My answers to your comments/questions are inline in the previous message.
> 
> Here is the answer to Boris question in another email thread:
> 
> > What if some NANDs have 4 or more copies of the param page?  
>  [Jane] The ONFI spec defines that the parameter page and its two redundant copies are mandatory.  
> The additional redundant pages are optional.  Currently, the FSL NAND driver only reads the first 
> parameter page.  This patch is to fix the driver to meet the mandatory requirement in the spec. 
> We got a batch of particularly bad NAND chips recently and we needed these changes to make them 
> work reliably over temperature.  The patch was verified using these bad chips.

And that proves my point. The core is reading 3 param pages [1], but
since this driver was trying to guess how many bytes to read from
->cmdfunc() and did not guess correctly you ended up with a partially
working implementation (works only if the first PARAM page is valid).
Now, you fix it to read 3 PARAM pages, but what if we decide to read
more to cope with MLC NANDs where even more copy are needed to have one
valid version? You'll have to patch ->cmdfunc() again, just because
you're trying to guess something that the core is supposed to tell you.

[1]https://elixir.bootlin.com/linux/v4.17-rc3/source/drivers/mtd/nand/raw/nand_base.c#L5115

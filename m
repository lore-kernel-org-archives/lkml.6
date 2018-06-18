Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9148AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5220850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF5220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934160AbeFRL7t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:59:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33414 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933079AbeFRL7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:59:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 99162207A5; Mon, 18 Jun 2018 13:59:45 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0F57A20703;
        Mon, 18 Jun 2018 13:59:35 +0200 (CEST)
Date:   Mon, 18 Jun 2018 13:59:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] mtd: rawnand: add NVIDIA Tegra NAND flash
 support
Message-ID: <20180618135935.5a41ec6f@bbrezillon>
In-Reply-To: <95279b61ce2630c1276669359b163933@agner.ch>
References: <20180617204605.4648-1-stefan@agner.ch>
        <20180618115806.7be25499@bbrezillon>
        <95279b61ce2630c1276669359b163933@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Mon, 18 Jun 2018 12:51:52 +0200
Stefan Agner <stefan@agner.ch> wrote:

> On 18.06.2018 11:58, Boris Brezillon wrote:
> > On Sun, 17 Jun 2018 22:45:59 +0200
> > Stefan Agner <stefan@agner.ch> wrote:
> >   
> >> Changes definitly calm down, most noteably probably the changes
> >> around checking whether a page is empty if the stack reports ECC
> >> errors.. I verified the code using raw nandwrites with OOB to
> >> simulate an empty page which has some bits flipped in the OOB area,
> >> everthing seems to work as I would expect it.
> >>
> >> For now I do not check extra OOB bytes since those are at variable
> >> locations depending on algorithm.  
> > 
> > Hm, if you expose them as free OOB bytes, you should also check them,
> > otherwise you might end up with corrupted data without noticing it. Note
> > that, depending on whether those free OOB bytes are ECC-protected or
> > not, you should change the way you do the check:
> > 
> > - non-protected OOB bytes: all bytes should be 0xff (no bitflips
> >   allowed)
> > - data+free OOB bytes protected by the same ECC bytes: you should pass
> >   the free OOB bytes buffer to nand_check_erased_ecc_chunk() along with
> >   the data and ECC buffers
> > - free OOB bytes have their own ECC bytes: call
> >   nand_check_erased_ecc_chunk() separately and pass it the ECC + free
> >   OOB buffers.  
> 
> This graphic taken from the public Tegra 2 Technical Reference Manual is
> quite useful:
> https://imgur.com/a/0Hqzbkc

Thanks for sharing this doc.

> 
> Tegra basically has all of the above, which makes the whole business
> really tricky...

I'm not sure. Are "Skip bytes" protected by "main data parity bytes"?

AFAICT, you have "Tag bytes" that fall in case #3 and "Remaining spare
bytes" that fall in case #1. If "Skip bytes" are protected by the "main
data parity bytes", then it falls in case #2, otherwise it probably
goes in case #1.

> 
> I am not sure if we really could do variant 1, non-protected OOB, but
> since we have the option of protected OOB, we probably anyway would do
> that.

That's up to you, but in this case, you should not declare those bytes
as free (didn't check what is currently done in the driver).

> 
> RS/Hamming implements variant 3.

It seems to be a mix of #1 and #3, but I'm not sure (see above).

> 
> BCH implements variant 2.

I'd say it's a mix of #1 (skip + remaining bytes) and #2(tag bytes).

> OOB is protected with the last data buffer.

That would be weird, but maybe you're right. HW ECC engine usually
split the OOB area in X portions, X being the number of ECC steps needed
to cover a NAND page, and then have ECC bytes cover a sub-portion of
data+OOB.

For example, for a NAND page of 2k with 64 bytes of OOB, and assuming
the ECC step is 512bytes, you usually have something like:

[512(data)+8(protected-oob)+8(ecc)] x 4

> 
> So this would require a algorithm depending implementation, which is
> probably not a big deal.

True.

> 
> But there is one more issue with BCH: Only if extra data are actually
> transferred, tag space is actually allocated. If no tag bytes are
> transferred, parity follows immediately skip bytes. As far as I know the
> MTD stacks OOB layout assumes that is always the same layout, no matter
> whether we write extra OOB data or not. For the Tegra NAND controller
> this would mean that we have to always transfer tag bytes and therefor
> penalize the use case we are most interested in (which is no extra OOB
> bytes, since UBI does not make use of it)...

Hm, given the amount of tag bytes I don't think you'll have a huge
penalty, so I'd recommend always sending those bytes. Alternatively,
you could decide that you never want to have those tag bytes and expose
none of them.

> 
> Furthermore I realized that testing is not easily possible since
> nandwrite with --oob seems not to make use of "oob_required" in the main
> page write but issues a separate OOB write command. I did not found a
> way to issue a write from user space which sets oob_required...

Maybe it's time to patch those tools. The ioctl exists, so it's just a
matter of using it in nandwrite/mtd-utils.

> 
> Due to all this I rather prefer to not implement extra OOB support at
> this point.

I'm fine with that, but that means no JFFS2 support, as I think JFFS2
wants to place some of its metadata in the OOB area. Also, I fear it
will be a mess to add support for that kind of things without breaking
existing setup afterwards, so, by taking this decision you're pretty
much saying that this controller will never expose free OOB bytes.
That's not a problem from my PoV, but I want you to be aware of that.

> 
> How do I do this properly? Set mtd_ooblayout_ops.free to NULL?

Just implement a dummy function that returns -ERANGE.

Regards,

Boris

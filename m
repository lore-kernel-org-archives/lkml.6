Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24621C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF59F2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="guK0/6QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfBKB1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:27:30 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:59688 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfBKB13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:27:29 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1B1RFEK003484
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:27:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1B1RFEK003484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549848436;
        bh=Bjymw9ZL2xJrOsBKqziIPpjjf6rQJ1btIsnzSZqEoMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=guK0/6QXKr7QEDuSC6oClOpIlZkziPPJ2dSS0om4rBcKq6rUbNQdf4UIwAvSu0vj5
         eM2AIFz6DPm4DQYvJ5w6gZwMfBrQ2jGXNvjLMljA25W3/QgDReXVOxwcgULNiEkhIF
         4vkkesJQg6qH8/I+jor8PcX4mQDG2Bqd41OCeMqVvXyWSjpdYvYDqIYu2eZ7o+lxVm
         VYkhFf68HjSnTRb/5LgBtaSeQHz94a4hQcqHEo2qaEH9+kluvKnyqsSoY1cTSOdCPB
         qLTobuFeB4CQdT+GMXGP5bFFykbfDVyl+XXXlenbN/T6pWzJ4mlLvBYNN0K9JEaomn
         hfrunUCT9ubwg==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id o130so2084774vke.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 17:27:16 -0800 (PST)
X-Gm-Message-State: AHQUAuaYb0wRGNExMPV76EJmtVKzAlSCWBR0aXCV99p0t7Wmpzj5FiX8
        6xcIPXDo9SMOAqq0hzjrpaXFNiXNM3+YoVoUzuM=
X-Google-Smtp-Source: AHgI3IarDvwMyJxXOcRy4QcYDk2Iek/zEss62Tawjmjxe/rUD4YkU9Wmbq94+C5udJB1zZmbQ5ONUMZ3Mb6XOROfFq0=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr13775627vkd.64.1549848435275;
 Sun, 10 Feb 2019 17:27:15 -0800 (PST)
MIME-Version: 1.0
References: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
 <1549613335-30319-7-git-send-email-yamada.masahiro@socionext.com> <20190208230511.5ee7c0f1@xps13>
In-Reply-To: <20190208230511.5ee7c0f1@xps13>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 11 Feb 2019 10:26:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSX=XTfykvqs3MYYZUbpWAGDrXVWsQQ3S6=RQG5DcbkA@mail.gmail.com>
Message-ID: <CAK7LNASSX=XTfykvqs3MYYZUbpWAGDrXVWsQQ3S6=RQG5DcbkA@mail.gmail.com>
Subject: Re: [PATCH 06/11] mtd: rawnand: denali: use more precise timeout for NAND_OP_WAITRDT_INSTR
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Sat, Feb 9, 2019 at 7:05 AM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Masahiro,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri,  8 Feb
> 2019 17:08:50 +0900:
>
> > Currently, wait_for_completion_timeout() is always passed in the
> > hard-coded msec_to_jiffies(1000). There is no specific reason for
> > 1000 msec, but I just chose it long enough.
> >
> > With the exec_op() conversion, NAND_OP_WAITRDY_INSTR provides more
> > precise timeout value, depending on the preceding command. Let's use
> > it to bail out earlier in error case.
>
> I'm not sure using 10ms instead of 1000ms is relevant in the below
> cases, 10ms is rather short for an IRQ, if your system is under load
> you might end up with a timeout, not because the right IRQ did not
> fire, but because the handler was not executed yet (it happened to me
> in the marvell_nand.c driver recently).


Good point.
Since Linux is not RT-OS, there is no defined worst-case time
until the handler is invoked.


I will add the following to denali_wait_for_irq().

        /* Prolong the IRQ wait time in case the system is under heavy load=
. */
        timeout_ms +=3D 100;





> Also, would you mind using a define instead of hardcoding '1000'?


I do not think this is worth doing.




> >
> > I am still keeping the hard-coded values for other higher level hooks
> > such as page_read, page_write, etc. We know the value of tR, tPROG, but
> > we have unknowledge about the data transfer speed of the DMA engine.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> Thanks,
> Miqu=C3=A8l



--=20
Best Regards
Masahiro Yamada

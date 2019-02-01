Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96BC218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="g2FqmAix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfBAK2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:28:46 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:32808 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfBAK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:28:45 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x11ASMUT002069
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 19:28:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x11ASMUT002069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549016903;
        bh=h78X69hmysRcuQAjIEmxJquoHYqPGCcvwTwZ91iDNo0=;
        h=From:Date:Subject:To:Cc:From;
        b=g2FqmAixsn3kjOMwoMN71yvRul7W2mhNN3wWLpuyPLPPyh464MR1BKTYiw94NcKsu
         JjkCZ+oObnJ/WJSMf915FUGpk6jK3p6n4rPtnceJOqVMMqEIqP4huMiOxXjHrwCknz
         0hZQvW6yzOfqtoTvmgft27YtuE/JL2JWem/PH/CUR78gekUNjQWc9pAQneVfuWr2IG
         tH+0HcUDpQeHoYBULFbx3sbnON8f/HiellQn5NbNvlICfl8ozgKU4POHZ3xhBVKYiY
         udsoVXo6xyWVspru8OB1UJmjUlDUPwUW3t634klNvLFoP/JxFETyr5S4RfoLBsP9N/
         1qX7kMdtrN1XA==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id c24so2051594uak.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:28:23 -0800 (PST)
X-Gm-Message-State: AJcUukd2Se1eDFioBIc6IHu/UW0L5fE0Vn4aAitgB78f1V90SfMR2Yva
        +J7d0jBp6ZikmJCl/CcaLNxN7uh+1cjnIjYO96I=
X-Google-Smtp-Source: ALg8bN4RSEGmATIoufCNlaRLLNyF1h7U9UC7P3T6i/AYlepXF8uUFSrraWj21NQ7KOvLnjbBdvOLsPr0GdTJ6b40fh0=
X-Received: by 2002:ab0:849:: with SMTP id b9mr16028106uaf.93.1549016901885;
 Fri, 01 Feb 2019 02:28:21 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 19:27:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLzvW-zDaR8qkDaxEXxmiCj7XQDK-G57sPhvZu1_eBdA@mail.gmail.com>
Message-ID: <CAK7LNAQLzvW-zDaR8qkDaxEXxmiCj7XQDK-G57sPhvZu1_eBdA@mail.gmail.com>
Subject: [Question] setup_data_interface() hook when switching to a different
 type of NAND chip
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


When I was looking into the NAND controller/chips separation,
this question popped up in my mind.


Commit 2d472aba15ff169 provides us a more flexibility
about the controller/chips connection.
The connected NAND chips do not need to be homogeneous
any more.


My question is about the ->setup_data_interface() hook
when switching between NAND chips with different speed (timing mode).


Think about the case below:

{
        compatible = "foo-nand-controller";
        reg = <...>;
        #address-cells = <1>;
        #size-cells = <0>;

        nand@0 {
                  reg = <0>;
                  /* Slow NAND chip */
        }

        nand@1 {
                  reg = <1>;
                  /* Fast NAND chip */
        }

}



In this case, two devices /dev/mtdblock0 and /dev/mtdblock1
will appear.

If a user gets access to those two devices in turns,
I think ->setup_data_interface() should be invoked somehow
in order to update the timing registers on the controller side.

Currently, ->setup_data_interface() is invoked in nand_scan_tail()
and that's it.

So, both nand@0 and nand@1 are accessed by the timing mode of nand@1
(assuming nand@0 and nand@1 are initialized in this order)


Of course, it depends on the controller.

If a controller has a register set for every chip select,
the hardware will be able to change the access speed automatically.


I think most of controllers just have a single set of timing registers.
So, when switching between different types of chips,
the driver must update the timing registers.


If this is a worthwhile usecase,
should it be taken care of by the NAND framework,
or by drivers ?


I just thought we could do something in
nand_get_device() / nand_release_device().


If this should be done per driver,
drivers can update registers in select_target or select_chip.


Thought?


-- 
Best Regards
Masahiro Yamada

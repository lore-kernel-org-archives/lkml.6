Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5094C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88002083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n2iO2NCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88002083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeIGTY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:24:59 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:36813 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbeIGTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:24:58 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w87EhYpH010900;
        Fri, 7 Sep 2018 23:43:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w87EhYpH010900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536331415;
        bh=ZAltnfKUbarGIiE92D434Zg9qP9zqHmtozbZ2afWcG8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=n2iO2NCIFCuAVWsv1t9FRtHKZNjz+NyoSs+qLswrbBN3tzFTEgN7mFH0BuPBO7nar
         OCKDPpD7ua9k/ry+xG+RM+M8SudcV40el9Zfb/Ujc62meFw/fv0SA8dPlaj8xhjCuE
         eF1ygloOLEspHGE+2n+p2IVnmO5jT8aLQ8KTeH0kZHIudUbh6Yc08WdFDkQYtqJsgi
         RK1r+JrsMcUqMpBV2VwiANx1AVqsdCEyTqOp529Z3i9WN61EwF3D/rkz9t0s8vCyj4
         estFQSE3hlwqSvN+O+UOL37ChtHjsBM1nq/TraIGjQkDmXBRZosgCVvmRvD4AITwQj
         FiFzc0222tHUA==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id s17-v6so922139vke.10;
        Fri, 07 Sep 2018 07:43:34 -0700 (PDT)
X-Gm-Message-State: APzg51AxUKLPIDLKQoEkFEkRh7Z+Xljy0B8zVcShE1X/PhCcsdW+hZz+
        5SNmgRYPFMtnzR4nA9hdomMyXYImEu4jOGzt/78=
X-Google-Smtp-Source: ANB0VdbwrPcq+QrtOHomFRixO5ujdsbcVCqujGz7H7hYiQmjyZv5osx+qayImPYVbrtglMIA0HNqlZoZBUPbqh4hevw=
X-Received: by 2002:a1f:f8c2:: with SMTP id w185-v6mr2853684vkh.135.1536331413560;
 Fri, 07 Sep 2018 07:43:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 07:42:53 -0700 (PDT)
In-Reply-To: <20180907160822.319047c8@bbrezillon>
References: <1536317783-4942-1-git-send-email-yamada.masahiro@socionext.com> <20180907160822.319047c8@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 7 Sep 2018 23:42:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJOD3mxwbiOSn5wpDsU23DhZcx9QB_ufFZB8LUnh1KdQ@mail.gmail.com>
Message-ID: <CAK7LNAQJOD3mxwbiOSn5wpDsU23DhZcx9QB_ufFZB8LUnh1KdQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: add DT property to specify skipped
 bytes in OOB
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

2018-09-07 23:08 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> Hi Masahiro,
>
> On Fri,  7 Sep 2018 19:56:23 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> NAND devices need additional data area (OOB) for error correction,
>> but it is also used for Bad Block Marker (BBM).  In many cases, the
>> first byte in OOB is used for BBM, but the location actually depends
>> on chip vendors.  The NAND controller should preserve the precious
>> BBM to keep track of bad blocks.
>>
>> In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
>> the number of bytes to skip from the start of OOB.  The ECC engine
>> will automatically skip the specified number of bytes when it gets
>> access to OOB area.
>>
>> The same value for SPARE_AREA_SKIP_BYTES should be used between
>> firmware and the operating system if you intend to use the NAND
>> device across the control hand-off.
>>
>> In fact, the current denali.c code expects firmware to have already
>> set the SPARE_AREA_SKIP_BYTES register, then reads the value out.
>>
>> If no firmware (or bootloader) has initialized the controller, the
>> register value is zero, which is the default after power-on-reset.
>>
>> In other words, the Linux driver cannot initialize the controller
>> by itself.  You cannot support the reset control either because
>> resetting the controller will get register values lost.
>>
>> This commit adds a way to specify it via DT.  If the property
>> "denali,oob-skip-bytes" exists, the value will be set to the register.
>
> Hm, do we really need to make this config customizable? I mean, either
> you have a large-page NAND (page > 512 bytes) and the 2 first bytes
> must be reserved for the BBM or you have a small-page NAND and the BBM
> is at position 4 and 5. Are you sure people configure that differently?
> Don't you always have SPARE_AREA_SKIP_BYTES set to 6 or 2?


As I said in the patch description,
I need to use the same SPARE_AREA_SKIP_BYTES value
across firmware, boot-loader, Linux, and whatever.

I want to set the value to 8 for my platform
because the on-chip boot ROM expects 8.
I cannot change it since the boot ROM is hard-wired.


The boot ROM skips 8 bytes in OOB
when it loads images from the on-board NAND device.

So, when I update the image from U-Boot or Linux,
I need to make sure to set the register to 8.

If I update the image with a different value,
the Boot ROM fails to boot.



When the system has booted from NAND,
the register is already set to 8.  It works.

However, when the system has booted from eMMC,
the register is not initialized by anyone.
I am searching for a way to set the register to 8
in this case.


The boot ROM in SOCFPGA might expect a different value,
I am not sure.



Thanks.



> Regards,
>
> Boris
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Best Regards
Masahiro Yamada

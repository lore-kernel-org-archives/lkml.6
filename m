Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AEDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36BC20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3P7f9/F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36BC20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeKCBOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:14:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/JDQWY/JBE9q38EEhQm/IWSJk9R3yclbl+qjGS2RsGI=; b=3P7f9/F4bOFgzgs537TP+Cy701
        VKSVnK1L9hVfsZIKR9EkzMBeOCCO5U/hG5qMYDmwGNzx2IG5PFzRHTXLGr0KmSpAQDoE6QOLAQ8y+
        3eCYZQybvZk5NZL/Dvaw7VM77F8WAtkOZsLkKjLRp1gG2NCNedBYEIl2cL8GnYj0u9eq6fApRXoAX
        6O73pz+NOG9Rkhv1qKP99sVc57q6yVYMJ+ZXQBAgmKT0on2VGoUC8dGkBKJWLbyS73ZHuASp/84zr
        OWFbAMzKmFMZJf/7jsNGG+1updHN0T1TasYBQJbt7HDpKsuyzVuW9E1VgGXEy0E/FqvVnVGhIy4YC
        ycmVPM4Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIbyQ-0003i7-L5; Fri, 02 Nov 2018 16:07:02 +0000
Subject: Re: [PATCH resend] arch/sh: mach-kfr2r09: fix struct mtd_oob_ops
 build warning
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org>
 <20181102075245.GR15991@w540>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bcd90d69-7487-a927-d5c1-d77c422665a8@infradead.org>
Date:   Fri, 2 Nov 2018 09:07:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102075245.GR15991@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 12:52 AM, jacopo mondi wrote:
> Hi Randy,
>    thanks for the patch.
> 
> On Thu, Nov 01, 2018 at 04:38:30PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
>> <mtd/onenand.h>, and doing so causes a build warning, so drop
>> that header file.
>>
>> In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
>> ../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
>>      struct mtd_oob_ops *ops);
>>
>> Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> 
> Not sure if this is worth pointing out, but this commit only resorts
> headers. The one introducing the warning is actually 33893d7aa.
> 
> I felt like reporting this, as introducing a "Fixes" line for that
> commit too would help backporting maybe?

Oops, thanks, I'll fix that and send a v2 with your Ack.

> In any case:
> Acked-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> Thanks
>    j
> 
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: linux-mtd@lists.infradead.org
>> Cc: linux-sh@vger.kernel.org
>> ---
>>  arch/sh/boards/mach-kfr2r09/setup.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> --- linux-next-20181101.orig/arch/sh/boards/mach-kfr2r09/setup.c
>> +++ linux-next-20181101/arch/sh/boards/mach-kfr2r09/setup.c
>> @@ -25,7 +25,6 @@
>>  #include <linux/memblock.h>
>>  #include <linux/mfd/tmio.h>
>>  #include <linux/mmc/host.h>
>> -#include <linux/mtd/onenand.h>
>>  #include <linux/mtd/physmap.h>
>>  #include <linux/platform_data/lv5207lp.h>
>>  #include <linux/platform_device.h>
>>
>>


-- 
~Randy

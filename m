Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE54C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C134F20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dKE6tR3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbeGXXP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:15:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbeGXXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2ZC1VRzLwKgVWmRtaJUcpGn7LZWAgp4Y0LJjh/8TWec=; b=dKE6tR3qzkjOc5+8eP2joKu+VD
        xj4InYB3g6gFZYkUoUAbcZU9kgIvYiCLZt8Voc1uboj2tkcOYZg04t/ELhxrcYfsCmOKkr9B9z0n0
        kev1Ta64jbfomhlT0lVGpo+xy72UqnB2OkbpIHBi2tsKxo4YG4UxT50VqnMPWxP1QmaQb6No2CD3P
        4kR4gXdPaq2oHk5k1tmZdpvxiVo5zGxNtt7JVNKrI/9XhZaYNKJVO6thURUPEZs32h+amIEnYwHVK
        7HjInC0CVQmpALX3fNxvB0AH8tuhwLI6oxVIo7W7BfNdjGDTo0CMsLNn4gwYC9SYfAbr3oUIkmyga
        J7Plse1A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi5Si-0004ew-MQ; Tue, 24 Jul 2018 22:07:22 +0000
Subject: Re: [PATCH 1/4] arc: fix some build issues in delay.h
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
 <20180724204622.2366-2-rd.dunlab@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B08394D@us01wembx1.internal.synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c265f489-9c7a-5002-68ea-755c090756cc@infradead.org>
Date:   Tue, 24 Jul 2018 15:07:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B08394D@us01wembx1.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 03:04 PM, Vineet Gupta wrote:
> On 07/24/2018 01:46 PM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build errors in arch/arc/'s delay.h:
>> - add <linux/delay.h> for loops_per_jiffy
>> - add <asm-generic/types.h> for "u64"
>>
>> In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
>> ../arch/arc/include/asm/delay.h: In function '__udelay':
>> ../arch/arc/include/asm/delay.h:61:12: error: 'u64' undeclared (first use in this function)
>>   loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
>>             ^~~
>>
>> In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
>> ../arch/arc/include/asm/delay.h: In function '__udelay':
>> ../arch/arc/include/asm/delay.h:63:37: error: 'loops_per_jiffy' undeclared (first use in this function)
>>   loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
>>                                      ^~~~~~~~~~~~~~~
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Ofer Levi <oferle@mellanox.com>
>> Cc: linux-snps-arc@lists.infradead.org
>> ---
>>  arch/arc/include/asm/delay.h |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- linux-next-20180723.orig/arch/arc/include/asm/delay.h
>> +++ linux-next-20180723/arch/arc/include/asm/delay.h
>> @@ -17,6 +17,8 @@
>>  #ifndef __ASM_ARC_UDELAY_H
>>  #define __ASM_ARC_UDELAY_H
>>  
>> +#include <linux/delay.h>
> 
> this file in turn includes asm/delay.h - the header guards will catch nested
> inclusion still seems ugly. Should we just reference loops_per_jiffy here like
> other arches do in theur delay.h

Yes, that's a good idea.  I'll do that.

>> +#include <asm-generic/types.h>
>>  #include <asm/param.h>		/* HZ */
>>  
>>  static inline void __delay(unsigned long loops)
>>
> 


-- 
~Randy

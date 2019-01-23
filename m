Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6510AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B01621872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfAWUt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:49:28 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:44929 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfAWUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:49:28 -0500
Received: from belgarion ([86.206.19.74])
        by mwinf5d65 with ME
        id TwpF1z0071btlZA03wpNuL; Wed, 23 Jan 2019 21:49:24 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 23 Jan 2019 21:49:24 +0100
X-ME-IP: 86.206.19.74
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH -next] mtd: docg3: Fix passing zero to 'PTR_ERR' warning in doc_probe_device
References: <20190123065827.16748-1-yuehaibing@huawei.com>
        <20190123101253.243add9d@bbrezillon>
        <86533285-e800-5cc0-f495-88fff8326b5a@huawei.com>
        <20190123105253.1f4487f2@bbrezillon>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 23 Jan 2019 21:49:15 +0100
In-Reply-To: <20190123105253.1f4487f2@bbrezillon> (Boris Brezillon's message
        of "Wed, 23 Jan 2019 10:52:53 +0100")
Message-ID: <87va2fyu9g.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Brezillon <bbrezillon@kernel.org> writes:

> On Wed, 23 Jan 2019 17:43:58 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
>
>> On 2019/1/23 17:12, Boris Brezillon wrote:
>> > On Wed, 23 Jan 2019 14:58:27 +0800
>> > YueHaibing <yuehaibing@huawei.com> wrote:
>> >   
>> >> Fix a static code checker warning:
>> >> drivers/mtd/devices/docg3.c:1875
>> >>  doc_probe_device() warn: passing zero to 'ERR_PTR'
>> >>
>> >> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
>> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> >> ---
>> >>  drivers/mtd/devices/docg3.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
>> >> index 4c94fc0..60ddc38 100644
>> >> --- a/drivers/mtd/devices/docg3.c
>> >> +++ b/drivers/mtd/devices/docg3.c
>> >> @@ -1872,7 +1872,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
>> >>  nomem2:
>> >>  	kfree(docg3);
>> >>  nomem1:
>> >> -	return ERR_PTR(ret);
>> >> +	return ret ? ERR_PTR(ret) : NULL;
>> >>  }
>> >>    
>> > 
>> > This is not the right fix, you should instead set ret to -EINVAL:  
>> 
>> Thanks , will fix it in v2.
>> 
>> And seems doc_probe_device cannot return NULL. The NULL check of doc_probe_device
>> in docg3_probe also can been removed, right?
>
> Hm, looks like the ret = 0 was intentional (to identify when ID is
> invalid). Let's just keep your initial patch.
Indeed, that's for the multiple floor configuration if I remember correctly.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert

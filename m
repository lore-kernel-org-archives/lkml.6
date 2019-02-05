Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF55FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D62083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfBEKYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:24:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbfBEKYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:24:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AAD5175CBB23DF3CB058;
        Tue,  5 Feb 2019 18:24:14 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 5 Feb 2019
 18:24:13 +0800
Date:   Tue, 5 Feb 2019 10:24:03 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: build warnings after merge of the staging tree
Message-ID: <20190205102403.000046d6@huawei.com>
In-Reply-To: <20190205142217.0c9ecabf@canb.auug.org.au>
References: <20190205142217.0c9ecabf@canb.auug.org.au>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 14:22:17 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Greg,
> 
> After merging the staging tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:
> 
> drivers/iio/chemical/sps30.c: In function 'sps30_read_raw':
> drivers/iio/chemical/sps30.c:289:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     switch (chan->channel2) {
>     ^~~~~~
> drivers/iio/chemical/sps30.c:299:3: note: here
>    default:
>    ^~~~~~~
> drivers/iio/chemical/sps30.c: In function 'sps30_do_cmd':
> drivers/iio/chemical/sps30.c:120:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
>           ^
> drivers/iio/chemical/sps30.c:121:2: note: here
>   case SPS30_READ_DATA_READY_FLAG:
>   ^~~~
> 
> Introduced by commits
> 
>   232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
>   62129a0849d2 ("iio: chemical: sps30: allow changing self cleaning period")
> 
> I get this warning because I am building with -Wimplicit-fallthrough
> in attempt to catch new additions early.  The gcc warning can be turned
> off by adding a /* fall through */ comment at the point the fall through
> happens (assuming that the fall through is intentional).
> 

These both should both be marked - certainly look to be intentional.
The second one might be better handled with an additional return of the -EINVAL.

Thomasz, could you send me a patch tidying this up.

Thanks Stephen!

Jonathan


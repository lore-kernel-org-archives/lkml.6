Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbeD2ObT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 10:31:19 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46823 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753599AbeD2ObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 10:31:17 -0400
X-Google-Smtp-Source: AB8JxZrDx1wG63FE7LqIOEgNlseIbn4nO1JrMZNuQX+Qj75vWpXHhS3tIXewyJt58qMd51H/5w3OQsy19/TFE/B/7A0=
MIME-Version: 1.0
In-Reply-To: <20180429111605.4cdf5ab2@bbrezillon>
References: <20180423203500.GA36488@beast> <20180429111605.4cdf5ab2@bbrezillon>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 29 Apr 2018 07:31:15 -0700
X-Google-Sender-Auth: __v2UCE-csl8NDh1xSsCx6UivmE
Message-ID: <CAGXu5jJJDF-3E_rt-16B-0CwjcF+52LPNGefD-KP+qz1JwM=6g@mail.gmail.com>
Subject: Re: [PATCH] mtd: nftl: Remove VLA usage
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 2:16 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Kees,
>
> On Mon, 23 Apr 2018 13:35:00 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> On the quest to remove all VLAs from the kernel[1] this changes the
>> check_free_sectors() routine to use the same stack buffer for both
>> data byte checks (SECTORSIZE) and oob byte checks (oobsize). Since
>> these regions aren't needed at the same time, they don't need to be
>> consecutively allocated. Additionally, while it's possible for oobsize
>> to be large, it is unlikely to be larger than the actual SECTORSIZE. As
>> such, remove the VLA, adjust offsets and add a sanity check to make sure
>> we never get a pathological oobsize.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/mtd/inftlmount.c | 11 ++++++++---
>>  drivers/mtd/nftlmount.c  | 11 ++++++++---
>>  2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
>> index aab4f68bd36f..9cdae7f0fc2e 100644
>> --- a/drivers/mtd/inftlmount.c
>> +++ b/drivers/mtd/inftlmount.c
>> @@ -334,7 +334,7 @@ static int memcmpb(void *a, int c, int n)
>>  static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
>>       int len, int check_oob)
>>  {
>> -     u8 buf[SECTORSIZE + inftl->mbd.mtd->oobsize];
>> +     u8 buf[SECTORSIZE];
>
> Could we instead move to dynamic allocation. I mean, SECTORSIZE is 512
> bytes, so only with this function we consume 1/16 of the stack. Not to
> mention that some MTD drivers might want to do DMA on buffer passed by
> the MTD user, and if the buffer is on the stack they'll have to use a
> bounce buffer instead.

Sure! I can rework it to do that. Is GFP_KERNEL okay for that, or does
it need something else?

-Kees

-- 
Kees Cook
Pixel Security

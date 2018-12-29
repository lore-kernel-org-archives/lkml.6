Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82118C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572812087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeL2QzG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 11:55:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:44915 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeL2QzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 11:55:05 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43RqSN4t94z9txrB;
        Sat, 29 Dec 2018 17:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id da60WTjGdypm; Sat, 29 Dec 2018 17:55:00 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43RqSN4Crgz9txr6;
        Sat, 29 Dec 2018 17:55:00 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 5B66463B; Sat, 29 Dec 2018 17:55:02 +0100 (CET)
Received: from 37.164.147.219 ([37.164.147.219]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 29 Dec 2018 17:55:02 +0100
Date:   Sat, 29 Dec 2018 17:55:02 +0100
Message-ID: <20181229175502.Horde.OaGr035vfDpvlvNGdmoaOQ2@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
In-Reply-To: <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> a écrit :

> Hi Finn,
>
> Am 29.12.2018 um 14:06 schrieb Finn Thain:
>> On Fri, 28 Dec 2018, LEROY Christophe wrote:
>>>> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
>>>> index 89f5154c40b6..99e5729d910d 100644
>>>> --- a/drivers/scsi/atari_scsi.c
>>>> +++ b/drivers/scsi/atari_scsi.c
>>>> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct
>>>> platform_device *pdev)
>>>> 	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
>>>> 		atari_scsi_template.sg_tablesize = setup_sg_tablesize;
>>>>
>>>> -	if (setup_hostid >= 0) {
>>>> +	if (setup_hostid >= 0)
>>>> 		atari_scsi_template.this_id = setup_hostid & 7;
>>>> -	} else {
>>>> +#ifdef CONFIG_NVRAM
>>>> +	else
>>>
>>> Such ifdefs should be avoided in C files.
>>> It would be better to use
>>>
>>> } else if (IS_ENABLED(CONFIG_NVRAM)) {
>>>
>>
>> I don't like #ifdefs either. However, as the maintainer of this file, I am
>> okay with this one.
>>
>> The old #ifdef CONFIG_NVRAM conditional compilation convention that gets
>> used here and under drivers/video/fbdev could probably be improved upon
>> but I consider this to be out-of-scope for this series, which is
>> complicated enough.
>>
>> And as explained in the commit log, CONFIG_NVRAM=y and CONFIG_NVRAM=m are
>> treaded differently by drivers. Therefore, IS_ENABLED would be incorrect.
>
> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to suggest.

Doesn't #ifdef means either y or m ? So the same as IS_ENABLED() ?

Christophe

>
> Or (really going out on a limb here):
>
> IS_BUILTIN(CONFIG_NVRAM) ||
> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
>
> Not that I'd advocate that, for this series.
>
> Cheers,
>
> 	Michael



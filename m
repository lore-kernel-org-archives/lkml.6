Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B14218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfAXN1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:27:33 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:41738 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfAXN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:27:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07492714|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.Dq7P6Ro_1548336445;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Dq7P6Ro_1548336445)
          by smtp.aliyun-inc.com(10.147.42.22);
          Thu, 24 Jan 2019 21:27:26 +0800
Subject: Re: [RFC v5 1/4] pstore/blk: new support logger for block devices
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1546862462-19640-2-git-send-email-liaoweixiong@allwinnertech.com>
 <CAGXu5jKjTPJNf0BgGAB_T3hFgwP3infRuegzJ-+qGxfGxpBgmA@mail.gmail.com>
 <1497804b-f921-b0cf-1327-3b17beaf9ce7@allwinnertech.com>
 <20190123181949.GC2792@darkstar.musicnaut.iki.fi>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <8f02a568-c1ab-fb10-7654-cb5db2d7a745@allwinnertech.com>
Date:   Thu, 24 Jan 2019 21:27:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190123181949.GC2792@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-24 02:19, Aaro Koskinen wrote:
> Hi,
> 
> On Sat, Jan 19, 2019 at 04:53:48PM +0800, liaoweixiong wrote:
>> On 2019-01-18 08:12, Kees Cook wrote:
>>>> MTD (drivers/mtd/mtdoops.c).
>>>
>>> Would mtdoops get dropped in favor of pstore/blk, or do they not share
>>> features?
>>
>> We can show them what pstore/blk do. I think they will be interested in it.
>> They should do a little work, including make a function for panic read,
>> then they gain enhanced features, including present logs as a file,
>> record multiple logs.
> 
> mtdoops has been in use over a decade and known working. What benefits
> this new framework would offer? (BTW I don't see MTD as "block device".)
> 

Pstore/blk is NOT to replace mtdoops, but to enhance it. Mtdoops provides
operation interface for panic and pstore/blk manage the special
partition space.

The combination of pstore/blk and mtdoops brings follow benefits:
1. Not only panic/oops, but also all feature of pstore, such as console,
ftrace, pmsg, etc.
2. Display log as a file. Pstore/blk can save multiple records and
display all of them as files. Users have no need to parse the partition,
just read files to get what they wants.
3. User can get more information, such as the trigger time, the trigger
count, etc.
4. ... perhaps other benefits that I can't think of right now

> Why should there be a panic read? That adds complexity. This codes runs
> on panic path, so it should be as simple and fast as possible.
> 

Read operation is only used to recover old data. Pstore/blk will do
recovery only one time before write (when trigger a new crash) and read
(when mount pstore filesystem). Most of the time, pstore/blk will do
read by general operation rather than panic read. However, how if kernel
panic when pstore/blk do not recover yet? That's why we need panic read.

In addition, pstore/blk do not recover log when panic. It just recover
the trigger counter and next position. Pstore/blk need old count to
accumulate count, next position to avoid damage to old records.

> Also compatibility has to be there. E.g. user upgrades an old system
> (with mtdoops and related userspace) to a new kernel. Upgrade fails,
> so the old software must be able to read the panic dumps properly to
> tell the user why.
> 

This is really a problem, because the header of each records is very
different between pstore/blk and mtdoops. But i think it is not fatal.

> A.
> 

-- 
liaoweixiong

Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852C1C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839720837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2839720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeIBXdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 19:33:03 -0400
Received: from smtp.infotech.no ([82.134.31.41]:51405 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeIBXdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 19:33:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id AAC0720423F;
        Sun,  2 Sep 2018 21:16:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kzAIKD4eko6I; Sun,  2 Sep 2018 21:16:12 +0200 (CEST)
Received: from [10.0.0.9] (ti0116a330-1202.bb.online.no [88.90.229.191])
        by smtp.infotech.no (Postfix) with ESMTPA id 89C0B204179;
        Sun,  2 Sep 2018 21:16:12 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: Recent removal of bsg read/write support
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        drorl@infinidat.com
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
References: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
 <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <6b907fed-d83f-de75-bde4-11270a0b1b0b@interlog.com>
Date:   Sun, 2 Sep 2018 21:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-02 01:44 PM, Richard Weinberger wrote:
> CC'ing relevant people. Otherwise your mail might get lost.
> 
> On Sun, Sep 2, 2018 at 1:37 PM Dror Levin <drorl@infinidat.com> wrote:
>>
>> Note: I am not subscribed to LKML so please CC replies to this email.
>>
>> Hi,
>>
>> We have an internal tool that uses the bsg read/write interface to
>> issue SCSI commands as part of a test suite for a storage device.
>>
>> After recently reading on LWN that this interface is to be removed we
>> tried porting our code to use sg instead. However, that raises new
>> issues - mainly getting ENOMEM over iSCSI for unknown reasons.
>>
>> Because of this we would like to continue using the bsg interface,
>> even if some changes are required to meet security concerns.
>>
>> Is there any chance for this removal to be reverted? I saw it was
>> already included in 4.19-rc1.

Hi,
Both bsg and sg are relatively thin shims over the same block layer
pass-through calls. And neither driver will themselves generate ENOMEM
unless the CPU is running low of memory.

In my experience, the main reason for unexpected ENOMEMs *** is from
blk_rq_map_user_iov() in block/blk_map.c called from both drivers.
That is a particular resource shortage rather than memory in general.
I do notice the blk_rq_map_user_iov() is/was called with GFP_KERNEL
in bsg and GFP_ATOMIC by sg. That suggests when you call write() on
a sg device and get ENOMEM, then wait a little (depends on your app)
and try again.

Could you share a test program that illustrates the problem with us?

One way of limiting user space programs that used bsg's write()/read()
interface (via the sg v4 interface), from needing a significant rewrite
would be to implement the sg_v4 interface in the sg driver. Currently the
sg driver supports the sg v1 (sort of), sg v2 and sg v3 (typically used)
interfaces.

Doug Gilbert


*** Prior to around February this year, that block layer resource
shortage resulted in a EINVAL being returned to the sg driver. That
had perplexed me for some time, as it happened only under heavy
testing, typically with the same SCSI command being repeated
(e.g. REQUEST SENSE). It was really a ENOMEM error that was being
inadvertently overwritten.









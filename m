Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BFCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2120827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tx9jiyfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A2120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbeKFA2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:28:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44637 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbeKFA2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:28:54 -0500
Received: by mail-io1-f66.google.com with SMTP id c6-v6so6693935iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lha7Fj1hdYaLcE1tasDrWqNe4m8vz6kWf2Mmm2+4yuI=;
        b=tx9jiyfhQ+NH41DTo2KlAAvk3+3mXt0Il86vp89yRbDD9Lo/9MDf+RlutNb364wer4
         1AFIwXPJlMP0FHnPd1IKTOvZvMNWmt6T93H7N6lsrmm33jXajcGVYFnj9pNzwd3c5pRU
         zuP/mAyHSjslkYRPMyqIW6XUZOGnFzcux8iyoipZDOMvSmmvk2jW7JHV8Vl5CdrgDPln
         1fmHJkio0/lM2WBqjGoaqXIRVG7EOpvodTJSsl0+JtVodNQaXKbrXhf5SXK7j2XXNO2j
         yM8RIXkWIw2Vdw1QmvoOBwobl+y/lKYZxzALU+FtxRjdZvGPaBojHhce5LzfpQQbBRhE
         HTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lha7Fj1hdYaLcE1tasDrWqNe4m8vz6kWf2Mmm2+4yuI=;
        b=BHfHk6+wZyhFEhzSo3s2jmWaghlVi+vvop1HdCi8YYWXUb77al0fR6OZTYEOz5GC3G
         6un1qXdc4a0N72WCLCF+uhW+Ore2DEolKvkqajxU2McN3YlKFbshYtwAV/ttY6+dYnLl
         DP6EeCBygs5kaXCb6BwX/J8PqSrGNpIN+ARM3iwmpwBmNNFR68ZY04Q9pKj1MEsCcqiQ
         TcdQQKa7xnqWgn1L+P2pYmouXz2aLxukqZ0ujjmNXFdewHEnpOQ0uCbBaoVe5U6S+9Rv
         uG/M9MrqgmStszJvCvgfHF33U1FQsTqx9FKyPX8RsZq0zPKPcqUhg785XJE76k5bYLwf
         qpkg==
X-Gm-Message-State: AGRZ1gIFBtCOg4QCU6Br29iStJqkkpzc9edQWMLcK+fcqPWozOHo7Z1e
        WKRQRi5OJ9c2CxpuPnyu0FemsSChpYk=
X-Google-Smtp-Source: AJdET5dNDoa+EM/EJ4HvSoCFn8o+BW5SuIOfm9kwREikHbuTnDQe3ddY4cRWW5UuV8y7qbmtP3w+uQ==
X-Received: by 2002:a6b:7847:: with SMTP id h7-v6mr12560852iop.241.1541430523587;
        Mon, 05 Nov 2018 07:08:43 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u127-v6sm6363162ita.10.2018.11.05.07.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:08:40 -0800 (PST)
Subject: Re: System not booting since dm changes? (was Linux 4.20-rc1)
To:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, satheera@in.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
 <87tvkvddnk.fsf@concordia.ellerman.id.au> <20181105135157.GA11485@redhat.com>
 <20181105143541.GA29120@MiWiFi-R3L-srv>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d272ebee-b5f8-1f84-c658-c5d831f2d266@kernel.dk>
Date:   Mon, 5 Nov 2018 08:08:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105143541.GA29120@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 7:35 AM, Satheesh Rajendran wrote:
> On Mon, Nov 05, 2018 at 08:51:57AM -0500, Mike Snitzer wrote:
>> On Mon, Nov 05 2018 at  5:25am -0500,
>> Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>> ...
>>>> Mike Snitzer (1):
>>>>     device mapper updates
>>>
>>> Hi Mike,
>>>
>>> Replying here because I can't find the device-mapper pull or the patch
>>> in question on LKML. I guess I should be subscribed to dm-devel.
>>>
>>> We have a box that doesn't boot any more, bisect points at one of:
>>>
>>>   cef6f55a9fb4 Mike Snitzer       dm table: require that request-based DM be layered on blk-mq devices 
>>>   953923c09fe8 Mike Snitzer       dm: rename DM_TYPE_MQ_REQUEST_BASED to DM_TYPE_REQUEST_BASED 
>>>   6a23e05c2fe3 Jens Axboe         dm: remove legacy request-based IO path 
>>>
>>>
>>> It's a Power8 system running Rawhide, it does have multipath, but I'm
>>> told it was setup by the Fedora installer, ie. nothing fancy.
>>>
>>> The symptom is the system can't find its root filesystem and drops into
>>> the initramfs shell. The dmesg includes a bunch of errors like below:
>>>
>>>   [   43.263460] localhost multipathd[1344]: sdb: fail to get serial
>>>   [   43.268762] localhost multipathd[1344]: mpatha: failed in domap for addition of new path sdb
>>>   [   43.268762] localhost multipathd[1344]: uevent trigger error
>>>   [   43.282065] localhost kernel: device-mapper: table: table load rejected: not all devices are blk-mq request-stackable
>> ...
>>>
>>> Any ideas what's going wrong here?
>>
>> "table load rejected: not all devices are blk-mq request-stackable"
>> speaks to the fact that you aren't using blk-mq for scsi (aka scsi-mq).
>>
>> You need to use scsi_mod.use_blk_mq=Y on the kernel commandline (or set
>> CONFIG_SCSI_MQ_DEFAULT in your kernel config)
> 
> Thanks Mike!, above solution worked and the system booted fine now:-)

This quirk will go away for the next kernel, fwiw, since the non-mq
path for SCSI will be dropped as well.

-- 
Jens Axboe


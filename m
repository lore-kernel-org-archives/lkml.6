Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F3F68C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB6220693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB6220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbeFLGTJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:19:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932362AbeFLGTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:19:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A1D648A784E9E;
        Tue, 12 Jun 2018 14:18:54 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Tue, 12 Jun 2018
 14:18:51 +0800
Subject: Re: [Query] Failed to create dm-crypt device when using AEAD type
To:     Milan Broz <gmazyland@gmail.com>, <agk@redhat.com>,
        <snitzer@redhat.com>
CC:     <broonie@linaro.org>, <arnd@arndb.de>, <joakim.bech@linaro.org>,
        <dm-devel@redhat.com>, <linux-kernel@vger.kernel.org>
References: <33220afd-9a26-6133-ebf0-83b1268c34b7@huawei.com>
 <9aebff4d-71b0-9fe0-2ccc-38c80fc2179a@gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <c11a89dc-6ea9-20d1-0b0c-1fc7659b6560@huawei.com>
Date:   Tue, 12 Jun 2018 14:18:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9aebff4d-71b0-9fe0-2ccc-38c80fc2179a@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milan,

Thanks so much! It worked. No integrity errors are printed after I wipe the device.
I am stuck in these errors for about a week. Thanks again!

Regards,
Xiongfeng

On 2018/6/12 13:50, Milan Broz wrote:
> On 06/12/2018 07:37 AM, Xiongfeng Wang wrote:
>> Hi Dm-crypt maintainers,
>>
>> Recently, I was testing the dm-crypt, but I failed to create dm-crypt device when using AEAD type.
>> I would really appreciate it if you could give some help.
>> The error info is as follows:
>> localhost:~ # export SIZE_INT=997376
>> 8 J 0"ost:~ # dmsetup create integ1 --table "0 $SIZE_INT integrity /dev/sdd2 0 2
>> localhost:~ #
>> dom \host:~ # dmsetup create crypt1 --table "0 $SIZE_INT crypt capi:gcm(aes)-ran
>>>  11ff33c6fb942655efb3e30cf4c0fd95f5ef483afca72166c530ae26151dd83b \
>>>  0 /dev/mapper/integ1 0 1 integrity:28:aead"
>> [ 1746.631559] device-mapper: crypt: Integrity AEAD, tag size 16, IV size 12.
>> [ 1746.649796] device-mapper: crypt: INTEGRITY AEAD ERROR, sector 997248
>> [ 1746.656382] device-mapper: crypt: INTEGRITY AEAD ERROR, sector 997248
>> [ 1746.662826] Buffer I/O error on dev dm-3, logical block 124656, async page read
> 
> These errors actually say that it works as expected! :)
> 
> If the underlying device has no integrity tags initialized, *every* access to device must generate
> integrity fail (because integrity tag is just not correct).
> 
> And the errors above are perhaps udev scans that are triggered by inotify when new device appears
> and it tries to find some signatures on uninitialized disk with blkid.
> 
> If you use cryptsetup, it will try to wipe the device, alternatively you can use
> dd (just be sure to use direct-io, page cache can generate some reads that fails as well),
> so in your case something like this:
> 
>   # dd if=/dev/zero of=/dev/maper/crypt1 bs=1M oflag=direct
> 
> should wipe the device (and store integrity tags).
> 
> If you activate your devices again (with the same parameters), no integrity errors should be present.
> 
> (I will write more documentation in next weeks regarding all this stuff, we have now better
> AEAD ciphers in 4.18.)
> 
> Thanks,
> Milan
>  
>>
>> I tested it both on qemu and hardware, and it printed the same error.
>> The error seems always on the last several sectors within the SIZE_INT I designated.
>> When I change the SIZE_INT, the error sector num also change.
>> I think something went wrong in the software, not the hardware.
>>
>> My board don't have AEAD accelerator, so it uses the software implemented cipher.
>> My kernel version is 4.17-rc3.
>>
>> The command is as follows:
>> export SIZE_INT=997376
>> dmsetup create integ1 --table "0 $SIZE_INT integrity /dev/sdd2 0 28 J 0"
>> dmsetup create crypt1 --table "0 $SIZE_INT crypt capi:gcm(aes)-random \
>>  11ff33c6fb942655efb3e30cf4c0fd95f5ef483afca72166c530ae26151dd83b \
>>  0 /dev/mapper/integ1 0 1 integrity:28:aead"
>>
>> This command comes from the commit information of the commit which introduce AEAD.
>> (commit ef43aa38063a6b2b3c6618e28ab35794f4f1fe29
>> dm crypt: add cryptographic data integrity protection (authenticated encryption))
>> I only change 'aes-gcm-random' to 'capi:gcm(aes)-random'
>>
>> Really appreciate it if you could have a look at it, Thanks!
>>
>> Regards,
>> Xiongfeng
>>
>>
> 
> .
> 


Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC562ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796E720671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796E720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeGSLiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:38:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727489AbeGSLiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:38:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 298BEFA72419A;
        Thu, 19 Jul 2018 18:55:17 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 18:55:11 +0800
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <dm-devel@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com>
Date:   Thu, 19 Jul 2018 18:55:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/7/18 23:34, Ard Biesheuvel wrote:
> On 18 July 2018 at 19:59, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Jul 18, 2018 at 9:30 AM, Xiongfeng Wang
>> <wangxiongfeng2@huawei.com> wrote:
>>>
>>> I tested the performance of software implemented ciphers before and after
>>> applying this patchset. The performance didn't change much except for
>>> slight regression when writting. The detail information is as follows.
>>>
>>> The command I used:
>>> cryptsetup -y -c aes-xts-plain -s 256 --hash sha256 luksFormat /dev/sdd1
>>> cryptsetup -y -c aes-cbc-essiv:sha256 -s 256 --hash sha256 luksFormat /dev/sdd1
>>> cryptsetup -y -c aes-cbc-benbi -s 256 --hash sha256 luksFormat /dev/sdd1
>>>
>>> cryptsetup luksOpen /dev/sdd1 crypt_fun
>>> time dd if=/dev/mapper/crypt_fun of=/dev/null bs=1M count=500 iflag=direct
>>> time dd if=/dev/zero of=/dev/mapper/crypt_fun bs=1M count=500 oflag=direct
>>>
>>> Performance comparision:
>>> --------------------------------------------------------
>>> algorithms      | before applying   |   after applying
>>> --------------------------------------------------------
>>>                 |  read  | write    |  read  | write
>>> --------------------------------------------------------
>>> aes-xts-plain   | 145.34 | 145.09   | 145.89 | 144.2
>>> --------------------------------------------------------
>>> aes-cbc-essiv   | 146.87 | 144.62   | 146.74 | 143.41
>>> --------------------------------------------------------
>>> aes-cbc-benbi   | 146.03 | 144.74   | 146.77 | 144.46
>>> --------------------------------------------------------
>>
>> Do you have any estimate of the expected gains for hardware
>> implementations?
>>
>> Would it make sense to try out implementing aes-cbc-essiv
>> on the ARMv8 crypto extensions? I see that Ard has done
>> some prior work on aes-ccm in arch/arm64/crypto/aes-ce-ccm-*
>> that (AFAICT) has a similar goal of avoiding overhead by
>> combining the usual operations, so maybe the same can
>> be done here.
>>
> 
> I am having trouble understanding what exactly this series aims to achieve.
> 
> Calling into the crypto layer fewer times is a nice goal, but a disk
> sector seems like a reasonable granularity for the dm layer to operate
> on, and I don't think any hardware exists that operates on multi
> sector sequences, where it would pay off to amortize the latency of
> invoking the hardware over an entire bio.

I don't know much about crypto hardware, but I think a crypto hardware can handle
data more than one sector at one time. So I think passing the whole bio to the hardware
at one time will decrease the overhead in passing each sector alternatively.

Thanks,
Xiongfeng
> 
> So in summary, you need to explain to us why we need this. It is
> really very easy to convince people if your changes make things go
> faster.
> 
> .
> 


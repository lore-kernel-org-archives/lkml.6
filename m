Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FCECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8370820693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8370820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeGSC1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 22:27:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729230AbeGSC1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 22:27:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15512BDCD52B6;
        Thu, 19 Jul 2018 09:46:14 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 09:46:06 +0800
Subject: Re: [PATCH 4/5] crypto: Add IV generation templates
To:     Milan Broz <gmazyland@gmail.com>, Mark Brown <broonie@kernel.org>
CC:     <agk@redhat.com>, <snitzer@redhat.com>,
        <herbert@gondor.apana.org.au>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <jonathan.cameron@huawei.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
 <b6eaf471-7279-ca4f-bb7c-d25df8db2419@gmail.com>
 <20180718164625.GA20360@sirena.org.uk>
 <82248c13-42fe-b598-0cd7-68e5db0b51be@gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <cda1d3de-3f21-2dfc-0423-c1cf456838b4@huawei.com>
Date:   Thu, 19 Jul 2018 09:46:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <82248c13-42fe-b598-0cd7-68e5db0b51be@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/7/19 1:17, Milan Broz wrote:
> On 18/07/18 18:46, Mark Brown wrote:
>> On Wed, Jul 18, 2018 at 10:16:05AM +0200, Milan Broz wrote:
>>
>>> So we are here again and moving INTERNAL dm-crypt functionality into
>>> cryptoapi.

> (namely TCW and LMK) do much more that IV - they modify encryption mode.
> This was a hack to support some FDE encryption modes (old Truecrypt and loopAES)
> and that should not spread outside dm-crypt (and blame me for this code hacks :).
> 
> 2) If the reason is performance, please provide numbers with the patch.
> What I see now is that the performance is almost the same. So why you are doing it?
> Any real hw that benefits from it?

I add IV templates, such as 'plain()',  'benbi()'
When applying it to the existing algorithm, such as 'aes-cbc', and so on,
it generates new algorithm 'aes-cbc-plain', 'aes-cbc-benbi.
This patch modify the dm-crypt to rely on the new algorithm 'aes-cbc-benbi'.
Dm-crypt passes the whole 'bio' to 'aes-cbc-benbi', rather than divide
the bio into sectors, and alternatively pass each sector to 'aes-cbc'.

Because the internal implementation of the IV template 'benbi()' is still
dividing the whole bio into sectors, so the performance is almost the same.
The purpose of this patch is to let dm-crypt rely on the new algorithm 'aes-cbc-benbi'
and pass the whole bio to the new algorithm.
And then if the hardware driver implements this new algorithm, it can get the data of
the bio at one time, and return the processed data at one time.
I think it will decrease the overhead of passing each sector alternatively.
But the hardware need to implement the new algorithm if it want to benefit from this.

Thanks,
Xiongfeng
> 
> I added 4k sector support in dmcrypt and IMO this helps much more
> than some hw IV accelerations (AFAIK is is already used in some mainframe
> accelerators this way because of performance).
> 
> Milan
> 
> 


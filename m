Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeCUIwU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:52:20 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:52639 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeCUIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:52:15 -0400
Subject: Re: [PATCH v2] MIPS: ralink: fix booting on mt7621
To: NeilBrown <neil@brown.name>, John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC: <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <87efkf9z0o.fsf@notabene.neil.brown.name>
 <87605r9mwf.fsf@notabene.neil.brown.name>
 <cc33f000-16ed-b331-53b7-d767e20a4a9c@mips.com>
 <874lla874z.fsf@notabene.neil.brown.name>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <a27180db-4fcf-7b6d-2cac-03aab25a71a6@mips.com>
Date: Wed, 21 Mar 2018 08:51:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <874lla874z.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1521622325-321459-16024-41654-1
X-BESS-VER: 2018.3-r1803192001
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191261
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 21/03/18 03:00, NeilBrown wrote:
> On Tue, Mar 20 2018, Matt Redfearn wrote:
> 
>> Hi Neil,
>>
>>
>> On 20/03/18 08:22, NeilBrown wrote:
>>>
>>> Further testing showed that the original version of this
>>> patch wasn't 100% reliable.  Very occasionally the read
>>> of SYSC_REG_CHIP_NAME0 returns garbage.  Repeating the
>>> read seems to be reliable, but it hasn't happened enough
>>> for me to be completely confident.
>>> So this version repeats that first read.
>>
>> You almost certainly need a sync() to ensure that the write to gcr_reg0
>> has completed before attempting to read sysc + SYSC_REG_CHIP_NAME0.
> 
> That sound like exactly the right sort of thing to do, though
> I assume you mean __sync().

Indeed I did :-)

> 
> I tried to reproduce the problem so I could test the fix, and of course
> I failed. Over 700 reboot cycles and never read any garbage from
> SYSC_REG_CHIP_NAME0.

Funny how things conspire like that :-) __sync() is definitely the 
correct barrier required to ensure the write completes before the read 
begins and will guarantee that the memory operations are ordered.

Thanks,
Matt

> 
> So I cannot test that this works, but I have tested that it doesn't
> cause any obvious regression.
> I'll send the v3 patch separately.
> 
> Thanks a lot,
> NeilBrown
> 

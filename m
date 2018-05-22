Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEVMV0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:21:26 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:37756 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeEVMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:21:24 -0400
Subject: Re: [PATCH v2 4/4] MIPS: memset.S: Add comments to fault fixup
 handlers
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
References: <1523979603-492-1-git-send-email-matt.redfearn@mips.com>
 <1523979603-492-4-git-send-email-matt.redfearn@mips.com>
 <20180521161443.GA9998@jamesdev>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <d9c292de-8d21-78e9-6094-5acef2c6fccb@mips.com>
Date: Tue, 22 May 2018 13:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180521161443.GA9998@jamesdev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526991658-298553-23664-57222-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193246
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 21/05/18 17:14, James Hogan wrote:
> On Tue, Apr 17, 2018 at 04:40:03PM +0100, Matt Redfearn wrote:
>> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
>> index 1cc306520a55..a06dabe99d4b 100644
>> --- a/arch/mips/lib/memset.S
>> +++ b/arch/mips/lib/memset.S
>> @@ -231,16 +231,25 @@
>>   
>>   #ifdef CONFIG_CPU_MIPSR6
>>   .Lbyte_fixup\@:
>> +	/*
>> +	 * unset_bytes = current_addr + 1
>> +	 *      a2     =      t0      + 1
> 
> The code looks more like a2 = 1 - t0 to me:
> 
>> +	 */
>>   	PTR_SUBU	a2, $0, t0
>>   	jr		ra
>>   	 PTR_ADDIU	a2, 1
> 
> I.e. t0 counts up to 1 and then stops.

Well spotted. Which means this code is also wrong.... :-/

We have the count of bytes to zero in a2, but that gets clobbered in the 
exception handler and we always return a number of bytes uncopied within 
STORSIZE.

This test code:

static int __init __attribute__((optimize("O0"))) test_clear_user(void)
{
	int j, k;

	pr_info("\n\n\nTesting clear_user\n");

	for (j = 0; j < 512; j++) {
		if ((k = clear_user(NULL+3, j)) != j) {
			pr_err("clear_user (NULL %d) returned %d\n", j, k);
		}
	}

	return 0;
}
late_initcall(test_clear_user);

on a 64r6el kernel results in:

[    3.965439] Testing clear_user
[    3.973169] clear_user (NULL 8) returned 6
[    3.976782] clear_user (NULL 9) returned 6
[    3.980390] clear_user (NULL 10) returned 6
[    3.984052] clear_user (NULL 11) returned 6
[    3.987524] clear_user (NULL 12) returned 6
[    3.991179] clear_user (NULL 13) returned 6
[    3.994841] clear_user (NULL 14) returned 6
[    3.998500] clear_user (NULL 15) returned 6
[    4.002160] clear_user (NULL 16) returned 6
[    4.005820] clear_user (NULL 17) returned 6
[    4.009480] clear_user (NULL 18) returned 6
[    4.013140] clear_user (NULL 19) returned 6
[    4.016797] clear_user (NULL 20) returned 6
[    4.020456] clear_user (NULL 21) returned 6

I'll post another fix soon, and update this comment to reflect the 
corrected behavior.

Thanks,
Matt

> 
> Anyway I've applied patch 3 for 4.18.
> 
> Cheers
> James
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeEUQ72 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:59:28 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:45113 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeEUQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:59:27 -0400
Subject: Re: ARC compact700 NPS platform - EZ_MachineCheck exception handler
To: "Ofer Levi(SW)" <oferle@mellanox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Meir Lichtinger" <meirl@mellanox.com>,
        arcml <linux-snps-arc@lists.infradead.org>
References: <DB6PR05MB4597A3B8BC5BE80BD039B0AAB2950@DB6PR05MB4597.eurprd05.prod.outlook.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <0c84cd14-19dc-a22c-271c-11cbd18ded3a@synopsys.com>
Date: Mon, 21 May 2018 09:59:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <DB6PR05MB4597A3B8BC5BE80BD039B0AAB2950@DB6PR05MB4597.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.52]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 07:14 AM, Ofer Levi(SW) wrote:
> Resending, due to typo in LKML mail  address.

Also please CC linux-snps-arc@lists.infradead.org for any ARC Linux related posts.

>   
>   The EV_MachineCheck exception handler is halting the core for exceptions
>   which are not tlb_overlap_fault.
>   Since for the NPS platform each core is running a single thread in ZOL (Zero
>   Overhead Linux) isolation mode, we feel that most of the time it is safe to
>   resume execution instead of halting the core.

Most of the time is not good enough when dealing with OS code :-(
A Machine check excepting implies something went terribly wrong. Some of those 
cases can be handled gracefully (such as duplicate TLB entry), but others can't so 
continuing despite it is recipe for disaster. Perhaps your chip has some spurious 
Machine check exceptions ?

>   I would appreciate it if you could review the change  below

Next time please send a real patch so I know right away what was changed.

> and let me know
>   what you think, if this change is valid or if we missed or overlooked
>   something.
>   We are not looking to push this change upstream, but will be used on some
>   systems.

Hmm, but you have to explain why those machine checks are fine !

>   
>   Please see below our implementation after label 1.
>   
>   Thanks
>   Ofer
>   
>   ENTRY(EV_MachineCheck)
>   
>   	EXCEPTION_PROLOGUE
>   
> ...
>   	brne    r3, ECR_C_MCHK_DUP_TLB, 1f
>   
>   	bl      do_tlb_overlap_fault
>   	b       ret_from_exception
>   
>   1:
>   	FAKE_RET_FROM_EXCPN

You don't need this.

>   	bl		do_machine_check  ; using DO_ERROR_INFO macro

We don't have above function in code. There's do_machine_check_fault() which calls 
die() -> flag 1 - so it would halt the kernel and would never return here.
So your patch is broken in implementation as well.

>   	b       ret_from_exception
>   
>   END(EV_MachineCheck)
>
>

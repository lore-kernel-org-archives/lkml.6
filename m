Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeEPHIp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:08:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751285AbeEPHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:08:44 -0400
Date: Wed, 16 May 2018 12:38:35 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC] powerpc/emulate_step: Fix kernel crash when VSX is not
 present
To: mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>
Cc: anton@samba.org, cyrilbur@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, matthew.brown.dev@gmail.com,
        paulus@samba.org, sandipan@linux.vnet.ibm.com
References: <20180516054021.5328-1-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20180516054021.5328-1-ravi.bangoria@linux.ibm.com>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18051607-0008-0000-0000-000004F6F4E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051607-0009-0000-0000-00001E8B604C
Message-Id: <1526454049.ztv236j5bs.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160072
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Mikey]

Ravi Bangoria wrote:
> emulate_step() is not checking runtime VSX feature flag before
> emulating an instruction. This can cause kernel oops when kernel
> is compiled with CONFIG_VSX=y but running on machine where VSX is
> not supported or disabled. Ex, while running emulate_step tests on
> P6 machine:
> 
>   ...
>   emulate_step_test: lvx            : PASS
>   emulate_step_test: stvx           : PASS
>   Oops: Exception in kernel mode, sig: 4 [#1]
>   NIP [c000000000095c24] .load_vsrn+0x28/0x54
>   LR [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
>   Call Trace:
>   [c0000000494c3770] [40fe240c7ae147ae] 0x40fe240c7ae147ae (unreliable)
>   [c0000000494c37f0] [c000000000094bdc] .emulate_loadstore+0x167c/0x17b0
>   [c0000000494c3900] [c000000000094f6c] .emulate_step+0x25c/0x5bc
>   [c0000000494c39b0] [c000000000ec90dc] .test_lxvd2x_stxvd2x+0x64/0x154
>   [c0000000494c3b90] [c000000000ec9204] .test_emulate_step+0x38/0x4c
>   [c0000000494c3c00] [c00000000000de2c] .do_one_initcall+0x5c/0x2c0
>   [c0000000494c3cd0] [c000000000eb4bf8] .kernel_init_freeable+0x314/0x4cc
>   [c0000000494c3db0] [c00000000000e1e4] .kernel_init+0x24/0x160
>   [c0000000494c3e30] [c00000000000bc24] .ret_from_kernel_thread+0x58/0xb4
> 
> With fix:
>   ...
>   emulate_step_test: stvx           : PASS
>   emulate_step_test: lxvd2x         : FAIL
>   emulate_step_test: stxvd2x        : FAIL

Those tests should also be updated to skip testing these instructions if 
!CPU_FTR_VSX.

> 
> Fixes: https://github.com/linuxppc/linux/issues/148
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
> Note: VSX was first introduced on P6. But there are many VSX instructions
>       which were introduced in later versions. So ideally, analyse_instr()
>       should check for ISA version along with opcode.

Yes, this patch should be useful for when VSX is not present. For 
specific instructions, we should add a cpu feature check.

- Naveen

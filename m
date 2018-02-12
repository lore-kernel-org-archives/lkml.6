Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934589AbeBLMfU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:35:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932925AbeBLMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:35:17 -0500
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param xmon=off
In-Reply-To: <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com> <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com>
Date: Mon, 12 Feb 2018 18:05:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18021212-0012-0000-0000-000005ADD8AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021212-0013-0000-0000-000019299C6D
Message-Id: <8737264c91.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing this patch Balbir

Balbir Singh <bsingharora@gmail.com> writes:

> Any specific issue you've run into without this patch? 
Without this patch since xmon is still accessible via sysrq and there is
no indication/warning on the xmon console mentioning that its is not
fully functional. Specifically xmon-console would still allow user to
set instruction/data breakpoint eventhough they wont work and will
result in a kernel-oops.

Below is command log illustrating this problem on one of my test system
where I tried setting an instruction breakpoint on cmdline_proc_show()
with xmon=off:

~# cat /proc/cmdline 
root=UUID=248ad10e-a272-4187-8672-5b25f701e8b9 ro xmon=off

~# echo 'x' > /proc/sysrq-trigger                                                                                                                                     
[  458.904802] sysrq: SysRq : Entering xmon

[ snip ]

78:mon> ls cmdline_proc_show
cmdline_proc_show: c0000000004196e0
78:mon> bi c0000000004196e0
78:mon> x

~# cat /proc/cmdline
[  505.618702] Oops: Exception in kernel mode, sig: 5 [#1]
[ snip ]
[  505.620082] NIP [c0000000004196e4] cmdline_proc_show+0x4/0x60
[  505.620136] LR [c0000000003b1db0] seq_read+0x130/0x5e0
[  505.620177] Call Trace:
[  505.620202] [c000200e5078fc00] [c0000000003b1d74] seq_read+0xf4/0x5e0 (unreliable)
[  505.620267] [c000200e5078fca0] [c00000000040cae0] proc_reg_read+0xb0/0x110
[  505.620322] [c000200e5078fcf0] [c00000000037687c] __vfs_read+0x6c/0x1b0
[  505.620376] [c000200e5078fd90] [c000000000376a7c] vfs_read+0xbc/0x1b0
[  505.620430] [c000200e5078fde0] [c00000000037724c] SyS_read+0x6c/0x110
[  505.620485] [c000200e5078fe30] [c00000000000b320] system_call+0x58/0x6c
[  505.620536] Instruction dump:
[  505.620570] 3c82ff2a 7fe3fb78 38a00000 3884dee0 4bf98c05 60000000 38210030 e8010010 
[  505.620656] ebe1fff8 7c0803a6 4e800020 3c4c00d6 <38422120> 7c0802a6 f8010010 f821ff91 
[  505.620728] ---[ end trace eaf583921860b3de ]---
[  506.629019] 
Trace/breakpoint trap
~#


> I presume running xmon=off indicates we don't want xmon to take over in case of
> panic/die/oops, 
I believe that when xmon console is available it should be fully
functional rather than partially, otherwise it gets really confusing to
the user as to why Instruction/Data break points arent working.

> why are we tying this to sysrq?
With xmon=off sysrq seems to be the only way to enter xmon console.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

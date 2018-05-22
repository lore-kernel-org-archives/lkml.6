Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEVHYQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:24:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751106AbeEVHYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:24:07 -0400
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Breno Leitao <leitao@debian.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH] powerpc/xmon: really enable xmon when a breakpoint is set
In-Reply-To: <20180521132108.7938-1-msuchanek@suse.de>
References: <20180521132108.7938-1-msuchanek@suse.de>
Date: Tue, 22 May 2018 12:53:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18052207-0044-0000-0000-000005550CC6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052207-0045-0000-0000-00002896986A
Message-Id: <87bmd8xieu.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220088
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch Michal,

Michal Suchanek <msuchanek@suse.de> writes:

> When single-stepping kernel code from xmon without a debug hook enabled
> the kernel crashes. This can happen when kernel starts with xmon on
> crash disabled but xmon is entered using sysrq.
>
> Commit e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
> break-point is set") adds force_enable_xmon function that prints
> "xmon: Enabling debugger hooks" but does not enable them.
Debugger hooks are enabled just befores debugger() is entered from
sysrq_handle_xmon(). Thats why force_enable_xmon() simply sets sets
'xmon_on=1' and exits.

The problem you are seeing is probably due to sysrq_handle_xmon()
clearing the debugger hooks on return from debugger() as xmon_on was
never set for the 's' xmon command.

> Add the call to xmon_init to install the debugger hooks in
> force_enable_xmon and also call force_enable_xmon when single-stepping
> in xmon.
Only calling force_enable_xmon() from do_step() should be suffice as on exit
from the debugger() the value of xmon_on is checked and if required the
debugger hooks are kept instead of getting cleared.


>  arch/powerpc/xmon/xmon.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a0842f1ff72c..504bd1c3d8b0 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c


> @@ -1275,6 +1279,7 @@ static inline void force_enable_xmon(void)
>  	if (!xmon_on) {
>  		printf("xmon: Enabling debugger hooks\n");
>  		xmon_on = 1;
> +		xmon_init(1);
>  	}
>  }

As mentioned above call to force_enable_xmon() is usually done in context of
sysrq_handle_xmon() which sets the debugger hooks as soon as its
entered. So I think that this hunk is not really needed.


-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

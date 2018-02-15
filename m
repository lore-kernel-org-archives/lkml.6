Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeBOGnT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 01:43:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754842AbeBOGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 01:43:13 -0500
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
        "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param xmon=off
In-Reply-To: <87eflnre7w.fsf@concordia.ellerman.id.au>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com> <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com> <8737264c91.fsf@vajain21.in.ibm.com> <87eflnre7w.fsf@concordia.ellerman.id.au>
Date: Thu, 15 Feb 2018 12:13:03 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18021506-0012-0000-0000-000005AEE6F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021506-0013-0000-0000-0000192AB4E5
Message-Id: <87d116wy6g.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking into this patch Mpe.

Michael Ellerman <mpe@ellerman.id.au> writes:
> <snip>
>
> But the same crash happens with XMON_DEFAULT=n and nothing on the
> command line.
Yes, XMON_DEFAULT=n and empty boot command line implies xmon=off hence
you will see the same issue and this patch should fix that issue too.

>
> The problem is not xmon=off on the command line.
>
> The problem is that when xmon_on = false and we enter xmon via sysrq and
> then set breakpoints, we need to enable xmon_on before leaving xmon.
>
Agree on both the points made.

> So this is a bug introduced by:
>
>   3b5bf42b81d5 ("powerpc/xmon: Fix an unexpected xmon on/off state change")
>
>
> How to fix it is not entirely clear. In general I like the behaviour we
> have since the above commit, ie. quickly dropping into xmon and
> inspecting something doesn't leave xmon enabled, which then causes the
> system not to kdump/reboot later.
Agree on the convenience factor of leaving the xmon console
enabled. However we still need a way to disable xmon completely at
kernel-boot time. Leaving xmon enabled even if 'xmon=off' is provided at
command line is counter intuitive.

>
> What would be nice is if we keep that behaviour, but any action you take
> in xmon that requires xmon to remain resident, ie. setting a breakpoint,
> calls a function which makes sure xmon_on = true and if it wasn't prints
> a nice message saying "Turning xmon on due to breakpoint insertion" or
> something.
That makes sense to me and sounds workable. However we already have a
debugfs interface to enable/disable xmon debugger hook. I can also tweak
this interface to also register the sysrq key when xmon is enabled. This
should provide the user the ability to still use xmon if they want to
after the system has booted with xmon=off.

>
> cheers
>

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

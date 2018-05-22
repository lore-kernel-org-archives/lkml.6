Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeEVWGv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:06:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753085AbeEVWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:06:46 -0400
Date: Tue, 22 May 2018 15:08:18 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:rcu/dev 5/99] arch/x86/kernel/cpu/mtrr/main.c:797:
 undefined reference to `rcu_cpu_starting'
Reply-To: paulmck@linux.vnet.ibm.com
References: <201805230528.PpQTquMr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805230528.PpQTquMr%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052222-0008-0000-0000-0000030E070C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036194; UDB=6.00530065; IPR=6.00815323;
 MB=3.00021246; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 22:06:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052222-0009-0000-0000-0000395C16EC
Message-Id: <20180522220818.GA3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 05:30:30AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/dev
> head:   477fc1978395d58ae0406293a1d963629778a39d
> commit: 354238a30982b817262fe6f9d00f808451694366 [5/99] rcu/x86: Provide early rcu_cpu_starting() callback
> config: i386-randconfig-i1-201820 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 354238a30982b817262fe6f9d00f808451694366
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):

Problems with !SMP, which I am beating up on...

							Thanx, Paul

>    arch/x86/kernel/cpu/mtrr/main.o: In function `mtrr_ap_init':
> >> arch/x86/kernel/cpu/mtrr/main.c:797: undefined reference to `rcu_cpu_starting'
> 
> vim +797 arch/x86/kernel/cpu/mtrr/main.c
> 
>    788	
>    789	void mtrr_ap_init(void)
>    790	{
>    791		if (!mtrr_enabled())
>    792			return;
>    793	
>    794		if (!use_intel() || mtrr_aps_delayed_init)
>    795			return;
>    796	
>  > 797		rcu_cpu_starting(smp_processor_id());
>    798	
>    799		/*
>    800		 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
>    801		 * changed, but this routine will be called in cpu boot time,
>    802		 * holding the lock breaks it.
>    803		 *
>    804		 * This routine is called in two cases:
>    805		 *
>    806		 *   1. very earily time of software resume, when there absolutely
>    807		 *      isn't mtrr entry changes;
>    808		 *
>    809		 *   2. cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug
>    810		 *      lock to prevent mtrr entry changes
>    811		 */
>    812		set_mtrr_from_inactive_cpu(~0U, 0, 0, 0);
>    813	}
>    814	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

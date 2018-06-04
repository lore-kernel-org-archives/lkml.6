Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeFDMUN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:20:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44321 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750868AbeFDMUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:20:11 -0400
Subject: Re: [PATCH 5/7] iommu/dma: add support for non-strict mode
To: kbuild test robot <lkp@intel.com>
References: <1527752569-18020-6-git-send-email-thunder.leizhen@huawei.com>
 <201806020106.eRUp2Ehc%fengguang.wu@intel.com>
CC: <kbuild-all@01.org>, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B152E4D.4040205@huawei.com>
Date: Mon, 4 Jun 2018 20:19:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <201806020106.eRUp2Ehc%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/2 1:51, kbuild test robot wrote:
> Hi Zhen,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.17-rc7 next-20180601]
> [cannot apply to iommu/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Zhen-Lei/add-non-strict-mode-support-for-arm-smmu-v3/20180602-000418
> config: x86_64-randconfig-x008-201821 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//iommu/amd_iommu.c: In function 'amd_iommu_capable':
>>> drivers//iommu/amd_iommu.c:3053:2: warning: enumeration value 'IOMMU_CAP_NON_STRICT' not handled in switch [-Wswitch]
>      switch (cap) {
>      ^~~~~~
> 
> vim +/IOMMU_CAP_NON_STRICT +3053 drivers//iommu/amd_iommu.c
> 
> 645c4c8d arch/x86/kernel/amd_iommu.c Joerg Roedel 2008-12-02  3050  
> ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3051  static bool amd_iommu_capable(enum iommu_cap cap)
> dbb9fd86 arch/x86/kernel/amd_iommu.c Sheng Yang   2009-03-18  3052  {
> 80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27 @3053  	switch (cap) {
> 80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27  3054  	case IOMMU_CAP_CACHE_COHERENCY:
> ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3055  		return true;
> bdddadcb drivers/iommu/amd_iommu.c   Joerg Roedel 2012-07-02  3056  	case IOMMU_CAP_INTR_REMAP:
> ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3057  		return (irq_remapping_enabled == 1);
> cfdeec22 drivers/iommu/amd_iommu.c   Will Deacon  2014-10-27  3058  	case IOMMU_CAP_NOEXEC:
It seems that it's better to change this to 'default'.

> cfdeec22 drivers/iommu/amd_iommu.c   Will Deacon  2014-10-27  3059  		return false;
> 80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27  3060  	}
> 80a506b8 arch/x86/kernel/amd_iommu.c Joerg Roedel 2010-07-27  3061  
> ab636481 drivers/iommu/amd_iommu.c   Joerg Roedel 2014-09-05  3062  	return false;
> dbb9fd86 arch/x86/kernel/amd_iommu.c Sheng Yang   2009-03-18  3063  }
> dbb9fd86 arch/x86/kernel/amd_iommu.c Sheng Yang   2009-03-18  3064  
> 
> :::::: The code at line 3053 was first introduced by commit
> :::::: 80a506b8fdcfa868bb53eb740f928217d0966fc1 x86/amd-iommu: Export cache-coherency capability
> 
> :::::: TO: Joerg Roedel <joerg.roedel@amd.com>
> :::::: CC: Joerg Roedel <joerg.roedel@amd.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Thanks!
BestRegards

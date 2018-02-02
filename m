Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeBBX62 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:58:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:61629 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751857AbeBBX6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:58:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,452,1511856000";
   d="scan'208";a="15079069"
Date: Sat, 3 Feb 2018 07:57:49 +0800
From: kbuild test robot <lkp@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org,
        jroedel@suse.de, alex.williamson@redhat.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/2] iommu: Fix iommu_unmap and iommu_unmap_fast return
 type
Message-ID: <201802030748.xftfsqJe%fengguang.wu@intel.com>
References: <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.15 next-20180202]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suravee-Suthikulpanit/iommu-Fix-iommu_unmap-and-iommu_unmap_fast-return-type/20180203-015316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iommu/qcom_iommu.c:592:27: sparse: incorrect type in initializer (different signedness) @@ expected long ( )( ... ) @@ got unsigned long ( )( ... ) @@
   drivers/iommu/qcom_iommu.c:592:27: expected long ( )( ... )
   drivers/iommu/qcom_iommu.c:592:27: got unsigned long ( )( ... )
   drivers/iommu/qcom_iommu.c:592:12: error: initialization from incompatible pointer type
    .unmap = qcom_iommu_unmap,
    ^~~~~~~~~~~~~~~~
   drivers/iommu/qcom_iommu.c:592:12: note: (near initialization for 'qcom_iommu_ops.unmap')
   cc1: some warnings being treated as errors

vim +592 drivers/iommu/qcom_iommu.c

0ae349a0f3 Rob Clark    2017-08-09  584  
0ae349a0f3 Rob Clark    2017-08-09  585  static const struct iommu_ops qcom_iommu_ops = {
0ae349a0f3 Rob Clark    2017-08-09  586  	.capable	= qcom_iommu_capable,
0ae349a0f3 Rob Clark    2017-08-09  587  	.domain_alloc	= qcom_iommu_domain_alloc,
0ae349a0f3 Rob Clark    2017-08-09  588  	.domain_free	= qcom_iommu_domain_free,
0ae349a0f3 Rob Clark    2017-08-09  589  	.attach_dev	= qcom_iommu_attach_dev,
0ae349a0f3 Rob Clark    2017-08-09  590  	.detach_dev	= qcom_iommu_detach_dev,
0ae349a0f3 Rob Clark    2017-08-09  591  	.map		= qcom_iommu_map,
0ae349a0f3 Rob Clark    2017-08-09 @592  	.unmap		= qcom_iommu_unmap,
0ae349a0f3 Rob Clark    2017-08-09  593  	.map_sg		= default_iommu_map_sg,
4d689b6194 Robin Murphy 2017-09-28  594  	.flush_iotlb_all = qcom_iommu_iotlb_sync,
4d689b6194 Robin Murphy 2017-09-28  595  	.iotlb_sync	= qcom_iommu_iotlb_sync,
0ae349a0f3 Rob Clark    2017-08-09  596  	.iova_to_phys	= qcom_iommu_iova_to_phys,
0ae349a0f3 Rob Clark    2017-08-09  597  	.add_device	= qcom_iommu_add_device,
0ae349a0f3 Rob Clark    2017-08-09  598  	.remove_device	= qcom_iommu_remove_device,
0ae349a0f3 Rob Clark    2017-08-09  599  	.device_group	= generic_device_group,
0ae349a0f3 Rob Clark    2017-08-09  600  	.of_xlate	= qcom_iommu_of_xlate,
0ae349a0f3 Rob Clark    2017-08-09  601  	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
0ae349a0f3 Rob Clark    2017-08-09  602  };
0ae349a0f3 Rob Clark    2017-08-09  603  

:::::: The code at line 592 was first introduced by commit
:::::: 0ae349a0f33fb040a2bc228fdc6d60111455feab iommu/qcom: Add qcom_iommu

:::::: TO: Rob Clark <robdclark@gmail.com>
:::::: CC: Joerg Roedel <jroedel@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214F7208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214F7208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeFUE7b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:59:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:63423 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932403AbeFUE7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:59:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 21:59:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,250,1526367600"; 
   d="scan'208";a="66397695"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 21:59:17 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fVrgi-000Ln0-Mj; Thu, 21 Jun 2018 12:59:16 +0800
Date:   Thu, 21 Jun 2018 12:58:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 5/5] PCI: Unify slot and bus reset API
Message-ID: <201806211229.kMutzrVj%fengguang.wu@intel.com>
References: <1529467995-28780-5-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529467995-28780-5-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.18-rc1 next-20180620]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/PCI-handle-error-return-from-pci_reset_bridge_secondary_bus/20180620-121648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/infiniband/hw/hfi1/pcie.c:908:33: sparse: incorrect type in argument 1 (different base types) @@    expected struct pci_dev *dev @@    got struct pci_dev *dev @@
   drivers/infiniband/hw/hfi1/pcie.c:908:33:    expected struct pci_dev *dev
   drivers/infiniband/hw/hfi1/pcie.c:908:33:    got struct pci_bus *bus
   drivers/infiniband/hw/hfi1/pcie.c: In function 'trigger_sbr':
   drivers/infiniband/hw/hfi1/pcie.c:908:23: error: passing argument 1 of 'pci_reset_bus' from incompatible pointer type [-Werror=incompatible-pointer-types]
     return pci_reset_bus(dev->bus);
                          ^~~
   In file included from drivers/infiniband/hw/hfi1/pcie.c:48:0:
   include/linux/pci.h:1099:5: note: expected 'struct pci_dev *' but argument is of type 'struct pci_bus *'
    int pci_reset_bus(struct pci_dev *dev);
        ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +908 drivers/infiniband/hw/hfi1/pcie.c

77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  873  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  874  /*
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  875   * Trigger a secondary bus reset (SBR) on ourselves using our parent.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  876   *
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  877   * Based on pci_parent_bus_reset() which is not exported by the
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  878   * kernel core.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  879   */
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  880  static int trigger_sbr(struct hfi1_devdata *dd)
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  881  {
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  882  	struct pci_dev *dev = dd->pcidev;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  883  	struct pci_dev *pdev;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  884  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  885  	/* need a parent */
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  886  	if (!dev->bus->self) {
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  887  		dd_dev_err(dd, "%s: no parent device\n", __func__);
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  888  		return -ENOTTY;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  889  	}
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  890  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  891  	/* should not be anyone else on the bus */
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  892  	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  893  		if (pdev != dev) {
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  894  			dd_dev_err(dd,
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  895  				   "%s: another device is on the same bus\n",
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  896  				   __func__);
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  897  			return -ENOTTY;
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  898  		}
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  899  
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  900  	/*
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  901  	 * A secondary bus reset (SBR) issues a hot reset to our device.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  902  	 * The following routine does a 1s wait after the reset is dropped
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  903  	 * per PCI Trhfa (recovery time).  PCIe 3.0 section 6.6.1 -
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  904  	 * Conventional Reset, paragraph 3, line 35 also says that a 1s
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  905  	 * delay after a reset is required.  Per spec requirements,
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  906  	 * the link is either working or not after that point.
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  907  	 */
f001109e drivers/infiniband/hw/hfi1/pcie.c Sinan Kaya       2018-06-20 @908  	return pci_reset_bus(dev->bus);
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  909  }
77241056 drivers/staging/rdma/hfi1/pcie.c  Mike Marciniszyn 2015-07-30  910  

:::::: The code at line 908 was first introduced by commit
:::::: f001109e94b74baebb3621ce1c7ba114a858adb3 IB/hfi1: use pci_reset_bus() for initiating pci secondary bus reset

:::::: TO: Sinan Kaya <okaya@codeaurora.org>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

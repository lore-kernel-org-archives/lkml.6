Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeCFGzO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:55:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:62763 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeCFGzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:55:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="35806186"
Date: Tue, 6 Mar 2018 14:54:11 +0800
From: kbuild test robot <lkp@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kbuild-all@01.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com,
        eric.auger@redhat.com, aik@ozlabs.ru
Subject: Re: [PATCH 3/3] vfio/pci: Add ioeventfd support
Message-ID: <201803061415.NOLGNvAS%fengguang.wu@intel.com>
References: <20180228201520.25283.97532.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228201520.25283.97532.stgit@gimli.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc4 next-20180306]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alex-Williamson/vfio-pci-Pull-BAR-mapping-setup-from-read-write-path/20180303-015851
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/vfio/pci/vfio_pci_rdwr.c:290:1: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:2>*<noident> @@    got sn:2>*<noident> @@
   drivers/vfio/pci/vfio_pci_rdwr.c:290:1:    expected void [noderef] <asn:2>*<noident>
   drivers/vfio/pci/vfio_pci_rdwr.c:290:1:    got void *opaque
   drivers/vfio/pci/vfio_pci_rdwr.c:291:1: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:2>*<noident> @@    got sn:2>*<noident> @@
   drivers/vfio/pci/vfio_pci_rdwr.c:291:1:    expected void [noderef] <asn:2>*<noident>
   drivers/vfio/pci/vfio_pci_rdwr.c:291:1:    got void *opaque
   drivers/vfio/pci/vfio_pci_rdwr.c:292:1: sparse: incorrect type in argument 2 (different address spaces) @@    expected void [noderef] <asn:2>*<noident> @@    got sn:2>*<noident> @@
   drivers/vfio/pci/vfio_pci_rdwr.c:292:1:    expected void [noderef] <asn:2>*<noident>
   drivers/vfio/pci/vfio_pci_rdwr.c:292:1:    got void *opaque
>> drivers/vfio/pci/vfio_pci_rdwr.c:378:52: sparse: incorrect type in argument 1 (different address spaces) @@    expected void *opaque @@    got void [noderef] <avoid *opaque @@
   drivers/vfio/pci/vfio_pci_rdwr.c:378:52:    expected void *opaque
   drivers/vfio/pci/vfio_pci_rdwr.c:378:52:    got void [noderef] <asn:2>*

vim +290 drivers/vfio/pci/vfio_pci_rdwr.c

   286	
   287	#ifdef iowrite64
   288	VFIO_PCI_IOEVENTFD_HANDLER(64)
   289	#endif
 > 290	VFIO_PCI_IOEVENTFD_HANDLER(32)
   291	VFIO_PCI_IOEVENTFD_HANDLER(16)
   292	VFIO_PCI_IOEVENTFD_HANDLER(8)
   293	
   294	long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
   295				uint64_t data, int count, int fd)
   296	{
   297		struct pci_dev *pdev = vdev->pdev;
   298		loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
   299		int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
   300		struct vfio_pci_ioeventfd *ioeventfd;
   301		int (*handler)(void *addr, void *value);
   302	
   303		/* Only support ioeventfds into BARs */
   304		if (bar > VFIO_PCI_BAR5_REGION_INDEX)
   305			return -EINVAL;
   306	
   307		if (pos + count > pci_resource_len(pdev, bar))
   308			return -EINVAL;
   309	
   310		/* Disallow ioeventfds working around MSI-X table writes */
   311		if (bar == vdev->msix_bar &&
   312		    !(pos + count <= vdev->msix_offset ||
   313		      pos >= vdev->msix_offset + vdev->msix_size))
   314			return -EINVAL;
   315	
   316		switch (count) {
   317		case 1:
   318			handler = &vfio_pci_ioeventfd_handler8;
   319			break;
   320		case 2:
   321			handler = &vfio_pci_ioeventfd_handler16;
   322			break;
   323		case 4:
   324			handler = &vfio_pci_ioeventfd_handler32;
   325			break;
   326	#ifdef iowrite64
   327		case 8:
   328			handler = &vfio_pci_ioeventfd_handler64;
   329			break;
   330	#endif
   331		default:
   332			return -EINVAL;
   333		}
   334	
   335		ret = vfio_pci_setup_barmap(vdev, bar);
   336		if (ret)
   337			return ret;
   338	
   339		mutex_lock(&vdev->ioeventfds_lock);
   340	
   341		list_for_each_entry(ioeventfd, &vdev->ioeventfds_list, next) {
   342			if (ioeventfd->pos == pos && ioeventfd->bar == bar &&
   343			    ioeventfd->data == data && ioeventfd->count == count) {
   344				if (fd == -1) {
   345					vfio_virqfd_disable(&ioeventfd->virqfd);
   346					list_del(&ioeventfd->next);
   347					vdev->ioeventfds_nr--;
   348					kfree(ioeventfd);
   349					ret = 0;
   350				} else
   351					ret = -EEXIST;
   352	
   353				goto out_unlock;
   354			}
   355		}
   356	
   357		if (fd < 0) {
   358			ret = -ENODEV;
   359			goto out_unlock;
   360		}
   361	
   362		if (vdev->ioeventfds_nr >= VFIO_PCI_IOEVENTFD_MAX) {
   363			ret = -ENOSPC;
   364			goto out_unlock;
   365		}
   366	
   367		ioeventfd = kzalloc(sizeof(*ioeventfd), GFP_KERNEL);
   368		if (!ioeventfd) {
   369			ret = -ENOMEM;
   370			goto out_unlock;
   371		}
   372	
   373		ioeventfd->pos = pos;
   374		ioeventfd->bar = bar;
   375		ioeventfd->data = data;
   376		ioeventfd->count = count;
   377	
 > 378		ret = vfio_virqfd_enable(vdev->barmap[bar] + pos, handler, NULL,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

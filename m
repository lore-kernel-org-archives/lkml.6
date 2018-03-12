Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCLSvV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:51:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:62875 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeCLSvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:51:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="scan'208";a="182027177"
Date: Mon, 12 Mar 2018 12:23:21 -0600
From: Keith Busch <keith.busch@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, netanel@amazon.com,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
        dwmw@amazon.co.uk
Subject: Re: [pci PATCH v5 1/4] pci: Add pci_sriov_configure_simple for PFs
 that don't manage VF resources
Message-ID: <20180312182321.GG18494@localhost.localdomain>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172031.3487.20651.stgit@localhost.localdomain>
 <20180312174012.GE18494@localhost.localdomain>
 <CAKgT0UdWc=Sz-xgd4H3bTDt5d17=-PY8VPWz6A3mAciWV6=97w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdWc=Sz-xgd4H3bTDt5d17=-PY8VPWz6A3mAciWV6=97w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:09:34AM -0700, Alexander Duyck wrote:
> On Mon, Mar 12, 2018 at 10:40 AM, Keith Busch <keith.busch@intel.com> wrote:
> > On Mon, Mar 12, 2018 at 10:21:29AM -0700, Alexander Duyck wrote:
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 024a1beda008..9cab9d0d51dc 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -1953,6 +1953,7 @@ static inline void pci_mmcfg_late_init(void) { }
> >>  int pci_vfs_assigned(struct pci_dev *dev);
> >>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
> >>  int pci_sriov_get_totalvfs(struct pci_dev *dev);
> >> +int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
> >>  resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
> >>  void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
> >>  #else
> >
> > I recommend stubbing 'pci_sriov_configure_simple' or defining it to
> > NULL in the '#else' section here so you don't need to repeat the "#ifdef
> > CONFIG_PCI_IOV" in each driver wishing to use this function. Otherwise
> > looks fine to me.
> 
> My concern with defining it as NULL is that somebody may end up
> calling it in the future directly and that may end up causing issues.
> One thought I have been debating is moving it to a different file. I
> am just not sure where the best place to put something like this would
> be. I could move this function to drivers/pci/pci.c if everyone is
> okay with it and then I could just strip the contents out by wrapping
> them in a #ifdef instead.

Okay, instead of NULL, a stub implementation in the header file may
suffice when CONFIG_PCI_IOV is not defined:

static inline int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn)
{
	return -ENOSYS;
}

See pci_iov_virtfn_bus, pci_iov_virtfn_devfn, pci_iov_add_virtfn, or
pci_enable_sriov for other examples.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeE3Qyn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:54:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:24566 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753670AbeE3Qyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:54:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="45449353"
From: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
To: "Rustad, Mark D" <mark.d.rustad@intel.com>,
        "mst@redhat.com" <mst@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Daly, Dan" <dan.daly@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
Thread-Topic: [PATCH] virtio_pci: support enabling VFs
Thread-Index: AQHT9/P5uaO7GXR/D0ickSAfuvKJDaRI6igAgAAGIoCAAALrgA==
Date: Wed, 30 May 2018 16:54:35 +0000
Message-ID: <1527699273.29907.2.camel@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
         <20180530192010-mutt-send-email-mst@kernel.org>
         <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
In-Reply-To: <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.177.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE63E1D03CDD854B8989945BAE9C2E54@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4UGspnX002814

On Wed, 2018-05-30 at 09:44 -0700, Rustad, Mark D wrote:
> On May 30, 2018, at 9:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > > +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int  
> > > num_vfs)
> > > +{
> > > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > > +	struct virtio_device *vdev = &vp_dev->vdev;
> > > +	int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
> > > +
> > > +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		return -EBUSY;
> > > +
> > > +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
> > > +		return -EINVAL;
> > > +
> > > +	sriov_configure = pci_sriov_configure_simple;
> > > +	if (sriov_configure == NULL)
> > > +		return -ENOENT;
> > 
> > BTW what is all this trickery in aid of?
> 
> When SR-IOV support is not compiled into the kernel,  
> pci_sriov_configure_simple is #defined as NULL. This allows it to compile  
> in that case, even though there is utterly no way for it to be called in  
> that case. It is an alternative to #ifs in the code.

Why even have the call though? I would wrap all of this in an #ifdef
and strip it out since you couldn't support SR-IOV if it isn't present
in the kernel anyway.

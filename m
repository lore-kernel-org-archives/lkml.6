Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeE3Q0e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:26:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:29567 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeE3Q0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:26:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="43998862"
From: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
To: "mst@redhat.com" <mst@redhat.com>,
        "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        "Daly, Dan" <dan.daly@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Thread-Topic: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Thread-Index: AQHT9/P5uaO7GXR/D0ickSAfuvKJDaRI5waAgAADPwCAAAEXAA==
Date: Wed, 30 May 2018 16:26:30 +0000
Message-ID: <1527697588.16245.136.camel@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
         <CAKgT0UcRZd5ajpTyC3KMvNFACVAb6D8A9Tss3m0r+UdamvVeRA@mail.gmail.com>
         <20180530192215-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180530192215-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.177.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <27BDE5CE4F9BBE428A5669147C2A00EF@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4UGQdOA031540

On Wed, 2018-05-30 at 19:22 +0300, Michael S. Tsirkin wrote:
> On Wed, May 30, 2018 at 09:10:57AM -0700, Alexander Duyck wrote:
> > On Wed, May 30, 2018 at 1:55 AM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> > > There is a new feature bit allocated in virtio spec to
> > > support SR-IOV (Single Root I/O Virtualization):
> > > 
> > > https://github.com/oasis-tcs/virtio-spec/issues/11
> > > 
> > > This patch enables the support for this feature bit in
> > > virtio driver.
> > > 
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > 
> > So from a quick glance it looks like we are leaving SR-IOV enabled if
> > the driver is removed. Do we want to have that behavior or should we
> > be adding the code to disable SR-IOV and free the VFs on driver
> > removal?
> 
> Could pci core handle it for us somehow?

Maybe, but it would require changes to the pci core to do it.

The problem is some drivers want to leave the VFs there since the PF
doesn't really do anything, or they have the option of essentially
putting the VFs into a standby state when the PF is gone.

My main concern is do we care if VFs are allocated and then somebody
removes the driver and binds a different driver to the interface? If
not then this code and be left as is, but I just wanted to be certain
since I know this isn't just enabling SR-IOV we are having to do a
number of other checks against the virtio device.

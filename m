Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E3ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0306F20673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0306F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeISJf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbeISJf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:35:56 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22B9E30014B0;
        Wed, 19 Sep 2018 03:59:59 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15607308BDA0;
        Wed, 19 Sep 2018 03:59:58 +0000 (UTC)
Date:   Tue, 18 Sep 2018 21:59:57 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Message-ID: <20180918215957.0d155684@t450s.home>
In-Reply-To: <20180912174618.GA19551@araj-mobl1.jf.intel.com>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
        <20180809134417.50de7fe7@t450s.home>
        <20180912174618.GA19551@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Sep 2018 03:59:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 10:46:19 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> On Thu, Aug 09, 2018 at 01:44:17PM -0600, Alex Williamson wrote:
> > On Thu,  9 Aug 2018 12:37:06 -0700
> > Ashok Raj <ashok.raj@intel.com> wrote:
> >   
> > > PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual
> > > Functions.
> > > 
> > > Some SRIOV devices have some bugs in RTL and VF's end up reading 1
> > > instead of 0 for the PIN.  
> > 
> > Hi Ashok,
> > 
> > One question, can we identify which VFs are known to have this
> > issue so that users (and downstreams) can know how to prioritize
> > this patch?  
> 
> Hi Alex
> 
> Sorry it took some time to hunt this down. 
> 
> The offending VF has a device ID : 0x270C
> The corresponding PF has a device ID: 0x270B.

Ok, I interpret Alan's previous comment about the patch[1] to suggest a
structure a bit more like that below.  IOW, we know that 8086:270c
inspires this change, but once it's included we won't know who else
relies on it.  We can perhaps encourage better hardware validation, or
at least better tracking of who needs this with a warning and
whitelist.  Testing, especially positive and negative testing against
the warning, and reviews welcome.  Thanks,

Alex

[1]https://lkml.org/lkml/2018/8/10/462

commit d780da26a81c6f47522ae0aeff03abd4d08b89b5
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue Sep 18 21:27:57 2018 -0600

    vfio/pci: Mask buggy SR-IOV VF INTx support
    
    The SR-IOV spec requires that VFs must report zero for the INTx pin
    register as VFs are precluded from INTx support.  It's much easier for
    the host kernel to understand whether a device is a VF and therefore
    whether a non-zero pin register value is bogus than it is to do the
    same in userspace.  Override the INTx count for such devices and
    virtualize the pin register to provide a consistent view of the device
    to the user.
    
    As this is clearly a spec violation, warn about it to support hardware
    validation, but also provide a known whitelist as it doesn't do much
    good to continue complaining if the hardware vendor doesn't plan to
    fix it.
    
    Known devices with this issue: 8086:270c
    
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cddb453a1ba5..8af3f6f35f32 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -430,14 +430,41 @@ static int vfio_pci_open(void *device_data)
 	return ret;
 }
 
+static const struct pci_device_id known_bogus_vf_intx_pin[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x270c) },
+	{}
+};
+
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 {
 	if (irq_type == VFIO_PCI_INTX_IRQ_INDEX) {
 		u8 pin;
+
+		if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
+			return 0;
+
 		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
-		if (IS_ENABLED(CONFIG_VFIO_PCI_INTX) && !vdev->nointx && pin)
-			return 1;
 
+		/*
+		 * Per SR-IOV spec rev 1.1, 3.4.1.18 the interrupt pin register
+		 * does not apply to VFs and VFs must implement this register
+		 * as read-only with value zero.  Userspace is not readily
+		 * able to identify a device as a VF and thus that the pin
+		 * definition on the device is bogus should a device violate
+		 * this requirement.  For such devices, override the bogus
+		 * value and provide a warning to support hardware validation
+		 * (or be quite if it's known).  PCI config space emulation
+		 * will virtualize this register for all VFs.
+		 */
+		if (pin && vdev->pdev->is_virtfn) {
+			if (!pci_match_id(known_bogus_vf_intx_pin, vdev->pdev))
+				dev_warn_once(&vdev->pdev->dev,
+					      "VF reports bogus INTx pin %d\n",
+					      pin);
+			return 0;
+		}
+
+		return pin ? 1 : 0;
 	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
 		u8 pos;
 		u16 flags;
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 62023b4a373b..25130fa6e265 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1678,7 +1678,8 @@ int vfio_config_init(struct vfio_pci_device *vdev)
 		*(__le16 *)&vconfig[PCI_DEVICE_ID] = cpu_to_le16(pdev->device);
 	}
 
-	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
+	    pdev->is_virtfn)
 		vconfig[PCI_INTERRUPT_PIN] = 0;
 
 	ret = vfio_cap_init(vdev);

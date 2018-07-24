Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF5C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42EC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42EC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbeGXU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388470AbeGXU7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:59:04 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BCE8BDD1;
        Tue, 24 Jul 2018 19:51:03 +0000 (UTC)
Received: from t450s.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E78C1309128B;
        Tue, 24 Jul 2018 19:51:01 +0000 (UTC)
Date:   Tue, 24 Jul 2018 13:51:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Message-ID: <20180724135101.58e81678@t450s.home>
In-Reply-To: <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
        <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
        <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
        <5B568D5B.5050606@linux.intel.com>
        <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 24 Jul 2018 19:51:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 12:30:35 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Baolu,
> 
> On 24/07/18 03:22, Lu Baolu wrote:
> > Hi,
> > 
> > On 07/23/2018 12:44 PM, Liu, Yi L wrote:  
> >>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> >>> Sent: Sunday, July 22, 2018 2:09 PM
> >>>
> >>> With the Intel IOMMU supporting PASID granularity isolation and protection, a
> >>> mediated device could be isolated and protected by an IOMMU unit. We need to
> >>> allocate a new group instead of a PCI group.  
> >> Existing vfio mdev framework also allocates an iommu group for mediate device.
> >>
> >> mdev_probe()
> >>   |_ mdev_attach_iommu()
> >>        |_ iommu_group_alloc()  
> > 
> > When external components ask iommu to allocate a group for a device,
> > it will call pci_device_group in Intel IOMMU driver's @device_group
> > callback. In another word, current Intel IOMMU driver doesn't aware
> > the mediated device and treat all devices as PCI ones. This patch
> > extends the @device_group call back to make it aware of a mediated
> > device.  
> 
> I agree that allocating two groups for an mdev seems strange, and in my
> opinion we shouldn't export the notion of mdev to IOMMU drivers.

Yep, I was just thinking the same thing.  This is too highly integrated
into VT-d and too narrowly focused on PASID being the only way that an
mdev could make use of the IOMMU.  Thanks,

Alex

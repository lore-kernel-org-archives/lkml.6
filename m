Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468BF206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468BF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeIEXrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbeIEXrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C8B03083393;
        Wed,  5 Sep 2018 19:15:38 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67D78600C5;
        Wed,  5 Sep 2018 19:15:34 +0000 (UTC)
Date:   Wed, 5 Sep 2018 13:15:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Message-ID: <20180905131534.1e638e3e@t450s.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F128F@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1912F128F@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Sep 2018 19:15:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 03:01:39 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> > Sent: Thursday, August 30, 2018 12:09 PM
> >   
> [...]
> > 
> > In order to distinguish the IOMMU-capable mediated devices from those
> > which still need to rely on parent devices, this patch set adds a
> > domain type attribute to each mdev.
> > 
> > enum mdev_domain_type {
> > 	DOMAIN_TYPE_NO_IOMMU,	/* Don't need any IOMMU support.
> > 				 * All isolation and protection
> > 				 * are handled by the parent
> > 				 * device driver with a device
> > 				 * specific mechanism.
> > 				 */
> > 	DOMAIN_TYPE_ATTACH_PARENT, /* IOMMU can isolate and
> > protect
> > 				    * the mdev, and the isolation
> > 				    * domain should be attaced with
> > 				    * the parent device.
> > 				    */
> > };
> >   
> 
> ATTACH_PARENT is not like a good counterpart to NO_IOMMU.

Please do not use NO_IOMMU, we already have a thing called
vfio-noiommu, enabled through CONFIG_VFIO_NOIOMMU and module parameter
enable_unsafe_noiommu_mode.  This is much, much too similar and will
generate confusion.

> what about DOMAIN_TYPE_NO_IOMMU/DOMAIN_TYPE_IOMMU? whether
> to attach parent device is just internal logic.
> 
> Alternatively DOMAIN_TYPE_SOFTWARE/DOMAIN_TYPE_HARDWARE,
> where software means iommu_domain is managed by software while
> the other means managed by hardware.

I haven't gotten deep enough into the series to see how it's used, but
my gut reaction is that we don't need an enum, we just need some sort
of pointer on the mdev that points to an iommu_parent, which indicates
the root of our IOMMU based isolation, or is NULL, which indicates we
use vendor defined isolation as we have now.

> One side note to Alex - with multiple domain extension in IOMMU layer,
> this version combines IOMMU-capable usages in VFIO: PASID-based (as 
> in scalable iov) and RID-based (as the usage of mdev wrapper on any 
> device). Both cases share the common path - just binding the domain to the
> parent device of mdev. IOMMU layer will handle two cases differently later. 

Good, I'm glad you've considered the regular (RID) IOMMU domain and not
just the new aux domain.  Thanks,

Alex

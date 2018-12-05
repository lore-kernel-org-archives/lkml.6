Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D537C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFBB20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFBB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeLEPuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:50:14 -0500
Received: from 8bytes.org ([81.169.241.247]:51918 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLEPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:50:13 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5B907345; Wed,  5 Dec 2018 16:50:12 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:50:12 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Message-ID: <20181205155012.GC16835@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-3-baolu.lu@linux.intel.com>
 <20181203134411.lejlkbnagxml54ro@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838B9@SHSMSX104.ccr.corp.intel.com>
 <5c81008b-30e8-177d-0182-db366608562f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c81008b-30e8-177d-0182-db366608562f@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:58:06PM +0800, Lu Baolu wrote:
> This function is called in an unsleepable context.
> 
> spin_lock(&lock)
> [...]
> if (pasid_table_is_necessary)
> 	allocate_pasid_table(dev)
> [...]
> spin_unlock(&lock)
> 
> We can move it out of the lock range.
> 
> How about
> 
> if (pasid_table_is_necessary)
> 	pasid_table = allocate_pasid_table(dev)
> 
> spin_lock(&lock)
> [...]
> if (pasid_table_is_necessary)
> 	set_up_pasid_table(pasid_table)
> [...]
> spin_unlock(&lock)

Hmm, so when the IOMMU is configured in scalable mode we can just
allocate a pasid-table for the device when we set it up, right?

Scalable mode is a boot-time decision, so we know for sure whether we
need a pasid-table on device-setup time. And the device-setup code it
preemptable, so I think it this allocation should be outside of any
spin-locked section.


	Joerg

Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA622082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA622082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLCNuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:50:05 -0500
Received: from 8bytes.org ([81.169.241.247]:51246 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCNuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:50:04 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B4EB2402; Mon,  3 Dec 2018 14:48:57 +0100 (CET)
Date:   Mon, 3 Dec 2018 14:48:56 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        peterx@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
Message-ID: <20181203134856.lui4us4ejm4d5avz@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128035449.10226-5-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:54:41AM +0800, Lu Baolu wrote:
> -
> -	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO, 0);
> +	/*
> +	 * Need two pages to accommodate 256 descriptors of 256 bits each
> +	 * if the remapping hardware supports scalable mode translation.
> +	 */
> +	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
> +				     !!ecap_smts(iommu->ecap));


Same here, does the allocation really need GFP_ATOMIC?

>  struct q_inval {
>  	raw_spinlock_t  q_lock;
> -	struct qi_desc  *desc;          /* invalidation queue */
> +	void		*desc;          /* invalidation queue */
>  	int             *desc_status;   /* desc status */
>  	int             free_head;      /* first free entry */
>  	int             free_tail;      /* last free entry */

Why do you switch the pointer to void* ?


	Joerg

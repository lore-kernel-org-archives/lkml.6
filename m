Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC2DC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F7C2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F7C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIGETN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:19:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:8981 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbeIGETN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:19:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 16:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="89648597"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 16:41:17 -0700
Date:   Thu, 6 Sep 2018 16:43:17 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Message-ID: <20180906164317.786bbdda@jacob-builder>
In-Reply-To: <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
        <20180830013524.28743-3-baolu.lu@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A85@SHSMSX101.ccr.corp.intel.com>
        <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 10:46:03 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> >> @@ -224,7 +271,14 @@ struct pasid_entry
> >> *intel_pasid_get_entry(struct device *dev, int pasid)
> >>    */
> >>   static inline void pasid_clear_entry(struct pasid_entry *pe)
> >>   {
> >> -	WRITE_ONCE(pe->val, 0);
> >> +	WRITE_ONCE(pe->val[0], 0);
> >> +	WRITE_ONCE(pe->val[1], 0);
> >> +	WRITE_ONCE(pe->val[2], 0);
> >> +	WRITE_ONCE(pe->val[3], 0);
> >> +	WRITE_ONCE(pe->val[4], 0);
> >> +	WRITE_ONCE(pe->val[5], 0);
> >> +	WRITE_ONCE(pe->val[6], 0);
> >> +	WRITE_ONCE(pe->val[7], 0);  
> > 
> > memset?  
> 
> The order is important here. Otherwise, the PRESENT bit of this pasid
> entry might still set while other fields contains invalid values.

WRITE_ONCE/READ_ONCE will switch to __builtin_memcpy() in if the size
exceeds word size, ie. 64bit in this case. I don;t think compiler will
reorder built-in function. Beside, we only need to clear present and
FDP bit, right?


Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48Iagt3JZq+MiYqJYPBEIvcpNz9SIgfe4N8jIWtL3PTKc7P9n0Tm5x3uhfZA2bI7zBI65Jo
ARC-Seal: i=1; a=rsa-sha256; t=1524484340; cv=none;
        d=google.com; s=arc-20160816;
        b=yawII0EE0bqG65w+BfV2Z1cjWkgwd8/l9VwYuBQwVFJFQA1Htqi951R5RL/9z92JJr
         detulfUFE7hVlU53o95Vjj58vGRD9kU7CnhCCL1+FipcqIMgRz0Hm/NbmfvEplAjvB5N
         s+uv04lGcnpbs1YHnJgRFcZd484W7O0MgEVWoN026ZrDgL4AHDWOAZSKGZ7Ap0fD2cRb
         8tk8mf5w9HyE0x23KD8Tvqu//S5M+bfPYHqV/+GouF49cLPwngj2WyNEvvIm+UOtwNuc
         A/V7ud4Z6RNk58T39gE75eTpIm06kI3c/3O2QhVmteyw4UXLNCAnesL4JbtTqlwLVqDj
         5wnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ZhJccs8j7zF2RwIOrs0vXDsTsAv5ZhUumFBDZEosT5o=;
        b=T7wv86CEtbIm8sevbAkE7yofEO8MeX/mBF0HM5Q/q0Ep1gCK9OeftD9K6WwKD906t0
         +tfmYNZkjQGVDH40FUdve+LHVzNfxY2+yXyl2ISMyGnrWAYFj1dmN4nzeteYK5vFFOAS
         B/hhgifXxVFVxbzrWXQGUMq28t84A3YAqMwKqrGMceQLEPZDw3jF0Apwwzz144r3fFnn
         Jj4NQYabQhfumn+qicni6LOU7tUS4z2Mt+S9Xk4QxeYv4sPB0/70hz+fXicVE+oELOgh
         8NYEa2fOhCD8meIQKAmCq/ntuNT+8nSVAF/9g/RPkOs8FcNFvIdIEXlwRkuX90QDuxKP
         cBqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="36317672"
Date: Mon, 23 Apr 2018 04:54:53 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok
 <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig
 <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Yi L
 <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 10/22] iommu: introduce device fault data
Message-ID: <20180423045453.752f8169@jacob-builder>
In-Reply-To: <20180423101140.GA38106@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-11-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180423101140.GA38106@ostrya.localdomain>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910604906206?=
X-GMAIL-MSGID: =?utf-8?q?1598537692335180692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018 11:11:41 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com> wrote:

> On Mon, Apr 16, 2018 at 10:48:59PM +0100, Jacob Pan wrote:
> > +/**
> > + * struct iommu_fault_event - Generic per device fault data
> > + *
> > + * - PCI and non-PCI devices
> > + * - Recoverable faults (e.g. page request), information based on
> > PCI ATS
> > + * and PASID spec.
> > + * - Un-recoverable faults of device interest
> > + * - DMA remapping and IRQ remapping faults
> > +
> > + * @type contains fault type.
> > + * @reason fault reasons if relevant outside IOMMU driver, IOMMU
> > driver internal
> > + *         faults are not reported
> > + * @addr: tells the offending page address
> > + * @pasid: contains process address space ID, used in shared
> > virtual memory(SVM)
> > + * @rid: requestor ID  
> 
> You can remove @rid from the comment
> 
thanks, will do.
> > + * @page_req_group_id: page request group index
> > + * @last_req: last request in a page request group
> > + * @pasid_valid: indicates if the PRQ has a valid PASID
> > + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ,
> > IOMMU_FAULT_WRITE
> > + * @device_private: if present, uniquely identify device-specific
> > + *                  private data for an individual page request.
> > + * @iommu_private: used by the IOMMU driver for storing
> > fault-specific
> > + *                 data. Users should not modify this field before
> > + *                 sending the fault response.  
> 
> In my opinion you can remove @iommu_private entirely. I proposed this
> field so that the IOMMU driver can store fault metadata when reporting
> them, and read them back when completing the fault. I'm not using it
> in SMMUv3 anymore (instead re-fetching the metadata) and it can't be
> used anyway, because the value isn't copied into page_response_msg.
> 
In vt-d use, I use private data for preserving vt-d specific fault data
across request and response. e.g. vt-d has streaming response type in
addition to group response (standard). This way, generic code does not
need to know about it.

At device level, since we have to sanitize page response based on
pending page requests, I am doing the private data copy in iommu.c, in
the pending event list. 
> Thanks,
> Jean
> 
> > + */
> > +struct iommu_fault_event {
> > +	enum iommu_fault_type type;
> > +	enum iommu_fault_reason reason;
> > +	u64 addr;
> > +	u32 pasid;
> > +	u32 page_req_group_id;
> > +	u32 last_req : 1;
> > +	u32 pasid_valid : 1;
> > +	u32 prot;
> > +	u64 device_private;
> > +	u64 iommu_private;
> > +};  

[Jacob Pan]

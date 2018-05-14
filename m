Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoTHnZlKXF3MlrTvE/A01BJK4jljUVV9gjJBGOFD+sqjr0IS9znaQb/EMLPEexcQrgHzAZt
ARC-Seal: i=1; a=rsa-sha256; t=1526330801; cv=none;
        d=google.com; s=arc-20160816;
        b=pHOFqmYK88A6F0r4du+JclMu5P4oeIIWbz/kAyMp4WzmE6OK5ffdt9Nsp82R8hagpI
         NVQHTCHSHR+0mU8/U6kwRBIDhlCKpCaSoUPw2ma2AjaE/LZXfFZjdgfieu57HhCLFgyh
         3e/xvzzQzpMjxWm/QdJFp94WtN86/DrFoR9p8HSS9/rPMW3ZMLDlI6ARSN80iOLIoMco
         osBqu5F/zPPFPPK7bham3ctVz0vBDQSNLoyMImUJ6mPyiGbPqimw4/UYnes+o8RpKNYT
         lw/hI0eG/Z/pPxk7Mx7x+gpvMLkSuuXsQz1eNZaUsccARxXIREeEWJjRDKzp8twgoUyu
         LRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=DznXwp2UpOxzvpwYx/VX+Kr/Q6OvAQY91/mHFmjL2MY=;
        b=Gd2NzGCZM6stObVLVjcDkOkuukdhBu5IVGxIaDCzvco7UIiq1ugoEvWE8LwvvR8Ir3
         apAfelvglTj8SdU6jZcxhwzl9vDqvFUjOh5CnjwPZoNNo5ron+D7KrmEz9PRb/PwNJwF
         mj4DqiLvX9NGWH0dtalNcbysQvkjXEKttCxdiqKboAnShhyLYzh6m8vf1EHcDWXxHEJJ
         A9X8ikVq3XeJLN/DZ36yWFcjwyNcdniIlBvKyu5A8WzuJiZdvYpPG91MKItcC6fBXYcN
         tDYgL7BBvp+/OfVIuFqHRgnE8lT+lLPyPumFqc3iTKPgZeBCGoiRBo1dzpA2cn5mInAV
         vlBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="55860038"
Date: Mon, 14 May 2018 13:49:27 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 09/23] iommu/vt-d: add svm/sva invalidate function
Message-ID: <20180514134927.04886814@jacob-builder>
In-Reply-To: <5AF903E9.6070408@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-10-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF903E9.6070408@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362454788780?=
X-GMAIL-MSGID: =?utf-8?q?1600473847037607020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 11:35:05 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> > +	switch (inv_info->hdr.type) {
> > +	case IOMMU_INV_TYPE_TLB:
> > +		if (inv_info->size &&
> > +			(inv_info->addr & ((1 << (VTD_PAGE_SHIFT +
> > inv_info->size)) - 1))) {
> > +			pr_err("Addr out of range, addr 0x%llx,
> > size order %d\n",
> > +				inv_info->addr, inv_info->size);
> > +			ret = -ERANGE;
> > +			goto out_unlock;
> > +		}
> > +
> > +		qi_flush_eiotlb(iommu, did,
> > mm_to_dma_pfn(inv_info->addr),
> > +				inv_info->pasid,
> > +				inv_info->size, granu,
> > +				inv_info->flags &
> > IOMMU_INVALIDATE_GLOBAL_PAGE);
> > +		/**
> > +		 * Always flush device IOTLB if ATS is enabled
> > since guest
> > +		 * vIOMMU exposes CM = 1, no device IOTLB flush
> > will be passed
> > +		 * down.
> > +		 */
> > +		info = iommu_support_dev_iotlb(dmar_domain, iommu,
> > bus, devfn);
> > +		if (info && info->ats_enabled) {
> > +			qi_flush_dev_eiotlb(iommu, sid,
> > +					inv_info->pasid,
> > info->ats_qdep,
> > +					inv_info->addr,
> > inv_info->size,
> > +					granu);
> > +		}
> > +		break;
> > +	case IOMMU_INV_TYPE_PASID:
> > +		qi_flush_pasid(iommu, did, granu, inv_info->pasid);
> > +
> > +		break;
> > +	default:
> > +		dev_err(dev, "Unknown IOMMU invalidation type
> > %d\n",
> > +			inv_info->hdr.type);  
> 
> There are three types of invalidation:
> 
> enum iommu_inv_type {
>         IOMMU_INV_TYPE_DTLB,
>         IOMMU_INV_TYPE_TLB,
>         IOMMU_INV_TYPE_PASID,
>         IOMMU_INV_NR_TYPE
> };
> 
> So "unsupported" looks better than "unknown" in the message.
> 
agreed, makes more sense.
>  [...]  

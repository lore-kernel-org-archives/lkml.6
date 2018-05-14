Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZo3uOKPWb1CHyAmUH5mxQgozZP5ISwfeSFRgR/QFOqHd5GlZBhiGHO6VSHA5P4n7r8vtED2
ARC-Seal: i=1; a=rsa-sha256; t=1526330139; cv=none;
        d=google.com; s=arc-20160816;
        b=ZqEM5YDE5BYXiYvkSYNya9Jx2nENqePmLgA4p95O8X8SEH0KgT9fxYimAp5cUtWIhe
         17s9EWezkq4LZBRXR5RCkfCRc71pfasty7yuy3Gv0zJ3KZQF1e6GB10nH4jWw62dASJL
         OIQV1Q+zYgOpFJMVCz/zatnmnu+8PrzUH0U10XdSqjEBIrk1LehEGz0JrOlQUkVrKxS/
         5hW0ITsHenknU9JzXTWwp5rWHsATy1FBHkCAGWR3T5WFdnLPaKcn2WIUrzZjSUgs+Npt
         QF8XFYu0DqgMRkvLLquXZkSptcWcfKy68g8GwL6lJnoVoUUjY9X9IHqaeE5G9YIiA2/r
         oG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=qETGxyeyWJYMPvSpDhNEJ+Xpx9bTjxuiPrJ78tIQPy4=;
        b=mIJdnUZ2L0j6no2JDr5knfPdu9SsxiQ69dUcFIv5QyhDbPxqwboVW63clzGzy1cMYU
         hfXiMVSccOC1SAseZTnJW4NVHdymO5NjajPAvMI8oSds1Pq+oiC5lqX588cUp5A0DO0n
         S7RRoXhbah773QXyPHLkhMLz8V/TxxjnBiHi+sim3I6mBFdM3ErW0ez7G1IMMZ7e0PSv
         u3sETmGtv823oUSurRk628q3hBdhzKigwFYKX8Bi+4p2cgRhN/BkNNMHPeQ/9qNUHCNt
         gjI5eQgKCWVkL6j56ysjlCSLrcqoXQwwbtKfvWVlbrvrN1a4bWlCbDPlgE+2zGNqdDNz
         bfqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="55856688"
Date: Mon, 14 May 2018 13:38:25 -0700
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
Subject: Re: [PATCH v5 07/23] iommu/vt-d: fix dev iotlb pfsid use
Message-ID: <20180514133825.5b166b68@jacob-builder>
In-Reply-To: <5AF8EBC4.4040104@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-8-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF8EBC4.4040104@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362234268830?=
X-GMAIL-MSGID: =?utf-8?q?1600473152532651106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 09:52:04 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 4623294..732a10f 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1459,6 +1459,19 @@ static void iommu_enable_dev_iotlb(struct
> > device_domain_info *info) return;
> >  
> >  	pdev = to_pci_dev(info->dev);
> > +	/* For IOMMU that supports device IOTLB throttling (DIT),
> > we assign
> > +	 * PFSID to the invalidation desc of a VF such that IOMMU
> > HW can gauge
> > +	 * queue depth at PF level. If DIT is not set, PFSID will
> > be treated as
> > +	 * reserved, which should be set to 0.
> > +	 */
> > +	if (!ecap_dit(info->iommu->ecap))
> > +		info->pfsid = 0;
> > +	else if (pdev && pdev->is_virtfn) {
> > +		if (ecap_(info->iommu->ecap))
> > +			dev_warn(&pdev->dev, "SRIOV VF device
> > IOTLB enabled without flow control\n");  
> 
> I can't understand these two lines.
> 
> Isn't the condition always true? What does the error message mean?

you are right, there is no need to check ecap_dit again. thanks!

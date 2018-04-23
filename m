Return-Path: <Jean-Philippe.Brucker@arm.com>
X-Google-Smtp-Source: AIpwx49xWVLW51WqqnzVncpm+CfngLN68Jd2+99jk557xmxHI9eeFh8lTdiPERP7QSWVUggKi6E+
ARC-Seal: i=1; a=rsa-sha256; t=1524478314; cv=none;
        d=google.com; s=arc-20160816;
        b=Fh25EUWgc53r4c410UN3m/uf0y2iKTl4DQCALPax9DNpY6LVjkGnq4gr9BHRXteeMf
         m+8i2g/VRwkkVnw4GlVXnAmH5itkz3UGyHQhOeYMrfjdbskldIfFaLKti/En862G80oE
         Njkc0JX/gbUIfqE0qkgAnGFRA+dELrNsoyF6/D7l1ttGr993dWoHdGWoc/DfTDanNUlw
         vP4deF71NrNo7fns4Yj/LS8RIuhf+40Noq2+kHuVngItytfeTWzk7T/AIFREekpA3G++
         ru82qk0ujCmuzgVPwePKKqvutktqfWKPs2AVpRUV4wovQVguCpNJRcHSiHgtO9G5RZsq
         M7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=fJQp4/bsi8TimXVPrn0MgujuJ8fo20vinDvb/5h5JMk=;
        b=oWhc1KP/8UlSasd1z9h7Ic8Kz38XHsdRss+HXrubXppZes00JDktHHyquQzAvupsgp
         q8XYpOnelAOqh/qyTowzWoIrRd/yEEbBtMfrRWkuV5gwvj6X4O16UX+1acOPwzorJErD
         CZ08rHMuQ9nYCZVGdW6K3QBVtVAxqQaYME+tqVLW5dOt9Q7jDjrPXWK4KnpXrCXbUc07
         a5jhPaBnAX/Ey40FL8FD1KJUj8QRVdnrXo5g5RUgX1HnoGWw8opU/ZZUs36Tk2FgIhcR
         ge21ylqhbD5NlgcGWqfDAHK8TXPc1BnmA6ZMyis55UI4L+ADcujD1CkR0QCT+62HaC/i
         D55w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Date: Mon, 23 Apr 2018 11:11:41 +0100
From: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Yi L <yi.l.liu@linux.intel.com>
Subject: Re: [PATCH v4 10/22] iommu: introduce device fault data
Message-ID: <20180423101140.GA38106@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-11-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523915351-54415-11-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910604906206?=
X-GMAIL-MSGID: =?utf-8?q?1598531372646182084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:48:59PM +0100, Jacob Pan wrote:
> +/**
> + * struct iommu_fault_event - Generic per device fault data
> + *
> + * - PCI and non-PCI devices
> + * - Recoverable faults (e.g. page request), information based on PCI ATS
> + * and PASID spec.
> + * - Un-recoverable faults of device interest
> + * - DMA remapping and IRQ remapping faults
> +
> + * @type contains fault type.
> + * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
> + *         faults are not reported
> + * @addr: tells the offending page address
> + * @pasid: contains process address space ID, used in shared virtual memory(SVM)
> + * @rid: requestor ID

You can remove @rid from the comment

> + * @page_req_group_id: page request group index
> + * @last_req: last request in a page request group
> + * @pasid_valid: indicates if the PRQ has a valid PASID
> + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
> + * @device_private: if present, uniquely identify device-specific
> + *                  private data for an individual page request.
> + * @iommu_private: used by the IOMMU driver for storing fault-specific
> + *                 data. Users should not modify this field before
> + *                 sending the fault response.

In my opinion you can remove @iommu_private entirely. I proposed this
field so that the IOMMU driver can store fault metadata when reporting
them, and read them back when completing the fault. I'm not using it in
SMMUv3 anymore (instead re-fetching the metadata) and it can't be used
anyway, because the value isn't copied into page_response_msg.

Thanks,
Jean

> + */
> +struct iommu_fault_event {
> +	enum iommu_fault_type type;
> +	enum iommu_fault_reason reason;
> +	u64 addr;
> +	u32 pasid;
> +	u32 page_req_group_id;
> +	u32 last_req : 1;
> +	u32 pasid_valid : 1;
> +	u32 prot;
> +	u64 device_private;
> +	u64 iommu_private;
> +};

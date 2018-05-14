Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZp9kLerdzFwR+0VKyN6hz/dpsNSW0jMlXtH5mSRTwx60pTLYz1LzJoLTSrkLIqtjisP/cEA
ARC-Seal: i=1; a=rsa-sha256; t=1526262727; cv=none;
        d=google.com; s=arc-20160816;
        b=YYlGAr3I4r0pwCdXHbN61OCX28Rq7O5KDpnTlEsVl94xGUDCzdKf1eC/shCE2V+N0X
         0tW9PlIadqX7VQx8SIdg/GxYxKC42sRk3IV3uvLcN1huE+B+p9vUkrjTarvKDNHWJGYH
         RhBCQZmRvSx8JlozGc2P3IUxmgUrLsuZ6pBPBn5szB26Gm0oPjOTbfQBNXYtDG5XsAOT
         47vfTwyhxNhbFb8ArVV6raHrKkcmpa8+7v3LFqMgDy1Knb9gwJxUR2btBrTHwi4Qi8kd
         AHmntXkCBhUJqGrkkW0KVsdu8jxNVuxi9/rVgf+hmYHhNuLLU4bSOnvxlGlM0LSrowQD
         S5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=9E/emqkJO8j8nzi+wdMp4EnZJF9neADRhnY2i8TQxoo=;
        b=wHpxq2h/f+8cYZmu49mp3hJUI62nQuqkQzG2yBCthF6EamAR3UywUIchj1hKqVWgS8
         rhGlhWEw4SuWzoOh9kTZGUKKQxXQWV8gurrYjxRvSBdq7DxGtZTpYdeR10Rr/SaZASlI
         0bKVn7YvJXoNwyteXtaZWKHBvGGsbmSnc+zaYxaoHUTJ8IijfsY+vExtCrbEpjZbN1x4
         vFA0VpRZbmC+9+3GhzI4j74Ao5/fpu5Wbkfs41BxTxVocX3rljV9UzVWvaGqEN8CZbyf
         vlYcPiqdDu7sMuPgC+44ffCQ9w3heNyiZX7JlBFuVe2Thm2AsWuCzAXl25o0r2qausFV
         NaPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,398,1520924400";
   d="scan'208";a="228161307"
Subject: Re: [PATCH v5 07/23] iommu/vt-d: fix dev iotlb pfsid use
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-8-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF8EBC4.4040104@linux.intel.com>
Date: Mon, 14 May 2018 09:52:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362234268830?=
X-GMAIL-MSGID: =?utf-8?q?1600402465068633337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:53 AM, Jacob Pan wrote:
> PFSID should be used in the invalidation descriptor for flushing
> device IOTLBs on SRIOV VFs.

This patch could be submitted separately.

>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        |  6 +++---
>  drivers/iommu/intel-iommu.c | 16 +++++++++++++++-
>  include/linux/intel-iommu.h |  5 ++---
>  3 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 460bed4..7852678 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1339,8 +1339,8 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
> -void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
> -			u64 addr, unsigned mask)
> +void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +			u16 qdep, u64 addr, unsigned mask)
>  {
>  	struct qi_desc desc;
>  
> @@ -1355,7 +1355,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
>  		qdep = 0;
>  
>  	desc.low = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
> -		   QI_DIOTLB_TYPE;
> +		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
>  
>  	qi_submit_sync(&desc, iommu);
>  }
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 4623294..732a10f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1459,6 +1459,19 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  		return;
>  
>  	pdev = to_pci_dev(info->dev);
> +	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
> +	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
> +	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
> +	 * reserved, which should be set to 0.
> +	 */
> +	if (!ecap_dit(info->iommu->ecap))
> +		info->pfsid = 0;
> +	else if (pdev && pdev->is_virtfn) {
> +		if (ecap_dit(info->iommu->ecap))
> +			dev_warn(&pdev->dev, "SRIOV VF device IOTLB enabled without flow control\n");

I can't understand these two lines.

Isn't the condition always true? What does the error message mean?

> +		info->pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
> +	} else
> +		info->pfsid = PCI_DEVID(info->bus, info->devfn);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	/* The PCIe spec, in its wisdom, declares that the behaviour of
> @@ -1524,7 +1537,8 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
>  
>  		sid = info->bus << 8 | info->devfn;
>  		qdep = info->ats_qdep;
> -		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
> +		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> +				qdep, addr, mask);

Alignment should match open parenthesis.

>  	}
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  }
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index dfacd49..678a0f4 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -504,9 +504,8 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
>  			     u8 fm, u64 type);
>  extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  			  unsigned int size_order, u64 type);
> -extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
> -			       u64 addr, unsigned mask);
> -
> +extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +			u16 qdep, u64 addr, unsigned mask);

Alignment should match open parenthesis.

>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
>  
>  extern int dmar_ir_support(void);

Best regards,
Lu Baolu

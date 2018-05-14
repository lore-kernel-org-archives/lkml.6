Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrTNaRiwXZody72WVAOdDMevCArz0j9s0JAuRZTUjEfT/f0wzam/Xf5fSGfdd4HfBiYJ73i
ARC-Seal: i=1; a=rsa-sha256; t=1526264330; cv=none;
        d=google.com; s=arc-20160816;
        b=vluCx9VckFBqW1VGXOqULf3WuxdUXyxnq6wTaRlDFVxF4GWn9LrsA+SdKQapTGXhV1
         e5Yf+tjG1MR6RPENK3axiYDDHVhiN5If8okQE+aMuCoV/DJy50K3+LSAPYHQmf5rKp3t
         m6esTCpoCy76TTwqFY3WHxih31BS182Sb8eT+h7rH40fZBMszno6y60ZRYXA0fyANYfC
         DzRwO1h1EHT8RBaLjKfF5RCHLb61rKV2Z9WLj70FRrwbEpGG331ohcY/P4+el/RXERLX
         bWLK8uyr3FmJYSrtUajNDmBxOCffadvoFm2l2sPpS6MN8m8fObi507EiCwYN+zkFuYjA
         V6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=rCkc3GVx8sxN0Xfz/iALZUNj/mR1ExGDQJ+mCJ0hAHg=;
        b=X1yw0/wtMfW6LWJVOwDDQ0/XiYLUBuH7yJlNldqvVU43+d0xFlwuGrwYUIvccTeT9o
         x7/Mcz8+H9yuzvyWOTrWgwLnI1alimO74UoP8EMHjes8NeyK0vKQ3UUZf4xqmY+xqRUs
         7JEKqkD4LhzDBJrbyiwc9fkWUIak0eN5ilvSLjDIGP9meaEF02P6Wb7hqzB5+x4SwYND
         NYDqY44mgG1+gXG9AO79dLthiIslqSJ/Hn2SqnBrHdi5HXAXaLiB38lAkWj4iUitkGRe
         LUa4JPYAO6ZZVtfPMkzLA6WdEwvCYXFC2ttHIy/shYEbjWT2zznwgS0loh+Xffez7VOF
         DuUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,398,1520924400";
   d="scan'208";a="223957245"
Subject: Re: [PATCH v5 08/23] iommu/vt-d: support flushing more translation
 cache types
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-9-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF8F204.2010800@linux.intel.com>
Date: Mon, 14 May 2018 10:18:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362792419747?=
X-GMAIL-MSGID: =?utf-8?q?1600404147201143473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:54 AM, Jacob Pan wrote:
> When Shared Virtual Memory is exposed to a guest via vIOMMU, extended
> IOTLB invalidation may be passed down from outside IOMMU subsystems.
> This patch adds invalidation functions that can be used for additional
> translation cache types.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h | 21 +++++++++++++++++++--
>  2 files changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 7852678..0b5b052 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1339,6 +1339,18 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
> +void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
> +		unsigned int size_order, u64 granu, bool global)

Alignment should match open parenthesis.

> +{
> +	struct qi_desc desc;
> +
> +	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> +	desc.high = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_GL(global) |
> +		QI_EIOTLB_IH(0) | QI_EIOTLB_AM(size_order);
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>  void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			u16 qdep, u64 addr, unsigned mask)
>  {
> @@ -1360,6 +1372,38 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
> +void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid,
> +		u32 pasid,  u16 qdep, u64 addr, unsigned size, u64 granu)

Ditto.

> +{
> +	struct qi_desc desc;
> +
> +	desc.low = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE;

Have you forgotten PFSID, or I missed anything here?

> +	desc.high |= QI_DEV_EIOTLB_GLOB(granu);
> +
> +	/* If S bit is 0, we only flush a single page. If S bit is set,
> +	 * The least significant zero bit indicates the size. VT-d spec
> +	 * 6.5.2.6
> +	 */
> +	if (!size)
> +		desc.high = QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
> +	else {
> +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size);
> +
> +		desc.high = QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
> +	}
> +	qi_submit_sync(&desc, iommu);
> +}
> +
> +void qi_flush_pasid(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
> +{
> +	struct qi_desc desc;
> +
> +	desc.high = 0;
> +	desc.low = QI_PC_TYPE | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_PASID(pasid);
> +
> +	qi_submit_sync(&desc, iommu);
> +}
>  /*
>   * Disable Queued Invalidation interface.
>   */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 678a0f4..5ac0c28 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -262,6 +262,10 @@ enum {
>  #define QI_PGRP_RESP_TYPE	0x9
>  #define QI_PSTRM_RESP_TYPE	0xa
>  
> +#define QI_DID(did)		(((u64)did & 0xffff) << 16)
> +#define QI_DID_MASK		GENMASK(31, 16)
> +#define QI_TYPE_MASK		GENMASK(3, 0)
> +
>  #define QI_IEC_SELECTIVE	(((u64)1) << 4)
>  #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
>  #define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
> @@ -293,8 +297,9 @@ enum {
>  #define QI_PC_DID(did)		(((u64)did) << 16)
>  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
>  
> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
> +/* PASID cache invalidation granu */
> +#define QI_PC_ALL_PASIDS	0
> +#define QI_PC_PASID_SEL		1
>  
>  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
>  #define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
> @@ -304,6 +309,10 @@ enum {
>  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
>  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
>  
> +/* QI Dev-IOTLB inv granu */
> +#define QI_DEV_IOTLB_GRAN_ALL		1
> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> +
>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
>  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> @@ -332,6 +341,7 @@ enum {
>  #define QI_RESP_INVALID		0x1
>  #define QI_RESP_FAILURE		0xf
>  
> +/* QI EIOTLB inv granu */
>  #define QI_GRAN_ALL_ALL			0
>  #define QI_GRAN_NONG_ALL		1
>  #define QI_GRAN_NONG_PASID		2
> @@ -504,8 +514,15 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
>  			     u8 fm, u64 type);
>  extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  			  unsigned int size_order, u64 type);
> +extern void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr,
> +			u32 pasid, unsigned int size_order, u64 type, bool global);
>  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			u16 qdep, u64 addr, unsigned mask);
> +
> +extern void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid,
> +			u32 pasid, u16 qdep, u64 addr, unsigned size, u64 granu);
> +extern void qi_flush_pasid(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
> +
>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
>  
>  extern int dmar_ir_support(void);

Best regards,
Lu Baolu

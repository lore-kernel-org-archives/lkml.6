Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbeEBGeo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:34:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:24137 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbeEBGen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:34:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="36182247"
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in irq
 handler
To: Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        joro@8bytes.org, "Raj, Ashok" <ashok.raj@intel.com>
References: <20180331003312.6390-1-dima@arista.com>
 <20180331003312.6390-2-dima@arista.com>
Cc: 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        iommu@lists.linux-foundation.org
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AE95BFF.5040306@linux.intel.com>
Date: Wed, 2 May 2018 14:34:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180331003312.6390-2-dima@arista.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/31/2018 08:33 AM, Dmitry Safonov wrote:
> Theoretically, on some machines faults might be generated faster than
> they're cleared by CPU.

Is this a real case?

>  Let's limit the cleaning-loop by number of hw
> fault registers.

Will this cause the fault recording registers full of faults, hence new
faults will be dropped without logging? And even worse, new faults
will not generate interrupts?

Best regards,
Lu Baolu

>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/iommu/dmar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 6c4ea32ee6a9..cf1105111209 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1615,7 +1615,7 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>  irqreturn_t dmar_fault(int irq, void *dev_id)
>  {
>  	struct intel_iommu *iommu = dev_id;
> -	int reg, fault_index;
> +	int reg, fault_index, i;
>  	u32 fault_status;
>  	unsigned long flag;
>  	static DEFINE_RATELIMIT_STATE(rs,
> @@ -1633,7 +1633,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  
>  	fault_index = dma_fsts_fault_record_index(fault_status);
>  	reg = cap_fault_reg_offset(iommu->cap);
> -	while (1) {
> +	for (i = 0; i < cap_num_fault_regs(iommu->cap); i++) {
>  		/* Disable printing, simply clear the fault when ratelimited */
>  		bool ratelimited = !__ratelimit(&rs);
>  		u8 fault_reason;

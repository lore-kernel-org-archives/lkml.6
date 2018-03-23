Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeCWTPJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:15:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCWTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:15:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DED0607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v5 2/3] RDMA/i40iw: Eliminate duplicate barriers on
 weakly-ordered archs
To: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-3-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <352b0adc-5489-c919-fa0a-2a3a3b2d37a0@codeaurora.org>
Date: Fri, 23 Mar 2018 15:15:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521736009-23387-3-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2018 12:26 PM, Sinan Kaya wrote:
> +++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
> @@ -706,9 +706,11 @@ static void i40iw_sc_ccq_arm(struct i40iw_sc_cq *ccq)
>  	wmb();       /* make sure shadow area is updated before arming */
>  
>  	if (ccq->dev->is_pf)
> -		i40iw_wr32(ccq->dev->hw, I40E_PFPE_CQARM, ccq->cq_uk.cq_id);
> +		i40iw_wr32_relaxed(ccq->dev->hw, I40E_PFPE_CQARM,
> +				   ccq->cq_uk.cq_id);
>  	else
> -		i40iw_wr32(ccq->dev->hw, I40E_VFPE_CQARM1, ccq->cq_uk.cq_id);
> +		i40iw_wr32_relaxed(ccq->dev->hw, I40E_VFPE_CQARM1,
> +				   ccq->cq_uk.cq_id);

do we want an mmiowb() here?

>  }


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

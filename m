Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeDKPO2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:14:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50532 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbeDKPO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:14:27 -0400
Subject: Re: [PATCH v2 1/2] dmaengine: stm32-mdma: align TLEN and buffer
 length on burst
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-2-git-send-email-pierre-yves.mordret@st.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9a2a267c-2b0b-0d6a-c762-47e7d37f84ea@arm.com>
Date: Wed, 11 Apr 2018 16:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523457879-9869-2-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/18 15:44, Pierre-Yves MORDRET wrote:
> Both buffer Transfer Length (TLEN if any) and transfer size have to be
> aligned on burst size (burst beats*bus width).
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>      v1:
>         * Initial
>      v2:
> ---
> ---
>   drivers/dma/stm32-mdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index daa1602..fbcffa2 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -413,7 +413,7 @@ static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
>   	u32 best_burst = max_burst;
>   	u32 burst_len = best_burst * width;
>   
> -	while ((burst_len > 0) && (tlen % burst_len)) {
> +	while ((burst_len > 0) && (((tlen | buf_len) & (burst_len - 1)) != 0)) {
>   		best_burst = best_burst >> 1;
>   		burst_len = best_burst * width;
>   	}

FWIW, doesn't that whole loop come down to just:

	burst_len = min(ffs(tlen | buf_len), max_burst * width);

?

Robin.

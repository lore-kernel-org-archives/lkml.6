Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeEVNFH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:05:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44510 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeEVNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:04:55 -0400
X-Google-Smtp-Source: AB8JxZolk5xokqS7Ti4agtrUcb100l4zeqZ57YeSX5y09AivMyAWYeRbvnjACOTscgu9xo8EYhYkkQ==
Subject: Re: [PATCH 3/4] venus: add check to make scm calls
To: Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        acourbot@google.com
References: <1526556740-25494-1-git-send-email-vgarodia@codeaurora.org>
 <1526556740-25494-4-git-send-email-vgarodia@codeaurora.org>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <9d5e12b1-40bd-adab-05f0-bdb209bf0174@linaro.org>
Date: Tue, 22 May 2018 16:04:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526556740-25494-4-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 05/17/2018 02:32 PM, Vikash Garodia wrote:
> In order to invoke scm calls, ensure that the platform
> has the required support to invoke the scm calls in
> secure world. This code is in preparation to add PIL
> functionality in venus driver.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index f61d34b..9bcce94 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -27,6 +27,7 @@
>  #include "hfi_msgs.h"
>  #include "hfi_venus.h"
>  #include "hfi_venus_io.h"
> +#include "firmware.h"
>  
>  #define HFI_MASK_QHDR_TX_TYPE		0xff000000
>  #define HFI_MASK_QHDR_RX_TYPE		0x00ff0000
> @@ -570,13 +571,19 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
>  static int venus_power_off(struct venus_hfi_device *hdev)
>  {
>  	int ret;
> +	void __iomem *reg_base;
>  
>  	if (!hdev->power_enabled)
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(TZBSP_VIDEO_STATE_SUSPEND, 0);
> -	if (ret)
> -		return ret;
> +	if (qcom_scm_is_available()) {
> +		ret = qcom_scm_set_remote_state(TZBSP_VIDEO_STATE_SUSPEND, 0);

I think it will be clearer if we abstract qcom_scm_set_remote_state to
something like venus_set_state(SUSPEND|RESUME) in firmware.c and export
the functions to be used here.

-- 
regards,
Stan

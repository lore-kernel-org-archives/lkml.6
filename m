Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeERF2t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:28:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38205 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeERF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:28:47 -0400
X-Google-Smtp-Source: AB8JxZq7Rt9NxHBI5sT6+eInEbH7vnDboAVSOBfk0JFcnRrMyRY5MeMMAYXQOCU2BjWa54CHimHBjw==
Date: Thu, 17 May 2018 22:28:44 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vikash Garodia <vgarodia@codeaurora.org>
Cc: hverkuil@xs4all.nl, mchehab@kernel.org, andy.gross@linaro.org,
        stanimir.varbanov@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, acourbot@google.com
Subject: Re: [PATCH 1/4] soc: qcom: mdt_loader: Add check to make scm calls
Message-ID: <20180518052844.GP14924@minitux>
References: <1526556740-25494-1-git-send-email-vgarodia@codeaurora.org>
 <1526556740-25494-2-git-send-email-vgarodia@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526556740-25494-2-git-send-email-vgarodia@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 May 04:32 PDT 2018, Vikash Garodia wrote:

> In order to invoke scm calls, ensure that the platform
> has the required support to invoke the scm calls in
> secure world.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/soc/qcom/mdt_loader.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 17b314d..db55d53 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -121,10 +121,12 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  	if (!fw_name)
>  		return -ENOMEM;
>  
> -	ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
> -	if (ret) {
> -		dev_err(dev, "invalid firmware metadata\n");
> -		goto out;
> +	if (qcom_scm_is_available()) {

qcom_scm_is_available() tells you if the qcom_scm driver has been
probed, not if your platform implements PAS.

Please add a DT property to tell the driver if it should require PAS or
not (the absence of such property should indicate PAS is required, for
backwards compatibility purposes). For the MDT loader we need to merge
the following patch to make this work:

https://patchwork.kernel.org/patch/10397889/ 

Regards,
Bjorn

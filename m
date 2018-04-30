Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeD3IgX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:36:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47697 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbeD3IgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:36:21 -0400
Subject: Re: [PATCH v3 4/6] rpmsg: Guard against null endpoint ops in destroy
To: Chris Lew <clew@codeaurora.org>, <bjorn.andersson@linaro.org>,
        <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <aneela@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1524783545-21951-1-git-send-email-clew@codeaurora.org>
 <1524783545-21951-5-git-send-email-clew@codeaurora.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <b328de2b-f1f9-6a10-eb80-b21d4d77acc1@st.com>
Date: Mon, 30 Apr 2018 10:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524783545-21951-5-git-send-email-clew@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

On 04/27/2018 12:59 AM, Chris Lew wrote:
> In RPMSG GLINK the chrdev device will allocate an ept as part of the
> rpdev creation. This device will not register endpoint ops even though
> it has an allocated ept. Protect against the case where the device is
> being destroyed.
> 
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> ---
> 
> Changes since v1:
> - New change
> 
>  drivers/rpmsg/rpmsg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 920a02f0462c..7bfe36afccc5 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -88,7 +88,7 @@ struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
>   */
>  void rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
>  {
> -	if (ept)
> +	if (ept && ept->ops)
>  		ept->ops->destroy_ept(ept);
>  }
>  EXPORT_SYMBOL(rpmsg_destroy_ept);
> 

Would make sense that you also add test on ept->ops->destroy_ept. I
guess that ops may not be null while destroy_ept pointer is.

Regards
Arnaud

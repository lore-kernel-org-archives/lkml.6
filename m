Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755346AbeDCJM6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:12:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23918 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755319AbeDCJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:12:52 -0400
From: Loic PALLARDY <loic.pallardy@st.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC: "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [PATCH 2/3] rpmsg: Only invoke announce_create for rpdev with
 endpoints
Thread-Topic: [PATCH 2/3] rpmsg: Only invoke announce_create for rpdev with
 endpoints
Thread-Index: AQHTxg+bYYNojr61C0O04JApu470KKPuyIPQ
Date: Tue, 3 Apr 2018 09:12:49 +0000
Message-ID: <3c952b4ca0cc4666ba01cf0dbe605248@SFHDAG7NODE2.st.com>
References: <20180327210643.3436-1-bjorn.andersson@linaro.org>
 <20180327210643.3436-3-bjorn.andersson@linaro.org>
In-Reply-To: <20180327210643.3436-3-bjorn.andersson@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org [mailto:linux-remoteproc-
> owner@vger.kernel.org] On Behalf Of Bjorn Andersson
> Sent: Tuesday, March 27, 2018 11:07 PM
> To: Ohad Ben-Cohen <ohad@wizery.com>; Bjorn Andersson
> <bjorn.andersson@linaro.org>
> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> arm-msm@vger.kernel.org
> Subject: [PATCH 2/3] rpmsg: Only invoke announce_create for rpdev with
> endpoints
> 
> For special rpmsg devices without a primary endpoint there is nothing to
> announce so don't call the backend announce create function if we didn't
> create an endpoint.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/rpmsg/rpmsg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index dffa3aab7178..e85d2691d2cf 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -442,7 +442,7 @@ static int rpmsg_dev_probe(struct device *dev)
>  		goto out;
>  	}
> 
> -	if (rpdev->ops->announce_create)
> +	if (ept && rpdev->ops->announce_create)

This check is already part of virtio_rpmsg.c (see line 341)
	/* need to tell remote processor's name service about this channel ? */
	if (rpdev->announce && rpdev->ept &&
	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {

should it be part of qcom_smd driver too? (but each implementation will duplicate checks)
Or may have a generic check in the core including rpdev->announce as well (and doing virtio_rpmsg.c clean-up)

Change will become:
	if (rpdev->announce && ept && rpdev->ops->announce_create)

Regards,
Loic
>  		err = rpdev->ops->announce_create(rpdev);
>  out:
>  	return err;
> --
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B2AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798F32089A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gxtwfqSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798F32089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeGYXuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:50:24 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53320 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeGYXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:50:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6PMaY2V013870;
        Wed, 25 Jul 2018 17:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532558194;
        bh=DME2vM/RDTCJ8kgTLSl2JBDAhC/bEavkyE8C1jRS6rY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gxtwfqSGpOO/3WLAyQrBI0HVo5Yfj1V4AhxS+NigJyW5pnxkw5fcDZMOL9caQoMcU
         N05L+cl0ZsT31/1M/D+BhsLV1K3Vk4i2nG/zCfZglK86E+kMrvRi3gJwPkCsvGn2ac
         KaTVeUuEfVOqLfAqyaplNVb7lVDlPpgrwk92tKpU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6PMaYsT029651;
        Wed, 25 Jul 2018 17:36:34 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 25
 Jul 2018 17:36:33 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 25 Jul 2018 17:36:34 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6PMaXjj011524;
        Wed, 25 Jul 2018 17:36:33 -0500
Subject: Re: [PATCH 1/1] rpmsg: virtio_rpmsg_bus: Fix rpmsg_create_channel
 memory leak
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532552916-30111-1-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <19e8f6e7-3ee6-6606-164c-3bb953a13da5@ti.com>
Date:   Wed, 25 Jul 2018 17:36:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532552916-30111-1-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 07/25/2018 04:08 PM, Loic Pallardy wrote:
> In case of rpmsg_register_device() failure, vch previously
> allocated must be free.
> 

Isn't this already handled through the virtio_rpmsg_release_device()
callback as part of the put_device() in rpmsg_register_device() failure.

regards
Suman

> fixes: 6eed598a0491 ("rpmsg: Split off generic tail of create_channel()")
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 664f957..10f927e 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -431,8 +431,10 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
>  	rpdev->dev.parent = &vrp->vdev->dev;
>  	rpdev->dev.release = virtio_rpmsg_release_device;
>  	ret = rpmsg_register_device(rpdev);
> -	if (ret)
> +	if (ret) {
> +		kfree(vch);
>  		return NULL;
> +	}
>  
>  	return rpdev;
>  }
> 


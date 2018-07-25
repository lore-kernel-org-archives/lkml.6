Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E200DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C8020833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="diCrkIN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C8020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbeGYXp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:45:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39242 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731605AbeGYXpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:45:55 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6PMW6RS039157;
        Wed, 25 Jul 2018 17:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532557926;
        bh=WP2+soeYI/gcryaOB2EXC4K7qCoDg2lFJEeGWfNJSO0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=diCrkIN8o+wEplrlSudqEDFdqMNHGrubEG2QQK366zzckp5ZxkhG7r5gYdZPHe6OE
         RzFTf+jqyyGVt6kOrYOnwbuKR/XlMrWBrksQKFDM3uT9NGpA9lH2We63WalBjQnX7g
         adtIHi/FdmyKuhRqX0drQU1umiu8dAqZPnoBgFC8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6PMW6Nr008864;
        Wed, 25 Jul 2018 17:32:06 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 25
 Jul 2018 17:32:06 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 25 Jul 2018 17:32:06 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6PMW6dm005490;
        Wed, 25 Jul 2018 17:32:06 -0500
Subject: Re: [PATCH 1/1] rpmsg: virtio_rpmsg_bus: Fix rpmsg_remove() release
 order
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532552826-30003-1-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <d9b7192b-2fc7-664f-d9a5-b90c8644b991@ti.com>
Date:   Wed, 25 Jul 2018 17:32:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532552826-30003-1-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 07/25/2018 04:07 PM, Loic Pallardy wrote:
> In rpmsg_remove() procedure, children are removed then Name
> Service announcement endpoint is destroyed and device released.
> 
> Issue with current implementation is if a NS announcement
> creation request is ongoing (received before virtio reset),
> child device could be created after children removing.
> In that case rpmsg_remove() is freeing rpmsg_virtio_bus,
> leading to an inconsistent state.
> 
> This patch is destroying NS announcement service endpoint before
> removing children to guarantee that list of child devices is
> fixed and all of them will be correctly removed before cleaning
> resources.

I do not think this is the right fix for the problem you explained.
The removal of rpmsg devices can actually invoke the announce_destroy
in the rpmsg_dev_remove().

regards
Suman

> 
> fixes: bcabbccabffe ("rpmsg: Split off generic tail of create_channel()")
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 664f957..f5d481f 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -1004,13 +1004,13 @@ static void rpmsg_remove(struct virtio_device *vdev)
>  
>  	vdev->config->reset(vdev);
>  
> +	if (vrp->ns_ept)
> +		__rpmsg_destroy_ept(vrp, vrp->ns_ept);
> +
>  	ret = device_for_each_child(&vdev->dev, NULL, rpmsg_remove_device);
>  	if (ret)
>  		dev_warn(&vdev->dev, "can't remove rpmsg device: %d\n", ret);
>  
> -	if (vrp->ns_ept)
> -		__rpmsg_destroy_ept(vrp, vrp->ns_ept);
> -
>  	idr_destroy(&vrp->endpoints);
>  
>  	vdev->config->del_vqs(vrp->vdev);
> 


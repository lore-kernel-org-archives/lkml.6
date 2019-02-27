Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5265C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF33C218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfB0GKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:10:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbfB0GJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:09:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF107B94AFF51F0DC26C;
        Wed, 27 Feb 2019 14:09:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 14:09:53 +0800
Subject: Re: [PATCH -next] scsi: libfc: Fix potential NULL pointer dereference
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
References: <20190130101141.20132-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <09c3242f-9a41-65f4-7dc6-f1c8aa6425f1@huawei.com>
Date:   Wed, 27 Feb 2019 14:09:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190130101141.20132-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Friendly ping:

Who can review or take this, please?

Thanks

On 2019/1/30 18:11, YueHaibing wrote:
> There is a potential NULL pointer dereference in case
> fc_rport_create() fails and returns NULL.
> 
> Fixes: 2580064b5ec6 ("scsi: libfc: Replace ->rport_create callback with function call")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/scsi/libfc/fc_lport.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
> index ff943f4..e2a3551 100644
> --- a/drivers/scsi/libfc/fc_lport.c
> +++ b/drivers/scsi/libfc/fc_lport.c
> @@ -250,6 +250,10 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
>  	}
>  	mutex_lock(&lport->disc.disc_mutex);
>  	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
> +	if (!lport->ptp_rdata) {
> +		mutex_unlock(&lport->disc.disc_mutex);
> +		return;
> +	}
>  	kref_get(&lport->ptp_rdata->kref);
>  	lport->ptp_rdata->ids.port_name = remote_wwpn;
>  	lport->ptp_rdata->ids.node_name = remote_wwnn;
> 


Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506C12088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506C12088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeIQTYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:24:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbeIQTYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:24:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32697AC9C;
        Mon, 17 Sep 2018 13:56:48 +0000 (UTC)
Subject: Re: [PATCH 4/5] scsi: libsas: check the ata device status by
 ata_dev_enabled()
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, zhaohongjiang@huawei.com,
        dan.j.williams@intel.com, jthumshirn@suse.de, hch@lst.de,
        huangdaode@hisilicon.com, chenxiang66@hisilicon.com,
        miaoxie@huawei.com, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-5-yanaijie@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <d9c96aca-3761-7fce-a5c8-2b7061900f6b@suse.com>
Date:   Mon, 17 Sep 2018 15:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912082946.34814-5-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 10:29 AM, Jason Yan wrote:
> When ata device IDENTIFY failed, the ata device status is
> ATA_DEV_UNKNOWN. The libata reported like:
> 
> [113518.620433] ata5.00: qc timeout (cmd 0xec)
> [113518.653646] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> But libsas verifies the device status by ata_dev_disabled(), which
> skiped ATA_DEV_UNKNOWN. This will make libsas think the ata device
> probing succeed the device cannot be actually brought up. And even the
> new bcast of this device will be considered as flutter and will not
> probe this device again.
> 
> Change ata_dev_disabled() to !ata_dev_enabled() so that libsas can
> deal with this if the ata device probe failed. New bcasts can let us
> try to probe the device again and bring it up if it is fine to
> IDENTIFY.
> 
> Tested-by: Zhou Yupeng <zhouyupeng1@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/libsas/sas_ata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 64a958a99f6a..4f6cdf53e913 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -654,7 +654,7 @@ void sas_probe_sata(struct asd_sas_port *port)
>  		/* if libata could not bring the link up, don't surface
>  		 * the device
>  		 */
> -		if (ata_dev_disabled(sas_to_ata_dev(dev)))
> +		if (!ata_dev_enabled(sas_to_ata_dev(dev)))
>  			sas_fail_probe(dev, __func__, -ENODEV);
>  	}
>  
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

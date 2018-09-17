Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D141ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB1B2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB1B2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeIQTWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:22:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:53184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeIQTWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:22:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1464BAD49;
        Mon, 17 Sep 2018 13:55:27 +0000 (UTC)
Subject: Re: [PATCH 3/5] scsi: libsas: always unregister the old device if
 going to discover new
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, zhaohongjiang@huawei.com,
        dan.j.williams@intel.com, jthumshirn@suse.de, hch@lst.de,
        huangdaode@hisilicon.com, chenxiang66@hisilicon.com,
        miaoxie@huawei.com, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-4-yanaijie@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <c64532c9-9497-29c5-9d96-efef453ee050@suse.com>
Date:   Mon, 17 Sep 2018 15:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912082946.34814-4-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 10:29 AM, Jason Yan wrote:
> If we went into sas_rediscover_dev() the attached_sas_addr was already
> insured not to be zero. So it's unnecessary to check if the
> attached_sas_addr is zero.
> 
> And although if the sas address is not changed, we always have to
> unregister the old device when we are going to register a new one. We
> cannot just leave the device there and bring up the new.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: chenxiang <chenxiang66@hisilicon.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/libsas/sas_expander.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index fadc99cb60df..52222940d398 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -2054,14 +2054,11 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id, bool last)
>  		return res;
>  	}
>  
> -	/* delete the old link */
> -	if (SAS_ADDR(phy->attached_sas_addr) &&
> -	    SAS_ADDR(sas_addr) != SAS_ADDR(phy->attached_sas_addr)) {
> -		SAS_DPRINTK("ex %016llx phy 0x%x replace %016llx\n",
> -			    SAS_ADDR(dev->sas_addr), phy_id,
> -			    SAS_ADDR(phy->attached_sas_addr));
> -		sas_unregister_devs_sas_addr(dev, phy_id, last);
> -	}
> +	/* we always have to delete the old device when we went here */
> +	SAS_DPRINTK("ex %016llx phy 0x%x replace %016llx\n",
> +		    SAS_ADDR(dev->sas_addr), phy_id,
> +		    SAS_ADDR(phy->attached_sas_addr));
> +	sas_unregister_devs_sas_addr(dev, phy_id, last);
>  
>  	return sas_discover_new(dev, phy_id);
>  }
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

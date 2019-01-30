Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045212087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbfA3Qlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:41:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731496AbfA3Qlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:41:31 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E04A2C22CB5F777FFF94;
        Thu, 31 Jan 2019 00:41:27 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 00:41:21 +0800
Subject: Re: [PATCH v2 3/7] scsi: libsas: optimize the debug print of the
 revalidate process
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190130082412.9357-1-yanaijie@huawei.com>
 <20190130082412.9357-4-yanaijie@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>, <tj@kernel.org>, <miaoxie@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2ffa6821-93d4-7925-d435-e34338f323ec@huawei.com>
Date:   Wed, 30 Jan 2019 16:41:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190130082412.9357-4-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2019 08:24, Jason Yan wrote:
> sas_rediscover() returns error code if discover failed for a expander
> phy. And sas_ex_revalidate_domain() only returns the last phy's error
> code. So when sas_revalidate_domain() prints the return value of the
> discover process, we do not know if the revalidation for every phy is
> successful or not. We just know the last bcast phy revalidation
> succeeded or not.
>
> No need to return a error code for sas_ex_revalidate_domain() and
> sas_rediscover(), and just print the debug log for each bcast phy directly
> in sas_rediscover().

do we want to know about every PHY, or just the PHY where res != 0?

>

I don't see any optimisation here. Maybe an improvement.


> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/libsas/sas_discover.c |  7 +++----
>  drivers/scsi/libsas/sas_expander.c | 11 ++++++-----
>  include/scsi/libsas.h              |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index 726ada9b8c79..ffc571a12916 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -500,7 +500,6 @@ static void sas_discover_domain(struct work_struct *work)
>
>  static void sas_revalidate_domain(struct work_struct *work)
>  {
> -	int res = 0;
>  	struct sas_discovery_event *ev = to_sas_discovery_event(work);
>  	struct asd_sas_port *port = ev->port;
>  	struct sas_ha_struct *ha = port->ha;
> @@ -521,10 +520,10 @@ static void sas_revalidate_domain(struct work_struct *work)
>
>  	if (ddev && (ddev->dev_type == SAS_FANOUT_EXPANDER_DEVICE ||
>  		     ddev->dev_type == SAS_EDGE_EXPANDER_DEVICE))
> -		res = sas_ex_revalidate_domain(ddev);
> +		sas_ex_revalidate_domain(ddev);
>
> -	pr_debug("done REVALIDATING DOMAIN on port %d, pid:%d, res 0x%x\n",
> -		 port->id, task_pid_nr(current), res);
> +	pr_debug("done REVALIDATING DOMAIN on port %d, pid:%d\n",
> +		 port->id, task_pid_nr(current));
>   out:
>  	mutex_unlock(&ha->disco_mutex);
>
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 7b0e6dcef6e6..5cd720f93f96 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -2062,7 +2062,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id, bool last)
>   * first phy,for other phys in this port, we add it to the port to
>   * forming the wide-port.
>   */
> -static int sas_rediscover(struct domain_device *dev, const int phy_id)
> +static void sas_rediscover(struct domain_device *dev, const int phy_id)
>  {
>  	struct expander_device *ex = &dev->ex_dev;
>  	struct ex_phy *changed_phy = &ex->ex_phy[phy_id];
> @@ -2090,7 +2090,9 @@ static int sas_rediscover(struct domain_device *dev, const int phy_id)
>  		res = sas_rediscover_dev(dev, phy_id, last);
>  	} else
>  		res = sas_discover_new(dev, phy_id);
> -	return res;
> +
> +	pr_debug("ex %016llx phy%d discover returned 0x%x\n",

Hmmm.. this is not just discover, but also rediscover

> +		 SAS_ADDR(dev->sas_addr), phy_id, res);
>  }
>
>  /**
> @@ -2102,7 +2104,7 @@ static int sas_rediscover(struct domain_device *dev, const int phy_id)
>   * Discover process only interrogates devices in order to discover the
>   * domain.
>   */
> -int sas_ex_revalidate_domain(struct domain_device *port_dev)
> +void sas_ex_revalidate_domain(struct domain_device *port_dev)
>  {
>  	int res;
>  	struct domain_device *dev = NULL;
> @@ -2117,11 +2119,10 @@ int sas_ex_revalidate_domain(struct domain_device *port_dev)
>  			res = sas_find_bcast_phy(dev, &phy_id, i, true);

this was missed

>  			if (phy_id == -1)
>  				break;
> -			res = sas_rediscover(dev, phy_id);
> +			sas_rediscover(dev, phy_id);
>  			i = phy_id + 1;
>  		} while (i < ex->num_phys);
>  	}
> -	return res;
>  }
>
>  void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 420156cea3ee..e557bcb0c266 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -692,7 +692,7 @@ int  sas_discover_root_expander(struct domain_device *);
>
>  void sas_init_ex_attr(void);
>
> -int  sas_ex_revalidate_domain(struct domain_device *);
> +void sas_ex_revalidate_domain(struct domain_device *);
>
>  void sas_unregister_domain_devices(struct asd_sas_port *port, int gone);
>  void sas_init_disc(struct sas_discovery *disc, struct asd_sas_port *);
>



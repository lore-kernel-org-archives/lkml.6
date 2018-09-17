Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559CA2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559CA2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeIQTWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:22:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeIQTWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:22:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D0E2AC9C;
        Mon, 17 Sep 2018 13:54:45 +0000 (UTC)
Subject: Re: [PATCH 2/5] scsi: libsas: check the lldd callback correctly
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, zhaohongjiang@huawei.com,
        dan.j.williams@intel.com, jthumshirn@suse.de, hch@lst.de,
        huangdaode@hisilicon.com, chenxiang66@hisilicon.com,
        miaoxie@huawei.com, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-3-yanaijie@huawei.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <8114701f-be33-9c41-3ed7-e2a13490569d@suse.com>
Date:   Mon, 17 Sep 2018 15:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912082946.34814-3-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 10:29 AM, Jason Yan wrote:
> We are using lldd_port_deformed so we'd better check if lldd_port_deformed
> is NULL.
> 
> After this, we can remove hisi_sas_port_deformed() because it is just a
> stub to avoid a NULL dereference caused by the wrong check.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> CC: John Garry <john.garry@huawei.com>
> CC: Johannes Thumshirn <jthumshirn@suse.de>
> CC: Ewan Milne <emilne@redhat.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Tomas Henzl <thenzl@redhat.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas_main.c | 9 ++-------
>  drivers/scsi/libsas/sas_discover.c    | 2 +-
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index a4e2e6aa9a6b..1975c9266978 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -1861,10 +1861,6 @@ static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
>  	hisi_sas_port_notify_formed(sas_phy);
>  }
>  
> -static void hisi_sas_port_deformed(struct asd_sas_phy *sas_phy)
> -{
> -}
> -
>  static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
>  			u8 reg_index, u8 reg_count, u8 *write_data)
>  {
> @@ -1954,10 +1950,9 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>  	.lldd_I_T_nexus_reset	= hisi_sas_I_T_nexus_reset,
>  	.lldd_lu_reset		= hisi_sas_lu_reset,
>  	.lldd_query_task	= hisi_sas_query_task,
> -	.lldd_clear_nexus_ha = hisi_sas_clear_nexus_ha,
> +	.lldd_clear_nexus_ha	= hisi_sas_clear_nexus_ha,
>  	.lldd_port_formed	= hisi_sas_port_formed,
> -	.lldd_port_deformed = hisi_sas_port_deformed,
> -	.lldd_write_gpio = hisi_sas_write_gpio,
> +	.lldd_write_gpio	= hisi_sas_write_gpio,
>  };
>  
>  void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index 0148ae62a52a..dde433aa59c2 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -260,7 +260,7 @@ static void sas_suspend_devices(struct work_struct *work)
>  	 * phy_list is not being mutated
>  	 */
>  	list_for_each_entry(phy, &port->phy_list, port_phy_el) {
> -		if (si->dft->lldd_port_formed)
> +		if (si->dft->lldd_port_deformed)
>  			si->dft->lldd_port_deformed(phy);
>  		phy->suspended = 1;
>  		port->suspended = 1;
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes

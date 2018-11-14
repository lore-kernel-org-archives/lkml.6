Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F010E21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F010E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbeKOA5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:57:33 -0500
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:43343 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbeKOA5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:57:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8692B81EF;
        Wed, 14 Nov 2018 14:53:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: camp42_22a123e0ed33a
X-Filterd-Recvd-Size: 2356
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Nov 2018 14:53:57 +0000 (UTC)
Message-ID: <132ba0c903b36d85db30cfebf58fe1f4c3a7c05b.camel@perches.com>
Subject: Re: [PATCH 4/5] scsi: libsas: Drop SAS_DPRINTK() and revise logs
 levels
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     hare@suse.com, yanaijie@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Wed, 14 Nov 2018 06:53:56 -0800
In-Reply-To: <1542203269-174932-5-git-send-email-john.garry@huawei.com>
References: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
         <1542203269-174932-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 21:47 +0800, John Garry wrote:
> Like sas_printk() did previously, SAS_DPRINTK() offers little value now
> that libsas logs already have the "sas" prefix through pr_fmt(fmt). So it
> can be dropped.
> 
> However, after reviewing some logs in libsas, it is noticed that debug
> level is too low in many instances.
> 
> So this change drops SAS_DPRINTK() and revises some logs to a more
> appropriate level. However many stay at debug level, although some
> are significantly promoted.
[]
> All the pre-existing checkpatch errors for spanning messages across
> multiple lines are untouched.

I think coalescing would be useful.

Where there are already embedded "sas: "
prefixes, those should be removed too.

You could verify this by using

	$ strings drivers/scsi/libsas/*.o | grep "^[0-7]"

> @@ -186,10 +186,10 @@ int sas_notify_lldd_dev_found(struct domain_device *dev)
>  
>  	res = i->dft->lldd_dev_found(dev);
>  	if (res) {
> -		printk("sas: driver on pcidev %s cannot handle "
> -		       "device %llx, error:%d\n",
> -		       dev_name(sas_ha->dev),
> -		       SAS_ADDR(dev->sas_addr), res);
> +		pr_warn("sas: driver on pcidev %s cannot handle "
> +			"device %llx, error:%d\n",
> +			dev_name(sas_ha->dev),
> +			SAS_ADDR(dev->sas_addr), res);

e.g.: this now emits "sas: sas: driver etc..."



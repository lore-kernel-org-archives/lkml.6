Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEFFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2922322419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2922322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeKMD1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:27:20 -0500
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:49502 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727247AbeKMD1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:27:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EEB0C8368F07;
        Mon, 12 Nov 2018 17:33:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lamp19_8eca08dca8d01
X-Filterd-Recvd-Size: 1716
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Nov 2018 17:33:01 +0000 (UTC)
Message-ID: <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
Subject: Re: [PATCH] scsi: libsas: Remove pcidev reference
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date:   Mon, 12 Nov 2018 09:32:59 -0800
In-Reply-To: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
References: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 01:28 +0800, John Garry wrote:
> Not all host drivers are PCI drivers - like hisi_sas, which supports a
> platform driver - so remove reference to "pcidev".
> 
> The debug level is also downgraded to KERN_ERR for the same message.
[]
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
[]
> @@ -186,7 +186,7 @@ int sas_notify_lldd_dev_found(struct domain_device *dev)
>  
>  	res = i->dft->lldd_dev_found(dev);
>  	if (res) {
> -		printk("sas: driver on pcidev %s cannot handle "
> +		pr_err("sas: driver on host %s cannot handle "
>  		       "device %llx, error:%d\n",

As a printk without a KERN_<LEVEL> is printed at whatever
CONFIG_MESSAGE_LOGLEVEL_DEFAULT is set to (default: 4 and
rarely unchanged), this is effectively upgraded from a
KERN_WARNING to KERN_ERR.



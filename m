Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122F4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5C820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5C820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeINQlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:41:13 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:33803 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727726AbeINQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:41:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7DD9E181D340F;
        Fri, 14 Sep 2018 11:27:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: join08_3c2231186f403
X-Filterd-Recvd-Size: 2033
Received: from XPS-9350 (unknown [172.56.7.28])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Sep 2018 11:26:49 +0000 (UTC)
Message-ID: <f1def33e05f7d6f568ee2f5259f8b1a35b413a10.camel@perches.com>
Subject: Re: [PATCH] scsi: mpt3sas: make sysfs error messages ratelimited
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180907103924.17598-1-colin.king@canonical.com>
References: <20180907103924.17598-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date:   Fri, 14 Sep 2018 04:26:25 -0700
Mime-Version: 1.0
X-Mailer: Evolution 3.28.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 11:39 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It is possible to heavily spam the kernel logs with messages by
> excessive reading of the mpt3sas sysfs files.  Make the error messages
> ratelimited to reduce the spamming effect.
[]
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
[]
> @@ -2958,7 +2958,7 @@ _ctl_BRM_status_show(struct device *cdev, struct device_attribute *attr,
>  	ssize_t rc = 0;
>  
>  	if (!ioc->is_warpdrive) {
> -		pr_err(MPT3SAS_FMT "%s: BRM attribute is only for"
> +		pr_err_ratelimited(MPT3SAS_FMT "%s: BRM attribute is only for"
>  		    " warpdrive\n", ioc->name, __func__);
>  		goto out;
>  	}

trivia:

All the uses of MPT3SAS_FMT in drivers/scsi/mpt3sas/ seem
not nice.  It obfuscate the format and arguments.

Perhaps better would be create ioc_<level> macros.


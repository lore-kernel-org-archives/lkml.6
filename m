Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA8DC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86BA217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbfAZK0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:26:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:60294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbfAZK0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:26:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77282AB87;
        Sat, 26 Jan 2019 10:26:49 +0000 (UTC)
Subject: Re: [PATCH v2] SCSI: fcoe: convert to use BUS_ATTR_WO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190122142735.GB18225@kroah.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3e91c991-8090-405a-58cf-0686e9a82a51@suse.de>
Date:   Sat, 26 Jan 2019 11:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190122142735.GB18225@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 3:27 PM, Greg Kroah-Hartman wrote:
> We are trying to get rid of BUS_ATTR() and the usage of that in the fcoe
> driver can be trivially converted to use BUS_ATTR_WO(), so use that
> instead.
> 
> Cc: Johannes Thumshirn <jth@kernel.org>
> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: Made simpler with wrapper functions to call the "real" show/store
>      functions, thanks to James for the idea.
>      Removed the EXPORT_SYMBOL() removal line, that belongs in a separate
>      patch
> 
>   drivers/scsi/fcoe/fcoe_sysfs.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
> index 5c8310bade61..c3dcbdc3aa64 100644
> --- a/drivers/scsi/fcoe/fcoe_sysfs.c
> +++ b/drivers/scsi/fcoe/fcoe_sysfs.c
> @@ -671,8 +671,19 @@ static const struct device_type fcoe_fcf_device_type = {
>   	.release = fcoe_fcf_device_release,
>   };
>   
> -static BUS_ATTR(ctlr_create, S_IWUSR, NULL, fcoe_ctlr_create_store);
> -static BUS_ATTR(ctlr_destroy, S_IWUSR, NULL, fcoe_ctlr_destroy_store);
> +static ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
> +				 size_t count)
> +{
> +	return fcoe_ctlr_create_store(bus, buf, count);
> +}
> +static BUS_ATTR_WO(ctlr_create);
> +
> +static ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
> +				  size_t count)
> +{
> +	return fcoe_ctlr_destroy_store(bus, buf, count);
> +}
> +static BUS_ATTR_WO(ctlr_destroy);
>   
>   static struct attribute *fcoe_bus_attrs[] = {
>   	&bus_attr_ctlr_create.attr,
> 
Why not renaming the functions and drop the wrapper?

Cheers,

Hannes

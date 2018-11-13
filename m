Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0922086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0922086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbeKNBpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:45:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726932AbeKNBpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:45:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42EA1663A5055;
        Tue, 13 Nov 2018 23:46:54 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 23:46:50 +0800
Subject: Re: [PATCH] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
References: <5beae8ff.1c69fb81.bd59a.b7fa@mx.google.com>
CC:     <jrdr.linux@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <brajeswar.linux@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a34379dd-f6f0-b439-b6de-f2db142f1823@huawei.com>
Date:   Tue, 13 Nov 2018 15:44:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5beae8ff.1c69fb81.bd59a.b7fa@mx.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 15:08, Sabyasachi Gupta wrote:
> Replaced vmalloc + memset with vzalloc
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/scsi/fnic/fnic_trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
> index 8271785..129ab27 100644
> --- a/drivers/scsi/fnic/fnic_trace.c
> +++ b/drivers/scsi/fnic/fnic_trace.c
> @@ -468,14 +468,14 @@ int fnic_trace_buf_init(void)
>  	fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
>  					  FNIC_ENTRY_SIZE_BYTES;
>
> -	fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
> +	fnic_trace_buf_p = (unsigned long)vzalloc((trace_max_pages *
> +								PAGE_SIZE));

If you remove the extra brackets in vzalloc() argument then you may not 
spill onto the next line.

>  	if (!fnic_trace_buf_p) {
>  		printk(KERN_ERR PFX "Failed to allocate memory "
>  				  "for fnic_trace_buf_p\n");
>  		err = -ENOMEM;
>  		goto err_fnic_trace_buf_init;
>  	}
> -	memset((void *)fnic_trace_buf_p, 0, (trace_max_pages * PAGE_SIZE));
>
>  	fnic_trace_entries.page_offset =
>  		vmalloc(array_size(fnic_max_trace_entries,
>



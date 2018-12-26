Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D94EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC3C20989
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbeLZDnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:43:05 -0500
Received: from smtp.infotech.no ([82.134.31.41]:51689 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLZDnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:43:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 9BA502041E3;
        Wed, 26 Dec 2018 04:43:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PKKl1IEwfJbX; Wed, 26 Dec 2018 04:42:55 +0100 (CET)
Received: from [192.168.48.23] (host-184-164-16-103.dyn.295.ca [184.164.16.103])
        by smtp.infotech.no (Postfix) with ESMTPA id 51450204187;
        Wed, 26 Dec 2018 04:42:53 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: fix a double-fetch bug in sg_write
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181225202427.69476-1-kjlu@umn.edu>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <7e727b1a-88e5-7062-159e-bf4be110d168@interlog.com>
Date:   Tue, 25 Dec 2018 22:42:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181225202427.69476-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-25 3:24 p.m., Kangjie Lu wrote:
> "opcode" has been copied in from user space and checked. We should not
> copy it in again, which may have been modified by malicous
> multi-threading user programs through race conditions. The fix uses the
> opcode fetched in the first copy.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
  Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Also applied to my sg v4 driver code. The v1 and v2 interfaces (based on
struct sg_header) did not provide a command length field. The sg driver
needed to read the first byte of the command (the "opcode") to determine
the full command's length prior to actually reading it in full.

Hard to think of an example of an exploit based on this double read.

> ---
>   drivers/scsi/sg.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 4dacbfffd113..41774e4f9508 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -686,7 +686,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
>   	hp->flags = input_size;	/* structure abuse ... */
>   	hp->pack_id = old_hdr.pack_id;
>   	hp->usr_ptr = NULL;
> -	if (__copy_from_user(cmnd, buf, cmd_size))
> +	cmnd[0] = opcode;
> +	if (__copy_from_user(cmnd + 1, buf + 1, cmd_size - 1))
>   		return -EFAULT;
>   	/*
>   	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
> 


Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED0CC5CFC3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B8C205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935282AbeFRRJm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:09:42 -0400
Received: from smtp.infotech.no ([82.134.31.41]:40110 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755342AbeFRRJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:09:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1AC3C20423F;
        Mon, 18 Jun 2018 19:09:38 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YeIam9yBhuH9; Mon, 18 Jun 2018 19:09:38 +0200 (CEST)
Received: from [10.7.0.18] (unknown [10.7.0.18])
        by smtp.infotech.no (Postfix) with ESMTPA id 7415A20418A;
        Mon, 18 Jun 2018 19:09:36 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: scsi_debug: Fix memory leak on module unload
To:     Luis Henriques <lhenriques@suse.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180618160803.11674-1-lhenriques@suse.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <ce35ef87-917e-cb2d-12a0-12a0588b867f@interlog.com>
Date:   Mon, 18 Jun 2018 13:09:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618160803.11674-1-lhenriques@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-18 12:08 PM, Luis Henriques wrote:
> Since commit 80c49563e250 ("scsi: scsi_debug: implement IMMED bit") there are
> long delays in F_SYNC_DELAY and F_SSU_DELAY.  This can cause a memory leak in
> schedule_resp(), which can be invoked while unloading the scsi_debug module:
> free_all_queued() had already freed all sd_dp and schedule_resp will alloc a new
> one, which will never get freed.  Here's the kmemleak report while running
> xfstests generic/350:
> 
> unreferenced object 0xffff88007d752b00 (size 128):
>    comm "rmmod", pid 26940, jiffies 4295816945 (age 7.588s)
>    hex dump (first 32 bytes):
>      00 2b 75 7d 00 88 ff ff 00 00 00 00 00 00 00 00  .+u}............
>      00 00 00 00 00 00 00 00 8e 31 a2 34 5f 03 00 00  .........1.4_...
>    backtrace:
>      [<000000002abd83d0>] 0xffffffffa000705e
>      [<000000004c063fda>] scsi_dispatch_cmd+0xc7/0x1a0
>      [<000000000c119a00>] scsi_request_fn+0x251/0x550
>      [<000000009de0c736>] __blk_run_queue+0x3f/0x60
>      [<000000001c4453c8>] blk_execute_rq_nowait+0x98/0xd0
>      [<00000000d17ec79f>] blk_execute_rq+0x3a/0x50
>      [<00000000a7654b6e>] scsi_execute+0x113/0x250
>      [<00000000fd78f7cd>] sd_sync_cache+0x95/0x160
>      [<0000000024dacb14>] sd_shutdown+0x9b/0xd0
>      [<00000000e9101710>] sd_remove+0x5f/0xb0
>      [<00000000c43f0d63>] device_release_driver_internal+0x13c/0x1f0
>      [<00000000e8ad57b6>] bus_remove_device+0xe9/0x160
>      [<00000000713a7b8a>] device_del+0x120/0x320
>      [<00000000e5db670c>] __scsi_remove_device+0x115/0x150
>      [<00000000eccbef30>] scsi_forget_host+0x20/0x60
>      [<00000000cd5a0738>] scsi_remove_host+0x6d/0x120
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks.

> ---
>   drivers/scsi/scsi_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 24d7496cd9e2..364e71861bfd 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -5507,9 +5507,9 @@ static void __exit scsi_debug_exit(void)
>   	int k = sdebug_add_host;
>   
>   	stop_all_queued();
> -	free_all_queued();
>   	for (; k; k--)
>   		sdebug_remove_adapter();
> +	free_all_queued();
>   	driver_unregister(&sdebug_driverfs_driver);
>   	bus_unregister(&pseudo_lld_bus);
>   	root_device_unregister(pseudo_primary);
> 


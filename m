Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A48EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4FA21A13
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXfZD4iV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4FA21A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbeHGBub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:50:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbeHGBua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OepMvDgitVkbslDlVfLAx+7xirDCIhVDWmMiq8OuIks=; b=VXfZD4iVp4D5oORJRoz6E04fu
        toEsqpzRclNuZwXUMmobpaCPRpI1jpK8DEKJLOrvkwQnw5wMXWLBtBlBzVEu5mozRT5GfQuB9ojkM
        L5o0YAmt5IcZFcQThc26Fd92Vur3D4B/6PS8O0YNIlGqEeIpy3C/rL3K513/2viGOE5zcbke0ji07
        0we/ARAt4SiYKpWwFMQOSuSg32bug4l+RLMo/R/jY4xpO2S4EC+MKT6Rj2fO+IqTQekDg+8LwjmNK
        xDDbpIAlAA9SHXm3BX1KcQN+iVS/MWBeHTe+1v0EJ5DSzntxINABlHDFykMspYUFaTPqdX/iGsrLB
        7duEbBAqQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmp5S-000474-9c; Mon, 06 Aug 2018 23:38:54 +0000
Subject: Re: [PATCH v2 4/9] target: don't depend on SCSI
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
References: <20180731195155.46664-1-keescook@chromium.org>
 <20180731195155.46664-5-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <111cb1b0-24ba-bcb2-53d5-9665d2b4c421@infradead.org>
Date:   Mon, 6 Aug 2018 16:38:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731195155.46664-5-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 12:51 PM, Kees Cook wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The core target code only needs code from scsi_common.c, which is now
> separately selectable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/target/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/Kconfig b/drivers/target/Kconfig
> index 4c44d7bed01a..cb6f32ce7de8 100644
> --- a/drivers/target/Kconfig
> +++ b/drivers/target/Kconfig
> @@ -1,10 +1,10 @@
>  
>  menuconfig TARGET_CORE
>  	tristate "Generic Target Core Mod (TCM) and ConfigFS Infrastructure"
> -	depends on SCSI && BLOCK
> +	depends on BLOCK
>  	select CONFIGFS_FS
>  	select CRC_T10DIF
> -	select BLK_SCSI_REQUEST # only for scsi_command_size_tbl..
> +	select BLK_SCSI_REQUEST
>  	select SGL_ALLOC
>  	default n
>  	help
> @@ -29,6 +29,7 @@ config TCM_FILEIO
>  
>  config TCM_PSCSI
>  	tristate "TCM/pSCSI Subsystem Plugin for Linux/SCSI"
> +	depends on SCSI
>  	help
>  	Say Y here to enable the TCM/pSCSI subsystem plugin for non-buffered
>  	passthrough access to Linux/SCSI device
> 

Hi,

This patch causes build errors in linux-next-20180806 when SCSI=m and
LOOPBACK_TARGET=y.

drivers/target/loopback/tcm_loop.o: In function `tcm_loop_port_link':
tcm_loop.c:(.text+0x445): undefined reference to `scsi_add_device'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_driver_remove':
tcm_loop.c:(.text+0x55c): undefined reference to `scsi_remove_host'
tcm_loop.c:(.text+0x564): undefined reference to `scsi_host_put'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_submission_work':
tcm_loop.c:(.text+0x7c4): undefined reference to `scmd_printk'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_driver_probe':
tcm_loop.c:(.text+0x7fb): undefined reference to `scsi_host_alloc'
tcm_loop.c:(.text+0x85b): undefined reference to `scsi_add_host_with_dma'
tcm_loop.c:(.text+0x896): undefined reference to `scsi_host_put'
drivers/target/loopback/tcm_loop.o: In function `tcm_loop_port_unlink':
tcm_loop.c:(.text+0x962): undefined reference to `scsi_device_lookup'
tcm_loop.c:(.text+0x972): undefined reference to `scsi_remove_device'
tcm_loop.c:(.text+0x97a): undefined reference to `scsi_device_put'
drivers/target/loopback/tcm_loop.o:(.data+0x210): undefined reference to `scsi_change_queue_depth'


-- 
~Randy

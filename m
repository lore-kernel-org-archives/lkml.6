Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D593C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD5920857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD5920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeIIQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 12:41:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726662AbeIIQls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 12:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B15126A81;
        Sun,  9 Sep 2018 11:52:22 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D37EC112D184;
        Sun,  9 Sep 2018 11:52:12 +0000 (UTC)
Date:   Sun, 9 Sep 2018 19:52:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xuewei Zhang <xueweiz@google.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kali <adityakali@google.com>, tytso@mit.edu,
        Guenter Roeck <groeck@chromium.org>, maze@google.com
Subject: Re: [PATCH] scsi: sd: Contribute to randomness when running
 rotational device
Message-ID: <20180909115205.GA17732@ming.t460p>
References: <20180906203719.209399-1-xueweiz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906203719.209399-1-xueweiz@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 09 Sep 2018 11:52:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 09 Sep 2018 11:52:22 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:37:19PM -0700, Xuewei Zhang wrote:
> Currently a scsi device won't contribute to kernel randomness when it
> uses blk-mq. Since we commonly use scsi on rotational device with
> blk-mq, it make sense to keep contributing to kernel randomness in these
> cases. This is especially important for virtual machines.
> 
> commit b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic
> irq vector affinity") made all virtio-scsi device to use blk-mq, which
> does not contribute to randomness today. So for a virtual machine only
> having virtio-scsi disk (which is common), it will simple stop getting
> randomness from its disks in today's implementation.
> 
> With this patch, if the above VM has rotational virtio-scsi device, then
> it can still benefit from the entropy generated from the disk.
> 
> Reported-by: Xuewei Zhang <xueweiz@google.com>
> Signed-off-by: Xuewei Zhang <xueweiz@google.com>
> ---
>  drivers/scsi/sd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index b79b366a94f7..5e4f10d28065 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2959,6 +2959,9 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>  	if (rot == 1) {
>  		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>  		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
> +	} else {
> +		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
> +		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
>  	}
>  
>  	if (sdkp->device->type == TYPE_ZBC) {
> -- 
> 2.19.0.rc2.392.g5ba43deb5a-goog
> 

Look reasonable, especially the disk randomness is added by SCSI itself.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

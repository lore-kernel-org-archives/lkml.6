Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E80120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E80120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=s5r6.in-berlin.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbeGWNb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:31:57 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:45291 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388578AbeGWNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:31:56 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 09:31:55 EDT
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTP id w6NCOI4F004999
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jul 2018 14:24:21 +0200
Date:   Mon, 23 Jul 2018 14:24:18 +0200
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] firewire: sbp2: Replace GFP_ATOMIC with GFP_KERNEL in
 sbp2_scsi_queuecommand()
Message-ID: <20180723142418.4aef4910@kant>
In-Reply-To: <20180723085801.6711-1-baijiaju1990@gmail.com>
References: <20180723085801.6711-1-baijiaju1990@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Cc: LSML

On Jul 23 Jia-Ju Bai wrote:
> sbp2_scsi_queuecommand() is only set to .queuecommand of 
> "struct scsi_host_template", and this function pointer is never called
> in atomic context.

As far as I remember, scsi_host_template::queuecommand() can be invoked
from either process context or tasklet context, predominantly the latter.

I haven't followed recent developments of the block and scsi stack, hence
don't know if this has changed fundamentally.

But even if it is purely process context now and no spinlocks held, the
memory allocation must be done so that the kernel does not go into memory
reclaim. Otherwise this could deadlock.

> sbp2_scsi_queuecommand() calls kzalloc() with GFP_ATOMIC,
> which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.

I doubt that static analysis, even if very sophisticated, can detect
deadlock scenarios such as I noted.

> I also manually check the kernel code before reporting it.

What does it mean?  Did you run-time test it, for which actual SBP-2
hardware is required?  (Such a test could detect GFP-KERNEL use in atomic
context, but would not reliably detect memory reclaim related deadlocks.)

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/firewire/sbp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
> index 6bac03999fd4..a7cd9d87eb02 100644
> --- a/drivers/firewire/sbp2.c
> +++ b/drivers/firewire/sbp2.c
> @@ -1463,7 +1463,7 @@ static int sbp2_scsi_queuecommand(struct Scsi_Host *shost,
>  	struct sbp2_command_orb *orb;
>  	int generation, retval = SCSI_MLQUEUE_HOST_BUSY;
>  
> -	orb = kzalloc(sizeof(*orb), GFP_ATOMIC);
> +	orb = kzalloc(sizeof(*orb), GFP_KERNEL);
>  	if (orb == NULL)
>  		return SCSI_MLQUEUE_HOST_BUSY;
>  

NACK for GFP_KERNEL, but I am curious whether a weaker GFP set than ATOMIC
is possible in scsi_host_template::queuecommand.
-- 
Stefan Richter
-======---=- -=== =-===
http://arcgraph.de/sr/

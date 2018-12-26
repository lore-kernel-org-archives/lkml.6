Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6757C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986FA21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLZGtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:49:21 -0500
Received: from smtp.infotech.no ([82.134.31.41]:52288 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeLZGtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:49:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7694120423B;
        Wed, 26 Dec 2018 07:49:19 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d488c0zTdaSy; Wed, 26 Dec 2018 07:49:13 +0100 (CET)
Received: from [192.168.48.23] (host-184-164-16-103.dyn.295.ca [184.164.16.103])
        by smtp.infotech.no (Postfix) with ESMTPA id 3417E20417A;
        Wed, 26 Dec 2018 07:49:11 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] scsi: avoid a double-fetch and a redundant copy
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181225201554.69395-1-kjlu@umn.edu>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <e68496e2-248b-e7ec-9bc2-597446c5b495@interlog.com>
Date:   Wed, 26 Dec 2018 01:49:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181225201554.69395-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-25 3:15 p.m., Kangjie Lu wrote:
> What we need is only "pack_id", so do not create a heap object or copy
> the whole object in. The fix efficiently copies "pack_id" only.

Now this looks like a worthwhile optimization, in some pretty tricky
code. I can't see a security angle in it. Did you test it?

Well the code as presented doesn't compile and the management takes a
dim view of that.

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/scsi/sg.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index c6ad00703c5b..4dacbfffd113 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -446,16 +446,8 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
>   		}
>   		if (old_hdr->reply_len < 0) {
>   			if (count >= SZ_SG_IO_HDR) {
> -				sg_io_hdr_t *new_hdr;
> -				new_hdr = kmalloc(SZ_SG_IO_HDR, GFP_KERNEL);
> -				if (!new_hdr) {
> -					retval = -ENOMEM;
> -					goto free_old_hdr;
> -				}
> -				retval =__copy_from_user
> -				    (new_hdr, buf, SZ_SG_IO_HDR);
> -				req_pack_id = new_hdr->pack_id;
> -				kfree(new_hdr);
> +				retval = get_user(req_pack_id,
> +						&((sg_io_hdr_t *)buf->pack_id));

The '->' binds higher then the cast and since buf is a 'char *' it doesn't
have a member called pack_id .

Hopefully your drive to remove redundancy went a little too far and removed
the required (but missing) parentheses binding the cast to 'buf'.

>   				if (retval) {
>   					retval = -EFAULT;
>   					goto free_old_hdr;
> 

Good work, silly mistake, but its got me thinking, the heap allocation can be
replaced by stack since its short. The code in this area is more tricky in
the v4 driver because I want to specifically exclude the sg_io_v4 (aka v4)
interface being sent through write(2)/read(2). The way to do that is to read
the first 32 bit integer which should be 'S' or v3, 'Q' for v4.


Hmm, just looking further along my mailer I see the kbuild test robot
has picked up the error and you have presented another patch which also
won't compile. Please stop doing that; apply your patch to kernel source
and compile it _before_ sending it to this list.

Doug Gilbert


Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD93C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F54D208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F54D208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJBGPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:15:02 -0400
Received: from smtp.infotech.no ([82.134.31.41]:50099 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbeJBGPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:15:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 3B29520423A;
        Tue,  2 Oct 2018 01:34:47 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V+d8ZnTecW5n; Tue,  2 Oct 2018 01:34:40 +0200 (CEST)
Received: from [192.168.0.12] (unknown [58.173.107.31])
        by smtp.infotech.no (Postfix) with ESMTPA id 8C13C20418C;
        Tue,  2 Oct 2018 01:34:36 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH RESEND] scsi: sg: Prevent potential double frees in sg
 driver
To:     Evan Green <evgreen@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robb Glasser <rglasser@google.com>, stable@vger.kernel.org
References: <20181001161506.100284-1-evgreen@chromium.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <ef53fcb4-9001-c06b-779f-d40949224c98@interlog.com>
Date:   Tue, 2 Oct 2018 09:34:33 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001161506.100284-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-02 02:15 AM, Evan Green wrote:
> From: Robb Glasser <rglasser@google.com>
> 
> sg_ioctl could be spammed by requests, leading to a double free in
> __free_pages. This protects the entry points of sg_ioctl where the
> memory could be corrupted by a double call to __free_pages if multiple
> requests are happening concurrently.

Hi,
I  don't like this patch. I would like to see the trace for the double
call to the __free_pages you are referring too. A test program that
show the fault, perhaps?

I have test code to "spam" the sg driver and have not seen a double
__free_pages that you refer to (see sg3_utils package version 1.44,
testing/sg_tst_async.cpp).

Currently I am dusting off 20 years of "laparoscopic" patches to the sg
driver that have made a bit of a mess of the naming and comments. Also
the 16 outstanding requests per file descriptor limit is being removed.
Then I want to add the SG_IOSUBMIT and SG_IORECEIVE ioctls proposed by
Linus Torvalds two week ago.

Executive summary: nak, without further information

Doug Gilbert

> Signed-off-by: Robb Glasser <rglasser@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Cc: stable@vger.kernel.org
> 
> ---
> Reposting this patch from last summer, as it looks like it fell in between
> the cracks.
> 
>   drivers/scsi/sg.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 8a254bb46a9b..25579d8a16b5 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -924,8 +924,10 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
>   			return -ENXIO;
>   		if (!access_ok(VERIFY_WRITE, p, SZ_SG_IO_HDR))
>   			return -EFAULT;
> +		mutex_lock(&sfp->parentdp->open_rel_lock);
>   		result = sg_new_write(sfp, filp, p, SZ_SG_IO_HDR,
>   				 1, read_only, 1, &srp);
> +		mutex_unlock(&sfp->parentdp->open_rel_lock);
>   		if (result < 0)
>   			return result;
>   		result = wait_event_interruptible(sfp->read_wait,
> 


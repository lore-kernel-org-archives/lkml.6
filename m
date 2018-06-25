Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9D6C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA92262A3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA92262A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933724AbeFYXS5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:18:57 -0400
Received: from smtp.infotech.no ([82.134.31.41]:47703 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754559AbeFYXS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:18:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 01275204187;
        Tue, 26 Jun 2018 01:18:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gj+h0CcrDX11; Tue, 26 Jun 2018 01:18:52 +0200 (CEST)
Received: from [82.134.31.189] (unknown [82.134.31.189])
        by smtp.infotech.no (Postfix) with ESMTPA id CD9D3204152;
        Tue, 26 Jun 2018 01:18:52 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3] sg: mitigate read/write abuse
To:     Jann Horn <jannh@google.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        kernel-hardening@lists.openwall.com, security@kernel.org,
        Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20180625142544.182673-1-jannh@google.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <beea2f87-807d-eabd-bd92-3f3feacb78ba@interlog.com>
Date:   Tue, 26 Jun 2018 01:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625142544.182673-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-25 04:25 PM, Jann Horn wrote:
> As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
> to be called under KERNEL_DS"), sg improperly accesses userspace memory
> outside the provided buffer, permitting kernel memory corruption via
> splice().
> But it doesn't just do it on ->write(), also on ->read().
> 
> As a band-aid, make sure that the ->read() and ->write() handlers can not
> be called in weird contexts (kernel context or credentials different from
> file opener), like for ib_safe_file_access().
> 
> If someone needs to use these interfaces from different security contexts,
> a new interface should be written that goes through the ->ioctl() handler.
> 
> I've mostly copypasted ib_safe_file_access() over as sg_safe_file_access()
> because I couldn't find a good common header - please tell me if you know a
> better way.
> 
> changed in v2:
>   - remove the bsg parts per Christoph Hellwig's request
> 
> changed in v3:
>   - move error messages into helper function
>   - use two different error messages and return values (Douglas Gilbert)
>   - add comment on stranded responses (Douglas Gilbert)
>   - use current_real_cred() instead of current_cred() (so that
>     override_creds() can't bypass this check)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   drivers/scsi/sg.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 53ae52dbff84..4f4e88ca8213 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -51,6 +51,7 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
>   #include <linux/atomic.h>
>   #include <linux/ratelimit.h>
>   #include <linux/uio.h>
> +#include <linux/cred.h> /* for sg_safe_file_access() */

s/_safe_/_check_/

>   
>   #include "scsi.h"
>   #include <scsi/scsi_dbg.h>
> @@ -209,6 +210,33 @@ static void sg_device_destroy(struct kref *kref);
>   	sdev_prefix_printk(prefix, (sdp)->device,		\
>   			   (sdp)->disk->disk_name, fmt, ##a)
>   
> +/*
> + * The SCSI interfaces that use read() and write() as an asynchronous variant of
> + * ioctl(..., SG_IO, ...) are fundamentally unsafe, since there are lots of ways
> + * to trigger read() and write() calls from various contexts with elevated
> + * privileges. This can lead to kernel memory corruption (e.g. if these
> + * interfaces are called through splice()) and privilege escalation inside
> + * userspace (e.g. if a process with access to such a device passes a file
> + * descriptor to a SUID binary as stdin/stdout/stderr).
> + *
> + * This function provides protection for the legacy API by restricting the
> + * calling context.
> + */
> +static int sg_check_file_access(struct file *filp, const char *caller)
> +{
> +	if (filp->f_cred != current_real_cred()) {
> +		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
> +			caller, task_tgid_vnr(current), current->comm);
> +		return -EPERM;
> +	}
> +	if (uaccess_kernel()) {
> +		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
> +			caller, task_tgid_vnr(current), current->comm);
> +		return -EACCES;
> +	}
> +	return 0;
> +}
> +
>   static int sg_allow_access(struct file *filp, unsigned char *cmd)
>   {
>   	struct sg_fd *sfp = filp->private_data;
> @@ -393,6 +421,14 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
>   	struct sg_header *old_hdr = NULL;
>   	int retval = 0;
>   
> +	/*
> +	 * This could cause a response to be stranded. Close the associated
> +	 * file descriptor to free up any resources being held.
> +	 */
> +	retval = sg_check_file_access(filp, __func__);
> +	if (retval)
> +		return retval;
> +
>   	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
>   		return -ENXIO;
>   	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
> @@ -580,9 +616,11 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
>   	struct sg_header old_hdr;
>   	sg_io_hdr_t *hp;
>   	unsigned char cmnd[SG_MAX_CDB_SIZE];
> +	int retval;
>   
> -	if (unlikely(uaccess_kernel()))
> -		return -EINVAL;
> +	retval = sg_check_file_access(filp, __func__);
> +	if (retval)
> +		return retval;
>   
>   	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
>   		return -ENXIO;
> 

If you need to make any other changes to this patch, then you could fix
that typo above.

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D35C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FFA21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfAVQW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:22:58 -0500
Received: from opengridcomputing.com ([72.48.214.68]:34600 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbfAVQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:22:57 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id F139922774;
        Tue, 22 Jan 2019 10:22:56 -0600 (CST)
Subject: Re: [PATCH 1/8] infiniband: cxgb4: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
 <20190122151800.15092-2-gregkh@linuxfoundation.org>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <dbf27d3d-ff19-4054-9495-80bcb5a10485@opengridcomputing.com>
Date:   Tue, 22 Jan 2019 10:22:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122151800.15092-2-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg,

On 1/22/2019 9:17 AM, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Steve Wise <swise@chelsio.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/hw/cxgb4/device.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
> index c13c0ba30f63..9c10fff6dcfb 100644
> --- a/drivers/infiniband/hw/cxgb4/device.c
> +++ b/drivers/infiniband/hw/cxgb4/device.c
> @@ -720,11 +720,8 @@ static const struct file_operations ep_debugfs_fops = {
>  	.read    = debugfs_read,
>  };
>  
> -static int setup_debugfs(struct c4iw_dev *devp)
> +static void setup_debugfs(struct c4iw_dev *devp)
>  {
> -	if (!devp->debugfs_root)
> -		return -1;
> -
>  	debugfs_create_file_size("qps", S_IWUSR, devp->debugfs_root,
>  				 (void *)devp, &qp_debugfs_fops, 4096);
>  
> @@ -740,7 +737,6 @@ static int setup_debugfs(struct c4iw_dev *devp)
>  	if (c4iw_wr_log)
>  		debugfs_create_file_size("wr_log", S_IWUSR, devp->debugfs_root,
>  					 (void *)devp, &wr_log_debugfs_fops, 4096);
> -	return 0;
>  }
>  
>  void c4iw_release_dev_ucontext(struct c4iw_rdev *rdev,
> @@ -1553,8 +1549,6 @@ static int __init c4iw_init_module(void)
>  		return err;
>  
>  	c4iw_debugfs_root = debugfs_create_dir(DRV_NAME, NULL);
> -	if (!c4iw_debugfs_root)
> -		pr_warn("could not create debugfs entry, continuing\n");
>  
>  	reg_workq = create_singlethread_workqueue("Register_iWARP_device");
>  	if (!reg_workq) {
> 

So it is not a problem to call debugfs_create_file_size() when
devp->debugfs_root is NULL?


Acked-by: Steve Wise <swise@opengridcomputing.com>

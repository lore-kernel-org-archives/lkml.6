Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F23C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C04A21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548174663;
	bh=kSynZL7eAkbY84I9sJkVn+Tr6YMrzM9uidYkUGLeFv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eNNUVbbYegml/BRomVPAmFyNCef0ltC/J9jDpeildsPbcW33uKDsikWCZBIboBWyx
	 c93IFkOVCbrbkHmGYIFDvZ/NqVtp3omy2z2lIc2gWxE583tdA72JiQ7yb82j+Hhywg
	 qJiSx0EQZhbCcq+LRRVa5sfQ2sdilD4IMvXLEzqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfAVQbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbfAVQbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:31:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822D22085A;
        Tue, 22 Jan 2019 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548174660;
        bh=kSynZL7eAkbY84I9sJkVn+Tr6YMrzM9uidYkUGLeFv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNi2mXuLFMwDsWMbuCqqasPmILCZdjbEAqXpkQcl3k9+T6cgSJNv/FU5HN/ArIvNM
         PwEnOQ0jXzDAcBzwCs2gM7EfCXdHDFVE4Z8uKDqAWNz4xSHCJZZlWFOJkFLtUKMbpt
         IsmirxvnE1ukqcy/bT48Q/hKdTdCE5NxqYE6fQM4=
Date:   Tue, 22 Jan 2019 17:30:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steve Wise <swise@opengridcomputing.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/8] infiniband: cxgb4: no need to check return value of
 debugfs_create functions
Message-ID: <20190122163057.GA23510@kroah.com>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
 <20190122151800.15092-2-gregkh@linuxfoundation.org>
 <dbf27d3d-ff19-4054-9495-80bcb5a10485@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf27d3d-ff19-4054-9495-80bcb5a10485@opengridcomputing.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:22:59AM -0600, Steve Wise wrote:
> Hey Greg,
> 
> On 1/22/2019 9:17 AM, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Steve Wise <swise@chelsio.com>
> > Cc: Doug Ledford <dledford@redhat.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/infiniband/hw/cxgb4/device.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
> > index c13c0ba30f63..9c10fff6dcfb 100644
> > --- a/drivers/infiniband/hw/cxgb4/device.c
> > +++ b/drivers/infiniband/hw/cxgb4/device.c
> > @@ -720,11 +720,8 @@ static const struct file_operations ep_debugfs_fops = {
> >  	.read    = debugfs_read,
> >  };
> >  
> > -static int setup_debugfs(struct c4iw_dev *devp)
> > +static void setup_debugfs(struct c4iw_dev *devp)
> >  {
> > -	if (!devp->debugfs_root)
> > -		return -1;
> > -
> >  	debugfs_create_file_size("qps", S_IWUSR, devp->debugfs_root,
> >  				 (void *)devp, &qp_debugfs_fops, 4096);
> >  
> > @@ -740,7 +737,6 @@ static int setup_debugfs(struct c4iw_dev *devp)
> >  	if (c4iw_wr_log)
> >  		debugfs_create_file_size("wr_log", S_IWUSR, devp->debugfs_root,
> >  					 (void *)devp, &wr_log_debugfs_fops, 4096);
> > -	return 0;
> >  }
> >  
> >  void c4iw_release_dev_ucontext(struct c4iw_rdev *rdev,
> > @@ -1553,8 +1549,6 @@ static int __init c4iw_init_module(void)
> >  		return err;
> >  
> >  	c4iw_debugfs_root = debugfs_create_dir(DRV_NAME, NULL);
> > -	if (!c4iw_debugfs_root)
> > -		pr_warn("could not create debugfs entry, continuing\n");
> >  
> >  	reg_workq = create_singlethread_workqueue("Register_iWARP_device");
> >  	if (!reg_workq) {
> > 
> 
> So it is not a problem to call debugfs_create_file_size() when
> devp->debugfs_root is NULL?

Nope!

> 
> Acked-by: Steve Wise <swise@opengridcomputing.com>

Thanks,

greg k-h

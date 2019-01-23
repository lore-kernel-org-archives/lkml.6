Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A68C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892A21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548226467;
	bh=Fn+0fF9Fr/2cq8up47QqbjHOey9kzUYCbrdqfdRUASE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sTfgj8d/KS5+gNbHHfmLf6S9iWDm1VNFP/ehwmfi1WDIMcHCafoqIr3vUIPXGdic7
	 8OBspAzoajVq3Bk9y6wntt6VZv8w6xf90AOM8atMcWNwouxe7g9S7bJNjsx9FcSLkM
	 WP6vzEavweSshG9r4WgK+nbWDngmSea7p+JCaquA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfAWGy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfAWGyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:54:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 598EE21726;
        Wed, 23 Jan 2019 06:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548226464;
        bh=Fn+0fF9Fr/2cq8up47QqbjHOey9kzUYCbrdqfdRUASE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xoSqs4KvsLnAVjubIM6uyq+rkM8dRWScHFnvNXtdYOXW/7UqXiHQcoEBVkhiwTNDN
         vY8axu00gapaV3SH4w82LxoN3Ya/sEjmz4ZXtfWRg394uQmOELLFHief9D0UPkGr/c
         aOgYqtJ6PUJ81B/32ZUenukJlJn1CJI2y4ChmwAw=
Date:   Wed, 23 Jan 2019 07:54:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] kprobes: no need to check return value of debugfs_create
 functions
Message-ID: <20190123065422.GA27466@kroah.com>
References: <20190122152151.16139-47-gregkh@linuxfoundation.org>
 <20190123111516.d5fd81cb315810235205fbeb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123111516.d5fd81cb315810235205fbeb@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:15:16AM +0900, Masami Hiramatsu wrote:
> On Tue, 22 Jan 2019 16:21:46 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/kprobes.c | 25 ++++++-------------------
> >  1 file changed, 6 insertions(+), 19 deletions(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index f4ddfdd2d07e..7287e7de2350 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2566,33 +2566,20 @@ static const struct file_operations fops_kp = {
> >  
> >  static int __init debugfs_kprobe_init(void)
> >  {
> > -	struct dentry *dir, *file;
> > +	struct dentry *dir;
> >  	unsigned int value = 1;
> >  
> >  	dir = debugfs_create_dir("kprobes", NULL);
> > -	if (!dir)
> > -		return -ENOMEM;
> 
> Here, I think IS_ERR(dir) is OK for debugfs_create_file(),
> but dir == NULL has different meaning. I think we'd better
> keep this check. (I see, -ENOMEM will be no good...)

dir == NULL means the system is out of memory.  Which I'll change and
just make it return an error, so it is fine to ignore this value.

thanks,

greg k-h

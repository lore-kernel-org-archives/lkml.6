Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DDCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D88217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548225193;
	bh=1OIinAK2VqHuUlLECWToVBckb1pu+BGk8GjTl4aGRc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yi3Qc3bFmOtK2CfZ9J/CougOT9+7bdSZLoU5hviX3CjF2Urdxr2xx9Irm2Zc/2zR+
	 UREnR5/Qc+ULV/lCryx7RjoUTM0nmKw6mZC/k98sRcl5qHjeOB+eQUGZVoalA7PnrZ
	 mjgiCJvmDHqZn17GyP8m87xz67ZWkuZ6NbPCuLa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfAWGdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:33:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfAWGdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:33:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE86521019;
        Wed, 23 Jan 2019 06:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548225188;
        bh=1OIinAK2VqHuUlLECWToVBckb1pu+BGk8GjTl4aGRc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWuiIjxCVGgaKHSYvMUZySDA+d9j0Bc9ifvJD7yjqZDfWvAfI8VnRT9vUw44CZSkC
         NOjl9CIn28X6btE065WaO6/HxwLBIXy2PbcCMOq+Fy+esKditeCCTLOlJVWHOD99+J
         E0xFMuN7JuxSu1i+KMm2emNODAeMi5aJRLBhmLqU=
Date:   Wed, 23 Jan 2019 07:33:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josef Bacik <jbacik@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH] fail_function: no need to check return value of
 debugfs_create functions
Message-ID: <20190123063305.GA25275@kroah.com>
References: <20190122152151.16139-45-gregkh@linuxfoundation.org>
 <20190123091141.bfc311d389e48a23af79a8a9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123091141.bfc311d389e48a23af79a8a9@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:11:41AM +0900, Masami Hiramatsu wrote:
> On Tue, 22 Jan 2019 16:21:44 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> Ah, OK. It simplifies the code. But I have a question below,
> 
> > 
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Josef Bacik <jbacik@fb.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: zhong jiang <zhongjiang@huawei.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/fail_function.c | 23 +++++------------------
> >  1 file changed, 5 insertions(+), 18 deletions(-)
> > 
> > diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> > index 17f75b545f66..afc779be5ebb 100644
> > --- a/kernel/fail_function.c
> > +++ b/kernel/fail_function.c
> > @@ -152,20 +152,13 @@ static int fei_retval_get(void *data, u64 *val)
> >  DEFINE_DEBUGFS_ATTRIBUTE(fei_retval_ops, fei_retval_get, fei_retval_set,
> >  			 "%llx\n");
> >  
> > -static int fei_debugfs_add_attr(struct fei_attr *attr)
> > +static void fei_debugfs_add_attr(struct fei_attr *attr)
> >  {
> >  	struct dentry *dir;
> >  
> >  	dir = debugfs_create_dir(attr->kp.symbol_name, fei_debugfs_dir);
> > -	if (!dir)
> > -		return -ENOMEM;
> > -
> > -	if (!debugfs_create_file("retval", 0600, dir, attr, &fei_retval_ops)) {
> > -		debugfs_remove_recursive(dir);
> > -		return -ENOMEM;
> > -	}
> >  
> > -	return 0;
> 
> Don't we need to check dir here? If above debugfs_create_dir() returns NULL,
> it seems we will create "retval" under root directory of debugfs.

If NULL is returned, your system is out of memory and worse things are
about to happen :)

thanks,

greg k-h

Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C21C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A12217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548228829;
	bh=yShXka+I1ykNY85lFktr4Xoj6raAzOluZd5zFbajo2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D6gb65mjfGL5uzKtdx/HKvLu1q+ZO3zpWiDNWUPfTdASnRztJFHK1DnMwkarqoJTu
	 ME+hPNc9BuSA44rza3IV9bFxXFko0rg0KLrwY7uw3W3wE87qDjT1zKeVgm87Xmzolt
	 KCISGDEHtzf9IUzYi/A9Bhry2TPncRuwuskeVJvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAWHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAWHdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:33:47 -0500
Received: from devnote (p105099-mobac01.tokyo.ocn.ne.jp [153.233.96.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A7E21726;
        Wed, 23 Jan 2019 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548228825;
        bh=yShXka+I1ykNY85lFktr4Xoj6raAzOluZd5zFbajo2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ceUev5VTrjjCFUbwVH0KHLQK5U02MlDiuQhTVKXGQl9Fhz5of8q7MGtKHvZcVRSFW
         Gl/juwug0hF2ufOjG+OOHhu5Gg5m69OSz7rCT3qcJmUMrqjKQ3D6iXM2oJyzRE+lpH
         WdTFtp/eYysi1mCBazGjhuDOflp/THWh2DOwfM20=
Date:   Wed, 23 Jan 2019 16:33:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josef Bacik <jbacik@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        zhong jiang <zhongjiang@huawei.com>
Subject: Re: [PATCH] fail_function: no need to check return value of
 debugfs_create functions
Message-Id: <20190123163341.fcee91b80f34e81218098739@kernel.org>
In-Reply-To: <20190123063427.GB25275@kroah.com>
References: <20190122152151.16139-45-gregkh@linuxfoundation.org>
        <20190123091141.bfc311d389e48a23af79a8a9@kernel.org>
        <20190123063305.GA25275@kroah.com>
        <20190123063427.GB25275@kroah.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 07:34:27 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 23, 2019 at 07:33:05AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 23, 2019 at 09:11:41AM +0900, Masami Hiramatsu wrote:
> > > On Tue, 22 Jan 2019 16:21:44 +0100
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > When calling debugfs functions, there is no need to ever check the
> > > > return value.  The function can work or not, but the code logic should
> > > > never do something different based on this.
> > > 
> > > Ah, OK. It simplifies the code. But I have a question below,
> > > 
> > > > 
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Josef Bacik <jbacik@fb.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> > > > Cc: zhong jiang <zhongjiang@huawei.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  kernel/fail_function.c | 23 +++++------------------
> > > >  1 file changed, 5 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> > > > index 17f75b545f66..afc779be5ebb 100644
> > > > --- a/kernel/fail_function.c
> > > > +++ b/kernel/fail_function.c
> > > > @@ -152,20 +152,13 @@ static int fei_retval_get(void *data, u64 *val)
> > > >  DEFINE_DEBUGFS_ATTRIBUTE(fei_retval_ops, fei_retval_get, fei_retval_set,
> > > >  			 "%llx\n");
> > > >  
> > > > -static int fei_debugfs_add_attr(struct fei_attr *attr)
> > > > +static void fei_debugfs_add_attr(struct fei_attr *attr)
> > > >  {
> > > >  	struct dentry *dir;
> > > >  
> > > >  	dir = debugfs_create_dir(attr->kp.symbol_name, fei_debugfs_dir);
> > > > -	if (!dir)
> > > > -		return -ENOMEM;
> > > > -
> > > > -	if (!debugfs_create_file("retval", 0600, dir, attr, &fei_retval_ops)) {
> > > > -		debugfs_remove_recursive(dir);
> > > > -		return -ENOMEM;
> > > > -	}
> > > >  
> > > > -	return 0;
> > > 
> > > Don't we need to check dir here? If above debugfs_create_dir() returns NULL,
> > > it seems we will create "retval" under root directory of debugfs.
> > 
> > If NULL is returned, your system is out of memory and worse things are
> > about to happen :)
> 
> But you aren't the first to ask about this, I guess I should just return
> ENOMEM and then the follow-on files will not be created.  I'll go make
> that change to the core of debugfs to help prevent this problem.

I got it, and yes, returning -ENOMEM sounds good to me, especially, in this case.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> thanks,
> 
> greg k-h


-- 
Masami Hiramatsu <mhiramat@kernel.org>

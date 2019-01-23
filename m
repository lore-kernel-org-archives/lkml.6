Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F0EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E617721019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548231007;
	bh=7J0pDHtZRLVxwU1gvRx1ZGnqrK3uix9v79Dk4CrIbCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y7/zegs3rtjGwrcpd208KVIHs/m5qnVTWpePrFARTS9mn6lUPEE9kVkmi0zzkUpmz
	 kPtm90pu35qyg/Qr82J/d0S1yjySGjDKgm0c5brW+2fYPugqy0ze8Bja49TsJYw81u
	 fwRyTVimBdJOYkgjPF6RLiL53RdCq13yjb/tAzfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfAWIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfAWIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:10:04 -0500
Received: from devnote (p105099-mobac01.tokyo.ocn.ne.jp [153.233.96.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD0321019;
        Wed, 23 Jan 2019 08:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548231004;
        bh=7J0pDHtZRLVxwU1gvRx1ZGnqrK3uix9v79Dk4CrIbCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iCFitbs62RFTfGnMmtiQwZA0pSHx5zp0uJS6JQUuR+xhWXruqWchJDikk2/i/TzJy
         2xTQ8ekwWmIgGLPNzBo9KfaVxQPMeixFM8E/DhHM4zqPwcgBlaqWyIB2AWvyZgKPBM
         xTSowvNaAmY4QQYm1hFy3UwUx8S9o+/dJE0mrJiU=
Date:   Wed, 23 Jan 2019 17:10:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] kprobes: no need to check return value of
 debugfs_create functions
Message-Id: <20190123171000.b1cbc9e1b52251bdd78b2338@kernel.org>
In-Reply-To: <20190123065422.GA27466@kroah.com>
References: <20190122152151.16139-47-gregkh@linuxfoundation.org>
        <20190123111516.d5fd81cb315810235205fbeb@kernel.org>
        <20190123065422.GA27466@kroah.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 07:54:22 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 23, 2019 at 11:15:16AM +0900, Masami Hiramatsu wrote:
> > On Tue, 22 Jan 2019 16:21:46 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > > 
> > > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  kernel/kprobes.c | 25 ++++++-------------------
> > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index f4ddfdd2d07e..7287e7de2350 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -2566,33 +2566,20 @@ static const struct file_operations fops_kp = {
> > >  
> > >  static int __init debugfs_kprobe_init(void)
> > >  {
> > > -	struct dentry *dir, *file;
> > > +	struct dentry *dir;
> > >  	unsigned int value = 1;
> > >  
> > >  	dir = debugfs_create_dir("kprobes", NULL);
> > > -	if (!dir)
> > > -		return -ENOMEM;
> > 
> > Here, I think IS_ERR(dir) is OK for debugfs_create_file(),
> > but dir == NULL has different meaning. I think we'd better
> > keep this check. (I see, -ENOMEM will be no good...)
> 
> dir == NULL means the system is out of memory.  Which I'll change and
> just make it return an error, so it is fine to ignore this value.

Got it! Thanks!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>




> 
> thanks,
> 
> greg k-h


-- 
Masami Hiramatsu <mhiramat@kernel.org>

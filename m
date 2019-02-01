Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DED218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549031208;
	bh=gSwrlzfwyyml8ihaics6bvBOT0IokvOM4CEtJuX/QC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qMEXxO/5Ow+WrFqpGpzZagIZOnS3Gx344aZjVYchYmZz9f+O1N1bZyIzgxYXRbMzi
	 IIU3wc9RjEuSLizb8K+m6rI0iPuyT5gOx0k+OgLYWstXA7TmiKMKT/KF5D5PHvYASb
	 uojQQE3P42mXIOaT2ZUggFmbPxuAgnsvPluJWTZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfBAO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:26:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E1A218AC;
        Fri,  1 Feb 2019 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549031205;
        bh=gSwrlzfwyyml8ihaics6bvBOT0IokvOM4CEtJuX/QC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoWlteNjG3atOqO62Y5j/cIS3C3kOX+daQSBk6ak+izth7OrH4gaYRvVTGsrka0jW
         FLKiR5v+odGYYp21sZwjtfqKQjrR6Cdy6Dc6si5wZUpTfPyjDNR6BLJs6RZ0EjqTps
         YKtvNASvKMqTgArLsUh42sAdVC3/Q/l3n0kLtXEE=
Date:   Fri, 1 Feb 2019 15:26:42 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "peter@hurleysoftware.com" <peter@hurleysoftware.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "keun-o.park@darkmatter.ae" <keun-o.park@darkmatter.ae>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        Rohit Thapliyal <r.thapliyal@samsung.com>,
        Ayush Mittal <ayush.m@samsung.com>
Subject: Re: race between flush_to_ldisc and pty_cleanup
Message-ID: <20190201142642.GB3211@kroah.com>
References: <CGME20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
 <20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 07:03:26PM +0530, Maninder Singh wrote:
> Hi,
> 
> 
> There is some race condition between tty_port_put and flush_to_ldisc
> which lead to use after free case:
> (Kernel 4.1)
> 
> [1403.5130] Unable to handle kernel paging request at virtual address 6b6b6b83
> ...
> ...
> ...
> 
> [1403.5132] [<c036a65c>] (ldsem_down_read_trylock) from [<c0367db4>] (tty_ldisc_ref+0x24/0x60)
> [1403.5132] [<c0367d90>] (tty_ldisc_ref) from [<c03690cc>] (flush_to_ldisc+0x6c/0x21c)
> [1403.5132]  r5:dbcd4a84 r4:00000000
> [1403.5132] [<c0369060>] (flush_to_ldisc) from [<c0049f18>] (process_one_work+0x214/0x570)
> [1403.5132]  r10:00000000 r9:ddab0000 r8:e3d6e000 r7:00000000 r6:e453f740 r5:cb37b780
> [1403.5132]  r4:dbcd4a84
> [1403.5132] [<c0049d04>] (process_one_work) from [<c004a2d4>] (worker_thread+0x60/0x580)
> [1403.5132]  r10:e453f740 r9:ddab0000 r8:e453f764 r7:00000088 r6:e453f740 r5:cb37b798
> [1403.5132]  r4:cb37b780
> [1403.5132] [<c004a274>] (worker_thread) from [<c005022c>] (kthread+0xec/0x104)
> [1403.5132]  r10:00000000 r9:00000000 r8:00000000 r7:c004a274 r6:cb37b780 r5:d8a3fc80
> [1403.5132]  r4:00000000
> [1403.5132] [<c0050140>] (kthread) from [<c00107d8>] (ret_from_fork+0x14/0x3c)
> 
> 
> for checking further we entered some debug prints and added delay in flush_to_ldisc to reproduce
> and seems there is some issue with workqueue implementation of TTY:
> 
> bool tty_buffer_cancel_work(struct tty_port *port)
> {
>         bool ret;
>         ret = cancel_work_sync(&port->buf.work); // Check return value of cancel_work_sync
>         pr_emerg("Work cancelled is 0x%x %pS %d\n", (unsigned int)&port->buf.work, (void *)_RET_IP_, ret); 
>         return ret;
> }
> 
> static void flush_to_ldisc(struct work_struct *work)
> {
> ...
>         mdelay(100);   // Added Delay to reproduce race
> 
>         if (flag_work_cancel) {
>                 pr_emerg("scheduled work after stopping work %x\n", (unsigned int)work);
> 
> ....
> }
> 
> static void pty_cleanup(struct tty_struct *tty)
> {
> ...
>         flag_work_cancel = 1;
> 		...
> }
> 
> 
> [1403.4158]Work cancelled is dbcd4a84 tty_port_destroy+0x1c/0x6c  0       // Since return is 0 so no work is pending 
> 
> [1403.5129] scheduled work after stopping work dbcd4a84    // Still same work is scheduled after cancelled
> [1403.5130] Unable to handle kernel paging request at virtual address 6b6b6b83   // Kernel OOPs occured because of use after free

Ok, after my initial "use a newer kernel" comment, this really does look
strange.  There has also been a lot of workqueue fixes and rework since
4.1, and that might be the thing that fixes this issue here.

However, are you sure you are not just calling flush_to_ldisc() directly
through some codepath somehow?  If you look at the stack in the
pr_emerg() message, where did it come from?  From the same workqueue
that you already stopped?

Testing on a newer kernel would be great, if possible.

thanks,

greg k-h

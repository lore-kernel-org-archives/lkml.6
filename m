Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B671EC6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858082087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547885439;
	bh=PnDFPQy4d7AhM3d8/U42pYDoa4meIxq8lbOVt38XxV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u0NXfrtWsrOzjiiLE4N9TTEbC85KHlZROomBLxA4oWfhHW8YIhAUQbBzsbBJWX0rI
	 za76SAbgpIu/Z7G/7HV+T42aC8DZzHg+JbxilKhSFiH5cb9VrexPT2RkgeA6Ax2zx5
	 A2LKFyEJIod9eH30RrLw2fo06RGAJAyGpdaE+WFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfASIKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfASIKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:10:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0C22084C;
        Sat, 19 Jan 2019 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547885437;
        bh=PnDFPQy4d7AhM3d8/U42pYDoa4meIxq8lbOVt38XxV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XP4m23QUafKcsQbve96fQ9bHA7qfpMzi2TQWtapcZF2e4OvHNdrmjuEupgBGnhwgq
         pnE6NBQ1UBslS+gc9E6gWN6VPFkzh6fseTBH5QnYrUfYbVw1HCgaJc8HDOoYaxh/UN
         IgIqPWqdxQ4GwkW+tOVUBr8/+JtUT0VLzlGh7ZJU=
Date:   Sat, 19 Jan 2019 09:10:33 +0100
From:   "Greg Kroah-Hartman (supporter:CHAR and MISC DRIVERS)" 
        <gregkh@linuxfoundation.org>
To:     Fred Klassen <fklassen@appneta.com>
Cc:     "Corey Minyard (supporter:IPMI SUBSYSTEM)" <minyard@acm.org>,
        "Arnd Bergmann (supporter:CHAR and MISC DRIVERS)" <arnd@arndb.de>,
        "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] ipmi: Prevent use-after-free in deliver_response
Message-ID: <20190119081033.GA8103@kroah.com>
References: <09133030-238B-475F-94BC-B48827812714@appneta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09133030-238B-475F-94BC-B48827812714@appneta.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:10:39PM -0800, Fred Klassen wrote:
> Some IPMI modules (e.g. ibmpex_msg_handler()) will have ipmi_usr_hdlr
> handlers that call ipmi_free_recv_msg() directly. This will essentially
> kfree(msg), leading to use-after-free.
> 
> This does not happen in the ipmi_devintf module, which will queue the
> message and run ipmi_free_recv_msg() later.
> 
>  BUG: KASAN: use-after-free in deliver_response+0x12f/0x1b0
>  Read of size 8 at addr ffff888a7bf20018 by task ksoftirqd/3/27
>  CPU: 3 PID: 27 Comm: ksoftirqd/3 Tainted: G           O      4.19.11-amd64-ani99-debug #12.0.1.601133+pv
>  Hardware name: AppNeta r1000/X11SPW-TF, BIOS 2.1a-AP 09/17/2018
>  Call Trace:
>   dump_stack+0x92/0xeb
>   print_address_description+0x73/0x290
>   kasan_report+0x258/0x380
>   deliver_response+0x12f/0x1b0
>   ? ipmi_free_recv_msg+0x50/0x50
>   deliver_local_response+0xe/0x50
>   handle_one_recv_msg+0x37a/0x21d0
>   handle_new_recv_msgs+0x1ce/0x440
>   ...
> 
>  Allocated by task 9885:
>   kasan_kmalloc+0xa0/0xd0
>   kmem_cache_alloc_trace+0x116/0x290
>   ipmi_alloc_recv_msg+0x28/0x70
>   i_ipmi_request+0xb4a/0x1640
>   ipmi_request_settime+0x1b8/0x1e0
>   ...
> 
>  Freed by task 27:
>   __kasan_slab_free+0x12e/0x180
>   kfree+0xe9/0x280
>   deliver_response+0x122/0x1b0
>   deliver_local_response+0xe/0x50
>   handle_one_recv_msg+0x37a/0x21d0
>   handle_new_recv_msgs+0x1ce/0x440
>   tasklet_action_common.isra.19+0xc4/0x250
>   __do_softirq+0x11f/0x51f
> 
> Fixes: e86ee2d44b4 ("ipmi: Rework locking and shutdown for hot remove")
> Signed-off-by: Fred Klassen <fklassen@appneta.com>
> 
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

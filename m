Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A01C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399BA2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545126751;
	bh=VMNw3L49t1+IXI7Aniydh0T+JgOY+QcPj9do/zKBYeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mM7VJmAQm50chK0btTN9sVLWBsC0/7+MRX6azZ8Y2Cj4Ft31Mk9NpjIEJdcn9kLB6
	 T/UO2jJry1XYD/uT6nS9WB/gBQ8BgXzKZq5TQ+4LCjDApUUnH6vBNfoqtaGq486REq
	 azd0RRkgTrKgWbfPLuk4+xTgBwJzKIJQDFbTRkjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLRJw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:52:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:57222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbeLRJw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:52:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 890CAAFE4;
        Tue, 18 Dec 2018 09:52:27 +0000 (UTC)
Date:   Tue, 18 Dec 2018 10:52:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     gchen.guomin@gmail.com
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, guominchen@tencent.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Fix mm->owner point to a tsk that has been free
Message-ID: <20181218095226.GD17870@dhcp22.suse.cz>
References: <1545110684-8730-1-git-send-email-gchen.guomin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545110684-8730-1-git-send-email-gchen.guomin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 13:24:44, gchen.guomin@gmail.com wrote:
> From: guomin chen <gchen.guomin@gmail.com>
> 
> When mm->owner is modified by exit_mm, if the new owner directly calls
> unuse_mm to exit, it will cause Use-After-Free. Due to the unuse_mm()
> directly sets tsk->mm=NULL.
> 
>  Under normal circumstances,When do_exit exits, mm->owner will
>  be updated on exit_mm(). but when the kernel process calls
>  unuse_mm() and then exits,mm->owner cannot be updated. And it
>  will point to a task that has been released.
> 
> The current issue flow is as follows: (Process A,B,C use the same mm)
> Process C              Process A         Process B
> qemu-system-x86_64:     kernel:vhost_net  kernel: vhost_net
> open /dev/vhost-net
>   VHOST_SET_OWNER   create kthread vhost-%d  create kthread vhost-%d
>   network init           use_mm()          use_mm()
>    ...                   ...
>    Abnormal exited
>    ...
>   do_exit
>   exit_mm()
>   update mm->owner to A
>   exit_files()
>    close_files()
>    kthread_should_stop() unuse_mm()
>     Stop Process A       tsk->mm=NULL
>                          do_exit()
>                          can't update owner
>                          A exit completed  vhost-%d  rcv first package
>                                            vhost-%d build rcv buffer for vq
>                                            page fault
>                                            access mm & mm->owner
>                                            NOW,mm->owner still pointer A
>                                            kernel UAF
>     stop Process B
> 
> Although I am having this issue on vhost_net,But it affects all users of
> unuse_mm.

I am confused. How can we ever assign the owner to a kernel thread. We
skip those explicitly. It simply doesn't make any sense to have an owner
a kernel thread.
-- 
Michal Hocko
SUSE Labs

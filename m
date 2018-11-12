Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69285C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5041208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5041208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeKLMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:48:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbeKLMsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:48:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED2D781DE9;
        Mon, 12 Nov 2018 02:56:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4506819940;
        Mon, 12 Nov 2018 02:56:53 +0000 (UTC)
Date:   Mon, 12 Nov 2018 10:56:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     axboe@kernel.dk, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: locking bug in loop_control_ioctl
Message-ID: <20181112025647.GC21443@ming.t460p>
References: <00000000000026aaac057a40a183@google.com>
 <913c3703-f6d3-a412-3b0c-ebc7422e8e69@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913c3703-f6d3-a412-3b0c-ebc7422e8e69@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 12 Nov 2018 02:57:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 05:09:09PM +0900, Tetsuo Handa wrote:
> From 4b9e5556fada37dff1eff13665a229b69e1f7dd8 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 10 Nov 2018 17:04:40 +0900
> Subject: [PATCH] loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl().
> 
> Commit 0a42e99b58a20883 ("loop: Get rid of loop_index_mutex") forgot to
> remove mutex_unlock(&loop_ctl_mutex) from loop_control_ioctl() when
> replacing loop_index_mutex with loop_ctl_mutex.
> 
> Reported-by: syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Jan Kara <jack@suse.cz>
> ---
>  drivers/block/loop.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bf6bc35..176ab1f 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2074,12 +2074,10 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  		if (lo->lo_state != Lo_unbound) {
>  			ret = -EBUSY;
> -			mutex_unlock(&loop_ctl_mutex);
>  			break;
>  		}
>  		if (atomic_read(&lo->lo_refcnt) > 0) {
>  			ret = -EBUSY;
> -			mutex_unlock(&loop_ctl_mutex);
>  			break;
>  		}
>  		lo->lo_disk->private_data = NULL;
> -- 
> 1.8.3.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

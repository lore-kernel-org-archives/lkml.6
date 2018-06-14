Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38D88C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB193208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNtqjj2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB193208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755110AbeFNLAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754906AbeFNLAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:00:10 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE371208D4;
        Thu, 14 Jun 2018 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528974010;
        bh=txTqgVC2CboIHthV54PHG96RQBQFm2lzl/gGKPScroo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TNtqjj2y5Lh6t2TDRyF5GZ5cZ2Dla1h5XfudCiSZn4FNxt3EcsLFaSrKHF9sedO8V
         pZUjmSvi6Yuszn/2biWFOXLcDSkZHTAMR2kPjJHEzQl+9AWuRItLWI+T725q6UAzAV
         oJrvzZy93MV7mTULF1OzWz7DDOECnTHBgR6JFagk=
Message-ID: <ca07bbc1a20d1429ce47561d9d235f12ef51dcd4.camel@kernel.org>
Subject: Re: [PATCH 2/2] fs/lock: show locks taken by processes from another
 pidns
From:   Jeff Layton <jlayton@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikolay Borisov <kernel@kyup.com>
Date:   Thu, 14 Jun 2018 07:00:07 -0400
In-Reply-To: <20180608142712.32460-3-khorenko@virtuozzo.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
         <20180608142712.32460-3-khorenko@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-08 at 17:27 +0300, Konstantin Khorenko wrote:
> Currently if we face a lock taken by a process invisible in the current
> pidns we skip the lock completely, but this
> 
> 1) makes the output not that nice
>     (root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
>     pos:    4
>     flags:  02100002
>     mnt_id: 257
>     lock:   (root@vz7)/:
> 
> 2) makes it more difficult to debug issues with leaked flocks
>    if you get error on lock, but don't see any locks in /proc/$id/fdinfo/$file
> 
> Let's show information about such locks again as previously, but
> show zero in the owner pid field.
> 
> After the patch:
> ===============
> (root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
> pos:    4
> flags:  02100002
> mnt_id: 295
> lock:   1: FLOCK  ADVISORY  WRITE 0 b6:f8a61:529946 0 EOF
> 
> Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  fs/locks.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index bfee5b7f2862..e533623e2e99 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2633,12 +2633,10 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  
>  	fl_pid = locks_translate_pid(fl, proc_pidns);
>  	/*
> -	 * If there isn't a fl_pid don't display who is waiting on
> -	 * the lock if we are called from locks_show, or if we are
> -	 * called from __show_fd_info - skip lock entirely
> +	 * If lock owner is dead (and pid is freed) or not visible in current
> +	 * pidns, zero is shown as a pid value. Check lock info from
> +	 * init_pid_ns to get saved lock pid value.
>  	 */
> -	if (fl_pid == 0)
> -		return;
>  
>  	if (fl->fl_file != NULL)
>  		inode = locks_inode(fl->fl_file);

(cc'ing Nickolay)

As Andrey points out, this behavior was originally added in commit
d67fd44f697d to address performance issues when there are a lot of locks
held by tasks in other namespaces.

Will allowing this code to show these again cause a problem there?
-- 
Jeff Layton <jlayton@kernel.org>

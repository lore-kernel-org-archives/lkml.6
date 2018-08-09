Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE2AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD8621D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5zhFnSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD8621D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeHINeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730758AbeHINeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:34:00 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83BD02177D;
        Thu,  9 Aug 2018 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533812978;
        bh=JKRgVp2jltUbxQUvzjm2xEUIkPkBZH+8rxRaf5dZl/I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g5zhFnSNb/TvID6s/Xs7gwqCOfR9KpDx23G81/Nw/5ZlyXBwfvv46EZypmozXeUE8
         cr+Q5rcSwF/90bkWhX2lt9CO5j5IeGTu/Mv/zgEKnZRs1jsP4aTQ8y5zVrjE/oTNNK
         +4Lhg4vLKoWI1VSjcb+G8YwF3v6rqtEB5bd0O5AQ=
Message-ID: <4c852081f72a8ed00cc216090030756b0a042f7c.camel@kernel.org>
Subject: Re: [PATCH 3/5] fs/locks: change all *_conflict() functions to
 return a new enum.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Aug 2018 07:09:35 -0400
In-Reply-To: <153378028114.1220.3708291796442871726.stgit@noble>
References: <153378012255.1220.6754153662007899557.stgit@noble>
         <153378028114.1220.3708291796442871726.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 12:04 +1000, NeilBrown wrote:
> In a future patch we will need to differentiate between conflicts that
> are "transitive" and those that aren't.
> A "transitive" conflict is defined as one where any lock that
> conflicts with the first (newly requested) lock would conflict with
> the existing lock.
> 
> So change posix_locks_conflict(), flock_locks_conflict() (both
> currently returning int) and leases_conflict() (currently returning
> bool) to return "enum conflict".
> Add locks_transitive_overlap() to make it possible to compute the
> correct conflict for posix locks.
> 
> The FL_NO_CONFLICT value is zero, so current code which only tests the
> truth value of these functions will still work the same way.
> 
> And convert some
>    return (foo);
> to
>    return foo;
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/locks.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index b4812da2a374..d06658b2dc7a 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -139,6 +139,16 @@
>  #define IS_OFDLCK(fl)	(fl->fl_flags & FL_OFDLCK)
>  #define IS_REMOTELCK(fl)	(fl->fl_pid <= 0)
>  
> +/* A transitive conflict is one where the first lock conflicts with
> + * the second lock, and any other lock that conflicts with the
> + * first lock, also conflicts with the second lock.
> + */
> +enum conflict {
> +	FL_NO_CONFLICT = 0,
> +	FL_CONFLICT,
> +	FL_TRANSITIVE_CONFLICT,
> +};
> +
>  static inline bool is_remote_lock(struct file *filp)
>  {
>  	return likely(!(filp->f_path.dentry->d_sb->s_flags & SB_NOREMOTELOCK));
> @@ -612,6 +622,15 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
>  		(fl2->fl_end >= fl1->fl_start));
>  }
>  
> +/* Check for transitive-overlap - true if any lock that overlaps
> + * the first lock must overlap the seconds
> + */
> +static inline bool locks_transitive_overlap(struct file_lock *fl1,
> +					    struct file_lock *fl2)
> +{
> +	return (fl1->fl_start >= fl2->fl_start) &&
> +		(fl1->fl_end <= fl2->fl_end);
> +}
>  /*
>   * Check whether two locks have the same owner.
>   */
> @@ -793,47 +812,61 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
>  /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
>   * checks for shared/exclusive status of overlapping locks.
>   */
> -static int locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
> +static enum conflict locks_conflict(struct file_lock *caller_fl,
> +				    struct file_lock *sys_fl)
>  {
>  	if (sys_fl->fl_type == F_WRLCK)
> -		return 1;
> +		return FL_TRANSITIVE_CONFLICT;
>  	if (caller_fl->fl_type == F_WRLCK)
> -		return 1;
> -	return 0;
> +		return FL_CONFLICT;
> +	return FL_NO_CONFLICT;
>  }
>  
>  /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
>   * checking before calling the locks_conflict().
>   */
> -static int posix_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
> +static enum conflict posix_locks_conflict(struct file_lock *caller_fl,
> +					  struct file_lock *sys_fl)
>  {
>  	/* POSIX locks owned by the same process do not conflict with
>  	 * each other.
>  	 */
>  	if (posix_same_owner(caller_fl, sys_fl))
> -		return (0);
> +		return FL_NO_CONFLICT;
>  
>  	/* Check whether they overlap */
>  	if (!locks_overlap(caller_fl, sys_fl))
> -		return 0;
> +		return FL_NO_CONFLICT;
>  
> -	return (locks_conflict(caller_fl, sys_fl));
> +	switch (locks_conflict(caller_fl, sys_fl)) {
> +	default:

Maybe BUG or WARN here or something? locks_conflict should never return
values that aren't in the enum.

> +	case FL_NO_CONFLICT:
> +		return FL_NO_CONFLICT;
> +	case FL_CONFLICT:
> +		return FL_CONFLICT;
> +	case FL_TRANSITIVE_CONFLICT:
> +		if (locks_transitive_overlap(caller_fl, sys_fl))
> +			return FL_TRANSITIVE_CONFLICT;
> +		else
> +			return FL_CONFLICT;
> +	}
>  }
>  
>  /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
>   * checking before calling the locks_conflict().
>   */
> -static int flock_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
> +static enum conflict flock_locks_conflict(struct file_lock *caller_fl,
> +					  struct file_lock *sys_fl)
>  {
>  	/* FLOCK locks referring to the same filp do not conflict with
>  	 * each other.
>  	 */
>  	if (caller_fl->fl_file == sys_fl->fl_file)
> -		return (0);
> +		return FL_NO_CONFLICT;
>  	if ((caller_fl->fl_type & LOCK_MAND) || (sys_fl->fl_type & LOCK_MAND))
> -		return 0;
> +		return FL_NO_CONFLICT;
>  
> -	return (locks_conflict(caller_fl, sys_fl));
> +	return locks_conflict(caller_fl, sys_fl);
>  }
>  
>  void
> @@ -1435,12 +1468,13 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>  	}
>  }
>  
> -static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
> +static enum conflict leases_conflict(struct file_lock *lease,
> +				     struct file_lock *breaker)
>  {
>  	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT))
> -		return false;
> +		return FL_NO_CONFLICT;
>  	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE))
> -		return false;
> +		return FL_NO_CONFLICT;
>  	return locks_conflict(breaker, lease);
>  }
>  
> 
> 
-- 
Jeff Layton <jlayton@kernel.org>


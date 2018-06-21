Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616E4C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E2821EEF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E2821EEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933379AbeFUUXo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:23:44 -0400
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:45053 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932940AbeFUUXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:23:43 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 22 Jun 2018 05:53:40 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fW67I-0000UY-18; Fri, 22 Jun 2018 06:23:40 +1000
Date:   Fri, 22 Jun 2018 06:23:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        y2038@lists.linaro.org, Andi Kleen <andi.kleen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Brian Foster <bfoster@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
Message-ID: <20180621202339.GC13748@dastard>
References: <20180620150138.49380-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620150138.49380-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:01:24PM +0200, Arnd Bergmann wrote:
> current_time is one of the few callers of current_kernel_time64(), which
> is a wrapper around ktime_get_coarse_real_ts64(). This calls the latter
> directly for consistency with the rest of the kernel that is moving to
> the ktime_get_ family of time accessors.
> 
> An open questions is whether we may want to actually call the more
> accurate ktime_get_real_ts64() for file systems that save high-resolution
> timestamps in their on-disk format. This would add a small but measurable
> overhead to each update of the inode stamps but lead to inode timestamps
> to actually have a usable resolution better than one jiffy (1 to 10
> milliseconds normally).
> 
> I traced the original addition of the current_kernel_time() call to set
> the nanosecond fields back to linux-2.5.48, where Andi Kleen added a
> patch with subject "nanosecond stat timefields". This adds the original
> call to current_kernel_time and the truncation to the resolution of the
> file system, but makes no mention of the intended accuracy.  At the time,
> we had a do_gettimeofday() interface that on some architectures could
> return a microsecond-resolution timestamp, but there was no interface
> for getting an accurate timestamp in nanosecond resolution, neither inside
> the kernel nor from user space. This makes me suspect that the use of
> coarse timestamps was never really a conscious decision but instead
> a result of whatever API was available 16 years ago.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 2c300e981796..e27bd9334939 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2133,7 +2133,9 @@ EXPORT_SYMBOL(timespec64_trunc);
>   */
>  struct timespec64 current_time(struct inode *inode)
>  {
> -	struct timespec64 now = current_kernel_time64();
> +	struct timespec64 now;
> +
> +	ktime_get_coarse_real_ts64(&now);

Can I just say as a filesystem dev who has no idea at all about
kernel timer implementations: this is an awful API change.  There
are hundreds of callers of current_time(), so I'm not going to be
the only person looking at this function who has no clue about WTF
"ktime_get_coarse_real" actually means or does. Further, this
function is not documented, and jumps straight into internal time
implementation stuff, so I'm lost straight away if somebody asks me
"what does that function do"?. i.e. I have *no clue* what this
function returns or why this code uses it.

i.e. the function goes from an obvious self documenting name that
has been blessed as the current kernel timestamp to something that
only people who work on the time subsystem understand and know when
to use. It might make sense to you, but it sucks for everyone
else....

Keep the wrapper, please. Change it to ktime_get_current(), if you
really must change the function namespace...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

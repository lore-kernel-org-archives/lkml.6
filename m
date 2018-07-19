Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1E220693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1E220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeGSLxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:53:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbeGSLxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:53:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1930EADD1;
        Thu, 19 Jul 2018 11:10:32 +0000 (UTC)
Date:   Thu, 19 Jul 2018 13:10:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, vdavydov.dev@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Keep int fields in struct shrink_control together
Message-ID: <20180719111031.GX7193@dhcp22.suse.cz>
References: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
 <153199747930.21131.861043607301997810.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153199747930.21131.861043607301997810.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 13:51:19, Kirill Tkhai wrote:
> gfp_t is of unsigned type, so let's move nid to keep
> them together.

I guess you meant unsigned int so you can fill up a hole in
shrink_control and as such reduce the stack consumption a bit (at least
on 64b).

An output from pahole is usually a great tool to visualize this.

die__process_function: tag not supported (INVALID)!
struct shrink_control {
	gfp_t                      gfp_mask;             /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          nr_to_scan;           /*     8     8 */
	long unsigned int          nr_scanned;           /*    16     8 */
	int                        nid;                  /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	struct mem_cgroup *        memcg;                /*    32     8 */

	/* size: 40, cachelines: 1, members: 5 */
	/* sum members: 32, holes: 2, sum holes: 8 */
	/* last cacheline: 40 bytes */
};

> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/shrinker.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index b154fd2b084c..d58aaaed34a4 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -12,6 +12,9 @@
>  struct shrink_control {
>  	gfp_t gfp_mask;
>  
> +	/* current node being shrunk (for NUMA aware shrinkers) */
> +	int nid;
> +
>  	/*
>  	 * How many objects scan_objects should scan and try to reclaim.
>  	 * This is reset before every call, so it is safe for callees
> @@ -26,9 +29,6 @@ struct shrink_control {
>  	 */
>  	unsigned long nr_scanned;
>  
> -	/* current node being shrunk (for NUMA aware shrinkers) */
> -	int nid;
> -
>  	/* current memcg being shrunk (for memcg aware shrinkers) */
>  	struct mem_cgroup *memcg;
>  };

-- 
Michal Hocko
SUSE Labs

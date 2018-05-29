Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbeE2LvB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:51:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933410AbeE2Lu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:50:57 -0400
Date: Tue, 29 May 2018 14:50:47 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] doc: document scope NOFS, NOIO APIs
References: <20180524114341.1101-1-mhocko@kernel.org>
 <20180529082644.26192-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529082644.26192-1-mhocko@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18052911-0008-0000-0000-000004FC2B3B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052911-0009-0000-0000-00001E904834
Message-Id: <20180529115047.GC13092@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:26:44AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Although the api is documented in the source code Ted has pointed out
> that there is no mention in the core-api Documentation and there are
> people looking there to find answers how to use a specific API.
> 
> Changes since v1
> - add kerneldoc for the api - suggested by Johnatan
> - review feedback from Dave and Johnatan
> - feedback from Dave about more general critical context rather than
>   locking
> - feedback from Mike
> - typo fixed - Randy, Dave
> 
> Requested-by: "Theodore Y. Ts'o" <tytso@mit.edu>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

I believe it's worth linking the kernel-doc part with the text. e.g.:

diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
index 2dc442b..b001f5f 100644
--- a/Documentation/core-api/gfp_mask-from-fs-io.rst
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -59,3 +59,10 @@ and so no special care is required and vmalloc should be called without
 any problems. Sometimes if the context is not really clear or there are
 layering violations then the recommended way around that is to wrap ``vmalloc``
 by the scope API with a comment explaining the problem.
+
+Reference
+=========
+
+.. kernel-doc:: include/linux/sched/mm.h
+   :functions: memalloc_nofs_save memalloc_nofs_restore \
+	       memalloc_noio_save memalloc_noio_restore

Except that, all looks good to me

Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

> ---
>  .../core-api/gfp_mask-from-fs-io.rst          | 61 +++++++++++++++++++
>  Documentation/core-api/index.rst              |  1 +
>  include/linux/sched/mm.h                      | 38 ++++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 Documentation/core-api/gfp_mask-from-fs-io.rst
> 
> diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
> new file mode 100644
> index 000000000000..2dc442b04a77
> --- /dev/null
> +++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
> @@ -0,0 +1,61 @@
> +=================================
> +GFP masks used from FS/IO context
> +=================================
> +
> +:Date: May, 2018
> +:Author: Michal Hocko <mhocko@kernel.org>
> +
> +Introduction
> +============
> +
> +Code paths in the filesystem and IO stacks must be careful when
> +allocating memory to prevent recursion deadlocks caused by direct
> +memory reclaim calling back into the FS or IO paths and blocking on
> +already held resources (e.g. locks - most commonly those used for the
> +transaction context).
> +
> +The traditional way to avoid this deadlock problem is to clear __GFP_FS
> +respectively __GFP_IO (note the latter implies clearing the first as well) in
> +the gfp mask when calling an allocator. GFP_NOFS respectively GFP_NOIO can be
> +used as shortcut. It turned out though that above approach has led to
> +abuses when the restricted gfp mask is used "just in case" without a
> +deeper consideration which leads to problems because an excessive use
> +of GFP_NOFS/GFP_NOIO can lead to memory over-reclaim or other memory
> +reclaim issues.
> +
> +New API
> +========
> +
> +Since 4.12 we do have a generic scope API for both NOFS and NOIO context
> +``memalloc_nofs_save``, ``memalloc_nofs_restore`` respectively ``memalloc_noio_save``,
> +``memalloc_noio_restore`` which allow to mark a scope to be a critical
> +section from a filesystem or I/O point of view. Any allocation from that
> +scope will inherently drop __GFP_FS respectively __GFP_IO from the given
> +mask so no memory allocation can recurse back in the FS/IO.
> +
> +FS/IO code then simply calls the appropriate save function before
> +any critical section with respect to the reclaim is started - e.g.
> +lock shared with the reclaim context or when a transaction context
> +nesting would be possible via reclaim. The restore function should be
> +called when the critical section ends. All that ideally along with an
> +explanation what is the reclaim context for easier maintenance.
> +
> +Please note that the proper pairing of save/restore functions
> +allows nesting so it is safe to call ``memalloc_noio_save`` or
> +``memalloc_noio_restore`` respectively from an existing NOIO or NOFS
> +scope.
> +
> +What about __vmalloc(GFP_NOFS)
> +==============================
> +
> +vmalloc doesn't support GFP_NOFS semantic because there are hardcoded
> +GFP_KERNEL allocations deep inside the allocator which are quite non-trivial
> +to fix up. That means that calling ``vmalloc`` with GFP_NOFS/GFP_NOIO is
> +almost always a bug. The good news is that the NOFS/NOIO semantic can be
> +achieved by the scope API.
> +
> +In the ideal world, upper layers should already mark dangerous contexts
> +and so no special care is required and vmalloc should be called without
> +any problems. Sometimes if the context is not really clear or there are
> +layering violations then the recommended way around that is to wrap ``vmalloc``
> +by the scope API with a comment explaining the problem.
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index c670a8031786..8a5f48ef16f2 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -25,6 +25,7 @@ Core utilities
>     genalloc
>     errseq
>     printk-formats
> +   gfp_mask-from-fs-io
> 
>  Interfaces for kernel debugging
>  ===============================
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index e1f8411e6b80..af5ba077bbc4 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -166,6 +166,17 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
>  static inline void fs_reclaim_release(gfp_t gfp_mask) { }
>  #endif
> 
> +/**
> + * memalloc_noio_save - Marks implicit GFP_NOIO allocation scope.
> + *
> + * This functions marks the beginning of the GFP_NOIO allocation scope.
> + * All further allocations will implicitly drop __GFP_IO flag and so
> + * they are safe for the IO critical section from the allocation recursion
> + * point of view. Use memalloc_noio_restore to end the scope with flags
> + * returned by this function.
> + *
> + * This function is safe to be used from any context.
> + */
>  static inline unsigned int memalloc_noio_save(void)
>  {
>  	unsigned int flags = current->flags & PF_MEMALLOC_NOIO;
> @@ -173,11 +184,30 @@ static inline unsigned int memalloc_noio_save(void)
>  	return flags;
>  }
> 
> +/**
> + * memalloc_noio_restore - Ends the implicit GFP_NOIO scope.
> + * @flags: Flags to restore.
> + *
> + * Ends the implicit GFP_NOIO scope started by memalloc_noio_save function.
> + * Always make sure that that the given flags is the return value from the
> + * pairing memalloc_noio_save call.
> + */
>  static inline void memalloc_noio_restore(unsigned int flags)
>  {
>  	current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
>  }
> 
> +/**
> + * memalloc_nofs_save - Marks implicit GFP_NOFS allocation scope.
> + *
> + * This functions marks the beginning of the GFP_NOFS allocation scope.
> + * All further allocations will implicitly drop __GFP_FS flag and so
> + * they are safe for the FS critical section from the allocation recursion
> + * point of view. Use memalloc_nofs_restore to end the scope with flags
> + * returned by this function.
> + *
> + * This function is safe to be used from any context.
> + */
>  static inline unsigned int memalloc_nofs_save(void)
>  {
>  	unsigned int flags = current->flags & PF_MEMALLOC_NOFS;
> @@ -185,6 +215,14 @@ static inline unsigned int memalloc_nofs_save(void)
>  	return flags;
>  }
> 
> +/**
> + * memalloc_nofs_restore - Ends the implicit GFP_NOFS scope.
> + * @flags: Flags to restore.
> + *
> + * Ends the implicit GFP_NOFS scope started by memalloc_nofs_save function.
> + * Always make sure that that the given flags is the return value from the
> + * pairing memalloc_nofs_save call.
> + */
>  static inline void memalloc_nofs_restore(unsigned int flags)
>  {
>  	current->flags = (current->flags & ~PF_MEMALLOC_NOFS) | flags;
> -- 
> 2.17.0
> 

-- 
Sincerely yours,
Mike.

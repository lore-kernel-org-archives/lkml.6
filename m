Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F73C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED22218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfAXMJU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:09:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:52730 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfAXMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:09:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 04:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,516,1539673200"; 
   d="scan'208";a="138383085"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.7.47])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2019 04:09:13 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     jglisse@redhat.com, linux-mm@kvack.org
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190123222315.1122-9-jglisse@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?utf-8?b?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michal Hocko <mhocko@kernel.org>,
        =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20190123222315.1122-1-jglisse@redhat.com>
 <20190123222315.1122-9-jglisse@redhat.com>
Message-ID: <154833175216.4120.925061299171157938@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH v4 8/9] gpu/drm/i915: optimize out the case when a range is
 updated to read only
Date:   Thu, 24 Jan 2019 14:09:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

This patch seems to have plenty of Cc:s, but none of the right ones :)

For further iterations, I guess you could use git option --cc to make
sure everyone gets the whole series, and still keep the Cc:s in the
patches themselves relevant to subsystems.

This doesn't seem to be on top of drm-tip, but on top of your previous
patches(?) that I had some comments about. Could you take a moment to
first address the couple of question I had, before proceeding to discuss
what is built on top of that base.

My reply's Message-ID is:
154289518994.19402.3481838548028068213@jlahtine-desk.ger.corp.intel.com

Regards, Joonas

PS. Please keep me Cc:d in the following patches, I'm keen on
understanding the motive and benefits.

Quoting jglisse@redhat.com (2019-01-24 00:23:14)
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> When range of virtual address is updated read only and corresponding
> user ptr object are already read only it is pointless to do anything.
> Optimize this case out.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: kvm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/i915_gem_userptr.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
> index 9558582c105e..23330ac3d7ea 100644
> --- a/drivers/gpu/drm/i915/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
> @@ -59,6 +59,7 @@ struct i915_mmu_object {
>         struct interval_tree_node it;
>         struct list_head link;
>         struct work_struct work;
> +       bool read_only;
>         bool attached;
>  };
>  
> @@ -119,6 +120,7 @@ static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>                 container_of(_mn, struct i915_mmu_notifier, mn);
>         struct i915_mmu_object *mo;
>         struct interval_tree_node *it;
> +       bool update_to_read_only;
>         LIST_HEAD(cancelled);
>         unsigned long end;
>  
> @@ -128,6 +130,8 @@ static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>         /* interval ranges are inclusive, but invalidate range is exclusive */
>         end = range->end - 1;
>  
> +       update_to_read_only = mmu_notifier_range_update_to_read_only(range);
> +
>         spin_lock(&mn->lock);
>         it = interval_tree_iter_first(&mn->objects, range->start, end);
>         while (it) {
> @@ -145,6 +149,17 @@ static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>                  * object if it is not in the process of being destroyed.
>                  */
>                 mo = container_of(it, struct i915_mmu_object, it);
> +
> +               /*
> +                * If it is already read only and we are updating to
> +                * read only then we do not need to change anything.
> +                * So save time and skip this one.
> +                */
> +               if (update_to_read_only && mo->read_only) {
> +                       it = interval_tree_iter_next(it, range->start, end);
> +                       continue;
> +               }
> +
>                 if (kref_get_unless_zero(&mo->obj->base.refcount))
>                         queue_work(mn->wq, &mo->work);
>  
> @@ -270,6 +285,7 @@ i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
>         mo->mn = mn;
>         mo->obj = obj;
>         mo->it.start = obj->userptr.ptr;
> +       mo->read_only = i915_gem_object_is_readonly(obj);
>         mo->it.last = obj->userptr.ptr + obj->base.size - 1;
>         INIT_WORK(&mo->work, cancel_userptr);
>  
> -- 
> 2.17.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

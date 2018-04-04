Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDDNYS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:24:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:39646 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeDDNYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:24:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,406,1517904000";
   d="scan'208";a="217570116"
Date: Wed, 4 Apr 2018 21:24:00 +0800
From: kbuild test robot <lkp@intel.com>
To: Xidong Wang <wangxidong_97@163.com>
Cc: kbuild-all@01.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xidong Wang <wangxidong_97@163.com>
Subject: Re: [PATCH 1/1] drm/i915:Do not use kfree() to free
 kmem_cache_alloc() return value
Message-ID: <201804042127.0qfhF0n9%fengguang.wu@intel.com>
References: <1522823851-28177-1-git-send-email-wangxidong_97@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522823851-28177-1-git-send-email-wangxidong_97@163.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xidong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-intel/for-linux-next]
[also build test WARNING on v4.16 next-20180403]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Xidong-Wang/drm-i915-Do-not-use-kfree-to-free-kmem_cache_alloc-return-value/20180404-193341
base:   git://anongit.freedesktop.org/drm-intel for-linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/i915/i915_gem_execbuffer.c:731:41: sparse: incorrect type in argument 1 (different base types) @@    expected struct kmem_cache *<noident> @@    got struct i915_lut_struct kmem_cache *<noident> @@
   drivers/gpu/drm/i915/i915_gem_execbuffer.c:731:41:    expected struct kmem_cache *<noident>
   drivers/gpu/drm/i915/i915_gem_execbuffer.c:731:41:    got struct i915_lut_handle *[assigned] lut
>> drivers/gpu/drm/i915/i915_gem_execbuffer.c:731:40: sparse: not enough arguments for function kmem_cache_free
   drivers/gpu/drm/i915/i915_gem_execbuffer.c: In function 'eb_lookup_vmas':
   drivers/gpu/drm/i915/i915_gem_execbuffer.c:731:20: error: passing argument 1 of 'kmem_cache_free' from incompatible pointer type [-Werror=incompatible-pointer-types]
       kmem_cache_free(lut);
                       ^~~
   In file included from include/linux/reservation.h:44:0,
                    from drivers/gpu/drm/i915/i915_gem_execbuffer.c:30:
   include/linux/slab.h:356:6: note: expected 'struct kmem_cache *' but argument is of type 'struct i915_lut_handle *'
    void kmem_cache_free(struct kmem_cache *, void *);
         ^~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_gem_execbuffer.c:731:4: error: too few arguments to function 'kmem_cache_free'
       kmem_cache_free(lut);
       ^~~~~~~~~~~~~~~
   In file included from include/linux/reservation.h:44:0,
                    from drivers/gpu/drm/i915/i915_gem_execbuffer.c:30:
   include/linux/slab.h:356:6: note: declared here
    void kmem_cache_free(struct kmem_cache *, void *);
         ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +731 drivers/gpu/drm/i915/i915_gem_execbuffer.c

   685	
   686	static int eb_lookup_vmas(struct i915_execbuffer *eb)
   687	{
   688		struct radix_tree_root *handles_vma = &eb->ctx->handles_vma;
   689		struct drm_i915_gem_object *obj;
   690		unsigned int i;
   691		int err;
   692	
   693		if (unlikely(i915_gem_context_is_closed(eb->ctx)))
   694			return -ENOENT;
   695	
   696		if (unlikely(i915_gem_context_is_banned(eb->ctx)))
   697			return -EIO;
   698	
   699		INIT_LIST_HEAD(&eb->relocs);
   700		INIT_LIST_HEAD(&eb->unbound);
   701	
   702		for (i = 0; i < eb->buffer_count; i++) {
   703			u32 handle = eb->exec[i].handle;
   704			struct i915_lut_handle *lut;
   705			struct i915_vma *vma;
   706	
   707			vma = radix_tree_lookup(handles_vma, handle);
   708			if (likely(vma))
   709				goto add_vma;
   710	
   711			obj = i915_gem_object_lookup(eb->file, handle);
   712			if (unlikely(!obj)) {
   713				err = -ENOENT;
   714				goto err_vma;
   715			}
   716	
   717			vma = i915_vma_instance(obj, eb->vm, NULL);
   718			if (unlikely(IS_ERR(vma))) {
   719				err = PTR_ERR(vma);
   720				goto err_obj;
   721			}
   722	
   723			lut = kmem_cache_alloc(eb->i915->luts, GFP_KERNEL);
   724			if (unlikely(!lut)) {
   725				err = -ENOMEM;
   726				goto err_obj;
   727			}
   728	
   729			err = radix_tree_insert(handles_vma, handle, vma);
   730			if (unlikely(err)) {
 > 731				kmem_cache_free(lut);
   732				goto err_obj;
   733			}
   734	
   735			/* transfer ref to ctx */
   736			vma->open_count++;
   737			list_add(&lut->obj_link, &obj->lut_list);
   738			list_add(&lut->ctx_link, &eb->ctx->handles_list);
   739			lut->ctx = eb->ctx;
   740			lut->handle = handle;
   741	
   742	add_vma:
   743			err = eb_add_vma(eb, i, vma);
   744			if (unlikely(err))
   745				goto err_vma;
   746	
   747			GEM_BUG_ON(vma != eb->vma[i]);
   748			GEM_BUG_ON(vma->exec_flags != &eb->flags[i]);
   749		}
   750	
   751		/* take note of the batch buffer before we might reorder the lists */
   752		i = eb_batch_index(eb);
   753		eb->batch = eb->vma[i];
   754		GEM_BUG_ON(eb->batch->exec_flags != &eb->flags[i]);
   755	
   756		/*
   757		 * SNA is doing fancy tricks with compressing batch buffers, which leads
   758		 * to negative relocation deltas. Usually that works out ok since the
   759		 * relocate address is still positive, except when the batch is placed
   760		 * very low in the GTT. Ensure this doesn't happen.
   761		 *
   762		 * Note that actual hangs have only been observed on gen7, but for
   763		 * paranoia do it everywhere.
   764		 */
   765		if (!(eb->flags[i] & EXEC_OBJECT_PINNED))
   766			eb->flags[i] |= __EXEC_OBJECT_NEEDS_BIAS;
   767		if (eb->reloc_cache.has_fence)
   768			eb->flags[i] |= EXEC_OBJECT_NEEDS_FENCE;
   769	
   770		eb->args->flags |= __EXEC_VALIDATED;
   771		return eb_reserve(eb);
   772	
   773	err_obj:
   774		i915_gem_object_put(obj);
   775	err_vma:
   776		eb->vma[i] = NULL;
   777		return err;
   778	}
   779	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

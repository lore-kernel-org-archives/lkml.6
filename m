Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB58C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4469A208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4469A208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeHXO3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:29:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50967 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeHXO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:29:24 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7OAsPjf051554;
        Fri, 24 Aug 2018 19:54:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Fri, 24 Aug 2018 19:54:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7OAsKKe051505
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 24 Aug 2018 19:54:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
Date:   Fri, 24 Aug 2018 19:54:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716115058.5559-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two more worries for this patch.



> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -178,12 +178,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>   *
>   * @amn: our notifier
>   */
> -static void amdgpu_mn_read_lock(struct amdgpu_mn *amn)
> +static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>  {
> -       mutex_lock(&amn->read_lock);
> +       if (blockable)
> +               mutex_lock(&amn->read_lock);
> +       else if (!mutex_trylock(&amn->read_lock))
> +               return -EAGAIN;
> +
>         if (atomic_inc_return(&amn->recursion) == 1)
>                 down_read_non_owner(&amn->lock);

Why don't we need to use trylock here if blockable == false ?
Want comment why it is safe to use blocking lock here.

>         mutex_unlock(&amn->read_lock);
> +
> +       return 0;
>  }
> 
>  /**



> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -177,16 +177,19 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>         up_write(&hmm->mirrors_sem);
>  }
> 
> -static void hmm_invalidate_range_start(struct mmu_notifier *mn,
> +static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>                                        struct mm_struct *mm,
>                                        unsigned long start,
> -                                      unsigned long end)
> +                                      unsigned long end,
> +                                      bool blockable)
>  {
>         struct hmm *hmm = mm->hmm;
> 
>         VM_BUG_ON(!hmm);
> 
>         atomic_inc(&hmm->sequence);
> +
> +       return 0;
>  }
> 
>  static void hmm_invalidate_range_end(struct mmu_notifier *mn,

This assumes that hmm_invalidate_range_end() does not have memory
allocation dependency. But hmm_invalidate_range() from
hmm_invalidate_range_end() involves

        down_read(&hmm->mirrors_sem);
        list_for_each_entry(mirror, &hmm->mirrors, list)
                mirror->ops->sync_cpu_device_pagetables(mirror, action,
                                                        start, end);
        up_read(&hmm->mirrors_sem);

sequence. What is surprising is that there is no in-tree user who assigns
sync_cpu_device_pagetables field.

  $ grep -Fr sync_cpu_device_pagetables *
  Documentation/vm/hmm.rst:     /* sync_cpu_device_pagetables() - synchronize page tables
  include/linux/hmm.h: * will get callbacks through sync_cpu_device_pagetables() operation (see
  include/linux/hmm.h:    /* sync_cpu_device_pagetables() - synchronize page tables
  include/linux/hmm.h:    void (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
  include/linux/hmm.h: * hmm_mirror_ops.sync_cpu_device_pagetables() callback, so that CPU page
  mm/hmm.c:               mirror->ops->sync_cpu_device_pagetables(mirror, action,

That is, this API seems to be currently used by only out-of-tree users. Since
we can't check that nobody has memory allocation dependency, I think that
hmm_invalidate_range_start() should return -EAGAIN if blockable == false for now.


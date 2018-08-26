Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9BAC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5316E2147D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5316E2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeHZMX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 08:23:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57283 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeHZMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 08:23:26 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7Q8eFmb074738;
        Sun, 26 Aug 2018 17:40:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sun, 26 Aug 2018 17:40:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7Q8e1lu074665
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 26 Aug 2018 17:40:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Leon Romanovsky <leonro@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
 <20180824123341.GN29735@dhcp22.suse.cz>
 <b11df415-baf8-0a41-3c16-60dfe8d32bd3@amd.com>
 <20180824130132.GP29735@dhcp22.suse.cz>
 <23d071d2-82e4-9b78-1000-be44db5f6523@gmail.com>
 <20180824132442.GQ29735@dhcp22.suse.cz>
 <86bd94d5-0ce8-c67f-07a5-ca9ebf399cdd@gmail.com>
 <20180824134009.GS29735@dhcp22.suse.cz>
 <735b0a53-5237-8827-d20e-e57fa24d798f@amd.com>
 <20180824135257.GU29735@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b78f8b3a-7bc6-0dea-6752-5ea798eccb6b@i-love.sakura.ne.jp>
Date:   Sun, 26 Aug 2018 17:40:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824135257.GU29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/24 22:52, Michal Hocko wrote:
> @@ -180,11 +180,15 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>   */
>  static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>  {
> -	if (blockable)
> -		mutex_lock(&amn->read_lock);
> -	else if (!mutex_trylock(&amn->read_lock))
> -		return -EAGAIN;
> -
> +	/*
> +	 * We can take sleepable lock even on !blockable mode because
> +	 * read_lock is only ever take from this path and the notifier
> +	 * lock never really sleeps. In fact the only reason why the
> +	 * later is sleepable is because the notifier itself might sleep
> +	 * in amdgpu_mn_invalidate_node but blockable mode is handled
> +	 * before calling into that path.
> +	 */
> +	mutex_lock(&amn->read_lock);
>  	if (atomic_inc_return(&amn->recursion) == 1)
>  		down_read_non_owner(&amn->lock);
>  	mutex_unlock(&amn->read_lock);
> 

I'm not following. Why don't we need to do like below (given that
nobody except amdgpu_mn_read_lock() holds ->read_lock) because e.g.
drm_sched_fence_create() from drm_sched_job_init() from amdgpu_cs_submit()
is doing GFP_KERNEL memory allocation with ->lock held for write?

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index e55508b..e1cb344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -64,8 +64,6 @@
  * @node: hash table node to find structure by adev and mn
  * @lock: rw semaphore protecting the notifier nodes
  * @objects: interval tree containing amdgpu_mn_nodes
- * @read_lock: mutex for recursive locking of @lock
- * @recursion: depth of recursion
  *
  * Data for each amdgpu device and process address space.
  */
@@ -85,8 +83,6 @@ struct amdgpu_mn {
 	/* objects protected by lock */
 	struct rw_semaphore	lock;
 	struct rb_root_cached	objects;
-	struct mutex		read_lock;
-	atomic_t		recursion;
 };
 
 /**
@@ -181,14 +177,9 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
 static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
 {
 	if (blockable)
-		mutex_lock(&amn->read_lock);
-	else if (!mutex_trylock(&amn->read_lock))
+		down_read(&amn->lock);
+	else if (!down_read_trylock(&amn->lock))
 		return -EAGAIN;
-
-	if (atomic_inc_return(&amn->recursion) == 1)
-		down_read_non_owner(&amn->lock);
-	mutex_unlock(&amn->read_lock);
-
 	return 0;
 }
 
@@ -199,8 +190,7 @@ static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
  */
 static void amdgpu_mn_read_unlock(struct amdgpu_mn *amn)
 {
-	if (atomic_dec_return(&amn->recursion) == 0)
-		up_read_non_owner(&amn->lock);
+	up_read(&amn->lock);
 }
 
 /**
@@ -410,8 +400,6 @@ struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
 	amn->type = type;
 	amn->mn.ops = &amdgpu_mn_ops[type];
 	amn->objects = RB_ROOT_CACHED;
-	mutex_init(&amn->read_lock);
-	atomic_set(&amn->recursion, 0);
 
 	r = __mmu_notifier_register(&amn->mn, mm);
 	if (r)

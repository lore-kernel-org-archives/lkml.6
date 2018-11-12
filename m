Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13019C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E2A22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E2A22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeKLUlt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:41:49 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:58188 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727156AbeKLUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:41:48 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14448974-1500050 
        for multiple; Mon, 12 Nov 2018 10:48:58 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Eric Anholt <eric@anholt.net>, christian.koenig@amd.com,
        zhoucm1 <zhoucm1@amd.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <199c35bc-e684-fbc4-dcef-d7105d82f0ff@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-3-eric@anholt.net>
 <635caa27-eb0b-a4d6-5a1d-3fbe5382bd6b@amd.com>
 <c5af6df2-d5d5-5276-3628-4bac0fd53c98@gmail.com>
 <d9d76fbc-44ad-891d-e535-34d0e8f615de@amd.com> <87d0rex8h2.fsf@anholt.net>
 <87y3a1sx8t.fsf@anholt.net> <199c35bc-e684-fbc4-dcef-d7105d82f0ff@gmail.com>
Message-ID: <154201973877.16646.5745251436337959698@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] drm: Revert syncobj timeline changes.
Date:   Mon, 12 Nov 2018 10:48:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian König (2018-11-12 10:16:01)
> Am 09.11.18 um 23:26 schrieb Eric Anholt:
> 
>     Eric Anholt <eric@anholt.net> writes:
> 
> 
>         [ Unknown signature status ]
>         zhoucm1 <zhoucm1@amd.com> writes:
> 
> 
>             On 2018年11月09日 00:52, Christian König wrote:
> 
>                 Am 08.11.18 um 17:07 schrieb Koenig, Christian:
> 
>                     Am 08.11.18 um 17:04 schrieb Eric Anholt:
> 
>                         Daniel suggested I submit this, since we're still seeing regressions
>                         from it.  This is a revert to before 48197bc564c7 ("drm: add syncobj
>                         timeline support v9") and its followon fixes.
> 
>                     This is a harmless false positive from lockdep, Chouming and I are
>                     already working on a fix.
> 
>                 On the other hand we had enough trouble with that patch, so if it
>                 really bothers you feel free to add my Acked-by: Christian König
>                 <christian.koenig@amd.com> and push it.
> 
>             NAK, please no, I don't think this needed, the Warning totally isn't
>             related to syncobj timeline, but fence-array implementation flaw, just
>             exposed by syncobj.
>             In addition, Christian already has a fix for this Warning, I've tested.
>             Please Christian send to public review.
> 
>         I backed out my revert of #2 (#1 still necessary) after adding the
>         lockdep regression fix, and now my CTS run got oomkilled after just a
>         few hours, with these notable lines in the unreclaimable slab info list:
> 
>         [ 6314.373099] drm_sched_fence        69095KB      69095KB
>         [ 6314.373653] kmemleak_object       428249KB     428384KB
>         [ 6314.373736] kmalloc-262144           256KB        256KB
>         [ 6314.373743] kmalloc-131072           128KB        128KB
>         [ 6314.373750] kmalloc-65536             64KB         64KB
>         [ 6314.373756] kmalloc-32768           1472KB       1728KB
>         [ 6314.373763] kmalloc-16384             64KB         64KB
>         [ 6314.373770] kmalloc-8192             208KB        208KB
>         [ 6314.373778] kmalloc-4096            2408KB       2408KB
>         [ 6314.373784] kmalloc-2048             288KB        336KB
>         [ 6314.373792] kmalloc-1024            1457KB       1512KB
>         [ 6314.373800] kmalloc-512              854KB       1048KB
>         [ 6314.373808] kmalloc-256              188KB        268KB
>         [ 6314.373817] kmalloc-192            69141KB      69142KB
>         [ 6314.373824] kmalloc-64             47703KB      47704KB
>         [ 6314.373886] kmalloc-128            46396KB      46396KB
>         [ 6314.373894] kmem_cache                31KB         35KB
> 
>         No results from kmemleak, though.
> 
>     OK, it looks like the #2 revert probably isn't related to the OOM issue.
>     Running a single job on otherwise unused DRM, watching /proc/slabinfo
>     every second for drm_sched_fence, I get:
> 
>     drm_sched_fence        0      0    192   21    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    0    0    0 : cpustat      0      0      0      0
>     drm_sched_fence       16     21    192   21    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0    0    0    0 : cpustat      5      1      6      0
>     drm_sched_fence       13     21    192   21    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0    0    0    0 : cpustat      5      1      6      0
>     drm_sched_fence        6     21    192   21    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0    0    0    0 : cpustat      5      1      6      0
>     drm_sched_fence        4     21    192   21    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0    0    0    0 : cpustat      5      1      6      0
>     drm_sched_fence        2     21    192   21    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0    0    0    0 : cpustat      5      1      6      0
>     drm_sched_fence        0     21    192   21    1 : tunables   32   16    8 : slabdata      0      1      0 : globalstat      16     16     1    0    0    0    0    0    0 : cpustat      5      1      6      0
> 
>     So we generate a ton of fences, and I guess free them slowly because of
>     RCU?  And presumably kmemleak was sucking up lots of memory because of
>     how many of these objects were laying around.
> 
> 
> That is certainly possible. Another possibility is that we don't drop the
> reference in dma-fence-array early enough.
> 
> E.g. the dma-fence-array will keep the reference to its fences until it is
> destroyed, which is a bit late when you chain multiple dma-fence-array objects
> together.
> 
> David can you take a look at this and propose a fix? That would probably be
> good to have fixed in dma-fence-array separately to the timeline work.

Note that drm_syncobj_replace_fence() leaks any existing fence for
!timeline syncobjs. Which coupled with the linear search ends up with
a severe regression in both time and memory.
-Chris

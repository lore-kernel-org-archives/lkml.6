Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A13BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDFA20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDFA20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeJ3NhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 09:37:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59866 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ3NhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 09:37:16 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9U4jMhB076678;
        Tue, 30 Oct 2018 13:45:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Tue, 30 Oct 2018 13:45:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9U4jMqc076673;
        Tue, 30 Oct 2018 13:45:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9U4jMhu076672;
        Tue, 30 Oct 2018 13:45:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810300445.w9U4jMhu076672@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [RFC PATCH v2 3/3] mm, oom: hand over =?ISO-2022-JP?B?TU1GX09PTV9T?=
 =?ISO-2022-JP?B?S0lQIHRvIGV4aXQgcGF0aCBpZiBpdCBpcyBndXJhbnRlZWQgdG8gZmlu?=
 =?ISO-2022-JP?B?aXNo?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
MIME-Version: 1.0
Date:   Tue, 30 Oct 2018 13:45:22 +0900
References: <20181025082403.3806-1-mhocko@kernel.org> <20181025082403.3806-4-mhocko@kernel.org>
In-Reply-To: <20181025082403.3806-4-mhocko@kernel.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko wrote:
> @@ -3156,6 +3166,13 @@ void exit_mmap(struct mm_struct *mm)
>                 vma = remove_vma(vma);
>         }
>         vm_unacct_memory(nr_accounted);
> +
> +       /*
> +        * Now that the full address space is torn down, make sure the
> +        * OOM killer skips over this task
> +        */
> +       if (oom)
> +               set_bit(MMF_OOM_SKIP, &mm->flags);
>  }
> 
>  /* Insert vm structure into process list sorted by address

I don't like setting MMF_OOF_SKIP after remove_vma() loop. 50 users might
call vma->vm_ops->close() from remove_vma(). Some of them are doing fs
writeback, some of them might be doing GFP_KERNEL allocation from
vma->vm_ops->open() with a lock also held by vma->vm_ops->close().

I don't think that waiting for completion of remove_vma() loop is safe.
And my patch is safe.

 drivers/android/binder.c                          |    2 +-
 drivers/gpu/drm/drm_gem_cma_helper.c              |    2 +-
 drivers/gpu/drm/drm_vm.c                          |    8 ++++----
 drivers/gpu/drm/gma500/framebuffer.c              |    2 +-
 drivers/gpu/drm/gma500/psb_drv.c                  |    2 +-
 drivers/gpu/drm/i915/i915_drv.c                   |    2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                   |    2 +-
 drivers/gpu/drm/udl/udl_drv.c                     |    2 +-
 drivers/gpu/drm/v3d/v3d_drv.c                     |    2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                     |    2 +-
 drivers/gpu/drm/vgem/vgem_drv.c                   |    2 +-
 drivers/gpu/drm/vkms/vkms_drv.c                   |    2 +-
 drivers/gpu/drm/xen/xen_drm_front.c               |    2 +-
 drivers/hwtracing/intel_th/msu.c                  |    2 +-
 drivers/hwtracing/stm/core.c                      |    2 +-
 drivers/infiniband/core/uverbs_main.c             |    2 +-
 drivers/infiniband/sw/rdmavt/mmap.c               |    2 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c              |    2 +-
 drivers/media/common/videobuf2/videobuf2-memops.c |    2 +-
 drivers/media/pci/meye/meye.c                     |    2 +-
 drivers/media/platform/omap/omap_vout.c           |    2 +-
 drivers/media/usb/stkwebcam/stk-webcam.c          |    2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c     |    2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c         |    2 +-
 drivers/media/v4l2-core/videobuf-vmalloc.c        |    2 +-
 drivers/misc/genwqe/card_dev.c                    |    2 +-
 drivers/misc/mic/scif/scif_mmap.c                 |    2 +-
 drivers/misc/sgi-gru/grufile.c                    |    2 +-
 drivers/rapidio/devices/rio_mport_cdev.c          |    2 +-
 drivers/staging/comedi/comedi_fops.c              |    2 +-
 drivers/staging/media/zoran/zoran_driver.c        |    2 +-
 drivers/staging/vme/devices/vme_user.c            |    2 +-
 drivers/usb/core/devio.c                          |    2 +-
 drivers/usb/mon/mon_bin.c                         |    2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c    |    2 +-
 drivers/xen/gntalloc.c                            |    2 +-
 drivers/xen/gntdev.c                              |    2 +-
 drivers/xen/privcmd-buf.c                         |    2 +-
 drivers/xen/privcmd.c                             |    2 +-
 fs/9p/vfs_file.c                                  |    2 +-
 fs/fuse/file.c                                    |    2 +-
 fs/kernfs/file.c                                  |    2 +-
 include/linux/mm.h                                |    2 +-
 ipc/shm.c                                         |    2 +-
 kernel/events/core.c                              |    2 +-
 kernel/relay.c                                    |    2 +-
 mm/hugetlb.c                                      |    2 +-
 mm/mmap.c                                         |   14 +++++++-------
 net/packet/af_packet.c                            |    2 +-
 sound/core/pcm_native.c                           |    4 ++--
 sound/usb/usx2y/us122l.c                          |    2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c                   |    2 +-
 52 files changed, 62 insertions(+), 62 deletions(-)

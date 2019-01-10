Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D3BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F93214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfAJMwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:52:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726974AbfAJMwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:52:38 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66BA8A0BE9C551568AFA;
        Thu, 10 Jan 2019 20:52:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 20:52:21 +0800
To:     <airlied@linux.ie>, <kraxel@redhat.com>, <aniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wang Haibin <wanghaibin.wang@huawei.com>
From:   Zheng Xiang <zhengxiang9@huawei.com>
Subject: [BUG] virtio-gpu hung when booting ARM64 virtual machine
Message-ID: <091a9619-a9de-acde-0f7e-70b5bd5970dc@huawei.com>
Date:   Thu, 10 Jan 2019 20:52:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Recently I encountered a problem that virtio-gpu driver would have a very low chance of getting hung
when I boot VM from linux kernel 4.19 on ARM64 server by using qemu. The dmesg log shows bellow:

    [  242.782731] INFO: task systemd:1 blocked for more than 120 seconds.
    [  242.782738]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  242.782739] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.782743] systemd         D    0     1      0 0x00000000
    [  242.782748] Call trace:
    [  242.782767]  __switch_to+0x94/0xd8
    [  242.782779]  __schedule+0x228/0x8a8
    [  242.782782]  schedule+0x2c/0x88
    [  242.782785]  schedule_timeout+0x234/0x470
    [  242.782787]  __down+0x88/0x108
    [  242.782792]  down+0x88/0xa0
    [  242.782798]  console_lock+0x24/0x48
    [  242.782799]  console_device+0x1c/0x88
    [  242.782806]  tty_lookup_driver+0xa8/0x128
    [  242.782808]  tty_open+0x1f4/0x418
    [  242.782813]  chrdev_open+0xd4/0x248
    [  242.782816]  do_dentry_open+0x1b0/0x380
    [  242.782818]  vfs_open+0x38/0x48
    [  242.782822]  do_last+0x294/0xf58
    [  242.782824]  path_openat+0x88/0x2a0
    [  242.782827]  do_filp_open+0x88/0x108
    [  242.782829]  do_sys_open+0x1a8/0x238
    [  242.782831]  __arm64_sys_openat+0x2c/0x38
    [  242.782834]  el0_svc_common+0x78/0x100
    [  242.782836]  el0_svc_handler+0x38/0x88
    [  242.782839]  el0_svc+0x8/0xc
    [  242.782850] INFO: task kworker/0:1:13 blocked for more than 120 seconds.
    [  242.782851]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  242.782853] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.782855] kworker/0:1     D    0    13      2 0x00000028
    [  242.782872] Workqueue: events drm_fb_helper_dirty_work
    [  242.782875] Call trace:
    [  242.782877]  __switch_to+0x94/0xd8
    [  242.782880]  __schedule+0x228/0x8a8
    [  242.782882]  schedule+0x2c/0x88
    [  242.782902]  virtio_gpu_queue_ctrl_buffer_locked+0x12c/0x220 [virtio_gpu]
    [  242.782906]  virtio_gpu_queue_ctrl_buffer+0x58/0x80 [virtio_gpu]
    [  242.782911]  virtio_gpu_cmd_resource_flush+0x8c/0xb0 [virtio_gpu]
    [  242.782915]  virtio_gpu_surface_dirty+0x60/0x110 [virtio_gpu]
    [  242.782920]  virtio_gpu_framebuffer_surface_dirty+0x34/0x48 [virtio_gpu]
    [  242.782922]  drm_fb_helper_dirty_work+0x170/0x1b0
    [  242.782928]  process_one_work+0x1f4/0x458
    [  242.782930]  worker_thread+0x50/0x4c8
    [  242.782932]  kthread+0x134/0x138
    [  242.782934]  ret_from_fork+0x10/0x1c
    [  242.782946] INFO: task kworker/1:1:34 blocked for more than 120 seconds.
    [  242.782948]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  242.782949] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.782950] kworker/1:1     D    0    34      2 0x00000028
    [  242.782960] Workqueue: events virtio_gpu_fb_dirty_work [virtio_gpu]
    [  242.782963] Call trace:
    [  242.782965]  __switch_to+0x94/0xd8
    [  242.782967]  __schedule+0x228/0x8a8
    [  242.782969]  schedule+0x2c/0x88
    [  242.782974]  virtio_gpu_queue_fenced_ctrl_buffer+0x12c/0x160 [virtio_gpu]
    [  242.782978]  virtio_gpu_cmd_transfer_to_host_2d+0xa4/0xd0 [virtio_gpu]
    [  242.782981]  virtio_gpu_dirty_update+0x184/0x200 [virtio_gpu]
    [  242.782986]  virtio_gpu_fb_dirty_work+0x3c/0x48 [virtio_gpu]
    [  242.782988]  process_one_work+0x1f4/0x458
    [  242.782990]  worker_thread+0x50/0x4c8
    [  242.782991]  kthread+0x134/0x138
    [  242.782993]  ret_from_fork+0x10/0x1c
    [  242.783033] INFO: task kworker/0:3:3706 blocked for more than 120 seconds.
    [  242.783034]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  242.783035] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.783037] kworker/0:3     D    0  3706      2 0x00000028
    [  242.783046] Workqueue: events console_callback
    [  242.783048] Call trace:
    [  242.783050]  __switch_to+0x94/0xd8
    [  242.783053]  __schedule+0x228/0x8a8
    [  242.783055]  schedule+0x2c/0x88
    [  242.783057]  schedule_timeout+0x234/0x470
    [  242.783059]  __down+0x88/0x108
    [  242.783061]  down+0x88/0xa0
    [  242.783063]  console_lock+0x24/0x48
    [  242.783065]  console_callback+0x40/0x198
    [  242.783067]  process_one_work+0x1f4/0x458
    [  242.783068]  worker_thread+0x50/0x4c8
    [  242.783070]  kthread+0x134/0x138
    [  242.783072]  ret_from_fork+0x10/0x1c
    [  242.783075] INFO: task kworker/u8:6:4901 blocked for more than 120 seconds.
    [  242.783077]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  242.783077] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.783079] kworker/u8:6    D    0  4901      2 0x00000028
    [  242.783087] Workqueue: events_unbound flush_to_ldisc
    [  242.783089] Call trace:
    [  242.783091]  __switch_to+0x94/0xd8
    [  242.783093]  __schedule+0x228/0x8a8
    [  242.783095]  schedule+0x2c/0x88
    [  242.783097]  schedule_timeout+0x234/0x470
    [  242.783099]  __down+0x88/0x108
    [  242.783101]  down+0x88/0xa0
    [  242.783103]  console_lock+0x24/0x48
    [  242.783105]  con_flush_chars+0x3c/0x58
    [  242.783107]  n_tty_receive_buf_common+0x3c4/0xa28
    [  242.783109]  n_tty_receive_buf2+0x40/0x50
    [  242.783111]  tty_ldisc_receive_buf+0x44/0x90
    [  242.783113]  tty_port_default_receive_buf+0x54/0xa0
    [  242.783114]  flush_to_ldisc+0xa4/0xc8
    [  242.783116]  process_one_work+0x1f4/0x458
    [  242.783118]  worker_thread+0x50/0x4c8
    [  242.783119]  kthread+0x134/0x138
    [  242.783121]  ret_from_fork+0x10/0x1c
    [  242.783125] INFO: task setfont:5118 blocked for more than 120 seconds.
    [  242.783127]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  242.783128] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.783129] setfont         D    0  5118      1 0x00000001
    [  242.783132] Call trace:
    [  242.783134]  __switch_to+0x94/0xd8
    [  242.783136]  __schedule+0x228/0x8a8
    [  242.783138]  schedule+0x2c/0x88
    [  242.783140]  schedule_timeout+0x234/0x470
    [  242.783142]  __down+0x88/0x108
    [  242.783144]  down+0x88/0xa0
    [  242.783146]  console_lock+0x24/0x48
    [  242.783148]  con_font_op+0x2a4/0x488
    [  242.783152]  vt_ioctl+0x119c/0x14a8
    [  242.783155]  tty_ioctl+0x118/0xc58
    [  242.783156]  do_vfs_ioctl+0xc4/0x8b0
    [  242.783158]  ksys_ioctl+0x8c/0xa0
    [  242.783160]  __arm64_sys_ioctl+0x28/0x38
    [  242.783161]  el0_svc_common+0x78/0x100
    [  242.783163]  el0_svc_handler+0x38/0x88
    [  242.783165]  el0_svc+0x8/0xc
    [  242.783167] INFO: task setfont:5121 blocked for more than 120 seconds.
    [  242.783169]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  242.783170] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  242.783172] setfont         D    0  5121      1 0x00000001
    [  242.783174] Call trace:
    [  242.783176]  __switch_to+0x94/0xd8
    [  242.783179]  __schedule+0x228/0x8a8
    [  242.783180]  schedule+0x2c/0x88
    [  242.783184]  virtio_gpu_queue_ctrl_buffer_locked+0x12c/0x220 [virtio_gpu]
    [  242.783188]  virtio_gpu_queue_ctrl_buffer+0x58/0x80 [virtio_gpu]
    [  242.783193]  virtio_gpu_cmd_set_scanout+0x90/0xb8 [virtio_gpu]
    [  242.783197]  virtio_gpu_primary_plane_update+0xc4/0x168 [virtio_gpu]
    [  242.783200]  drm_atomic_helper_commit_planes+0xd8/0x218
    [  242.783204]  vgdev_atomic_commit_tail+0x44/0x70 [virtio_gpu]
    [  242.783207]  commit_tail+0x4c/0x80
    [  242.783208]  drm_atomic_helper_commit+0xe0/0x160
    [  242.783215]  drm_atomic_commit+0x54/0x60
    [  242.783217]  restore_fbdev_mode_atomic+0x190/0x238
    [  242.783219]  drm_fb_helper_pan_display+0xac/0x1e8
    [  242.783226]  fb_pan_display+0x9c/0x120
    [  242.783229]  bit_update_start+0x28/0x50
    [  242.783231]  fbcon_switch+0x344/0x588
    [  242.783233]  redraw_screen+0x1a0/0x2a8
    [  242.783235]  fbcon_do_set_font+0x1cc/0x268
    [  242.783237]  fbcon_set_font+0x224/0x260
    [  242.783239]  con_font_op+0x2c8/0x488
    [  242.783240]  vt_ioctl+0x119c/0x14a8
    [  242.783243]  tty_ioctl+0x118/0xc58
    [  242.783245]  do_vfs_ioctl+0xc4/0x8b0
    [  242.783246]  ksys_ioctl+0x8c/0xa0
    [  242.783248]  __arm64_sys_ioctl+0x28/0x38
    [  242.783250]  el0_svc_common+0x78/0x100
    [  242.783252]  el0_svc_handler+0x38/0x88
    [  242.783253]  el0_svc+0x8/0xc
    [  363.614716] INFO: task systemd:1 blocked for more than 120 seconds.
    [  363.614721]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  363.614722] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  363.614726] systemd         D    0     1      0 0x00000000
    [  363.614732] Call trace:
    [  363.614751]  __switch_to+0x94/0xd8
    [  363.614763]  __schedule+0x228/0x8a8
    [  363.614766]  schedule+0x2c/0x88
    [  363.614769]  schedule_timeout+0x234/0x470
    [  363.614771]  __down+0x88/0x108
    [  363.614776]  down+0x88/0xa0
    [  363.614782]  console_lock+0x24/0x48
    [  363.614783]  console_device+0x1c/0x88
    [  363.614790]  tty_lookup_driver+0xa8/0x128
    [  363.614791]  tty_open+0x1f4/0x418
    [  363.614796]  chrdev_open+0xd4/0x248
    [  363.614799]  do_dentry_open+0x1b0/0x380
    [  363.614800]  vfs_open+0x38/0x48
    [  363.614805]  do_last+0x294/0xf58
    [  363.614807]  path_openat+0x88/0x2a0
    [  363.614809]  do_filp_open+0x88/0x108
    [  363.614811]  do_sys_open+0x1a8/0x238
    [  363.614813]  __arm64_sys_openat+0x2c/0x38
    [  363.614817]  el0_svc_common+0x78/0x100
    [  363.614819]  el0_svc_handler+0x38/0x88
    [  363.614822]  el0_svc+0x8/0xc
    [  363.614832] INFO: task kworker/0:1:13 blocked for more than 120 seconds.
    [  363.614833]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  363.614834] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  363.614836] kworker/0:1     D    0    13      2 0x00000028
    [  363.614851] Workqueue: events drm_fb_helper_dirty_work
    [  363.614854] Call trace:
    [  363.614856]  __switch_to+0x94/0xd8
    [  363.614859]  __schedule+0x228/0x8a8
    [  363.614860]  schedule+0x2c/0x88
    [  363.614881]  virtio_gpu_queue_ctrl_buffer_locked+0x12c/0x220 [virtio_gpu]
    [  363.614886]  virtio_gpu_queue_ctrl_buffer+0x58/0x80 [virtio_gpu]
    [  363.614891]  virtio_gpu_cmd_resource_flush+0x8c/0xb0 [virtio_gpu]
    [  363.614895]  virtio_gpu_surface_dirty+0x60/0x110 [virtio_gpu]
    [  363.614899]  virtio_gpu_framebuffer_surface_dirty+0x34/0x48 [virtio_gpu]
    [  363.614902]  drm_fb_helper_dirty_work+0x170/0x1b0
    [  363.614906]  process_one_work+0x1f4/0x458
    [  363.614908]  worker_thread+0x50/0x4c8
    [  363.614911]  kthread+0x134/0x138
    [  363.614913]  ret_from_fork+0x10/0x1c
    [  363.614922] INFO: task kworker/1:1:34 blocked for more than 120 seconds.
    [  363.614923]       Tainted: G            E     4.19.5-1.2.32.aarch64 #1
    [  363.614925] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    [  363.614926] kworker/1:1     D    0    34      2 0x00000028
    [  363.614936] Workqueue: events virtio_gpu_fb_dirty_work [virtio_gpu]
    [  363.614938] Call trace:
    [  363.614940]  __switch_to+0x94/0xd8
    [  363.614943]  __schedule+0x228/0x8a8
    [  363.614945]  schedule+0x2c/0x88
    [  363.614948]  virtio_gpu_queue_fenced_ctrl_buffer+0x12c/0x160 [virtio_gpu]
    [  363.614953]  virtio_gpu_cmd_transfer_to_host_2d+0xa4/0xd0 [virtio_gpu]
    [  363.614957]  virtio_gpu_dirty_update+0x184/0x200 [virtio_gpu]
    [  363.614961]  virtio_gpu_fb_dirty_work+0x3c/0x48 [virtio_gpu]
    [  363.614964]  process_one_work+0x1f4/0x458
    [  363.614966]  worker_thread+0x50/0x4c8
    [  363.614967]  kthread+0x134/0x138
    [  363.614969]  ret_from_fork+0x10/0x1c

It seems that the commit d02d270014f70dcab0117776b81a37b6fca745ae(drm/virtio: fix vq wait_event condition) is relative to the above exception.
I don't know in which case the ctrl_vq.vq->num_free would be always less than 3 so that virtio_gpu_queue_fenced_ctrl_buffer and virtio_gpu_queue_ctrl_buffer_locked wait for schedule timeout.


-- 

Thanks,
Xiang


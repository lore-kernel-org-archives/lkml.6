Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeDGHuJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 03:50:09 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:39473 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeDGHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 03:50:07 -0400
X-Google-Smtp-Source: AIpwx48074078bxfiB0pwO4M9nbbi+I8SGqxFc2qCxZMS9JbmDUEX4WNXsEmI9n/39SJAV4N0d0senLBIdE9ESKnRGU=
MIME-Version: 1.0
X-Originating-IP: [175.156.94.175]
From: Daniel J Blueman <daniel@quora.org>
Date: Sat, 7 Apr 2018 15:50:06 +0800
Message-ID: <CAMVG2svG=HaK15JwZwg7PRJUR26FHrzSz3-OL01jz1wikHe+oQ@mail.gmail.com>
Subject: drm/vc4: false-positive negative cursor position warning
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric et al,

In a number of windowing environments (eg GNOME 3) on Raspberry Pi 3B
on 4.16.0 arm64, the mouse cursor top-left gets down to x,y -4,-4,
tripping WARN_ON_ONCE(plane->state->crtc_x < 0 || plane->state->crtc_y
< 0) [1], which therefore seems false-positive.

Git history doesn't turn up any reason, eg it could cause undefined
hardware behaviour, which it doesn't appear to, so would it be better
to drop the warning, or adjust it to trip on x or y < -4 or so? If so,
I'll prepare a patch to adjust it.

[Side note: simply opening the GNOME 3 Activities menu with
libgl1-mesa-dri 17.3.7 is a reliable way to reproduce "[drm] Resetting
GPU"]

Thanks,
  Dan

-- [1]

WARNING: CPU: 3 PID: 966 at drivers/gpu/drm/vc4/vc4_plane.c:771
vc4_plane_async_set_fb+0x98/0xa0
CPU: 3 PID: 966 Comm: Xorg Tainted: G S               4.16.0+ #13
Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : vc4_plane_async_set_fb+0x98/0xa0
lr : vc4_plane_async_set_fb+0x4c/0xa0
sp : ffff0000086ab9b0
x29: ffff0000086ab9b0 x28: 0000000000000000
x27: 0000000000000009 x26: 00000000fffffffc
x25: ffffa81b36ca8b00 x24: ffffa81b30667c00
x23: 0000000000400000 x22: ffffa81b30790400
x21: ffffa81b36ca8b00 x20: ffffa81b30a53018
x19: ffffa81b30667c00 x18: ffffffffffffffff
x17: 0000ffffb4fcec50 x16: ffff3447cc0e8588
x15: ffff3447d14fbf88 x14: ffff344851bb337f
x13: ffff3447d1bb338d x12: ffff3447d153b000
x11: ffff3447d14fc7f0 x10: ffff3447ccb3dac8
x9 : 00000000ffffffd0 x8 : 0000000000000005
x7 : 3932373639343932 x6 : 000000000000056e
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 0000000000000000 x2 : ed59bd53d8905e00
x1 : 00000000fffffffc x0 : ffffa81b30667c00
Call trace:
 vc4_plane_async_set_fb+0x98/0xa0
 vc4_update_plane+0x124/0x1a0
 __setplane_internal+0x1f4/0x260
 drm_mode_cursor_universal+0xf4/0x220
 drm_mode_cursor_common+0x19c/0x218
 drm_mode_cursor2_ioctl+0x34/0x48
 drm_ioctl_kernel+0x70/0xd8
 drm_ioctl+0x30c/0x438
 do_vfs_ioctl+0xc4/0x880
 SyS_ioctl+0x8c/0xa8
 el0_svc_naked+0x30/0x34
-- 
Daniel J Blueman

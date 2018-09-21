Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE51ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF09921536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO59yKst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF09921536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbeIUFxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:53:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39597 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeIUFxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:53:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id o15-v6so183496qtk.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GmOOir3QzQCgZ48pzs34w6vqrBQOL0u0wBqrv39hdnk=;
        b=fO59yKstvyG94qukhHM/tTdxP4n8KY677NlVOiZG7TeOf3ERgmdY8og+Sj6qNlvvyU
         KgUYoInmj2cEbEecGlIxHgfc1jgsCsreYnN2hsZttY5pRmxCv+2mjmqs++3f/HvsSTkw
         8zxhiro3ZXuzeVSfCigpUzg+NCuq5hKitAmNcIMVLz+biozyREpWg0/AxbRiHgyy5/RB
         e/3UdajBxyOmu6r7F5lcgIrTPdMFca7TR/H7nQYJ0zJJcFEfp490AJu1pHKAXqx/4bKh
         /wevF9CjWxE8iPZZFv/od6tvcQNGMdnwCNjdqejmyG4rr67OMfrkwWes8F1JUaxk/ccv
         RusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GmOOir3QzQCgZ48pzs34w6vqrBQOL0u0wBqrv39hdnk=;
        b=GM9QZzy3cHUkHEoyA+0esjj+G+9r5eLSMVIJykV3dUaAwf3ANX8fIqU83eHAXHahp3
         7oIp4FKOtaS15FJBBT8UOCS3Tw5RWdvnTxqMUilRLiVQYXw0WTFQ42xEalLUqHlML25m
         6dUTkOs50SkjQvI3/hr6ojrNu9yuc7jwrf8W1V6RLRAEcRZvQCVBSTG6WPpLlah0znUu
         MzCtRkGnUH+rRm3140TscZXz3kTnlLqWdl7uzZBwMvbDFp4rOIAZZGCJLYWn0q7WcVWk
         rK+HdoevJLayy+yWYbWlrVAbfH07Kh0MTVg4m+TPRnfYoYYXN6eh+YpclJR3IAb/Nnk+
         Soyw==
X-Gm-Message-State: APzg51DRuDA1Rwfmdi99PuQoNq/VOtfG4HFkiTWIxMIc/8sooa1+Nc7E
        uHC3mFdkPfSmK5TQRkJ9VbisWscCpVXRW3bgshY=
X-Google-Smtp-Source: ANB0VdbAOlBErbOALBZJqYburuHCroScr2lpCqSVZeoDZ+CFQfyMZFYHZ+qXYWoMRPs77+aVL541J9GP5IPc0zeqaH0=
X-Received: by 2002:ac8:d02:: with SMTP id q2-v6mr4301729qti.182.1537488429994;
 Thu, 20 Sep 2018 17:07:09 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 21 Sep 2018 10:06:58 +1000
Message-ID: <CAPM=9tz2sHYqjTMUnzr_SQ1J9qrWAGDs56y_2CrFhCCJOeYgjA@mail.gmail.com>
Subject: [git pull] drm fixes for 4.19-rc5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg,

Looks like a pretty run of the mill set of fixes for this stage,

core: fix debugfs for atomic, fix the check for atomic for
non-modesetting drivers
amdgpu: adds a new PCI id, some kfd fixes and a sdma fix
i915: a bunch of GVT fixes.
vc4: scaling fix
vmwgfx: modesetting fixes and a old buffer eviction fix
udl: framebuffer destruction fix
sun4i: disable on R40 fix until next kernel
pl111: NULL termination on table fix

Thanks,
Dave.

drm-fixes-2018-09-21:
amdgpu, vwmgfx, i915, sun4i, vgem, vc4, udl and core fixes.
The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-09-21

for you to fetch changes up to 4fcb7f8be829d21bcbb24eef2204fb6b34ed1f80:

  Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2018-09-21
09:52:27 +1000)

----------------------------------------------------------------
amdgpu, vwmgfx, i915, sun4i, vgem, vc4, udl and core fixes.

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: add new polaris pci id

Amber Lin (1):
      drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Boris Brezillon (1):
      drm/vc4: Fix the "no scaling" case on multi-planar YUV formats

Chen-Yu Tsai (1):
      drm/sun4i: Remove R40 display pipeline compatibles

Colin Xu (2):
      drm/i915/gvt: Init PHY related registers for BXT
      drm/i915/gvt: Add GEN9_CLKGATE_DIS_4 to default BXT mmio handler

Dave Airlie (5):
      drm: fix drm_drv_uses_atomic_modeset on non modesetting drivers.
      Merge tag 'drm-misc-fixes-2018-09-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2018-09-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'vmwgfx-fixes-4.19' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge branch 'drm-fixes-4.19' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Deepak Rawat (4):
      drm/vmwgfx: don't check for old_crtc_state enable status
      drm/vmwgfx: limit screen size to stdu_max during check_modeset
      drm/vmwgfx: limit mode size for all display unit to texture_max
      drm/vmwgfx: Don't impose STDU limits on framebuffer size

Emil Lundmark (1):
      drm: udl: Destroy framebuffer only if it was initialized

Icenowy Zheng (1):
      drm: sun4i: drop second PLL from A64 HDMI PHY

Lyude Paul (1):
      drm/atomic: Use drm_drv_uses_atomic_modeset() for debugfs creation

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2018-09-18' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Thomas Hellstrom (1):
      drm/vmwgfx: Fix buffer object eviction

Weinan Li (1):
      drm/i915/gvt: request srcu_read_lock before checking if one gfn is valid

Yong Zhao (2):
      drm/amdkfd: Change the control stack MTYPE from UC to NC on GFX9
      drm/amdkfd: Fix ATS capablity was not reported correctly on some APUs

YueHaibing (1):
      drm/fb-helper: Remove set but not used variable 'connector_funcs'

Zhipeng Gong (1):
      drm/i915/gvt: clear ggtt entries when destroy vgpu

zhong jiang (1):
      drm/pl111: Make sure of_device_id tables are NULL terminated

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c        |  6 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c           | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c           |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c            | 13 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h             |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c         | 21 +++++++++---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +-
 drivers/gpu/drm/drm_atomic.c                      |  2 +-
 drivers/gpu/drm/drm_debugfs.c                     |  2 +-
 drivers/gpu/drm/drm_fb_helper.c                   |  3 --
 drivers/gpu/drm/i915/gvt/handlers.c               |  1 +
 drivers/gpu/drm/i915/gvt/kvmgt.c                  |  7 +++-
 drivers/gpu/drm/i915/gvt/mmio.c                   | 28 +++++++++++++++
 drivers/gpu/drm/i915/gvt/vgpu.c                   |  1 +
 drivers/gpu/drm/pl111/pl111_vexpress.c            |  3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                 |  1 -
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c            |  1 -
 drivers/gpu/drm/sun4i/sun8i_mixer.c               | 24 -------------
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c            |  1 -
 drivers/gpu/drm/udl/udl_fb.c                      |  8 +++--
 drivers/gpu/drm/vc4/vc4_plane.c                   | 25 +++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c           |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               | 42 ++++++++++++++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c              | 25 --------------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c           | 24 +++++++------
 include/drm/drm_drv.h                             |  2 +-
 30 files changed, 152 insertions(+), 117 deletions(-)

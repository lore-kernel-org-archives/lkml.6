Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B7F4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAB820864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXrCS02w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAB820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755547AbeFOEcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:32:25 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38917 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeFOEcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:32:23 -0400
Received: by mail-qt0-f196.google.com with SMTP id p23-v6so7990716qtn.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 21:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=srxlymyuyiVXmCTcbR+oKhaFkxPWxiVIRmzEsV+BAwQ=;
        b=GXrCS02wG5O8ieXo1lascysS5YSa/U3eY05Et1YGRKsgQY+S7jYs5zWeMhlC6SgTve
         vEErPWOXnVTXCTJk5xhytLT6FuKI+uQXZ8yBYWHw1lSwVryUilufO9xGt1K8KPhJHxjf
         l0VSdzBiDwU5R314WFxAKciXENKiKwd2eAdZcy/AtZSW69WedpvRXwR9MpcgrEbqOMcC
         Flj0AhmVFV+OZczXx1dllWXBRZBdjW6GNRR8ZK+dmjETeSHI7eRdHQh3MZlNrZVYybpN
         NIPf4rGfrYvllMFY+j5azqmEXrkDMIY3I20g87v61rTbiWU+gp7xgd7e3TRhrtRyErEj
         PT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=srxlymyuyiVXmCTcbR+oKhaFkxPWxiVIRmzEsV+BAwQ=;
        b=PqaVg8pniup1Ze73rf0/Qz7k5oFbF71+nW3dnzDXocvLFuM40eAPVdK2Xhoxu6eUx2
         d5NsqMyh8gDnbiJDYSKkjbWRKAL4c0tWIuaFERM2DX3xCBuQUdmyboimnmAZ6M+JYTnI
         KbfZyCrq4STPvnCqqHCcS2fGrUIqqRJPuknS5e9Z5iAjFpr7mYvtLocDinYy0V1GAlBM
         uDWuHJ7MXTYY4fRlYmbrFFrr3/dk47dQfYA96Zvlbp6nPDhvlulcMYl4t7ih2ZsqkUl7
         ts/WM8/Ic/r+R5zTSw3rqRNuJrL2zyowgn9HXYSNqJ88j5+fZtaicCQYmimBwHUnSQNR
         OkEw==
X-Gm-Message-State: APt69E2WzcV3h9FqK59+QcoLW4blafkDw2K8lRpgupcnAOkqL+u6Yfgu
        qNl2gE5Qcx7MseG7IrSTrp8BkkvBcALXIzU1fjn+5A==
X-Google-Smtp-Source: ADUXVKL2ZqJkvJvkn5Fw/kZ45qBHcQVrr3RUFE5LJ9DtFAhGoQuI99oNWhfHxaLPvaZ/e+QHpQDsU2HSblx/0ChjiZc=
X-Received: by 2002:ac8:1b7b:: with SMTP id p56-v6mr83763qtk.254.1529037142546;
 Thu, 14 Jun 2018 21:32:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3f3d:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 21:32:22
 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 Jun 2018 14:32:22 +1000
Message-ID: <CAPM=9tyJuBhcZjKdaCj5SPA7MjaPCLCSLMw6Axbaa=95Z4jBCg@mail.gmail.com>
Subject: [git pull] drm amd fixes for 4.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just a single set of AMD fixes for stuff in -next for -rc1.

Thanks,
Dave.

drm-next-2018-06-15:
amd fixes for 4.18-rc1
The following changes since commit 33ce21d6a2491ef9adb8dc395e3f5bbbfcdc95b5:

  Merge tag 'drm-intel-next-fixes-2018-06-08-2' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2018-06-09
06:34:51 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2018-06-15

for you to fetch changes up to daf0678c2036c918f01e4aa6035629d2debc2f30:

  Merge branch 'drm-next-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2018-06-15
11:32:29 +1000)

----------------------------------------------------------------
amd fixes for 4.18-rc1

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/display: check if ppfuncs exists before using it
      Revert "drm/amdgpu: Add an ATPX quirk for hybrid laptop"

Charlene Liu (1):
      drm/amd/display: add register offset != 0 check.

Chunming Zhou (1):
      drm/amdgpu: gds bo must not be per-vm-bo

Colin Ian King (2):
      drm/amdgpu/df: fix potential array out-of-bounds read
      drm/amd/pp: initialize result to before or'ing in data

Dave Airlie (1):
      Merge branch 'drm-next-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Deepak Sharma (2):
      drm/amdgpu: Use GTT for dumb buffer if sg display enabled (v2)
      drm/amdgpu: Add helper function to get buffer domain

Dmytro Laktyushkin (1):
      drm/amd/display: fix dscl_manual_ratio_init

Emily Deng (1):
      drm/amdgpu: To get gds, gws and oa from adev->gds (v2)

Eric Bernstein (2):
      drm/amd/display: DP component depth 16 bpc
      drm/amd/display: Set TMZ and DCC for secondary surface

Evan Quan (6):
      drm/amdgpu: correct SMU11 SYSPLL0 clock id values
      drm/amd/powerplay: bug fixs for getsmuclockinfo
      drm/amdgpu: typo fix for vega20 cg flags
      drm/amd/powerplay: fix wrong clock adjust sequence
      drm/amdgpu: fix parsing indirect register list v2
      drm/amd/powerplay: remove uncessary extra gfxoff control call

Feifei Xu (1):
      drm/gfx9: Update gc goldensetting for vega20.

Harry Wentland (2):
      drm/amd/display: Implement dm_pp_get_clock_levels_by_type_with_latency
      drm/amd/display: Fix wrong latency assignment for VEGA clock levels

Huang Rui (4):
      drm/amdgpu: fix the missed vcn fw version report
      drm/amdgpu: add checking for sos version
      drm/amdgpu: fix CG enabling hang with gfxoff enabled
      drm/amd/powerplay: fix missed hwmgr check warning before call
gfx_off_control handler

Junwei Zhang (1):
      drm/amdgpu: fix clear_all and replace handling in the VM (v2)

Kenneth Feng (1):
      drm/amd/powerplay: Set higher SCLK&MCLK frequency than dpm7 in OD (v2)

Leo (Sunpeng) Li (2):
      drm/amd/display: Destroy connector state on reset
      drm/amd/display: Fix BUG_ON during CRTC atomic check update

Leo Liu (1):
      drm/amdgpu: remove unnecessary scheduler entity for VCN

Lyude Paul (1):
      drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()

Mikita Lipski (5):
      drm/amd/pp: Add cases for getting phys and disp clks for SMU10
      drm/amd/display: Do not limit color depth to 8bpc
      drm/amd/display: Release fake sink
      drm/amd/display: Do not program interrupt status on disabled crtc
      drm/amd/pp: Connect display_clock_voltage_request to a function pointer

Nayan Deshmukh (1):
      drm/scheduler: fix a corner case in dependency optimization

Nikola Cornij (2):
      drm/amd/display: Read DPCD link caps up to and including DP_ADAPTER_CAP
      drm/amd/display: Read DP_SINK_COUNT_ESI range on HPD for DP 1.4

Pratik Vishwakarma (1):
      drm/amd/display: Fix stale buffer object (bo) use

Rex Zhu (2):
      drm/amd/pp: Allow underclocking when od table is empty in vbios
      drm/amd/pp: Fix OD feature enable failed on Vega10 workstation cards

Roman Li (2):
      drm/amd/display: replace msleep with udelay in fbc path
      drm/amd/display: check if audio clk enable is applicable

Shaoyun Liu (2):
      drm/amdgpu: Fix NULL pointer when load kfd driver with PP block
is disabled
      drm/amd/include: Update df 3.6 mask and shift definition

kbuild test robot (1):
      drm/amdgpu: vcn_v1_0_is_idle() can be static

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 18 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 38 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         | 17 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 52 +++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  6 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 21 +++---
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              | 27 +++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 80 +++++++++++-----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 45 +++++++++++-
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |  5 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 37 ++++++++--
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |  6 +-
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |  8 +--
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |  3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |  6 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |  8 +--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  | 14 ++--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |  8 +++
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |  4 ++
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |  2 +
 .../drm/amd/include/asic_reg/df/df_3_6_sh_mask.h   |  8 +--
 drivers/gpu/drm/amd/include/atomfirmware.h         | 12 ++--
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 10 +--
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       | 13 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |  4 +-
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |  6 --
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |  6 --
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  | 74 ++++++++++----------
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 12 +++-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 15 +++-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |  2 +-
 .../amd/powerplay/hwmgr/vega10_processpptables.c   |  6 --
 drivers/gpu/drm/scheduler/gpu_scheduler.c          |  9 ++-
 43 files changed, 372 insertions(+), 255 deletions(-)

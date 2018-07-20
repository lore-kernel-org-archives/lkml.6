Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B357AECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB312084E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE8mmNdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB312084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeGTDSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 23:18:52 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:46060 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbeGTDSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 23:18:52 -0400
Received: by mail-qk0-f173.google.com with SMTP id c192-v6so5464423qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 19:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0w5PlsvB93jRNrskokdvzGlyTxHaSOX8uLK9sDt+kEs=;
        b=cE8mmNdd6iLaKtHv4J0mVF7G7v87JkyuoqgQt7j6z8Wg1scKcr0IPlgeynb3dwYl70
         sLvKh+/O068XrTpboFF7tgtSLXfjFWfVCH+04be9yV+4wiw0IK6i1IZ6as7eWK4XigjS
         2sryVASC9QFUWFAGCDjJVMvaJdITMvS8IYdUtH/A9rC9INldjPtN3lMoBed4elG9mwyc
         r9H3+vcKdjn/e3PCdtbB0E/HbU+B+uWm5EYUgL8nogodhYkZkpVxhCBkh8obCGarpQt4
         99DsGAQ+BLXHJ3fNp96pm0jEBNYOzJie2zy4ueoU9L1hDJlHYUVgPaWD2HO/104n68NU
         uBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0w5PlsvB93jRNrskokdvzGlyTxHaSOX8uLK9sDt+kEs=;
        b=HVcUzlH4HpP6ktwpnEyaybubKeQzed43HhDjrdjBzGMK2f+f3srkvXdauAvc/am8gO
         qTsYdeEqCIwF5CA2Q9gz40rTvwZk5Sr6YT+NYr3Kjmmpa35gDg4T9HEkbhTfacso6J+5
         SHQsWydnJ99VtLTmty4Cc03KNVJXjtHpWAYy2K0GJxDqWkmak5Qjj/TmSt3QeK+GphBb
         UsF1UXdnQr9iMNZrNlRm7/D3Dox9tV59bh603gcoskcZwcOLF9CDxu3RPNdJlRLWBqeX
         WW9rPaYhPyvkXujZxhe9M/C8m4Qj6ROrlvgz9A75o8B3S/OB83RVhJqS8KzeMNc4TG69
         Ugjg==
X-Gm-Message-State: AOUpUlGz10b7EL2cYFSYd4FAhe9h+orP6VZ4QIcTXeQ4hplgFnUN/a+c
        44iw4Ggbn2mgF9tIbt3N9DRnJfobAsL/7fk4dfAS1ezx
X-Google-Smtp-Source: AAOMgpfIQMaiuaeorLoELBFiQ3T+QDshotH6t64e0EP0haDM97z2VW7qRSX8eAgCPhEiWwex2ElYW1URtD1iIbrMRI4=
X-Received: by 2002:a37:56c7:: with SMTP id k190-v6mr137403qkb.29.1532053974116;
 Thu, 19 Jul 2018 19:32:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3666:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 19:32:53
 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 20 Jul 2018 12:32:53 +1000
Message-ID: <CAPM=9tyf=81vWFypSQO3hZKeFkx9P60GKMcWKWtaXMCsTHsD7Q@mail.gmail.com>
Subject: [git pull] drm amdgpu and nouveau fixes for 4.18-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just two sets of driver fixes this week to follow up on the set from
earlier in the week and hopefully get me realigned schedule wise.

amdgpu:
ACP fix for boards with multiple I2S instances
DP fix for CZ, vega
hybrid laptop fixes
Resume regression fix

nouveau:
large memory systems and Pascal fix
MST race fixes
runtime PM fix.

Thanks,
Dave.

drm-fixes-2018-07-20:
nouveau and amdgpu fixes
The following changes since commit bf642e3a1996f1ed8f083c5ecd4b51270a9e11bc:

  Merge tag 'drm-intel-fixes-2018-07-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2018-07-16
10:32:28 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-07-20

for you to fetch changes up to 02e546eacceaaad4494e2ea8fb5014f00f9c4bef:

  Merge branch 'linux-4.18' of git://github.com/skeggsb/linux into
drm-fixes (2018-07-20 10:27:53 +1000)

----------------------------------------------------------------
nouveau and amdgpu fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: add another ATPX quirk for TOPAZ

Ben Skeggs (2):
      drm/nouveau/kms/nv50-: ensure window updates are submitted when
flushing mst disables
      drm/nouveau/fb/gp100-: disable address remapper

Dan Carpenter (1):
      drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()

Dave Airlie (2):
      Merge branch 'drm-fixes-4.18' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'linux-4.18' of git://github.com/skeggsb/linux into drm-fixes

Hersen Wu (1):
      drm/amd/display: Fix DP HBR2 Eye Diagram Pattern on Carrizo

Leo Liu (1):
      drm/amdgpu: Make sure IB tests flushed after IP resume

Lyude Paul (5):
      drm/nouveau: Use drm_connector_list_iter_* for iterating connectors
      drm/nouveau: Avoid looping through fake MST connectors
      drm/nouveau/drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_commit()
      drm/nouveau: Remove bogus crtc check in pmops_runtime_idle
      drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs

Vijendar Mukunda (1):
      drm/amd/amdgpu: creating two I2S instances for stoney/cz (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            | 47 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  3 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  8 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  2 +
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |  3 ++
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 53 +++++++++++-----------
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |  6 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  9 +++-
 drivers/gpu/drm/nouveau/nouveau_connector.h        | 36 +++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_display.c          | 10 +++-
 drivers/gpu/drm/nouveau/nouveau_drm.c              | 18 +++-----
 drivers/gpu/drm/nouveau/nouveau_gem.c              |  4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c      |  3 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp100.c     |  9 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp102.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |  2 +
 18 files changed, 152 insertions(+), 64 deletions(-)

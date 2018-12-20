Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D41FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E6B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbeLTS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:28:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732679AbeLTS21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:28:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48CC8B008;
        Thu, 20 Dec 2018 18:28:25 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: features and fixes for 4.21
Date:   Thu, 20 Dec 2018 19:28:23 +0100
Message-Id: <20181220182823.7803-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.21-rc1-tag

xen: features and fixes for 4.21

It contains the following changes:

- a series to enable KVM guests to be booted by qemu via the Xen PVH
  boot entry for speeding up KVM guest tests

- a series for a common driver to be used by Xen PV frontends (right now
  drm and sound)

- two other fixes in Xen related code


Thanks.

Juergen

 MAINTAINERS                                     |   1 +
 arch/x86/Kbuild                                 |   2 +
 arch/x86/Kconfig                                |   6 +
 arch/x86/kernel/head_64.S                       |   2 +-
 arch/x86/platform/pvh/Makefile                  |   5 +
 arch/x86/platform/pvh/enlighten.c               | 137 ++++++
 arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} |   0
 arch/x86/xen/Kconfig                            |   3 +-
 arch/x86/xen/Makefile                           |   2 -
 arch/x86/xen/enlighten_pvh.c                    |  92 +---
 arch/x86/xen/xen-asm_64.S                       |   2 +
 drivers/gpu/drm/xen/Kconfig                     |   1 +
 drivers/gpu/drm/xen/Makefile                    |   1 -
 drivers/gpu/drm/xen/xen_drm_front.c             |  65 ++-
 drivers/gpu/drm/xen/xen_drm_front_gem.c         |   1 -
 drivers/gpu/drm/xen/xen_drm_front_shbuf.c       | 414 ------------------
 drivers/gpu/drm/xen/xen_drm_front_shbuf.h       |  64 ---
 drivers/xen/Kconfig                             |   3 +
 drivers/xen/Makefile                            |   1 +
 drivers/xen/xen-front-pgdir-shbuf.c             | 553 ++++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c              |   3 +-
 include/xen/interface/hvm/start_info.h          |  63 ++-
 include/xen/xen-front-pgdir-shbuf.h             |  89 ++++
 include/xen/xen.h                               |   3 +
 sound/xen/Kconfig                               |   1 +
 sound/xen/Makefile                              |   1 -
 sound/xen/xen_snd_front.c                       |   7 +-
 sound/xen/xen_snd_front.h                       |   4 +-
 sound/xen/xen_snd_front_alsa.c                  | 102 +++--
 sound/xen/xen_snd_front_shbuf.c                 | 194 ---------
 sound/xen/xen_snd_front_shbuf.h                 |  36 --
 31 files changed, 996 insertions(+), 862 deletions(-)

Andrea Righi (1):
      kprobes/x86/xen: blacklist non-attachable xen interrupt functions

Maran Wilson (7):
      xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
      xen/pvh: Move PVH entry code out of Xen specific tree
      xen/pvh: Create a new file for Xen specific PVH code
      xen/pvh: Move Xen specific PVH VM initialization out of common file
      xen/pvh: Move Xen code for getting mem map via hcall out of common file
      xen/pvh: Add memory map pointer to hvm_start_info struct
      KVM: x86: Allow Qemu/KVM to use PVH entry point

Oleksandr Andrushchenko (3):
      xen: Introduce shared buffer helpers for page directory...
      drm/xen-front: Use Xen common shared buffer implementation
      ALSA: xen-front: Use Xen common shared buffer implementation

Ross Lagerwall (1):
      xen/pciback: Check dev_data before using it

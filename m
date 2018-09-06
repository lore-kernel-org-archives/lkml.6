Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0100EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE411206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="QdS5rn3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE411206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIGCzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:55:54 -0400
Received: from lekensteyn.nl ([178.21.112.251]:37687 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeIGCzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=Azoeh7ONZW4pASwk57naKlFdhZ4qoJqyNyxU05h63Qs=;
        b=QdS5rn3WAdjRrNK+FdLw1R/4M1xbPIJVC6S/aWLm4RQ1zZUycM838XnLSP6GDRMy6UepFlSSjdzrVj8jjJzjLq9kDLn4HtPsDa0o48UIK4y1xHqxIwsPaBjX58+bfPxxRwaWa5VlNKidGuu9GtppkwmyVBSwYArDccTe3M94NyX0ue6klSKD+YV4Mp1gkkDneh/LfpKYJzB2Z4iHPOfCD1F6D2LzTIUHexRcpOnBxvHyKZJUoHVBvaZzc+ppwkDTyo9eCd8PCWzBHpt7V78Pyn36KJIcCWWI1LFMllcNUizomC2O0A3nR+7MnfMXvdRZuDUiT9VJo1aq+XxlbIwblA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1fy2bK-0005Us-PS; Fri, 07 Sep 2018 00:18:12 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2 0/4] bochs fixes and fb-helper documentation updates
Date:   Fri,  7 Sep 2018 00:18:06 +0200
Message-Id: <20180906221810.20170-1-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series tries to improve the bochs driver and update documentation based on
my brief experience with the fb-helper API. Thank you Daniel and Gerd for your
previous feedback and helpful suggestions.

Patch 2 was previously posted and is unmodified except for acked-by + rebase on
drm-misc-next (9a09a42369a4a37a959c051d8e1a1f948c1529a4). Patch 1 is a trivial
(build) fix that was missing last time.

Patch 3 converts from the legacy API to the modern drm_dev_register approach.
This seems required for the "generic" fbdev API as suggested by Daniel, but as
bochs does not implement the required "gem_prime_vmap" function, the conversion
cannot be completed for now.

Patch 4 includes some documentation updates that would have helped me during
qxl/bochs development and a warning that made me realize that "a virtual address
and that can be mmap'ed" in the documentation referred to "gem_prime_vmap". It
is to my best of understanding, so please correct me if I am wrong.

Side note: I originally tried to fix the unbind/remove crash in QXL and then
turned to bochs as it seemed simpler to learn how to work on DRM drivers.
Hopefully I manage to eventually figure out how to fix QXL. QXL is a bit
strange, it advertises PRIME "support" but it only has stub functions (including
a stub gem_prime_vmap).

After my recent patch ("qxl: fix null-pointer crash during suspend") qxl can
suspend/resume in the normal situation, but doing anything (suspend or unload)
after unbinding just fails (suspend then fails with "failed to wait on release
23 after spincount 301", unload triggers a use-after-free according to KASAN).
On the other hand, bochs passes these tests:

    # 1. s/r with unbound console
    modprobe bochs_drm
    echo 0 > /sys/class/vtconsole/vtcon1/bind
    rtcwake -s 1 -m mem
    # 2. s/r in normal sitation
    echo 1 > /sys/class/vtconsole/vtcon1/bind
    rtcwake -s 1 -m mem
    # 3. unload module (and s/r for good measure)
    echo 0 > /sys/class/vtconsole/vtcon1/bind
    rmmod bochs_drm
    rtcwake -s 1 -m mem

Kind regards,
Peter

Peter Wu (4):
  bochs: use drm_fb_helper_set_suspend_unlocked in suspend/resume
  bochs: convert to drm_fb_helper_fbdev_setup/teardown
  bochs: convert to drm_dev_register
  drm/fb-helper: improve documentation and print warnings

 drivers/gpu/drm/bochs/bochs.h       | 21 ++------
 drivers/gpu/drm/bochs/bochs_drv.c   | 46 +++++++++++------
 drivers/gpu/drm/bochs/bochs_fbdev.c | 79 +++++++----------------------
 drivers/gpu/drm/bochs/bochs_hw.c    |  2 +-
 drivers/gpu/drm/bochs/bochs_kms.c   |  7 +--
 drivers/gpu/drm/bochs/bochs_mm.c    | 74 ---------------------------
 drivers/gpu/drm/drm_fb_helper.c     | 25 ++++++---
 7 files changed, 73 insertions(+), 181 deletions(-)

-- 
2.18.0


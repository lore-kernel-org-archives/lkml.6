Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83067C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A8F20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xiDkQLq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A8F20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKBJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbeKBJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:36:51 -0400
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D56420666;
        Fri,  2 Nov 2018 00:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541118698;
        bh=r8b2BOJ4Li1ARaz6/8zSjU5qNUXyec07Uoy+zT/pmRI=;
        h=From:To:Cc:Subject:Date:From;
        b=xiDkQLq9/Qc8YEf6l8xB16NWrLlXoGynfQOSirYH9aQO6ZMc3Ooi2wgGAFQ+esKeR
         gVg526rHGcolmvkJbnf6hSxdQ+hhldfKh9pRIDw8sctlg6F0lsTLMzJXrH8LtcnB1f
         NEmI2ukLZDLm0dxbMWNd7jhE9CmQ0OLj3O/+FxwA=
From:   shuah@kernel.org
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH v8 0/4] Media Device Allocator API
Date:   Thu,  1 Nov 2018 18:31:29 -0600
Message-Id: <cover.1541118238.git.shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

This patch series has been on the ice for the last couple of years.
Mauro asked me to restart the discussion on this and see if we can
make progress.

I rebased the series to Linux 4.19. It has been surprisingly well
preserved with one small merge conflict resolved in 0004.

Media Device Allocator API to allows multiple drivers share a media device.
Using this API, drivers can allocate a media device with the shared struct
device as the key. Once the media device is allocated by a driver, other
drivers can get a reference to it. The media device is released when all
the references are released.

- No changes to 0001,0002 code since the v7 referenced below.
- 0003 is a new patch to enable ALSA defines that have been
  disabled for kernel between 4.9 and 4.19.
- Minor merge conflict resolution in 0004.
- Added SPDX to new files.

References:
https://www.mail-archive.com/linux-media@vger.kernel.org/msg105854.html

Please review. I am sending this as RFC even though it has been tested
several times prior to this non-event rebased v8. I ran sanity tests.

Shuah Khan (4):
  media: Media Device Allocator API
  media: change au0828 to use Media Device Allocator API
  media: media.h: Enable ALSA MEDIA_INTF_T* interface types
  sound/usb: Use Media Controller API to share media resources

 Documentation/media/kapi/mc-core.rst   |  37 +++
 drivers/media/Makefile                 |   3 +-
 drivers/media/media-dev-allocator.c    | 132 ++++++++++
 drivers/media/usb/au0828/au0828-core.c |  12 +-
 drivers/media/usb/au0828/au0828.h      |   1 +
 include/media/media-dev-allocator.h    |  53 ++++
 include/uapi/linux/media.h             |  25 +-
 sound/usb/Kconfig                      |   4 +
 sound/usb/Makefile                     |   2 +
 sound/usb/card.c                       |  14 ++
 sound/usb/card.h                       |   3 +
 sound/usb/media.c                      | 320 +++++++++++++++++++++++++
 sound/usb/media.h                      |  73 ++++++
 sound/usb/mixer.h                      |   3 +
 sound/usb/pcm.c                        |  29 ++-
 sound/usb/quirks-table.h               |   1 +
 sound/usb/stream.c                     |   2 +
 sound/usb/usbaudio.h                   |   6 +
 18 files changed, 692 insertions(+), 28 deletions(-)
 create mode 100644 drivers/media/media-dev-allocator.c
 create mode 100644 include/media/media-dev-allocator.h
 create mode 100644 sound/usb/media.c
 create mode 100644 sound/usb/media.h

-- 
2.17.0


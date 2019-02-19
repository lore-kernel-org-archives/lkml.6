Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA49C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C495521904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ih9NGf77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfBSHzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:55:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41642 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBSHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:55:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id x7so15873290eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=5h/OAbm3eDxbCkwORNNaL8t676q5hePRb9/ArbcR1gc=;
        b=Ih9NGf77YMMWPALzPF+epyhaRmuMJJJ8XiYHZHEFK10w1cClI2BYBdvZo2THmzLFUK
         WkpXPIH2gvY86JRqwU+FFzCi/4LxnxnJFSGMTxMq3+QAa440bMBq+9/XNV7xhv6WpSMR
         A/7wFYG58cXauJcB4YWGz1SMUtAZgwjagpW7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=5h/OAbm3eDxbCkwORNNaL8t676q5hePRb9/ArbcR1gc=;
        b=hPZEiKKGGF6rVaTz0p/otAV7x+L9u4Js9Qz6rWzvcQywVTD0j/AltKXFDZKLrGRvbf
         tuXlcVeDHskaGEQrkSEng+NRxth7b69hxf++r2/gNKohk+3fUEgcqalr7tm+kSB90+oO
         vXAcG18kJzTeICCvKqJ1FnDOCX3WrIAYv46ZYtKmKt5iaVXyQeOaNxwpx7bbZITG9818
         /KmddMAr9bhMhqgXjsEoNAeEQGLmIx/Yla+i3WSr6127Gh5BTtdno7JGWGbfNhptORae
         NMfcyRlxRlB39U+A+tAvozcP2eHHu2vrG6Os41DE0b3cG8exwS/MRBjnzZUw9rQarp3w
         nK8g==
X-Gm-Message-State: AHQUAubhW2pD3ekMJkNydSYp0jm7UH9gSJYTEOQmlwoQo013Mz6QmzLv
        /8xJWlskoWeZtHXb08KxeKEZWiaXTcgBFg==
X-Google-Smtp-Source: AHgI3IZikLQlC5QaUZBQQIan3GudZq3iv+VVRMpkpB20BO/n+B9QgSaHIFbFaVjRgDH04r7c/BL1bA==
X-Received: by 2002:a05:6402:2c9:: with SMTP id b9mr13284100edx.8.1550562933701;
        Mon, 18 Feb 2019 23:55:33 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a18sm1551914ejt.20.2019.02.18.23.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 23:55:32 -0800 (PST)
Date:   Tue, 19 Feb 2019 08:55:27 +0100
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dim-tools@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] topic/mei-hdcp
Message-ID: <20190219071619.GA11016@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dim-tools@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

topic/mei-hdcp-2019-02-19:
Prep patches + headers for the mei-hdcp/i915 component interfaces

Also contains the prep work in the component helpers plus adjustements
for the snd-hda/i915 component interface.

Plus one small static inline in the drm_hdcp.h header that both i915
and mei_hdcp will need.

Joonas, please pull into drm-intel-next-queued so I can apply the i915
hdcp patches.

Greg/Arnd, I think there's two options to get the mei-hdcp patches landed
into drivers-misc:
- You pull this topic pull and then apply the mei-hdcp patches on top in
  char-misc-next.
- I also pull in char-misc-next to get at 32ea33a04484 ("mei: bus: export
  to_mei_cl_device for mei client devices drivers") and then apply all the
  mei-hdcp stuff into a new topic branch.

I think 2nd option would be better, allows us to integration test easier,
and we'll have a topic branch in case we need a fixup spanning mei-hdcp
and i915. Also would allow me to start merging the patches, since I think
it's too late for 5.1.

Cheers, Daniel

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm-intel tags/topic/mei-hdcp-2019-02-19

for you to fetch changes up to 35c0272502cca0a1b461d310c23aac94a503983d:

  drm/audio: declaration of struct device (2019-02-18 20:19:28 +0100)

----------------------------------------------------------------
Prep patches + headers for the mei-hdcp/i915 component interfaces

Also contains the prep work in the component helpers plus adjustements
for the snd-hda/i915 component interface.

Plus one small static inline in the drm_hdcp.h header that both i915
and mei_hdcp will need.

----------------------------------------------------------------
Daniel Vetter (3):
      component: Add documentation
      components: multiple components for a device
      i915/snd_hdac: I915 subcomponent for the snd_hdac

Ramalingam C (5):
      drm/i915: enum port definition is moved into i915_drm.h
      drm/i915: header for i915 - MEI_HDCP interface
      drm/i915: MEI interface definition
      drm: helper functions for hdcp2 seq_num to from u32
      drm/audio: declaration of struct device

 Documentation/driver-api/component.rst   |  17 +++
 Documentation/driver-api/device_link.rst |   3 +
 Documentation/driver-api/index.rst       |   1 +
 drivers/base/component.c                 | 206 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/i915/intel_audio.c       |   4 +-
 drivers/gpu/drm/i915/intel_display.h     |  16 +--
 include/drm/drm_audio_component.h        |   1 +
 include/drm/drm_hdcp.h                   |  18 +++
 include/drm/i915_component.h             |   5 +
 include/drm/i915_drm.h                   |  15 +++
 include/drm/i915_mei_hdcp_interface.h    | 149 ++++++++++++++++++++++
 include/linux/component.h                |  76 ++++++++++++
 include/sound/hda_component.h            |   5 +-
 sound/hda/hdac_component.c               |   4 +-
 sound/hda/hdac_i915.c                    |   6 +-
 15 files changed, 493 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/driver-api/component.rst
 create mode 100644 include/drm/i915_mei_hdcp_interface.h

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA44C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60042081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60042081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=80x24.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeKDNnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:43:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51408 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbeKDNnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:43:46 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7E6E51F453;
        Sun,  4 Nov 2018 04:23:28 +0000 (UTC)
Date:   Sun, 4 Nov 2018 04:23:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: radeon vs radeonfb Mobility quirks (Thinkpad X32)
Message-ID: <20181104042328.jzavn47y2wloprbs@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Thinkpad X32 (r100, Mobility M6) can't suspend or hibernate
with KMS using the "radeon" driver.  "radeonfb" and the VESA
fallback (no KMS) are both fine.

It seems to be the same bug as:
https://bugs.freedesktop.org/show_bug.cgi?id=38554
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=583120

The problem manifests in the console and inside X11,
and with 0 or 3 in /proc/sys/kernel/acpi_video_flags.
"radeontool light off" to disable the backlight doesn't
help, either (no VGA plugged in)

Looking at drivers/video/fbdev/aty/radeon_pm.c, I notice it sets
a D2 sleep mode for my X32:

	BUGFIX("IBM Thinkpad X31/X32",
	       PCI_VENDOR_ID_IBM, 0x052f,
	       radeon_pm_d2, NULL),

Which I suspect is what allows "radeonfb" to work for me

But I can't find the corresponding quirk in drivers/gpu/drm/radeon/,
so I now believe a missing quirk is the cause of this problem
with the "radeon" driver.

I poked around but couldn't figure out what changes to make to
the "radeon" driver to enable the corresponding, but I'm willing
to test patches.

Setting "dynpm" in /sys/**/power_method didn't seem to change
things, either.

Help greatly appreaciated.  Thanks


I've mainly been using the X32 as a server this decade so didn't
use suspend/hibernate so I didn't investigate until recently
(because my netbook died).

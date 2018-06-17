Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D9A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FjK0rC3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D9A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbeFQTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:07:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51536 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbeFQTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:07:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6505FC138;
        Sun, 17 Jun 2018 15:07:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=OlWf7tyGxY9ASHst7eR5fxeKMh8
        =; b=FjK0rC3sw/u7cllgsSgMPlpyfAK/IPv9ABJhaH7rghDnyUrlKhL/9kjOWLZ
        NJs/sAQx/WYEcBLpgU6B9sz6c+dSKDR69iofnw1xSfxiUPFA07QxcGuN1seAt6k/
        LxhpGyK38f/weLsBjm3WrJvoGLx0+RD+g0INJH+Tlz5WafCY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDDF5FC137;
        Sun, 17 Jun 2018 15:07:09 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49511FC12F;
        Sun, 17 Jun 2018 15:07:09 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 4E0E12DA019C;
        Sun, 17 Jun 2018 15:07:08 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] have the vt console preserve unicode characters
Date:   Sun, 17 Jun 2018 15:07:02 -0400
Message-Id: <20180617190706.14614-1-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Pobox-Relay-ID: A22E641C-7261-11E8-B023-44CE1968708C-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vt code translates UTF-8 strings into glyph index values and stores
those glyph values directly in the screen buffer. Because there can only
be at most 512 glyphs, it is impossible to represent most unicode
characters, in which case a default glyph (often '?') is displayed
instead. The original unicode value is then lost.

This also means that the /dev/vcs* devices only provide user space with
glyph index values, and then user applications must get hold of the
unicode-to-glyph table the kernel is using in order to back-translate
those into actual characters. It is not possible to get back the original
unicode value when multiple unicode characters map to the same glyph,
especially for the vast majority that maps to the default replacement
glyph.

The 512-glyph limitation is inherent to VGA displays, but users of
/dev/vcs* shouldn't have to be restricted to a narrow unicode space from
lossy screen content because of that. This is especially true for
accessibility applications such as BRLTTY that rely on /dev/vcs to rander
screen content onto braille terminals.

This patch series introduces unicode support to /dev/vcs* devices,
allowing full unicode access from userspace to the vt console which
can, amongst other purposes, appropriately translate actual unicode
screen content into braille. Memory is allocated, and possible CPU
overhead introduced, only if /dev/vcsu is read at least once.

I'm a prime user of this feature, as well as the BRLTTY maintainer Dave Mielke
who implemented support for this in BRLTTY. There is therefore a vested
interest in maintaining this feature as necessary. And this received
extensive testing as well at this point.

Patch #4 was used for validation and is included for completeness, however
if people think it is unappropriate for mainline then it can be dropped.

This is also available on top of v4.18-rc1 here:

  git://git.linaro.org/people/nicolas.pitre/linux vt-unicode

Changes from v1:

- Rebased to v4.18-rc1.
- Dropped first patch (now in mainline as commit 4b4ecd9cb8).
- Removed a printk instance from an error path easily triggerable
  from user space.
- Minor cleanup.

Diffstat:

 drivers/tty/vt/vc_screen.c     |  90 +++++++--
 drivers/tty/vt/vt.c            | 347 +++++++++++++++++++++++++++++++++--
 include/linux/console_struct.h |   2 +
 include/linux/selection.h      |   5 +
 4 files changed, 419 insertions(+), 25 deletions(-)


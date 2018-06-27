Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26224C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97DB268E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Axn6A/Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97DB268E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeF0D4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:56:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53214 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeF0D4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:56:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2F71E7787;
        Tue, 26 Jun 2018 23:56:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=d3LgZaE8SnHbrUb77BIW8JQoLLs
        =; b=Axn6A/Y2OZPk1WL/SvMLfhWHYNMAxuzi/b/CiuHf14J/5xe2q9ADq9BohBm
        AdLUOSey8esSeGpeSfSrR1iilLffzkoKJItgf3F3eDPYX3itPcJ3TfncEn6VP+xp
        mfv3XhTGWgqk73Np4OJXjXlA6QDCXKcBPxqxiCxZhxE4HKXI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AB57E7786;
        Tue, 26 Jun 2018 23:56:46 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18EB4E777F;
        Tue, 26 Jun 2018 23:56:46 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 483112DA00D8;
        Tue, 26 Jun 2018 23:56:44 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: [PATCH v3 0/3] have the vt console preserve unicode characters
Date:   Tue, 26 Jun 2018 23:56:39 -0400
Message-Id: <20180627035642.8561-1-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Pobox-Relay-ID: 1C5A012A-79BE-11E8-9FF5-40570C78B957-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vt code translates UTF-8 strings into glyph index values and stores 
those glyph values in the screen buffer. Because there can only be at 
most 512 glyphs at the moment, it is impossible to represent most 
unicode characters, in which case a default glyph (often '?') is 
displayed instead. The original unicode value is then lost.

The 512-glyph limitation is inherent to text-mode VGA displays after 
which the core console code was modelled. This also means that the 
/dev/vcs* devices only provide user space with glyph index values, and 
then user applications must get hold of the unicode-to-glyph table the 
kernel is using in order to back-translate those into actual characters. 
It is not possible to get back the original unicode value when multiple 
unicode characters map to the same glyph, especially for the vast 
majority that maps to the default replacement glyph.

Users of /dev/vcs* shouldn't have to be restricted to a narrow unicode 
space from lossy screen content because of that. This is especially true 
for accessibility applications such as BRLTTY that rely on /dev/vcs to 
render screen content onto braille terminals.

It was also argued that the VGA-centric glyph buffer should eventually 
go entirely. The current design made sense when hardware was slow and 
managing the screen directly into the VGA memory made a difference (i.e. 
25 years ago). Modern console display drivers no longer have to be 
   limited to 512 glyphs.
Quoting Alan Cox:

|The only driver that it suits is the VGA text mode driver, which at 
|2GHz+ is going to be fast enough whatever format you convert from. We 
|have the memory, the processor power and the fact almost all our 
|displays are bitmapped (or more complex still) all in favour of 
|throwing away that limit.

This patch series introduces unicode screen support to the core console 
code with /dev/vcs* as a first user. Memory is allocated, and possible 
CPU overhead introduced, only if /dev/vcsu is read at least once. For 
now both the glyph and unicode buffers are maintained in parallel to 
allow for a smooth transition.

I'm a prime user of this new /dev/vcsu interface, as well as the BRLTTY 
maintainer Dave Mielke who implemented support for this in BRLTTY. There 
is therefore a vested interest in maintaining this feature as necessary. 
And this received extensive testing as well at this point.

This is also available on top of v4.18-rc2 here:

  git://git.linaro.org/people/nicolas.pitre/linux vt-unicode

Changes from v2:

- Dropped patch #4 as it was useful only for initial debugging and it 
  attracted all the review comments so far -- actually more than the 
  patch is worth.
- Added Adam Borowski's ACK.

Changes from v1:

- Rebased to v4.18-rc1.
- Dropped first patch (now in mainline as commit 4b4ecd9cb8).
- Removed a printk instance from an error path easily triggerable
  from user space.
- Minor cleanup.

Diffstat:

 drivers/tty/vt/vc_screen.c     |  90 ++++++++--
 drivers/tty/vt/vt.c            | 308 +++++++++++++++++++++++++++++++--
 include/linux/console_struct.h |   2 +
 include/linux/selection.h      |   5 +
 4 files changed, 380 insertions(+), 25 deletions(-)


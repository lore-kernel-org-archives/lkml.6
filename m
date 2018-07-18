Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C1ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2B42075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2B42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeGRCli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:41:38 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:33802 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbeGRClh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:41:37 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffbqu-0007J4-6f; Wed, 18 Jul 2018 04:06:04 +0200
Date:   Wed, 18 Jul 2018 04:06:04 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: [PATCH 0/3] use unicode for vt mouse paste
Message-ID: <20180718020604.3u25omf5fxqvsy3q@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Based on Nicolas' nice work (in tty-next), let's avoid corrupting characters
that have been copy+pasted via mouse selection.  The uniscr array holds
their original identity even if they got mangled by glyph conversion.
The glyph conversion lossily turns similar-looking characters into a
representation, and everyone else into a replacement character.

There's no proper handling for CJK (yet?) but anything of wcwidth()==1 will
work fine.

The whole thing doesn't get enabled until something reads from /dev/vcsu for
that console, but let's test this code first before enabling it widely.


Diffstat:
 drivers/tty/vt/selection.c | 48 +++++++++++++++++++++++++++++-------------------
 drivers/tty/vt/vt.c        | 10 ++++++++++
 include/linux/selection.h  |  1 +
 3 files changed, 40 insertions(+), 19 deletions(-)


-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.

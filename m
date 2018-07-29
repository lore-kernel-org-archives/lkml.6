Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E3FA373B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3480620873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3480620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nomi.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeG2LRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 07:17:21 -0400
Received: from ackle.nomi.cz ([81.31.33.35]:42890 "EHLO ackle.nomi.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeG2LRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 07:17:21 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2018 07:17:20 EDT
Received: from localhost (notes.lisk.in [IPv6:2a01:430:1::115:4])
        by ackle.nomi.cz (Postfix) with ESMTPSA id 9A9289F58E;
        Sun, 29 Jul 2018 11:41:31 +0200 (CEST)
Date:   Sun, 29 Jul 2018 11:41:31 +0200
From:   Tomas Janousek <tomi@nomi.cz>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 13, 2018 at 09:41:41PM +0800, Ming Lei wrote:
> Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue is
> triggered on your machine.

While Patrick did miss the following patch:

* 765e40b675a9 ("block: disable runtime-pm for blk-mq"; July 2017).

there is at least one other way to trigger it -- enable laptop-mode-tools
or tlp which enable runtime-pm for all devices.

The "disable runtime-pm for blk-mq" only disables it _by_default_, but doesn't
prevent it from being enabled again from user-space, which it is unless one
manually blacklists sd devices from runtime-pm enablement. It's bitten a few
people already: https://github.com/rickysarraf/laptop-mode-tools/issues/123

(I found this thread because I'm also getting the NULL pointer dereference at
00000000000001a8 on resume from suspend.)

-- 
Tomáš Janoušek, a.k.a. Pivník, a.k.a. Liskni_si, http://work.lisk.in/

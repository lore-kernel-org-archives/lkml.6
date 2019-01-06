Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C1EC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E73C2184C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfAFIiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:38:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:57164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbfAFIiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86133ABD7;
        Sun,  6 Jan 2019 08:38:02 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH lora-next 00/11] net: lora: sx130x: Fixes for enabling regcache
Date:   Sun,  6 Jan 2019 09:37:43 +0100
Message-Id: <20190106083754.6004-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series fixes a number of issues that stood in the way of enabling the
regmap cache for SX130x. It goes on to enable REGCACHE_RBTREE.

1) Soft reset needs special treatment.
2) More registers need to be treated as volatile.
3) Some register field writes need to be forced.

This complements Ben Whitten's regmap conversion patches [1] I already squashed,
mainly [2]. I intend to squash these into my driver commit as well.

In my testing it has not regressed with spi-gpio or cdc-acm, nor with spi-sun6i;
given that we seem no closer to a solution for the clk lock-up, we may need to
revert that commit from [1] again.

Have a lot of fun!

Cheers,
Andreas

[1] https://patchwork.ozlabs.org/cover/983168/
[2] https://patchwork.ozlabs.org/patch/983170/

Cc: Ben Whitten <ben.whitten@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-lpwan@lists.infradead.org
Cc: netdev@vger.kernel.org

Andreas Färber (11):
  net: lora: sx125x: Abort on wrong version
  net: lora: sx130x: Fix error codes
  net: lora: sx130x: Revert drop of sx1301_soft_reset()
  net: lora: sx130x: Fix soft reset
  net: lora: sx130x: Fix regmap field toggles
  net: lora: sx130x: Force regmap field write before sleep
  net: lora: sx130x: Force regmap field writes before function
    boundaries
  net: lora: sx130x: Force regmap field write before reading status
  net: lora: sx130x: Mark AGCSTS register as volatile
  net: lora: sx130x: Mark MCU_CTRL register as volatile
  net: lora: sx130x: Enable regmap caching

 drivers/net/lora/sx125x.c |  6 ++++-
 drivers/net/lora/sx130x.c | 65 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 51 insertions(+), 20 deletions(-)

-- 
2.16.4


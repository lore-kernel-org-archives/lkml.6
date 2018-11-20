Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717CC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42486206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42486206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeKTSaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:30:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeKTSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:30:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 870D920D72; Tue, 20 Nov 2018 09:02:15 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4082C20D9D;
        Tue, 20 Nov 2018 09:02:05 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     thor.thayer@linux.intel.com, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
Date:   Tue, 20 Nov 2018 09:02:03 +0100
Message-Id: <20181120080203.4183-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: a6a66f80c85e8e20573ca03fabf32445954a88d5
In-Reply-To: <1542378349-29929-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 14:25:49 UTC, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The current Cadence QSPI driver caused a kernel panic sporadically
> when writing to QSPI. The problem was caused by writing more bytes
> than needed because the QSPI operated on 4 bytes at a time.
> <snip>
> [   11.202044] Unable to handle kernel paging request at virtual address bffd3000
> [   11.209254] pgd = e463054d
> [   11.211948] [bffd3000] *pgd=2fffb811, *pte=00000000, *ppte=00000000
> [   11.218202] Internal error: Oops: 7 [#1] SMP ARM
> [   11.222797] Modules linked in:
> [   11.225844] CPU: 1 PID: 1317 Comm: systemd-hwdb Not tainted 4.17.7-d0c45cd44a8f
> [   11.235796] Hardware name: Altera SOCFPGA Arria10
> [   11.240487] PC is at __raw_writesl+0x70/0xd4
> [   11.244741] LR is at cqspi_write+0x1a0/0x2cc
> </snip>
> On a page boundary limit the number of bytes copied from the tx buffer
> to remain within the page.
> 
> This patch uses a temporary buffer to hold the 4 bytes to write and then
> copies only the bytes required from the tx buffer.
> 
> Reported-by: Adrian Amborzewicz <adrian.ambrozewicz@intel.com>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>

Applied to http://git.infradead.org/linux-mtd.git master, thanks.

Boris
